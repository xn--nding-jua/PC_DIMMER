<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form1
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Me.StatusStrip1 = New System.Windows.Forms.StatusStrip()
        Me.ToolStripStatusLabel1 = New System.Windows.Forms.ToolStripStatusLabel()
        Me.Timer1 = New System.Windows.Forms.Timer(Me.components)
        Me.Label1 = New System.Windows.Forms.Label()
        Me.BtnWritePortVal = New System.Windows.Forms.Button()
        Me.TextBoxWritePortValue = New System.Windows.Forms.TextBox()
        Me.TextBoxReadPortValue = New System.Windows.Forms.TextBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.BtnReadPortValue = New System.Windows.Forms.Button()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.TextBoxIODefaultValue = New System.Windows.Forms.TextBox()
        Me.BtnConfigure = New System.Windows.Forms.Button()
        Me.CheckBoxIOBit0 = New System.Windows.Forms.CheckBox()
        Me.CheckBoxIOBit1 = New System.Windows.Forms.CheckBox()
        Me.CheckBoxIOBit2 = New System.Windows.Forms.CheckBox()
        Me.CheckBoxIOBit3 = New System.Windows.Forms.CheckBox()
        Me.CheckBoxIOBit4 = New System.Windows.Forms.CheckBox()
        Me.CheckBoxIOBit5 = New System.Windows.Forms.CheckBox()
        Me.CheckBoxIOBit6 = New System.Windows.Forms.CheckBox()
        Me.CheckBoxIOBit7 = New System.Windows.Forms.CheckBox()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.Label10 = New System.Windows.Forms.Label()
        Me.Label11 = New System.Windows.Forms.Label()
        Me.StatusStrip1.SuspendLayout()
        Me.SuspendLayout()
        '
        'StatusStrip1
        '
        Me.StatusStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripStatusLabel1})
        Me.StatusStrip1.Location = New System.Drawing.Point(0, 226)
        Me.StatusStrip1.Name = "StatusStrip1"
        Me.StatusStrip1.Size = New System.Drawing.Size(284, 22)
        Me.StatusStrip1.TabIndex = 0
        Me.StatusStrip1.Text = "StatusStrip1"
        '
        'ToolStripStatusLabel1
        '
        Me.ToolStripStatusLabel1.Name = "ToolStripStatusLabel1"
        Me.ToolStripStatusLabel1.Size = New System.Drawing.Size(111, 17)
        Me.ToolStripStatusLabel1.Text = "ToolStripStatusLabel1"
        '
        'Timer1
        '
        Me.Timer1.Enabled = True
        Me.Timer1.Interval = 500
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(9, 15)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(110, 13)
        Me.Label1.TabIndex = 7
        Me.Label1.Text = "Write Port Value (hex)"
        '
        'BtnWritePortVal
        '
        Me.BtnWritePortVal.Location = New System.Drawing.Point(157, 31)
        Me.BtnWritePortVal.Name = "BtnWritePortVal"
        Me.BtnWritePortVal.Size = New System.Drawing.Size(111, 34)
        Me.BtnWritePortVal.TabIndex = 6
        Me.BtnWritePortVal.Text = "Write Port Value"
        Me.BtnWritePortVal.UseVisualStyleBackColor = True
        '
        'TextBoxWritePortValue
        '
        Me.TextBoxWritePortValue.Location = New System.Drawing.Point(12, 31)
        Me.TextBoxWritePortValue.Name = "TextBoxWritePortValue"
        Me.TextBoxWritePortValue.Size = New System.Drawing.Size(114, 20)
        Me.TextBoxWritePortValue.TabIndex = 5
        '
        'TextBoxReadPortValue
        '
        Me.TextBoxReadPortValue.Enabled = False
        Me.TextBoxReadPortValue.Location = New System.Drawing.Point(12, 87)
        Me.TextBoxReadPortValue.Name = "TextBoxReadPortValue"
        Me.TextBoxReadPortValue.Size = New System.Drawing.Size(114, 20)
        Me.TextBoxReadPortValue.TabIndex = 10
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(9, 73)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(111, 13)
        Me.Label2.TabIndex = 9
        Me.Label2.Text = "Read Port Value (hex)"
        '
        'BtnReadPortValue
        '
        Me.BtnReadPortValue.Location = New System.Drawing.Point(157, 87)
        Me.BtnReadPortValue.Name = "BtnReadPortValue"
        Me.BtnReadPortValue.Size = New System.Drawing.Size(111, 34)
        Me.BtnReadPortValue.TabIndex = 8
        Me.BtnReadPortValue.Text = "Read Port Value"
        Me.BtnReadPortValue.UseVisualStyleBackColor = True
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(3, 169)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(106, 13)
        Me.Label3.TabIndex = 28
        Me.Label3.Text = "Default Output Value"
        '
        'TextBoxIODefaultValue
        '
        Me.TextBoxIODefaultValue.Location = New System.Drawing.Point(6, 185)
        Me.TextBoxIODefaultValue.Name = "TextBoxIODefaultValue"
        Me.TextBoxIODefaultValue.Size = New System.Drawing.Size(70, 20)
        Me.TextBoxIODefaultValue.TabIndex = 27
        Me.TextBoxIODefaultValue.Text = "FF"
        '
        'BtnConfigure
        '
        Me.BtnConfigure.Location = New System.Drawing.Point(185, 148)
        Me.BtnConfigure.Name = "BtnConfigure"
        Me.BtnConfigure.Size = New System.Drawing.Size(83, 57)
        Me.BtnConfigure.TabIndex = 26
        Me.BtnConfigure.Text = "Configure"
        Me.BtnConfigure.UseVisualStyleBackColor = True
        '
        'CheckBoxIOBit0
        '
        Me.CheckBoxIOBit0.AutoSize = True
        Me.CheckBoxIOBit0.Location = New System.Drawing.Point(153, 148)
        Me.CheckBoxIOBit0.Name = "CheckBoxIOBit0"
        Me.CheckBoxIOBit0.Size = New System.Drawing.Size(15, 14)
        Me.CheckBoxIOBit0.TabIndex = 25
        Me.CheckBoxIOBit0.UseVisualStyleBackColor = True
        '
        'CheckBoxIOBit1
        '
        Me.CheckBoxIOBit1.AutoSize = True
        Me.CheckBoxIOBit1.Location = New System.Drawing.Point(132, 148)
        Me.CheckBoxIOBit1.Name = "CheckBoxIOBit1"
        Me.CheckBoxIOBit1.Size = New System.Drawing.Size(15, 14)
        Me.CheckBoxIOBit1.TabIndex = 24
        Me.CheckBoxIOBit1.UseVisualStyleBackColor = True
        '
        'CheckBoxIOBit2
        '
        Me.CheckBoxIOBit2.AutoSize = True
        Me.CheckBoxIOBit2.Location = New System.Drawing.Point(111, 148)
        Me.CheckBoxIOBit2.Name = "CheckBoxIOBit2"
        Me.CheckBoxIOBit2.Size = New System.Drawing.Size(15, 14)
        Me.CheckBoxIOBit2.TabIndex = 23
        Me.CheckBoxIOBit2.UseVisualStyleBackColor = True
        '
        'CheckBoxIOBit3
        '
        Me.CheckBoxIOBit3.AutoSize = True
        Me.CheckBoxIOBit3.Location = New System.Drawing.Point(90, 148)
        Me.CheckBoxIOBit3.Name = "CheckBoxIOBit3"
        Me.CheckBoxIOBit3.Size = New System.Drawing.Size(15, 14)
        Me.CheckBoxIOBit3.TabIndex = 22
        Me.CheckBoxIOBit3.UseVisualStyleBackColor = True
        '
        'CheckBoxIOBit4
        '
        Me.CheckBoxIOBit4.AutoSize = True
        Me.CheckBoxIOBit4.Location = New System.Drawing.Point(69, 148)
        Me.CheckBoxIOBit4.Name = "CheckBoxIOBit4"
        Me.CheckBoxIOBit4.Size = New System.Drawing.Size(15, 14)
        Me.CheckBoxIOBit4.TabIndex = 21
        Me.CheckBoxIOBit4.UseVisualStyleBackColor = True
        '
        'CheckBoxIOBit5
        '
        Me.CheckBoxIOBit5.AutoSize = True
        Me.CheckBoxIOBit5.Location = New System.Drawing.Point(48, 148)
        Me.CheckBoxIOBit5.Name = "CheckBoxIOBit5"
        Me.CheckBoxIOBit5.Size = New System.Drawing.Size(15, 14)
        Me.CheckBoxIOBit5.TabIndex = 20
        Me.CheckBoxIOBit5.UseVisualStyleBackColor = True
        '
        'CheckBoxIOBit6
        '
        Me.CheckBoxIOBit6.AutoSize = True
        Me.CheckBoxIOBit6.Location = New System.Drawing.Point(27, 148)
        Me.CheckBoxIOBit6.Name = "CheckBoxIOBit6"
        Me.CheckBoxIOBit6.Size = New System.Drawing.Size(15, 14)
        Me.CheckBoxIOBit6.TabIndex = 19
        Me.CheckBoxIOBit6.UseVisualStyleBackColor = True
        '
        'CheckBoxIOBit7
        '
        Me.CheckBoxIOBit7.AutoSize = True
        Me.CheckBoxIOBit7.Location = New System.Drawing.Point(6, 148)
        Me.CheckBoxIOBit7.Name = "CheckBoxIOBit7"
        Me.CheckBoxIOBit7.Size = New System.Drawing.Size(15, 14)
        Me.CheckBoxIOBit7.TabIndex = 18
        Me.CheckBoxIOBit7.UseVisualStyleBackColor = True
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte), True)
        Me.Label4.Location = New System.Drawing.Point(4, 136)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(20, 9)
        Me.Label4.TabIndex = 29
        Me.Label4.Text = "GP7"
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte), True)
        Me.Label5.Location = New System.Drawing.Point(25, 136)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(20, 9)
        Me.Label5.TabIndex = 30
        Me.Label5.Text = "GP6"
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte), True)
        Me.Label6.Location = New System.Drawing.Point(46, 136)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(20, 9)
        Me.Label6.TabIndex = 31
        Me.Label6.Text = "GP5"
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte), True)
        Me.Label7.Location = New System.Drawing.Point(67, 136)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(20, 9)
        Me.Label7.TabIndex = 32
        Me.Label7.Text = "GP4"
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte), True)
        Me.Label8.Location = New System.Drawing.Point(88, 136)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(20, 9)
        Me.Label8.TabIndex = 33
        Me.Label8.Text = "GP3"
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte), True)
        Me.Label9.Location = New System.Drawing.Point(109, 136)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(20, 9)
        Me.Label9.TabIndex = 34
        Me.Label9.Text = "GP2"
        '
        'Label10
        '
        Me.Label10.AutoSize = True
        Me.Label10.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte), True)
        Me.Label10.Location = New System.Drawing.Point(130, 136)
        Me.Label10.Name = "Label10"
        Me.Label10.Size = New System.Drawing.Size(20, 9)
        Me.Label10.TabIndex = 35
        Me.Label10.Text = "GP1"
        '
        'Label11
        '
        Me.Label11.AutoSize = True
        Me.Label11.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte), True)
        Me.Label11.Location = New System.Drawing.Point(151, 136)
        Me.Label11.Name = "Label11"
        Me.Label11.Size = New System.Drawing.Size(20, 9)
        Me.Label11.TabIndex = 36
        Me.Label11.Text = "GP0"
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(284, 248)
        Me.Controls.Add(Me.Label11)
        Me.Controls.Add(Me.Label10)
        Me.Controls.Add(Me.Label9)
        Me.Controls.Add(Me.Label8)
        Me.Controls.Add(Me.Label7)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.TextBoxIODefaultValue)
        Me.Controls.Add(Me.BtnConfigure)
        Me.Controls.Add(Me.CheckBoxIOBit0)
        Me.Controls.Add(Me.CheckBoxIOBit1)
        Me.Controls.Add(Me.CheckBoxIOBit2)
        Me.Controls.Add(Me.CheckBoxIOBit3)
        Me.Controls.Add(Me.CheckBoxIOBit4)
        Me.Controls.Add(Me.CheckBoxIOBit5)
        Me.Controls.Add(Me.CheckBoxIOBit6)
        Me.Controls.Add(Me.CheckBoxIOBit7)
        Me.Controls.Add(Me.TextBoxReadPortValue)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.BtnReadPortValue)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.BtnWritePortVal)
        Me.Controls.Add(Me.TextBoxWritePortValue)
        Me.Controls.Add(Me.StatusStrip1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D
        Me.MaximizeBox = False
        Me.Name = "Form1"
        Me.Text = "Form1"
        Me.StatusStrip1.ResumeLayout(False)
        Me.StatusStrip1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents StatusStrip1 As System.Windows.Forms.StatusStrip
    Friend WithEvents ToolStripStatusLabel1 As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents Timer1 As System.Windows.Forms.Timer
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents BtnWritePortVal As System.Windows.Forms.Button
    Friend WithEvents TextBoxWritePortValue As System.Windows.Forms.TextBox
    Friend WithEvents TextBoxReadPortValue As System.Windows.Forms.TextBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents BtnReadPortValue As System.Windows.Forms.Button
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents TextBoxIODefaultValue As System.Windows.Forms.TextBox
    Friend WithEvents BtnConfigure As System.Windows.Forms.Button
    Friend WithEvents CheckBoxIOBit0 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBoxIOBit1 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBoxIOBit2 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBoxIOBit3 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBoxIOBit4 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBoxIOBit5 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBoxIOBit6 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBoxIOBit7 As System.Windows.Forms.CheckBox
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents Label9 As System.Windows.Forms.Label
    Friend WithEvents Label10 As System.Windows.Forms.Label
    Friend WithEvents Label11 As System.Windows.Forms.Label

End Class
