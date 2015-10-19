/*
 * DRIVER for Lighting-Solutions USBDMX interfaces
 * Copyright (C) 2004-2006 Jan Menzel <driver@lighting-solutions.de>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */
/*
 * CHANGES:
 * 16.06.2004: changed MINOR_ID to 192 to avoid conflicts with HID. 
 *   usb_register() fails when the MINOR_ID points into a block of 16 IDs
 *   already used by another driver.  
 * 12.01.2006: removed MOD_INC_USE_COUNT und MOD_DEC_USE_COUNT if compiling
 *   for kernel 2.6.x
 *
 * TODO:
 * - enable bulk transfers
 * - add spinlooking for multi processor operation
 * - check usb_skeleton.c for changes of the kernel API
 */

#include <linux/config.h>  // kernel configuration
#include <linux/kernel.h>  // kernel function like printk
#include <linux/errno.h>
#include <linux/init.h>    // module initialisation macros
#include <linux/slab.h>	   // kernel nmemory management functions

/*
#if CONFIG_MODVERSIONS==1  // deal with CONFIG_MODVERSIONS
#define MODVERSIONS
#include <linux/modversions.h>
#endif
*/
#include <linux/module.h>  // module specific stuff

//#include <linux/kref.h>
#include <linux/version.h> // kernel version information
#include <asm/uaccess.h>   // copy_from_user(), copy_to_user()
#include <linux/devfs_fs_kernel.h>
#include <linux/usb.h>

#include "usbdmx.h"

// keep shure, that KERNEL_VERSION is always defined
#ifndef KERNEL_VERSION
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
#endif

//MODULE_LICENSE("GPL");

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,17)
// general macros to get the Driver loaded in 2.4.x
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Jan Menzel");
MODULE_DESCRIPTION("driver for USBDMX interfaces by Peperoni, http://www.peperoni-light.de");
#endif

/* wait timeout for usbdmx [msec] */
#define TIMEOUT (100)

// define maximum number of allowed devices
#define DEVICES_MAX (16)

// define first minor id (IDs are claimed in blocks of 16. If the block is
//   already in use by another driver, usb_register() will fail.)
#define MINOR_ID (192)

// define VendorID
#define LIGHTING_SOLUTIONS_VENDOR_ID (0x0ce1)

// define types of interface, which can be connected
struct {
  char *name;                // name for log entries
  int id;                    // product id in device descriptor
  int default_configuration; // for old interfaces (bcdDevice < 0x400)
} device_information[] = {
  { "USBDMX X-Switch", XSWITCH,      2},
  { "Rodin1",          RODIN1,       1},
  { "Rodin2",          RODIN2,       2},
  { "USBDMX21",        USBDMX21,     2},
  { 0,                 0,            0}
};

/* table of devices that work with this driver */
static struct usb_device_id usbdmx_table [] = {
  { USB_DEVICE(LIGHTING_SOLUTIONS_VENDOR_ID, XSWITCH)      },
  { USB_DEVICE(LIGHTING_SOLUTIONS_VENDOR_ID, RODIN1)       },
  { USB_DEVICE(LIGHTING_SOLUTIONS_VENDOR_ID, RODIN2)       },
  { USB_DEVICE(LIGHTING_SOLUTIONS_VENDOR_ID, USBDMX21)     },
  { }
};
MODULE_DEVICE_TABLE (usb, usbdmx_table);

struct usbdmx_data {
  struct usb_device *dmx_dev;	/* init: probe_dmx */
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
  devfs_handle_t     devfs;     /* devfs device node */
#endif
  unsigned char      minor;     /* the starting minor number for this device */
  int isopen;			/* nz if open */
  int present;			/* Device is present on the bus */
  int type;                     /* Interface type in device_information */
  int memory;			/* selected memory map of read/write */
  int offset;			/* memory offset */
  int blocking; 		/* blocking read/write? */
};

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
/* the global usb devfs handle */
extern devfs_handle_t usb_devfs_handle;
#endif

// maximum number of 16 interfaces allowed
static struct usbdmx_data dmx_instance[DEVICES_MAX];

/*
 * usbdmx_open(): called to open a interface
 */
