VERSION 5.00
Begin VB.Form USBTEST 
   BackColor       =   &H80000010&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Peperoni USB DMX interface test"
   ClientHeight    =   3345
   ClientLeft      =   5160
   ClientTop       =   4335
   ClientWidth     =   5430
   LinkTopic       =   "Form1"
   MinButton       =   0   'False
   ScaleHeight     =   3345
   ScaleWidth      =   5430
   Begin VB.CommandButton Command1 
      Caption         =   "OPEN PORT"
      Height          =   375
      Left            =   3720
      TabIndex        =   7
      Top             =   360
      Width           =   1515
   End
   Begin VB.Timer AutoXMit 
      Enabled         =   0   'False
      Interval        =   50
      Left            =   4680
      Top             =   2400
   End
   Begin VB.VScrollBar VScroll1 
      Enabled         =   0   'False
      Height          =   2655
      Index           =   5
      LargeChange     =   20
      Left            =   2640
      Max             =   0
      Min             =   255
      TabIndex        =   6
      Top             =   360
      Width           =   315
   End
   Begin VB.VScrollBar VScroll1 
      Enabled         =   0   'False
      Height          =   2655
      Index           =   4
      LargeChange     =   20
      Left            =   2160
      Max             =   0
      Min             =   255
      TabIndex        =   5
      Top             =   360
      Width           =   315
   End
   Begin VB.VScrollBar VScroll1 
      Enabled         =   0   'False
      Height          =   2655
      Index           =   3
      LargeChange     =   20
      Left            =   1680
      Max             =   0
      Min             =   255
      TabIndex        =   4
      Top             =   360
      Width           =   315
   End
   Begin VB.VScrollBar VScroll1 
      Enabled         =   0   'False
      Height          =   2655
      Index           =   2
      LargeChange     =   20
      Left            =   1200
      Max             =   0
      Min             =   255
      TabIndex        =   3
      Top             =   360
      Width           =   315
   End
   Begin VB.VScrollBar VScroll1 
      Enabled         =   0   'False
      Height          =   2655
      Index           =   1
      LargeChange     =   20
      Left            =   720
      Max             =   0
      Min             =   255
      TabIndex        =   2
      Top             =   360
      Width           =   315
   End
   Begin VB.CommandButton Command2 
      Caption         =   "CLOSE PORT"
      Height          =   375
      Left            =   3720
      TabIndex        =   1
      Top             =   840
      Width           =   1515
   End
   Begin VB.VScrollBar VScroll1 
      Enabled         =   0   'False
      Height          =   2655
      Index           =   0
      LargeChange     =   20
      Left            =   240
      Max             =   0
      Min             =   255
      TabIndex        =   0
      Top             =   360
      Width           =   315
   End
   Begin VB.Menu mnufile 
      Caption         =   "File"
      Begin VB.Menu mnufile_End 
         Caption         =   "END"
         Shortcut        =   ^{F4}
      End
   End
End
Attribute VB_Name = "USBTEST"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' The idea for this programm was taken from www.pcdmx.de

Private Sub AutoXMit_Timer()
'Use this timer to regularly transfer DMX values from the
'application to the interface.
  If interface_open > 0 Then
    dummy = usbdmx_tx_set(usbdmxhandle, dmxdata(0), 512)
  End If
End Sub

Private Sub Command1_Click()

Dim i
Dim result

  interface_open = usbdmx_open(0, usbdmxhandle)
   
    If interface_open <> 0 Then
      If usbdmx_is_rodin1(usbdmxhandle) Then
        USBTEST.Caption = "Rodin1 opened succesfully"
      ElseIf usbdmx_is_rodin2(usbdmxhandle) Then
        USBTEST.Caption = "Rodin2 opened succesfully !!! DMXin interface !!!"
      ElseIf usbdmx_is_rodint(usbdmxhandle) Then
        USBTEST.Caption = "RodinT opened succesfully"
      ElseIf usbdmx_is_xswitch(usbdmxhandle) Then
        USBTEST.Caption = "USBDMX X-Switch opened succesfully"
      ElseIf usbdmx_is_usbdmx21(usbdmxhandle) Then
        USBTEST.Caption = "USBDMX21 opened succesfully !!! transmitting on first universe !!!"
      Else
        USBTEST.Caption = "Other USB DMX Interface opened succesfully"
      End If
      'Interface opened succesfully. Now set all computer
      'output varaibles zu their respective values or zero.
      For i = 0 To 511
        dmxdata(i) = 0
      Next i
      For i = 0 To cnum - 1
        VScroll1(i).Enabled = True
        dmxdata(i) = VScroll1(i).Value
      Next i
      'or zero interface output, respectively.
      dummy = usbdmx_tx_set(usbdmxhandle, dmxdata(0), 512)
      AutoXMit.Enabled = True
    Else
      'if not opened / interface not found
      USBTEST.Caption = "No interface found"
      AutoXMit.Enabled = False
    End If
End Sub


Private Sub Command2_Click()
    If interface_open > 0 Then
      dummy = usbdmx_close(usbdmxhandle)
      USBTEST.Caption = "Interface CLOSED"
      interface_open = 0
      AutoXMit.Enabled = False
    End If
End Sub


Private Sub Form_Initialize()
    interface_open = 0
End Sub

Private Sub Form_Unload(Cancel As Integer)

  If interface_open <> 0 Then
      interface_open = usbdmx_close(usbdmxhandle)
  End If
End Sub


Private Sub mnufile_End_Click()
  'Termination of program closes the interface
  Call Command2_Click
End Sub

Private Sub VScroll1_Change(Index As Integer)
  dmxdata(Index) = VScroll1(Index).Value
End Sub


Private Sub VScroll1_Scroll(Index As Integer)
  Call VScroll1_Change(Index)
End Sub


