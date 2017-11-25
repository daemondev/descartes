Imports System.Data.Common
Imports System.Data
Imports App_datos
Imports App_entidades


Namespace DAO

    Public Class DL_usuario
        'Public Function buscar_cliente() As List(Of SOT.TB_datos)
        '    Try
        '        Dim sqlCommand As DbCommand
        '        Dim BE As SOT.TB_datos
        '        Dim lst_plataforma As New List(Of SOT.TB_datos)
        '        sqlCommand = db.GetStoredProcCommand("usp_Select_TB_plataforma")
        '        sqlCommand.CommandTimeout = "900000000"
        '        Dim dr As IDataReader = db.ExecuteReader(sqlCommand)
        '        While dr.Read()
        '            BE = New SOT.TB_datos
        '            If Validation.IsNullOrDBNull(dr("vc_plataforma")) Then BE.abreviado = Nothing Else BE.codigo = dr("vc_plataforma")
        '            lst_plataforma.Add(BE)
        '        End While
        '        dr.Close()
        '        Return lst_plataforma
        '    Catch ex As Exception
        '        DL_UTIL.GeneraLog(ex.Message, "Listadoplataforma")
        '        Throw ex
        '    End Try
        'End Function

    End Class
End Namespace
