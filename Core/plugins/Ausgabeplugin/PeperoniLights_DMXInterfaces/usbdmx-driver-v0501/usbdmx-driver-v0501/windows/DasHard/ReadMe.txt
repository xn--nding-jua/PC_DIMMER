DasHard.DLL
===========

Overview:
---------
This DLL was designed to replace any other DasHard.DLL to operate the software with
one of Peperonis USB DMX512 interfaces. It supports up to 10 interfaces and all commands 
of the original DasHard.DLL by returning at least DHE_OK. Commands OPEN, CLOSE, DMXOUT
and DMXOUTOFF are implemented to operate the connected interface. The USBDMX.DLL is
needed by the DasHard.DLL.

Installation:
-------------
Since not all commands of the DasHard.dll are well documented one can use the old .dll to 
server commands not handled by the replacement. For that to work the replacement .dll is
trying to open the orignal .dll with the name "DasHard.orig.dll" on startup. On success
all commands not handled by the replacement are send down to the original for handling.

- Rename the orignial DasHard.DLL to DasHard.orig.DLL
- Copy the new DasHard.dll to the location of the original, finished!

Node:
-----
The DasHard.dll does not supports names of interfaces, it only returnes their identity.
This circumstance makes any of Peperonis interfaces look like Soundlight USBDMX1 and
USBDMX2 to the software.

In case of trouble please do not hesitate to contact driver@lighting-solutions.de.
Thank You!