static int usbdmx_open(struct inode *inode, struct file *file) {
  int device = MINOR(inode->i_rdev) - MINOR_ID; // get minor device id
  struct usbdmx_data *dmx;

  // is the requested device number valid?
  if (device >= DEVICES_MAX)
    return -ENODEV;

  // get requested device
  dmx = &dmx_instance[device];

  // is a device present?
  if (!dmx->present)
    return -ENODEV;
  
  // is the device busy?
  if (dmx->isopen)
    return -EBUSY;
  
  // open the device
  dmx->isopen = 1;

  // save dmx structure to file handle (for later use)
  file->private_data = (void *)dmx;

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
  // mark driver in use
  MOD_INC_USE_COUNT;
#endif
  
  dbg("%s opened.", device_information[dmx->type].name);
  
  return 0;
}

/*
 * usbdmx_release(): release the connection to a interface
 */
static int usbdmx_release(struct inode *inode, struct file *file) {
  struct usbdmx_data *dmx = (struct usbdmx_data *)file->private_data;
  
  dmx->isopen = 0;
  
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
  MOD_DEC_USE_COUNT;
#endif
  
  dbg("%s closed.", device_information[dmx->type].name);
  return 0;
}

/*
 * usbdmx_ioctl(): handle ioctls
 */
static int usbdmx_ioctl(struct inode *inode, struct file *file, 
                        unsigned int cmd, unsigned long arg) {
  struct usbdmx_data *dmx = (struct usbdmx_data *)file->private_data;
  int result = 0;
  int d;
  
  /* Sanity check to make sure usbdmx is connected, powered, etc */
  if ( dmx == NULL ||
       dmx->present == 0 ||
       dmx->dmx_dev == NULL )
    return -1;

  dbg("USBDMX ioctl");
  
  switch(cmd) {
  case DMX_TYPE_GET:
    result = device_information[dmx->type].id;
    break;

  case CONFIG_SET:
    d = (int)arg;

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
    if((result = !usb_set_configuration(dmx->dmx_dev, d)))
      info("configuration changed to %i", d);
#else
    warn("changing configurations within device drivers is not possible anymore.");
    result = 0;
#endif
    break;

  case DMX_BLOCKING_SET:
    d = (int)arg;
    
    dmx->blocking = d?VALUE_BLOCKING:0;
    break;

  case DMX_BLOCKING_GET:
    return dmx->blocking?1:0;

  case DMX_SERIAL_GET:
    d = 0;
    result = usb_control_msg(dmx->dmx_dev, usb_rcvctrlpipe(dmx->dmx_dev, 0),
			     DMX_SERIAL,
			     USB_DIR_IN | USB_TYPE_VENDOR, 0, 0, &d, 4, TIMEOUT);
    if(result == 4)
      return d;
    else
      dbg("ioctl: DMX_SERIAL_GET: got %i/%i bytes back", result, 4);
    break;

  case DMX_MEM_MAP_SET:
    d = (int)arg;
    
    if(d == DMX_RX_MEM || d == DMX_TX_MEM)
      dmx->memory = d;
    else
      dmx->memory = 0;

    dmx->offset = 0;
    break;

  case DMX_MEM_MAP_GET:
    return dmx->memory;

  case DMX_TX_FRAMES_GET:
    d = 0;
    result = usb_control_msg(dmx->dmx_dev, usb_rcvctrlpipe(dmx->dmx_dev, 0),
			     DMX_TX_FRAMES,
			     USB_DIR_IN | USB_TYPE_VENDOR, 0, 0, &d, 4, TIMEOUT);
    if(result == 4)
      return d;
    else
      dbg("ioctl: DMX_TX_FRAMES_GET: got %i/%i bytes back", result, 4);
    break;
    
  case DMX_RX_FRAMES_GET:
    d = 0;
    result = usb_control_msg(dmx->dmx_dev, usb_rcvctrlpipe(dmx->dmx_dev, 0),
			     DMX_RX_FRAMES,
			     USB_DIR_IN | USB_TYPE_VENDOR, 0, 0, &d, 4, TIMEOUT);
    if(result == 4)
      return d;
    else
      dbg("ioctl: DMX_RX_FRAMES_GET: got %i/%i bytes back", result, 4);
    break;
    
  case DMX_TX_STARTCODE_GET:
    d = 0;
    result = usb_control_msg(dmx->dmx_dev, usb_rcvctrlpipe(dmx->dmx_dev, 0),
			     DMX_TX_STARTCODE,
			     USB_DIR_IN | USB_TYPE_VENDOR, 0, 0, &d, 1, TIMEOUT);
    if(result == 1)
      return d;
    else
      dbg("ioctl: DMX_TX_STARTCODE_GET: got %i/%i bytes back", result, 1);
    break;
   
  case DMX_TX_STARTCODE_SET:
    /* get value from arg-list */
    d = (int)arg;
    if(d > 0xff || d < 0)
      break;

    result = usb_control_msg(dmx->dmx_dev, usb_sndctrlpipe(dmx->dmx_dev, 0),
			     DMX_TX_STARTCODE,
			     USB_DIR_OUT | USB_TYPE_VENDOR, d, 0, 0, 0, TIMEOUT);
    break;

  case DMX_RX_STARTCODE_GET:
    d = 0;
    result = usb_control_msg(dmx->dmx_dev, usb_rcvctrlpipe(dmx->dmx_dev, 0),
			     DMX_RX_STARTCODE,
			     USB_DIR_IN | USB_TYPE_VENDOR, 0, 0, &d, 1, TIMEOUT);
    if(result == 1)
      return d;
    else
      dbg("ioctl: DMX_RX_STARTCODE_GET: got %i/%i bytes back", result, 1);
    break;
   
  case DMX_RX_STARTCODE_SET:
    /* get value from arg-list */
    d = (int)arg;
    if(d > 0xff || d < 0)
      break;

    result = usb_control_msg(dmx->dmx_dev, usb_sndctrlpipe(dmx->dmx_dev, 0),
			     DMX_RX_STARTCODE,
			     USB_DIR_OUT | USB_TYPE_VENDOR, d, 0, 0, 0, TIMEOUT);
    break;

  case DMX_RX_SLOTS_GET:
    d = 0;
    result = usb_control_msg(dmx->dmx_dev, usb_rcvctrlpipe(dmx->dmx_dev, 0),
			     DMX_RX_SLOTS,
			     USB_DIR_IN | USB_TYPE_VENDOR, 0, 0, &d, 2, TIMEOUT);
    if(result == 2)
      return d;
    else
      dbg("ioctl: DMX_RX_SLOTS_GET: got %i/%i bytes back", result, 2);
    break;
   
  case DMX_TX_SLOTS_GET:
    d = 0;
    result = usb_control_msg(dmx->dmx_dev, usb_rcvctrlpipe(dmx->dmx_dev, 0),
			     DMX_TX_SLOTS,
			     USB_DIR_IN | USB_TYPE_VENDOR, 0, 0, &d, 2, TIMEOUT);
    if(result == 2)
      return d;
    else
      dbg("ioctl: DMX_TX_SLOTS_GET: got %i/%i bytes back", result, 2);
    break;
   
  case DMX_TX_SLOTS_SET:
    /* get value from arg-list */
    d = (int)arg;
    if(d > 0x200 || d < 24)
      break;

    result = usb_control_msg(dmx->dmx_dev, usb_sndctrlpipe(dmx->dmx_dev, 0),
			     DMX_TX_SLOTS,
			     USB_DIR_OUT | USB_TYPE_VENDOR, d, 0, 0, 0, TIMEOUT);
    break;

  default:
    return -ENOIOCTLCMD;
    break;
  }
  return result;
}

