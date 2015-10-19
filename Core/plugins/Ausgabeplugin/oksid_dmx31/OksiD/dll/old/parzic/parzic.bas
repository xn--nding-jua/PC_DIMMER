Attribute VB_Name = "Module1"
Option Explicit

Public Const DLL_PROCESS_DETACH = 0
Public Const DLL_PROCESS_ATTACH = 1
Public Const DLL_THREAD_ATTACH = 2
Public Const DLL_THREAD_DETACH = 3
Dim ValeurDMX(1 To 512) As Integer
Dim comptetrame As Integer
Dim n As Integer
Dim BaseAddress As Integer

'Inp and Out declarations for direct port I/O
'in 32-bit Visual Basic 4 programs.

Public Declare Function Inp Lib "inpout32.dll" _
Alias "Inp32" (ByVal PortAddress As Integer) As Integer
Public Declare Sub Out Lib "inpout32.dll" _
Alias "Out32" (ByVal PortAddress As Integer, ByVal Value As Integer)




Public Function DllMain(hInst As Long, fdwReason As Long, lpvReserved As Long) As Boolean
   Select Case fdwReason
      Case DLL_PROCESS_DETACH
         ' No per-process cleanup needed
      Case DLL_PROCESS_ATTACH
         
      Case DLL_THREAD_ATTACH
         ' No per-thread initialization needed
      Case DLL_THREAD_DETACH
         ' No per-thread cleanup needed
   End Select
   DllMain = True
End Function


Sub debugger(mes As String)
   Open "debug.txt" For Binary Access Write As #1
    Write #1, mes
    Close #1
End Sub

Sub Main()

End Sub

Public Function Parzic(ByVal Command As Long, ByVal Parameter As Long, ByRef Buffer() As Byte) As Long
    Dim canal As Integer
    Open "debug.txt" For Binary Access Write As #1
    For canal = 1 To n
        ValeurDMX(canal) = Buffer(canal - 1)
    Next canal
    Parzic = 0
    Exit Function
End Function
Public Function Parzic1(ByVal Command As Long, ByVal Parameter As Long, ByRef Buffer() As Byte) As Long
    Dim canal As Integer
    Open "debug.txt" For Binary Access Write As #1
    Write #1, "yo"
    Close #1
    n = 512
    
    debugger ("enter")
    
    BaseAddress = &H378
    For canal = 1 To n
        ValeurDMX(canal) = Buffer(canal - 1)
    Next canal
    debugger ("after for")
    init
    debugger ("after init")
    Parzic1 = 0
    Exit Function
End Function


Public Sub init()

comptetrame = comptetrame + 1
If comptetrame > 32000 Then comptetrame = 0
Out BaseAddress + 2, &H10
Call envoitrame

End Sub


Public Sub envoitrame()
Dim timecount As Integer
Dim a As Integer
Dim canal As Integer
'mettre /init à 1 et strobe à 1

Out BaseAddress + 2, &H14
' envoi du 1er byte de config : 0

canal = n

If n > 255 Then
Out BaseAddress, &H1
canal = n - 256
Else: Out BaseAddress, &H0
End If
' mise a 0 de strobe
Out BaseAddress + 2, &H15
'attente be busy à 1
timecount = 0
a = &H80
While a = &H80
a = Inp(BaseAddress + 1) And &H80
timecount = timecount + 1
If timecount = 100 Then
a = &H0
timecount = 0
End If


Wend
' envoi du nombre de slots
envoibyte (canal)
' envoi de l'octet de start dmx
envoibyte (0)
' envoi de toutes les valeurs

For canal = 1 To n
envoibyte (ValeurDMX(canal))
Next canal

End Sub

Public Sub envoibyte(valeur As Integer)

Dim a As Integer
Dim timecount As Integer

timecount = 0

'test ACK à 0
timecount = 0
a = &H0
While a = &H0
a = Inp(BaseAddress + 1) And &H40
timecount = timecount + 1
If timecount = 100 Then
a = &H40
timecount = 0
End If

'ReadPorts
Wend
'tempo (10000)
'ReadPorts
'envoi de la donnée
Out BaseAddress, valeur

'tempo (10000)
'mise à 1 de strobe
Out BaseAddress + 2, &H14


'test ACK à 1
timecount = 0
a = &H40
While a = &H40
a = Inp(BaseAddress + 1) And &H40
timecount = timecount + 1
If timecount = 100 Then
a = &H0
timecount = 0
End If

Wend

'attente du busy à 0
timecount = 0
a = &H0
While a = &H0
a = Inp(BaseAddress + 1) And &H80
timecount = timecount + 1
If timecount = 100 Then
a = &H80
timecount = 0
End If

Wend

'mise à zero du strobe
Out BaseAddress + 2, &H15

'attente du busy à 1
a = &H80
timecount = 0
While a = &H80
a = Inp(BaseAddress + 1) And &H80
timecount = timecount + 1
If timecount = 100 Then
a = &H0
timecount = 0
End If

Wend


End Sub




