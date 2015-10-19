
Public Class Console
    Inherits System.Windows.Forms.Form

    Public Declare Function OksidCommand Lib "DasHard.dll" _
        (ByVal Command As Integer, ByVal Parameter As Integer, _
            ByVal Buffer As Byte) As Integer

#Region " Code généré par le Concepteur Windows Form "

    Public Sub New()
        MyBase.New()

        'Cet appel est requis par le Concepteur Windows Form.
        InitializeComponent()

        'Ajoutez une initialisation quelconque après l'appel InitializeComponent()

    End Sub

    'La méthode substituée Dispose du formulaire pour nettoyer la liste des composants.
    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Requis par le Concepteur Windows Form
    Private components As System.ComponentModel.IContainer

    'REMARQUE : la procédure suivante est requise par le Concepteur Windows Form
    'Elle peut être modifiée en utilisant le Concepteur Windows Form.  
    'Ne la modifiez pas en utilisant l'éditeur de code.
    Friend WithEvents Timer1 As System.Windows.Forms.Timer
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Me.Timer1 = New System.Windows.Forms.Timer(Me.components)
        '
        'Timer1
        '
        Me.Timer1.Enabled = True
        Me.Timer1.Interval = 30
        '
        'Console
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.AutoScroll = True
        Me.ClientSize = New System.Drawing.Size(544, 373)
        Me.Name = "Console"
        Me.Text = "DMX 512 Console"

    End Sub

#End Region

   
    Private Sub Form2_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim i As Integer
        Dim f1 As Form1
        f1 = New Form1
        f1.Show()

        Sa = New SliderArray(Me)
        la = New LabelArray(Me)
        ta = New TextArray(Me)
        Hide()
        For i = 1 To 512
            Sa.AddNewSlider()
            la.AddNewLabel()
            ta.AddNewText()
        Next i
        Show()
        f1.Hide()
        f1.Dispose()
    End Sub

    Private Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick
        OksidCommand(4, 512, Buffer(0))
    End Sub
End Class

Public Module data
    Public Buffer(512) As Byte
    Public Sa As SliderArray
    Public la As LabelArray
    Public ta As TextArray
End Module

Public Class SliderArray
    Inherits System.Collections.CollectionBase

    Private ReadOnly HostForm As System.Windows.Forms.Form

    Public Sub New(ByVal host As System.Windows.Forms.Form)
        HostForm = host
    End Sub

    Public Function AddNewSlider() As System.Windows.Forms.TrackBar
        ' Create a new instance of the Button class.
        Dim aSlider As New System.Windows.Forms.TrackBar
        ' Add the button to the collection's internal list.
        aSlider.Orientation = Orientation.Vertical
        aSlider.TickStyle = TickStyle.Both

        Me.List.Add(aSlider)
        ' Add the button to the controls collection of the form 
        ' referenced by the HostForm field.
        HostForm.Controls.Add(aSlider)
        ' Set intial properties for the button object.
        aSlider.Top = 24
        aSlider.Left = 8 + (Count - 1) * 48
        aSlider.Height = 304
        aSlider.Width = 42
        aSlider.Tag = Me.Count
        aSlider.Maximum = 255
        aSlider.Minimum = 0
        aSlider.LargeChange = 16
        aSlider.TickFrequency = 32
        AddHandler aSlider.ValueChanged, AddressOf ChangeHandler

        Return aSlider
    End Function

    Default Public ReadOnly Property Item(ByVal Index As Integer) As _
       System.Windows.Forms.TrackBar
        Get
            Return CType(Me.List.Item(Index), System.Windows.Forms.TrackBar)
        End Get
    End Property

    Public Sub ChangeHandler(ByVal sender As Object, ByVal e As _
       System.EventArgs)
        Dim us As TrackBar
        us = CType(sender, System.Windows.Forms.TrackBar)
        data.Buffer(us.Tag - 1) = us.Value
        ta.Item(us.Tag - 1).Text = data.Buffer(us.Tag - 1).ToString
    End Sub
End Class

Public Class LabelArray
    Inherits System.Collections.CollectionBase

    Private ReadOnly HostForm As System.Windows.Forms.Form

    Public Sub New(ByVal host As System.Windows.Forms.Form)
        HostForm = host
    End Sub

    Public Function AddNewLabel() As System.Windows.Forms.Label
        ' Create a new instance of the Button class.
        Dim aLabel As New System.Windows.Forms.Label
        ' Add the button to the collection's internal list.

        Me.List.Add(aLabel)
        ' Add the button to the controls collection of the form 
        ' referenced by the HostForm field.
        HostForm.Controls.Add(aLabel)
        ' Set intial properties for the button object.
        aLabel.Top = 8
        aLabel.Left = 10 + (Count - 1) * 48
        aLabel.Height = 16
        aLabel.Width = 40
        aLabel.Text = Me.Count.ToString
        aLabel.TextAlign = ContentAlignment.MiddleCenter
        Return aLabel
    End Function

End Class

Public Class TextArray
    Inherits System.Collections.CollectionBase

    Private ReadOnly HostForm As System.Windows.Forms.Form

    Public Sub New(ByVal host As System.Windows.Forms.Form)
        HostForm = host
    End Sub

    Public Function AddNewText() As System.Windows.Forms.TextBox
        ' Create a new instance of the Button class.
        Dim aText As New System.Windows.Forms.TextBox
        ' Add the button to the collection's internal list.

        Me.List.Add(aText)
        ' Add the button to the controls collection of the form 
        ' referenced by the HostForm field.
        HostForm.Controls.Add(aText)
        ' Set intial properties for the button object.
        aText.Top = 328
        aText.Left = 8 + (Count - 1) * 48
        aText.Height = 20
        aText.Width = 40
        aText.Text = "000"
        aText.Tag = Count
        aText.TextAlign = HorizontalAlignment.Center
        AddHandler aText.TextChanged, AddressOf ChangeHandler
        Return aText
    End Function

    Default Public ReadOnly Property Item(ByVal Index As Integer) As _
       System.Windows.Forms.TextBox
        Get
            Return CType(Me.List.Item(Index), System.Windows.Forms.TextBox)
        End Get
    End Property

    Public Sub ChangeHandler(ByVal sender As Object, ByVal e As _
       System.EventArgs)
        Dim us As TextBox
        us = CType(sender, System.Windows.Forms.TextBox)
        If (us.Text <> "") Then
            Dim i As Int32
            Try
                i = Convert.ToInt32(us.Text.ToString)
            Catch
                i = 0
            End Try

            If ((i > 255) Or (i < 0)) Then
                i = 0
            End If
            data.Buffer(us.Tag - 1) = i
        End If
        Sa.Item(us.Tag - 1).Value = data.Buffer(us.Tag - 1)
    End Sub

End Class

