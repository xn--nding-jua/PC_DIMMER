This is the Windows driver for Peperonis/Lighting-Solutions USB to DMX512 intefaces 
Rodin1, Rodin2, RodinT, USBDMX X-Switch and USBDMX21.
The latest Version can be found on http://www.lighting-solutions/support/usbdmx

To install the driver connect the interface and point the installation procedure to
the suppied .INF file.

The directoty C contrains the Visual C projects demo1 and demo2 in which you can find 
starting point for your interface programming in C/C++. You will also find usbdmx.h, the 
header file for the .DLL and usbdmx.lib, the library you can link your project against. 
Doing so allows you to just use the functions supplied by the .DLL without the need for
extra dll handling stuff, but requires the dll to be present. demo2 shows how to use
the USBDMX.DLL with rund-time dynamic linking which can handle the situation, that the
dll is not present. This is how demo.cpp was build up.

The directory VB contrains a very simple demo written in Visual Basis.

The directory DasHard contrains a replacement for the DasHard.dll found to operate some
other interfaces. For details please see ReadMe.txt within the directory.

In case of trouble or problems please do not hesitate to contact 
driver@lighting-solutions.de or call +49/40/600877-51. Thank You!
