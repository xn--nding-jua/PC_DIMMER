Public Class Form1
    Inherits System.Windows.Forms.Form

#Region " Windows Form Designer generated code "

    Public Sub New()
        MyBase.New()

        'This call is required by the Windows Form Designer.
        InitializeComponent()

        'Add any initialization after the InitializeComponent() call

    End Sub

    'Form overrides dispose to clean up the component list.
    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    Friend WithEvents VScrollBar1 As System.Windows.Forms.VScrollBar
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents TextBox1 As System.Windows.Forms.TextBox
    Friend WithEvents Label9 As System.Windows.Forms.Label
    Friend WithEvents VScrollBar2 As System.Windows.Forms.VScrollBar
    Friend WithEvents VScrollBar3 As System.Windows.Forms.VScrollBar
    Friend WithEvents VScrollBar4 As System.Windows.Forms.VScrollBar
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.VScrollBar1 = New System.Windows.Forms.VScrollBar
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.Label4 = New System.Windows.Forms.Label
        Me.Label5 = New System.Windows.Forms.Label
        Me.Label6 = New System.Windows.Forms.Label
        Me.Label7 = New System.Windows.Forms.Label
        Me.Label8 = New System.Windows.Forms.Label
        Me.TextBox1 = New System.Windows.Forms.TextBox
        Me.Label9 = New System.Windows.Forms.Label
        Me.VScrollBar2 = New System.Windows.Forms.VScrollBar
        Me.VScrollBar3 = New System.Windows.Forms.VScrollBar
        Me.VScrollBar4 = New System.Windows.Forms.VScrollBar
        Me.SuspendLayout()
        '
        'VScrollBar1
        '
        Me.VScrollBar1.LargeChange = 1
        Me.VScrollBar1.Location = New System.Drawing.Point(20, 28)
        Me.VScrollBar1.Maximum = 255
        Me.VScrollBar1.Name = "VScrollBar1"
        Me.VScrollBar1.Size = New System.Drawing.Size(16, 164)
        Me.VScrollBar1.TabIndex = 0
        Me.VScrollBar1.Value = 255
        '
        'Label1
        '
        Me.Label1.Location = New System.Drawing.Point(16, 12)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(28, 12)
        Me.Label1.TabIndex = 4
        Me.Label1.Text = " 0"
        '
        'Label2
        '
        Me.Label2.Location = New System.Drawing.Point(48, 12)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(28, 12)
        Me.Label2.TabIndex = 5
        Me.Label2.Text = " 0"
        '
        'Label3
        '
        Me.Label3.Location = New System.Drawing.Point(80, 12)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(28, 12)
        Me.Label3.TabIndex = 6
        Me.Label3.Text = " 0"
        '
        'Label4
        '
        Me.Label4.Location = New System.Drawing.Point(112, 12)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(28, 12)
        Me.Label4.TabIndex = 7
        Me.Label4.Text = " 0"
        '
        'Label5
        '
        Me.Label5.Location = New System.Drawing.Point(20, 196)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(28, 12)
        Me.Label5.TabIndex = 8
        Me.Label5.Text = "1"
        '
        'Label6
        '
        Me.Label6.Location = New System.Drawing.Point(52, 196)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(28, 12)
        Me.Label6.TabIndex = 9
        Me.Label6.Text = "2"
        '
        'Label7
        '
        Me.Label7.Location = New System.Drawing.Point(84, 196)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(28, 12)
        Me.Label7.TabIndex = 10
        Me.Label7.Text = "3"
        '
        'Label8
        '
        Me.Label8.Location = New System.Drawing.Point(116, 196)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(28, 12)
        Me.Label8.TabIndex = 11
        Me.Label8.Text = "4"
        '
        'TextBox1
        '
        Me.TextBox1.Location = New System.Drawing.Point(164, 176)
        Me.TextBox1.Name = "TextBox1"
        Me.TextBox1.Size = New System.Drawing.Size(68, 20)
        Me.TextBox1.TabIndex = 12
        Me.TextBox1.Text = "1"
        '
        'Label9
        '
        Me.Label9.Location = New System.Drawing.Point(164, 156)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(80, 16)
        Me.Label9.TabIndex = 13
        Me.Label9.Text = "Start address:"
        '
        'VScrollBar2
        '
        Me.VScrollBar2.LargeChange = 1
        Me.VScrollBar2.Location = New System.Drawing.Point(52, 28)
        Me.VScrollBar2.Maximum = 255
        Me.VScrollBar2.Name = "VScrollBar2"
        Me.VScrollBar2.Size = New System.Drawing.Size(16, 164)
        Me.VScrollBar2.TabIndex = 14
        Me.VScrollBar2.Value = 255
        '
        'VScrollBar3
        '
        Me.VScrollBar3.LargeChange = 1
        Me.VScrollBar3.Location = New System.Drawing.Point(84, 28)
        Me.VScrollBar3.Maximum = 255
        Me.VScrollBar3.Name = "VScrollBar3"
        Me.VScrollBar3.Size = New System.Drawing.Size(16, 164)
        Me.VScrollBar3.TabIndex = 15
        Me.VScrollBar3.Value = 255
        '
        'VScrollBar4
        '
        Me.VScrollBar4.LargeChange = 1
        Me.VScrollBar4.Location = New System.Drawing.Point(116, 28)
        Me.VScrollBar4.Maximum = 255
        Me.VScrollBar4.Name = "VScrollBar4"
        Me.VScrollBar4.Size = New System.Drawing.Size(16, 164)
        Me.VScrollBar4.TabIndex = 16
        Me.VScrollBar4.Value = 255
        '
        'Form1
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.ClientSize = New System.Drawing.Size(264, 221)
        Me.Controls.Add(Me.VScrollBar4)
        Me.Controls.Add(Me.VScrollBar3)
        Me.Controls.Add(Me.VScrollBar2)
        Me.Controls.Add(Me.Label9)
        Me.Controls.Add(Me.TextBox1)
        Me.Controls.Add(Me.Label8)
        Me.Controls.Add(Me.Label7)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.VScrollBar1)
        Me.Name = "Form1"
        Me.Text = "K8062 Light Controller Demo"
        Me.ResumeLayout(False)

    End Sub

