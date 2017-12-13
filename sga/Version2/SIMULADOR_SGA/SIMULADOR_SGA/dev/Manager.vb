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

    Public Shared Sub disableTextbox(ByVal ParamArray containner() As System.Windows.Forms.GroupBox)
        If containner.Length > 0 Then
            For Each aContainner As Control In containner
                If TypeOf aContainner Is GroupBox Then
                    For Each ctrl As GroupBox In containner
                        For Each txt As Control In ctrl.Controls
                            If TypeOf txt Is TextBox Then
                                With DirectCast(txt, TextBox)
                                    '.Enabled = False
                                    .ReadOnly = True
                                    .BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
                                    '.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
                                    '.BackColor = SystemColors.Info
                                    .BackColor = Color.FromArgb(240, 240, 240)
                                    .ForeColor = Color.FromArgb(109, 109, 109)
                                End With
                            End If
                        Next
                    Next
                End If
            Next
        End If
    End Sub
End Class
