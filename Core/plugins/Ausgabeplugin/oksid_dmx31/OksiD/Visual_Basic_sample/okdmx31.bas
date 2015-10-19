Attribute VB_Name = "Module1"
Public Declare Function Okdmx31Read Lib "okdmx31.dll" _
(ByVal PortAddress As Integer, ByVal Universe As Byte, Buffer As Byte) As Integer

Public Declare Function Okdmx31Write Lib "okdmx31.dll" _
(ByVal PortAddress As Integer, ByVal Universe As Byte, Buffer As Byte) As Integer


