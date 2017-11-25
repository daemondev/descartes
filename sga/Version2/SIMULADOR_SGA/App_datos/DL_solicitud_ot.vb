Imports App_datos
Imports App_entidades
Imports System.Data.Common
Imports System.Data
Imports System.Collections.Generic
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Windows.Forms
Imports System.Configuration
Imports System.Data.SqlTypes
Imports System.Data.OleDb
Imports Microsoft.Practices.EnterpriseLibrary
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports GS.Framework.Data
Imports GS.Framework.Common
Namespace DL
    Public Class DL_solicitud_ot
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("dbConexion").ConnectionString)
        Public Function generar_numero_solicitud_ot() As DataRow
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "exec genera_solicitud_tb_solicitudes_ot"
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function


        Public Function guardar_solicitud_ot(ByVal dts As SOT.TB_solicitudes_ot) As Boolean
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_insert_tb_solicitudes_ot")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_solicitud", dts.vc_solicitud)
                cmd.Parameters.AddWithValue("@vc_codigo", dts.vc_codigo)
                cmd.Parameters.AddWithValue("@vc_cliente", dts.vc_cliente)
                cmd.Parameters.AddWithValue("@vc_direccion", dts.vc_direccion)
                cmd.Parameters.AddWithValue("@vc_distrito", dts.vc_distrito)
                cmd.Parameters.AddWithValue("@vc_incidencia", dts.vc_incidencia)
                cmd.Parameters.AddWithValue("@vc_tipo", dts.vc_tipo)
                cmd.Parameters.AddWithValue("@vc_motivo", dts.vc_motivo)
                cmd.Parameters.AddWithValue("@vc_tipo_servicio", dts.vc_tipo_servicio)
                cmd.Parameters.AddWithValue("@vc_area", dts.vc_area)
                cmd.Parameters.AddWithValue("@vc_f_comp", dts.vc_f_comp)
                cmd.Parameters.AddWithValue("@vc_solicitante", dts.vc_solicitante)
                cmd.Parameters.AddWithValue("@vc_observacion", dts.vc_observacion)
                'cmd.Parameters.AddWithValue("@vc_n_doc", dts.vc_n_doc)
                'cmd.Parameters.AddWithValue("@vc_n_servicio", dts.vc_n_servicio)
                

                If cmd.ExecuteNonQuery Then
                    Return True
                Else
                    Return False
                End If

            Catch ex As Exception
                MsgBox(ex.Message)
                Return False
            Finally
                con.Close()
            End Try
        End Function


        Public Function guardar_detalle_solicitud_ot(ByVal dts As SOT.TB_solicitudes_ot) As Boolean
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_insert_tb_detalle_solicitudes_ot")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_codigo", dts.vc_codigo)
                cmd.Parameters.AddWithValue("@vc_numero_servicio", dts.vc_numero_servicio)
                cmd.Parameters.AddWithValue("@vc_cliente", dts.vc_cliente)
                cmd.Parameters.AddWithValue("@vc_incidencia", dts.vc_incidencia)
                cmd.Parameters.AddWithValue("@vc_producto_contratado", dts.vc_producto_contratado)
                cmd.Parameters.AddWithValue("@vc_solicitud", dts.vc_solicitud)
                If cmd.ExecuteNonQuery Then
                    Return True
                Else
                    Return False
                End If

            Catch ex As Exception
                MsgBox(ex.Message)
                Return False
            Finally
                con.Close()
            End Try
        End Function

    End Class
End Namespace

