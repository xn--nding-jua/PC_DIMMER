VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Intelligent Usb Dmx Interface"
   ClientHeight    =   2565
   ClientLeft      =   45
   ClientTop       =   270
   ClientWidth     =   3750
   LinkTopic       =   "Form1"
   ScaleHeight     =   2565
   ScaleWidth      =   3750
   StartUpPosition =   3  'Windows Default
   Begin VB.HScrollBar channel_scroll 
      Height          =   492
      Left            =   840
      Max             =   512
      Min             =   1
      TabIndex        =   2
      Top             =   1800
      Value           =   1
      Width           =   2652
   End
   Begin VB.VScrollBar level_scroll 
      Height          =   1452
      Left            =   120
      Max             =   255
      TabIndex        =   0
      Top             =   960
      Value           =   1
      Width           =   492
   End
   Begin VB.Label hardware_text 
      Caption         =   "Label1"
      Height          =   615
      Left            =   2280
      TabIndex        =   5
      Top             =   480
      Width           =   1335
   End
   Begin VB.Label Title 
      Caption         =   "Sample Source code using Visual Basic 6.0"
      Height          =   252
      Left            =   120
      TabIndex        =   4
      Top             =   120
      Width           =   3612
   End
   Begin VB.Label channel_text 
      Caption         =   "Label1"
      Height          =   252
      Left            =   1560
      TabIndex        =   3
      Top             =   1440
      Width           =   1932
   End
   Begin VB.Label level_text 
      Caption         =   "Label1"
      Height          =   252
      Left            =   120
      TabIndex        =   1
      Top             =   600
      Width           =   1812
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const DMXCHANNEL = 512

Const DHC_SIUDI0 = 0                ' COMMAND
Const DHC_SIUDI1 = 100              ' COMMAND
Const DHC_SIUDI2 = 200              ' COMMAND
Const DHC_SIUDI3 = 300              ' COMMAND
Const DHC_SIUDI4 = 400              ' COMMAND
Const DHC_SIUDI5 = 500              ' COMMAND
Const DHC_SIUDI6 = 600              ' COMMAND
Const DHC_SIUDI7 = 700              ' COMMAND
Const DHC_SIUDI8 = 800              ' COMMAND
Const DHC_SIUDI9 = 900              ' COMMAND

Const DHC_INIT = 9  ' COMMAND
Const DHC_EXIT = 10 ' COMMAND

Const DHC_OPEN = 1 ' COMMAND
Const DHC_CLOSE = 2 ' COMMAND
Const DHC_DMXOUTOFF = 3 ' COMMAND
Const DHC_DMXOUT = 4 ' COMMAND
Const DHC_PORTREAD = 5 ' COMMAND


Const DHE_OK = 1  ' RETURN NO ERROR

Const DHE_ERROR_COMMAND = -1 ' RETURN ERROR
Const DHE_ERROR_NOTOPEN = -2 ' RETURN ERROR

Dim channel_select As Integer
Dim dmxdata(512) As Byte
Dim hardware_ok As Integer

Dim command As Integer
Dim channels As Integer
Dim result As Integer



Private Sub Form_Load()
    channels = DMXCHANNEL
    For i = 1 To channels
        dmxdata(i) = 0
    Next i
    channel_select = 1
    Call set_level
    Call Show_channel
    Call Show_level
    command = DHC_INIT
    hardware_ok = DasUsbCommand(command, 0, 0)
    command = DHC_OPEN
    hardware_ok = DasUsbCommand(command, 0, 0)
    If hardware_ok > 0 Then
        hardware_text = "Interface: found"
        command = DHC_DMXOUTOFF
        result = DasUsbCommand(command, channels, dmxdata(1))
    Else
        hardware_text = "Interface: not found"
    End If

End Sub

Private Sub Form_Unload(Cancel As Integer)
    If hardware_ok > 0 Then
            command = DHC_CLOSE
            result = DasUsbCommand(command, 0, 0)
            command = DHC_EXIT
            result = DasUsbCommand(command, 0, 0)
    End If
End Sub

Private Sub level_scroll_Change()
    dmxdata(channel_select) = CByte(255 - level_scroll.Value)
    If hardware_ok > 0 Then
            command = DHC_DMXOUT
            result = DasUsbCommand(command, channels, dmxdata(1))
    End If
    Call Show_channel
    Call Show_level
End Sub

Private Sub channel_scroll_Change()
    channel_select = channel_scroll.Value
    Call set_level
    Call Show_channel
    Call Show_level
End Sub

Private Sub Show_channel()
    channel_text = "Channel " + CStr(channel_select) + "/512"
End Sub

Private Sub Show_level()
    level_text = "DMX Level " + CStr(dmxdata(channel_select))
End Sub

Private Sub set_level()
    level_scroll.Value = 255 - dmxdata(channel_select)
End Sub

