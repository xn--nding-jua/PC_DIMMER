Attribute VB_Name = "Module1"
Rem Application - specific
Rem ----------------------
Global interface_open As Integer
Global dmxdata(0 To 512) As Byte
Global Const cnum  As Integer = 6     'number of faders
Global timercount As Integer
Global usbdmxhandle As Long

