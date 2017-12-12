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
End Class