/*
 * usbdmx_llseek(): seek file pointer
*/
static loff_t usbdmx_llseek(struct file *file, loff_t offset, int whence) {
  struct usbdmx_data *dmx = (struct usbdmx_data *)file->private_data;
  
  if(dmx == NULL)
    return -1;

  switch(whence) {
  case 0:
    dmx->offset = offset;
    break;

  case 1:
    dmx->offset += offset;
    break;

  default:
    return -EINVAL;
  }
  return dmx->offset;
}

/*
 * usbdmx_write(): write to interface
 */
static ssize_t usbdmx_write(struct file *file, const char *buffer,
	  size_t count, loff_t * ppos) {
  struct usbdmx_data *dmx = (struct usbdmx_data *)file->private_data;
  int result;
  char *buf;
  
  /* Sanity check to make sure usbdmx is connected, powered, etc */
  if( dmx == NULL ||
      dmx->present == 0 ||
      dmx->dmx_dev == NULL ||
      dmx->memory == 0 ) {
    warn("usbdmx_write: sanity check failed");

    return -1;
  }

  if(!(buf = (char *) kmalloc(count, GFP_KERNEL))) {
    err("usbdmx_write: Not enough memory for buffer");
    return -ENOMEM;
  }
  
  if (copy_from_user(buf, buffer, count)) {
    warn("usbdmx_write: copy_from_user failed");

    kfree(buf);
    return -EFAULT;
  }

  result = usb_control_msg(dmx->dmx_dev, usb_sndctrlpipe(dmx->dmx_dev, 0),
			   dmx->memory,
			   USB_DIR_OUT | USB_TYPE_VENDOR, dmx->blocking, 
			   dmx->offset, buf, count, TIMEOUT);
  if(result != count && result != -ETIMEDOUT)
    err("usbdmx_write: finished with result: %i", result);
  
  return result;
}

