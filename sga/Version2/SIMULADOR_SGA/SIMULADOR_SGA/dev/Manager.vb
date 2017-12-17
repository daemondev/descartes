Public Class Manager
    Public Shared Function getClientData(ByVal idCliente As Integer) As DataTable
        Return R.get("getTVSatelitalDataByDOCCliente", idCliente)
    End Function

    Public Shared Function getTVSServices(ByVal idCLiente As String) As DataTable
        Return R.get("getTVSServices", idCLiente)
    End Function

    Public Shared Function getTVSEquipo(ByVal idCLiente As Integer) As DataTable
        Return R.get("getTVSEquipo", idCLiente)
    End Function
    Public Shared Function getCurrentSOT(ByVal search As String) As DataTable
        Return R.get("getCurrentSOT", search)
    End Function


    Public Shared Function getWorkType() As DataTable
        Return R.get("getWorkType")
    End Function

    Public Shared Function getMotivo() As DataTable
        Return R.get("getMotivo")
    End Function

    Public Shared Function getContactsAvailable() As DataTable
        Return R.get("getContactsAvailable")
    End Function

    Public Shared Function insAndGetIncidence(ByVal idUsuario As Integer) As DataTable
        Return R.get("insAndGetIncidence", idUsuario)
    End Function

    Shared Sub disableTextBox(ByVal txt As TextBox)
        With txt
            .ReadOnly = True
            .BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
            .BackColor = Color.FromArgb(240, 240, 240)
            .ForeColor = Color.FromArgb(109, 109, 109)
        End With
    End Sub


    Shared Sub disableCheckBox(ByVal txt As CheckBox)
        With txt
            .Enabled = False
            .BackColor = Color.FromArgb(240, 240, 240)
            .ForeColor = Color.FromArgb(109, 109, 109)
        End With
    End Sub



    Public Shared Sub disableTextbox(ByVal ParamArray containners() As System.Windows.Forms.Control)
        If containners.Length > 0 Then
            For Each aContainner As Control In containners
                Dim singleContainer As Control

                If TypeOf aContainner Is TextBox Then
                    disableTextBox(DirectCast(aContainner, TextBox))
                    Continue For
                ElseIf TypeOf aContainner Is CheckBox Then
                    disableTextBox(DirectCast(aContainner, CheckBox))
                    Continue For
                ElseIf TypeOf aContainner Is GroupBox Then
                    singleContainer = DirectCast(aContainner, GroupBox)
                ElseIf TypeOf aContainner Is Panel Then
                    singleContainer = DirectCast(aContainner, Panel)
                End If

                For Each singleControl As Control In singleContainer.Controls
                    If TypeOf singleControl Is CheckBox Then
                        disableCheckBox(DirectCast(singleControl, CheckBox))
                    ElseIf TypeOf singleControl Is TextBox Then
                        disableTextBox(DirectCast(singleControl, TextBox))
                    End If
                Next
            Next
        End If
    End Sub
End Class
