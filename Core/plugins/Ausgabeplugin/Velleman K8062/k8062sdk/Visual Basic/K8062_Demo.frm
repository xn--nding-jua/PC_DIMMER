VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "K8062 Light Controller Demo"
   ClientHeight    =   3345
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4020
   LinkTopic       =   "Form1"
   ScaleHeight     =   3345
   ScaleWidth      =   4020
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Height          =   315
      Left            =   2820
      TabIndex        =   4
      Text            =   "1"
      Top             =   2580
      Width           =   795
   End
   Begin VB.VScrollBar VScroll1 
      Height          =   2595
      Index           =   3
      Left            =   2040
      Max             =   255
      TabIndex        =   3
      Top             =   300
      Value           =   255
      Width           =   315
   End
   Begin VB.VScrollBar VScroll1 
      Height          =   2595
      Index           =   2
      Left            =   1440
      Max             =   255
      TabIndex        =   2
      Top             =   300
      Value           =   255
      Width           =   315
   End
   Begin VB.VScrollBar VScroll1 
      Height          =   2595
      Index           =   1
      Left            =   840
      Max             =   255
      TabIndex        =   1
      Top             =   300
      Value           =   255
      Width           =   315
   End
   Begin VB.VScrollBar VScroll1 
      Height          =   2595
      Index           =   0
      Left            =   240
      Max             =   255
      TabIndex        =   0
      Top             =   300
      Value           =   255
      Width           =   315
   End
   Begin VB.Label Label3 
      Caption         =   " 00"
      Height          =   195
      Index           =   3
      Left            =   2040
      TabIndex        =   13
      Top             =   60
      Width           =   315
   End
   Begin VB.Label Label3 
      Caption         =   " 00"
      Height          =   195
      Index           =   2
      Left            =   1440
      TabIndex        =   12
      Top             =   60
      Width           =   315
   End
   Begin VB.Label Label3 
      Caption         =   " 00"
      Height          =   195
      Index           =   1
      Left            =   840
      TabIndex        =   11
      Top             =   60
      Width           =   315
   End
   Begin VB.Label Label3 
      Caption         =   " 00"
      Height          =   195
      Index           =   0
      Left            =   240
      TabIndex        =   10
      Top             =   60
      Width           =   315
   End
   Begin VB.Label Label2 
      Caption         =   "4"
      Height          =   195
      Index           =   3
      Left            =   2100
      TabIndex        =   9
      Top             =   3000
      Width           =   375
   End
   Begin VB.Label Label2 
      Caption         =   "3"
      Height          =   195
      Index           =   2
      Left            =   1500
      TabIndex        =   8
      Top             =   3000
      Width           =   375
   End
   Begin VB.Label Label2 
      Caption         =   "2"
      Height          =   195
      Index           =   1
      Left            =   900
      TabIndex        =   7
      Top             =   3000
      Width           =   375
   End
   Begin VB.Label Label2 
      Caption         =   "1"
      Height          =   195
      Index           =   0
      Left            =   300
      TabIndex        =   6
      Top             =   3000
      Width           =   375
   End
   Begin VB.Label Label1 
      Caption         =   "Start address:"
      Height          =   255
      Left            =   2760
      TabIndex        =   5
      Top             =   2220
      Width           =   1095
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Declare Sub StartDevice Lib "k8062d.dll" ()
Private Declare Sub SetData Lib "k8062d.dll" (ByVal Channel As Long, ByVal Data As Long)
Private Declare Sub SetChannelCount Lib "k8062d.dll" (ByVal Count As Long)
Private Declare Sub StopDevice Lib "k8062d.dll" ()

Private Sub Form_Load()
    StartDevice
End Sub

Private Sub Form_Terminate()
    StopDevice
End Sub

Private Sub UpdateLabels()
    Dim i As Integer
    Dim n As Integer
    n = 0
    If (Val(Text1.Text) > 0) And (Val(Text1.Text) < 510) Then
        For i = Val(Text1.Text) To Val(Text1.Text) + 3
            Label2(n) = Str(i)
            n = n + 1
        Next i
        SetChannelCount Val(Text1.Text) + 3
    End If
End Sub

Private Sub Text1_Change()
    UpdateLabels
End Sub

Private Sub VScroll1_Change(Index As Integer)
    Label3(Index) = Str(255 - VScroll1(Index).Value)
    SetData Val(Label2(Index)), Val(Label3(Index))
End Sub

Private Sub VScroll1_Scroll(Index As Integer)
    Label3(Index) = Str(255 - VScroll1(Index).Value)
    SetData Val(Label2(Index)), Val(Label3(Index))
End Sub
