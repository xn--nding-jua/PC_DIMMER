'MICROCHIP SOFTWARE NOTICE AND DISCLAIMER:  You may use this software, and any derivatives created by any person or entity by or on your behalf, exclusively with Microchip’s products.  Microchip and its licensors retain all ownership and intellectual property rights in the accompanying software and in all derivatives hereto.  
'
'This software and any accompanying information is for suggestion only.  It does not modify Microchip’s standard warranty for its products.  You agree that you are solely responsible for testing the software and determining its suitability.  Microchip has no obligation to modify, test, certify, or support the software.
'
'THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE, ITS INTERACTION WITH MICROCHIP’S PRODUCTS, COMBINATION WITH ANY OTHER PRODUCTS, OR USE IN ANY APPLICATION. 
'
'IN NO EVENT, WILL MICROCHIP BE LIABLE, WHETHER IN CONTRACT, WARRANTY, TORT (INCLUDING NEGLIGENCE OR BREACH OF STATUTORY DUTY), STRICT LIABILITY, INDEMNITY, CONTRIBUTION, OR OTHERWISE, FOR ANY INDIRECT, SPECIAL, PUNITIVE, EXEMPLARY, INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, FOR COST OR EXPENSE OF ANY KIND WHATSOEVER RELATED TO THE SOFTWARE, HOWSOEVER CAUSED, EVEN IF MICROCHIP HAS BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE.  TO THE FULLEST EXTENT ALLOWABLE BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT OF FEES, IF ANY, THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS SOFTWARE.
'
'MICROCHIP PROVIDES THIS SOFTWARE CONDITIONALLY UPON YOUR ACCEPTANCE OF THESE TERMS.

Public Class Form1
    Const mcp2200_vid As UInteger = &H4D8
    Const mcp2200_pid As UInteger = &HDF
    Dim bConnected As Boolean = False
    Dim ucIoMapValue As UShort


    Public Sub New()

        ' This call is required by the designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        SimpleIO.SimpleIOClass.InitMCP2200(mcp2200_vid, mcp2200_pid)
    End Sub


    Private Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick
        bConnected = SimpleIO.SimpleIOClass.IsConnected()
        If (bConnected = False) Then
            ToolStripStatusLabel1.Text = "Not Connected"
            BtnReadPortValue.Enabled = False
            BtnWritePortVal.Enabled = False
            TextBoxWritePortValue.Enabled = False
            TextBoxWritePortValue.Text = "N/A"
            TextBoxReadPortValue.Text = "N/A"

            TextBoxIODefaultValue.Enabled = False
            TextBoxIODefaultValue.Text = "N/A"
            BtnConfigure.Enabled = False
            CheckBoxIOBit0.Enabled = False
            CheckBoxIOBit1.Enabled = False
            CheckBoxIOBit2.Enabled = False
            CheckBoxIOBit3.Enabled = False
            CheckBoxIOBit4.Enabled = False
            CheckBoxIOBit5.Enabled = False
            CheckBoxIOBit6.Enabled = False
            CheckBoxIOBit7.Enabled = False
        Else
            ToolStripStatusLabel1.Text = "MCP2200 Connected"
            Dim uiPortValue As UInteger

            If (BtnWritePortVal.Enabled = False) Then
                BtnReadPortValue.Enabled = True
                BtnWritePortVal.Enabled = True
                TextBoxWritePortValue.Enabled = True
                TextBoxWritePortValue.Text = ""

                TextBoxIODefaultValue.Enabled = True
                TextBoxIODefaultValue.Text = "FF"
                BtnConfigure.Enabled = True
                CheckBoxIOBit0.Enabled = True
                CheckBoxIOBit1.Enabled = True
                CheckBoxIOBit2.Enabled = True
                CheckBoxIOBit3.Enabled = True
                CheckBoxIOBit4.Enabled = True
                CheckBoxIOBit5.Enabled = True
                CheckBoxIOBit6.Enabled = True
                CheckBoxIOBit7.Enabled = True
            End If

            uiPortValue = SimpleIO.SimpleIOClass.ReadPortValue()
            TextBoxReadPortValue.Text = Hex(uiPortValue)
        End If
    End Sub

    Private Sub BtnWritePortVal_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnWritePortVal.Click
        Dim uiPortValue As UInteger
        If (bConnected = True) Then
            uiPortValue = Convert.ToUInt32(TextBoxWritePortValue.Text, 16)
            SimpleIO.SimpleIOClass.WritePort(uiPortValue)
        End If
    End Sub

    Private Sub BtnReadPortValue_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnReadPortValue.Click
        Dim uiPortValue As UInteger
        If (bConnected = True) Then
            uiPortValue = SimpleIO.SimpleIOClass.ReadPortValue()
            TextBoxReadPortValue.Text = Hex(uiPortValue)
        End If
    End Sub

    Private Sub BtnConfigure_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnConfigure.Click
        Dim ucDefaultValue As UShort
        If (bConnected = True) Then
            ucDefaultValue = Convert.ToUInt32(TextBoxIODefaultValue.Text, 16)
            GetIOMapValue()
            SimpleIO.SimpleIOClass.ConfigureIoDefaultOutput(ucIoMapValue, ucDefaultValue)
        End If
    End Sub

    Private Sub GetIOMapValue()
        ucIoMapValue = 0

        If (CheckBoxIOBit0.Checked = True) Then
            ucIoMapValue = ucIoMapValue Or 1
        End If

        If (CheckBoxIOBit1.Checked = True) Then
            ucIoMapValue = ucIoMapValue Or 2
        End If

        If (CheckBoxIOBit2.Checked = True) Then
            ucIoMapValue = ucIoMapValue Or 4
        End If

        If (CheckBoxIOBit3.Checked = True) Then
            ucIoMapValue = ucIoMapValue Or 8
        End If

        If (CheckBoxIOBit4.Checked = True) Then
            ucIoMapValue = ucIoMapValue Or 16
        End If

        If (CheckBoxIOBit5.Checked = True) Then
            ucIoMapValue = ucIoMapValue Or 32
        End If

        If (CheckBoxIOBit6.Checked = True) Then
            ucIoMapValue = ucIoMapValue Or 64
        End If

        If (CheckBoxIOBit7.Checked = True) Then
            ucIoMapValue = ucIoMapValue Or 128
        End If
    End Sub
End Class