/*
 * usbdmx_read(): read from interface
 */
static ssize_t usbdmx_read(struct file *file, char *buffer, size_t count, loff_t * ppos) {
  struct usbdmx_data *dmx = (struct usbdmx_data *)file->private_data;
  int result;
  char *buf;
  
  /* Sanity check to make sure usbdmx is connected, powered, etc */
  if( dmx == NULL ||
      dmx->present == 0 ||
      dmx->dmx_dev == NULL ||
      dmx->memory == 0 ) {
    warn("read_dmx: sanity check failed");

    return -1;
  }
  
  if(!(buf = (char *) kmalloc(count, GFP_KERNEL))) {
    err("read_dmx: Not enough memory for buffer");
    return -ENOMEM;
  }
  
  result = usb_control_msg(dmx->dmx_dev, usb_rcvctrlpipe(dmx->dmx_dev, 0),
			   dmx->memory,
			   USB_DIR_IN | USB_TYPE_VENDOR, dmx->blocking, 
			   dmx->offset, buf, count, TIMEOUT);

  if(result != count && result != -ETIMEDOUT)
    err("usbdmx_read: finished with result: %i", result);

  if (result >= 0 && copy_to_user(buffer, buf, result)) {
    warn("read_dmx: copy_to_user failed");
    result = -EFAULT;
  }
  kfree(buf);
  return result;
}

/*
 * file operation structure of this module
 */
static struct
file_operations usbdmx_fops = {
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
  .owner   = THIS_MODULE,
#endif
  .llseek  = usbdmx_llseek,
  .read    = usbdmx_read,
  .write   = usbdmx_write,
  .ioctl   = usbdmx_ioctl,
  .open    = usbdmx_open,
  .release = usbdmx_release,
};

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
/*
 * usb class driver info in order to get a minor number from the usb core,
 * and to have the device registered with devfs and the driver core
 */
static struct usb_class_driver usbdmx_class = {
  .name =         "usbdmx%d",
  .fops =         &usbdmx_fops,
  .minor_base =   MINOR_ID,
};
#endif
                           
