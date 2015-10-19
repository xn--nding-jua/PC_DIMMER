VERSION 5.00
Begin VB.Form Parzic 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   Caption         =   "Parzic"
   ClientHeight    =   0
   ClientLeft      =   165
   ClientTop       =   450
   ClientWidth     =   1875
   LinkTopic       =   "Form1"
   ScaleHeight     =   0
   ScaleWidth      =   1875
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer Timer1 
      Interval        =   200
      Left            =   0
      Top             =   0
   End
End
Attribute VB_Name = "Parzic"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Timer1_Timer()
    runit
End Sub
