VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form Form1 
   Caption         =   "OksiD DMX test"
   ClientHeight    =   3120
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4590
   LinkTopic       =   "Form1"
   ScaleHeight     =   3120
   ScaleWidth      =   4590
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text5 
      Height          =   285
      Left            =   3360
      TabIndex        =   11
      Text            =   "0"
      Top             =   1560
      Width           =   855
   End
   Begin VB.TextBox Text4 
      Height          =   285
      Left            =   3360
      TabIndex        =   10
      Text            =   "0"
      Top             =   1200
      Width           =   855
   End
   Begin VB.Timer Timer1 
      Interval        =   50
      Left            =   3480
      Top             =   600
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   3360
      TabIndex        =   9
      Text            =   "None"
      Top             =   120
      Width           =   1095
   End
   Begin VB.TextBox Text3 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   2400
      TabIndex        =   6
      Text            =   "0"
      Top             =   120
      Width           =   615
   End
   Begin VB.TextBox Text2 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   1320
      TabIndex        =   3
      Text            =   "0"
      Top             =   120
      Width           =   615
   End
   Begin VB.TextBox Text1 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   360
      TabIndex        =   1
      Text            =   "0"
      Top             =   120
      Width           =   615
   End
   Begin ComctlLib.Slider Slider1 
      Height          =   2175
      Left            =   360
      TabIndex        =   0
      Top             =   480
      Width           =   630
      _ExtentX        =   1111
      _ExtentY        =   3836
      _Version        =   327682
      Orientation     =   1
      Max             =   255
      SelStart        =   255
      TickStyle       =   2
      TickFrequency   =   0
      Value           =   255
   End
   Begin ComctlLib.Slider Slider2 
      Height          =   2175
      Left            =   1320
      TabIndex        =   4
      Top             =   480
      Width           =   630
      _ExtentX        =   1111
      _ExtentY        =   3836
      _Version        =   327682
      Orientation     =   1
      Max             =   255
      SelStart        =   255
      TickStyle       =   2
      TickFrequency   =   0
      Value           =   255
   End
   Begin ComctlLib.Slider Slider3 
      Height          =   2175
      Left            =   2400
      TabIndex        =   7
      Top             =   480
      Width           =   630
      _ExtentX        =   1111
      _ExtentY        =   3836
      _Version        =   327682
      Orientation     =   1
      Max             =   255
      SelStart        =   255
      TickStyle       =   2
      TickFrequency   =   0
      Value           =   255
   End
   Begin VB.Label Label4 
      Caption         =   "DMX 512"
      Height          =   255
      Left            =   3480
      TabIndex        =   12
      Top             =   2280
      Width           =   855
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      Caption         =   "U3/C512"
      Height          =   255
      Left            =   2280
      TabIndex        =   8
      Top             =   2760
      Width           =   855
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      Caption         =   "U2/C1"
      Height          =   255
      Left            =   1200
      TabIndex        =   5
      Top             =   2760
      Width           =   855
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "U1/C1"
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   2760
      Width           =   855
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim IN1(511) As Byte
Dim Port As Integer
Dim U2(511) As Byte
Dim U3(511) As Byte
Dim U1(511) As Byte



Private Sub Combo1_Click()
    Dim i As Integer
    i = Combo1.ListIndex
    If 1 = i Then
        Port = Val("&H378")
    ElseIf 2 = i Then
        Port = Val("&H278")
    Else
        Port = 0
    End If
End Sub

Private Sub Form_Load()
    Combo1.AddItem "None", 0
    Combo1.AddItem "LPT1:", 1
    Combo1.AddItem "LPT2:", 2
    Port = 0
End Sub

Private Sub Slider1_Click()
    Text1.Text = 255 - Slider1.Value
    U1(0) = 255 - Slider1.Value
End Sub

Private Sub Slider2_Click()
    Text2.Text = 255 - Slider2.Value
    U2(0) = 255 - Slider2.Value
End Sub

Private Sub Slider3_Click()
    Text3.Text = 255 - Slider3.Value
    U3(511) = 255 - Slider3.Value
End Sub

Private Sub Timer1_Timer()
    
    If Port > 0 Then
        If (Okdmx31Read(Port, 0, IN1(0)) <> 0) Then
            Port = 0
            Combo1.ListIndex = 0
        End If
        Text4.Text = IN1(0)
        Text5.Text = IN1(511)
    End If
    If Port > 0 Then
        If (Okdmx31Write(Port, 0, U1(0)) <> 0) Then
            Port = 0
            Combo1.ListIndex = 0
        End If
    End If
    If Port > 0 Then
        If (Okdmx31Write(Port, 1, U2(0)) <> 0) Then
            Port = 0
            Combo1.ListIndex = 0
        End If
    End If
    If Port > 0 Then
        If (Okdmx31Write(Port, 2, U3(0)) <> 0) Then
            Port = 0
            Combo1.ListIndex = 0
        End If
    End If
End Sub