/*
 * usbdmx_probe(): check if a usb device is handled by this driver
 */
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
static void *usbdmx_probe(struct usb_device *dev, 
                          unsigned int ifnum,
                          const struct usb_device_id *id) 
{
#else
static int usbdmx_probe(struct usb_interface *interface, 
                        const struct usb_device_id *id)
{
  struct usb_device *dev = usb_get_dev(interface_to_usbdev(interface));
  int retval;
#endif
  struct usbdmx_data *dmx;
  int i, type;
  char   name[16];

  if (dev->descriptor.idVendor != LIGHTING_SOLUTIONS_VENDOR_ID)
  {
    warn("Device with wrong idVendor: 0x%04x.", dev->descriptor.idVendor);
    info("sizeof(descriptor) = %d", sizeof(dev->descriptor));
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
    return NULL;
#else
    return 0;
#endif
  }

  // identify interface type
  type = 0;
  while (device_information[type].name && 
  	 device_information[type].id != dev->descriptor.idProduct)
    type++;
    
  // type identified?
  if (device_information[type].name == 0)
  {
    warn("Interface 0x%04x not supported.", dev->descriptor.idProduct);
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
    return NULL;
#else
    return -ENODEV;
#endif
  }
  
  info("%s found at address %d", device_information[type].name, dev->devnum);

#if 0
  /* allocate memory for our device state and initialize it */
  dmx = kmalloc(sizeof(*dmx), GFP_KERNEL);
  if (dmx == NULL) {
    err("Out of memory");
    return -ENOMEM
  }
  memset(dmx, 0x00, sizeof(*dev));
  kref_init(&dmx->kref);
#else

  // get a free position in free dmx instance
  for (i = 0; i < DEVICES_MAX && dmx_instance[i].present; ++i)
    ;

  // free instance found?
  if (i >= DEVICES_MAX)
  {
    warn("No dmx_instance available anymore.");
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
    return NULL;
#else
    return -ENODEV;
#endif
  }

  // grep instance into dmx
  dmx = &dmx_instance[i];
#endif
  
  dmx->present = 1;
  dmx->dmx_dev = dev;
  dmx->type   = type;
  dmx->memory = 0;
  dmx->offset = 0;
  dmx->blocking = 0;
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
  dmx->minor  = i;
#else
  dmx->minor  = interface->minor;
#endif

  // configure device to default (only if bcddevice < 0x0400)
  if(dev->descriptor.bcdDevice < 0x400)
  { 
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
    if (usb_set_configuration(dev, device_information[type].default_configuration))
      err ("setting configuration failed");
#else
    warn("changing configuration within device driver to %d is not possible anymore.", 
         device_information[type].default_configuration);
#endif
  }

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
  /* save our data pointer in this interface device */
  usb_set_intfdata(interface, dmx);

#if 1
  /* we can register the device now, as it is ready */
  retval = usb_register_dev(interface, &usbdmx_class);
  if (retval) {
    /* something prevented us from registering this driver */
    err("Not able to get a minor for this device.");
    usb_set_intfdata(interface, NULL);
    return retval;
  }
#endif
  // construct device name from minor id
  sprintf(name, usbdmx_class.name, dmx->minor);
  
#else
  // construct device name from minor id
  sprintf(name, "usbdmx%d", dmx->minor);
  
  /* initialize the devfs node for this device and register it */
  dmx->devfs = devfs_register (usb_devfs_handle, name,
			       DEVFS_FL_DEFAULT, USB_MAJOR,
			       MINOR_ID + i,
			       S_IFCHR | S_IRUSR | S_IWUSR | 
			       S_IRGRP | S_IWGRP | S_IROTH, 
			       &usbdmx_fops, NULL);
#endif
  
  /* let the user know what node this device is now attached to */
  info("%s now attached to %s (MINOR = %d)", 
       device_information[type].name, 
       name, 
       MINOR_ID + dmx->minor);

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
  return dmx;
#else
  return 0;
#endif
}

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
static void usbdmx_disconnect(struct usb_device *dev, void *ptr) 
{
  struct usbdmx_data *dmx = (struct usbdmx_data *)ptr;
#else
static void usbdmx_disconnect(struct usb_interface *interface)
{
  struct usbdmx_data *dmx =  usb_get_intfdata(interface);
  usb_set_intfdata(interface, NULL);
#endif

#if 0  
  if (dmx->isopen) {
    dmx->isopen = 0;
    
    /* better let it finish - the release will do whats needed */
    dmx->dmx_dev = NULL;
    return;
  }
#endif
  dmx->present = 0;
  dmx->dmx_dev = NULL;

  info("%s disconnected.", device_information[dmx->type].name);

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
  /* give back our minor */
  usb_deregister_dev(interface, &usbdmx_class);
#else
  /* remove our devfs node */
  devfs_unregister(dmx->devfs);
#endif
}

/*
 * properties of this driver
 */
static struct usb_driver usbdmx_driver = {
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
  .owner      = THIS_MODULE,
#endif
  .name       = "usbdmx",
  .probe      = usbdmx_probe,
  .disconnect = usbdmx_disconnect,
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
  .fops       = &usbdmx_fops,
  .minor      = MINOR_ID,
#endif
  .id_table   = usbdmx_table
};

/*
 * usbdmx_init(): start the module
 */
static int __init usbdmx_init(void) {
  int i;

  for(i = 0; i < DEVICES_MAX; ++i)
  {
    struct usbdmx_data *dmx = &dmx_instance[i];
    
    dmx->present = 0;
    dmx->dmx_dev = NULL;
  }

  // register driver to the usb subsystem  
  if (usb_register(&usbdmx_driver) < 0) {
    err("registering driver to the usb-system failed, check the MINOR_ID");
    return -1;
  }

  info("USBDMX support registered.");
  return 0;
}

/*
 * usbdmx_cleanup(): clean up module
 */
static void __exit usbdmx_cleanup(void) {
  usb_deregister(&usbdmx_driver);
}

module_init(usbdmx_init);
module_exit(usbdmx_cleanup);

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
// don't export any symbols to the kernel
EXPORT_NO_SYMBOLS;
#endif