#End Region
    Private Declare Sub StartDevice Lib "k8062d.dll" ()
    Private Declare Sub SetData Lib "k8062d.dll" (ByVal Channel As Integer, ByVal Data As Integer)
    Private Declare Sub SetChannelCount Lib "k8062d.dll" (ByVal Count As Integer)
    Private Declare Sub StopDevice Lib "k8062d.dll" ()
    Dim StartAddress As Integer

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        StartDevice()
        StartAddress = 1
    End Sub

    Private Sub Form1_Closed(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Closed
        StopDevice()
    End Sub
    Private Sub VScrollBar1_Scroll(ByVal sender As System.Object, ByVal e As System.Windows.Forms.ScrollEventArgs) Handles VScrollBar1.Scroll
        Label1.Text = Str(255 - VScrollBar1.Value)
        SetData(StartAddress, 255 - VScrollBar1.Value)
    End Sub

    Private Sub VScrollBar2_Scroll(ByVal sender As System.Object, ByVal e As System.Windows.Forms.ScrollEventArgs) Handles VScrollBar2.Scroll
        Label2.Text = Str(255 - VScrollBar2.Value)
        SetData(StartAddress + 1, 255 - VScrollBar2.Value)
    End Sub

    Private Sub VScrollBar3_Scroll(ByVal sender As System.Object, ByVal e As System.Windows.Forms.ScrollEventArgs) Handles VScrollBar3.Scroll
        Label3.Text = Str(255 - VScrollBar3.Value)
        SetData(StartAddress + 2, 255 - VScrollBar3.Value)
    End Sub

    Private Sub VScrollBar4_Scroll(ByVal sender As System.Object, ByVal e As System.Windows.Forms.ScrollEventArgs) Handles VScrollBar4.Scroll
        Label4.Text = Str(255 - VScrollBar4.Value)
        SetData(StartAddress + 3, 255 - VScrollBar4.Value)
    End Sub

    Private Sub TextBox1_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TextBox1.TextChanged
        If Val(TextBox1.Text) > 0 And Val(TextBox1.Text) < 510 Then
            StartAddress = Val(TextBox1.Text)
            SetChannelCount(StartAddress + 3)
            Label5.Text = Str(StartAddress)
            Label6.Text = Str(StartAddress + 1)
            Label7.Text = Str(StartAddress + 2)
            Label8.Text = Str(StartAddress + 3)
        End If
    End Sub
End Class
