/* 
 * demo code for the usbdmx driver
 */

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>

/* the include file ... */
#include "usbdmx.h"

/* where do we find the interface */
#define DEVICE "/dev/usbdmx0"

int main(int argc, char **argv)
{
  unsigned char buf[512]; /* buffer for one frame */
  long frames;
  char startcode;
  int f;

  /* open the device */
  f = open(DEVICE, O_RDWR);

  if (f == -1) {
    char str[128];
    sprintf(str, "Error open device \"%s\"", DEVICE);
    perror(str);
    exit(1);
  }

  /* read in terface memory non-blocking */
  ioctl(f, DMX_BLOCKING_SET, 0);

  /* select memory map */
  ioctl(f, DMX_MEM_MAP_SET, DMX_RX_MEM);
  /* move to beginning of map */
  lseek(f, 0, SEEK_SET);
  /* read data */
  read(f, buf, sizeof(buf));

  /* blocking or not... */
  ioctl(f, DMX_BLOCKING_SET, 1);

  /* select memory map */
  ioctl(f, DMX_MEM_MAP_SET, DMX_TX_MEM);
  /* move to beginning of map */
  lseek(f, 0, SEEK_SET);
  /* write data */
  write(f, buf, sizeof(buf));

  /* read frame counter */
  frames = ioctl(f, DMX_TX_FRAMES_GET);
  printf("usbdmx transmitter frame counter: %ld\n", frames);

  /* read receiver startcode */
  startcode = ioctl(f, DMX_RX_STARTCODE_GET);

  /* write startcode to transmitter */
  ioctl(f, DMX_TX_STARTCODE_SET, startcode);

  return 0;
}
