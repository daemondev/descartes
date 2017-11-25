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
    Public Class DL_incidencia
        'Inherits DAOBase
        'Public Sub New(ByRef db As Database)
        '    MyBase.New(db)
        'End Sub

        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("dbConexion").ConnectionString)

        Public Function __mostrar_tipo_atencion(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tipificacion_tipo_atencion")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_numero_servicio", dts.vc_tipo_atencion)
                If cmd.ExecuteNonQuery Then
                    Dim dt As New DataTable
                    Dim da As New SqlDataAdapter(cmd)
                    da.Fill(dt)
                    Return dt
                Else
                    Return Nothing
                End If
            Catch ex As Exception
                MsgBox(ex.Message)
                Return Nothing
            Finally
                con.Close()
            End Try
        End Function

        Public Function _mostrar_tipo_caso(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tipificacion_tipo_caso")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_numero_servicio", dts.vc_tipo_caso_tipificacion)
                If cmd.ExecuteNonQuery Then
                    Dim dt As New DataTable
                    Dim da As New SqlDataAdapter(cmd)
                    da.Fill(dt)
                    Return dt
                Else
                    Return Nothing
                End If
            Catch ex As Exception
                MsgBox(ex.Message)
                Return Nothing
            Finally
                con.Close()
            End Try
        End Function

        Public Function _buscar_tipo_caso(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_buscar_tipificacion_tipo_caso")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_numero_servicio", dts.vc_tipo_caso_tipificacion)
                cmd.Parameters.AddWithValue("@buscar", dts.buscar_caso)
                If cmd.ExecuteNonQuery Then
                    Dim dt As New DataTable
                    Dim da As New SqlDataAdapter(cmd)
                    da.Fill(dt)
                    Return dt
                Else
                    Return Nothing
                End If
            Catch ex As Exception
                MsgBox(ex.Message)
                Return Nothing
            Finally
                con.Close()
            End Try
        End Function

        Public Function _mostrar_clientes_incidencias(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_mostrar_clientes_incidencia")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@codigo", dts.vc_codigo)
                If cmd.ExecuteNonQuery Then
                    Dim dt As New DataTable
                    Dim da As New SqlDataAdapter(cmd)
                    da.Fill(dt)
                    Return dt
                Else
                    Return Nothing
                End If
            Catch ex As Exception
                MsgBox(ex.Message)
                Return Nothing
            Finally
                con.Close()
            End Try
        End Function





        Public Function mostrar_contactos_incidencias(id As String) As DataRow
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select * from tb_contactos_derivacion_incidencia where vc_codigo_cliente=@codigo"
            cmd.Parameters.AddWithValue("@codigo", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function


        Public Function mostrar_datos_incidencias() As DataRow
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = " select * from tb_generar_incidencia"
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function


        Public Function generar_numero_incidencia() As DataRow
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "exec genera_incidencia_tb_incidencias_lista_general"
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function



        Public Function generar_numero_ticket() As DataRow
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "exec genera_tickect_tb_incidencias_lista_general"
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function



        'GUARDAR INCIDENCIA
        Public Function guardar_incidencia(ByVal dts As SOT.TB_incidencias_reclamos) As Boolean
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_insert_tb_incidencias_lista_general")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_incidencia", dts.vc_incidencia)
                cmd.Parameters.AddWithValue("@vc_tipo_incidencia", dts.vc_tipo_incidencia)
                cmd.Parameters.AddWithValue("@vc_nticket", dts.vc_nticket)
                cmd.Parameters.AddWithValue("@vc_estado", dts.vc_estado)
                cmd.Parameters.AddWithValue("@vc_arearegistro", dts.vc_area_registro)
                cmd.Parameters.AddWithValue("@vc_usuarioregistro", dts.vc_usuario_registro)
                cmd.Parameters.AddWithValue("@vc_canal_ingreso", dts.vc_canal_ingreso)
                cmd.Parameters.AddWithValue("@vc_fecharegistro", dts.vc_fecharegistro)
                cmd.Parameters.AddWithValue("@vc_fecha_env", dts.vc_fecha_env)
                cmd.Parameters.AddWithValue("@vc_tipo_caso", dts.vc_tipo_caso)
                cmd.Parameters.AddWithValue("@vc_codigo", dts.vc_codigo)
                cmd.Parameters.AddWithValue("@vc_n_doc", dts.n_doc)
                cmd.Parameters.AddWithValue("@vc_n_servicio", dts.n_servicio)


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

        Public Function guardar_seguimiento_incidencia(ByVal dts As SOT.TB_seguimiento_incidencia) As Boolean
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_insert_tb_incidencias_seguimiento_lista_general")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_recepcionista", dts.vc_recepcionista)
                cmd.Parameters.AddWithValue("@vc_estado", dts.vc_estado)
                cmd.Parameters.AddWithValue("@vc_area_origen", dts.vc_area_origen)
                cmd.Parameters.AddWithValue("@vc_usuario_origen", dts.vc_usuario_origen)
                cmd.Parameters.AddWithValue("@vc_area_destino", dts.vc_area_destino)
                cmd.Parameters.AddWithValue("@vc_usuario_destino", dts.vc_usuario_destino)
                cmd.Parameters.AddWithValue("@vc_observacion", dts.vc_observacion)
                cmd.Parameters.AddWithValue("@vc_incidencia_seguimiento", dts.vc_incidencia_seguimiento)

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


        'GUARDAR CLIENTE SERVICIOS INCIDENCIA
        Public Function guardar_cliente_servicios_incidencia(ByVal dts As SOT.TB_incidencias_lista_general) As Boolean
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_insert_tb_incidencias_clientes_servicios_lista_general")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_codigo_incidencia", dts.vc_codigo_incidencias)
                cmd.Parameters.AddWithValue("@vc_nombre_cliente", dts.vc_nombre_cliente)
                cmd.Parameters.AddWithValue("@vc_numero_servicio", dts.vc_numero_servicio)
                cmd.Parameters.AddWithValue("@vc_desc_servicio", dts.vc_desc_servicio)
                cmd.Parameters.AddWithValue("@vc_tipo_servicio", dts.vc_tipo_servicio)
                cmd.Parameters.AddWithValue("@vc_estado", dts.vc_estado)
                cmd.Parameters.AddWithValue("@vc_usuario", dts.vc_usuario)
                cmd.Parameters.AddWithValue("@vc_incidencia_seguimiento", dts.vc_incidencia_seguimiento)

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
