#
# Makefile for the USBDMX-driver for Peperoni's USBDMX interfaces
#
# in case of trouble, please contact driver@lighting-solutions.de
#

# path to kernel 2.4 sources
K24_PATH = /lib/modules/`uname -r`/build

# path to kernel 2.6 sources
K26_PATH = /lib/modules/`uname -r`/build

# define if to compile the module for kernel 2.4 or 2.6
#COMPILE_VERSION = k24
#COMPILE_VERSION = k26
#COMPILE_VERSION = k24 k26

#############################################################################
# definitions for kernel 2.4.x
KCFLAGS24 = -I$(K24_PATH)/include \
            -O2 -Wall -Wstrict-prototypes -Wno-trigraphs \
	    -fno-strict-aliasing -fno-common -fomit-frame-pointer \
            -D__KERNEL__ -DMODULE -Wall -nostdinc -iwithprefix include

#           -DMODVERSIONS -include $(KINC)/linux/modversions.h
CC24	  = gcc
CFLAGS24  = -Wall -g

#############################################################################
# definitions for kernel 2.6.x
obj-m += usbdmx.o

#############################################################################
# definitions for the demo program
PROGRAMS = demo

#############################################################################
# targets

all: $(PROGRAMS)

clean:
	rm -f $(PROGRAMS) *~

k24: usbdmx.o

usbdmx.o: usbdmx.c usbdmx.h
	$(CC24) $(KCFLAGS24) -c -o $*.o $<

clean24:
	rm -f usbdmx.o

k26:
	make -C $(K26_PATH) M=$(PWD) modules

clean26:
	make -C $(K26_PATH) M=$(PWD) clean
