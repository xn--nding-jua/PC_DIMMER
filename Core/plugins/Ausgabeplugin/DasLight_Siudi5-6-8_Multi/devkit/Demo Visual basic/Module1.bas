Attribute VB_Name = "Module1"
'*********************************************
'DLL subroutines declaration
'*********************************************

Declare Function DasUsbCommand Lib "DasHard2006VB.dll" (ByVal command As Long, ByVal param As Long, ByRef dmxdata As Byte) As Integer
