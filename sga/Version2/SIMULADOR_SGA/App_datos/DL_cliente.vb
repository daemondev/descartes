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
    Public Class DL_cliente
        'Protected lDataset As DataSet
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("dbConexion").ConnectionString)

        Public Function mostrar() As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_datos")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
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

        Public Function _mostrar_por_codigo_cliente(ByVal dts As SOT.TB_datos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_datos_por_codigo")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@codigo", dts.codigo)
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


        Public Function _mostrar_por_n_doc(ByVal dts As SOT.TB_datos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_datos_por_n_doc")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_doc", dts.n_doc)
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

        Public Function _mostrar_por_n_servicio(ByVal dts As SOT.TB_datos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_datos_por_n_servicio")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_servicio", dts.n_servicio)
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

#Region "MOSTRAR SEGUIMIENTO LISTA GENERAL"

        Public Function _mostrar_seguimiento_lista_general_por_codigo(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_incidencias_seguimiento_lista_general")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                'cmd.Parameters.AddWithValue("@codigo", dts.vc_codigo)
                cmd.Parameters.AddWithValue("@incidencia_seguimiento", dts.vc_incidencia_seguimiento)
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

#End Region


#Region "MOSTRAR INCIDENCIAS LISTA GENERAL"

        Public Function _mostrar_incidencias_lista_general_por_codigo(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_incidencias_lista_general_por_codigo")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_codigo", dts.vc_codigo)
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

        Public Function _mostrar_incidencias_lista_general_por_n_doc(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_incidencias_lista_general_por_n_doc")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_doc", dts.n_doc)
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

        Public Function _mostrar_incidencias_lista_general_por_n_servicio(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_incidencias_lista_general_por_n_servicio")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_n_servicio", dts.n_servicio)
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

#End Region

#Region "MOSTRAR CLIENTES_SERVICIOS LISTA GENERAL"

        Public Function _mostrar_incidencias_servicios_lista_general_por_codigo(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_incidencias_servicios_lista_general")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                'md.Parameters.AddWithValue("@codigo", dts.vc_codigo)
                cmd.Parameters.AddWithValue("@incidencia_seguimiento", dts.vc_incidencia_seguimiento)
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

        Public Function _mostrar_incidencias_servicios_lista_general_por_n_doc(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_incidencias_servicios_lista_general_por_n_doc")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_doc", dts.n_doc)
                cmd.Parameters.AddWithValue("@incidencia_seguimiento", dts.vc_incidencia_seguimiento)
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

        Public Function _mostrar_incidencias_servicios_lista_general_por_n_servicio(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_incidencias_servicios_lista_general_por_n_servicio")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_servicio", dts.n_servicio)
                cmd.Parameters.AddWithValue("@incidencia_seguimiento", dts.vc_incidencia_seguimiento)
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

#End Region



#Region "MOSTRAR INCIDENCIAS CLIENTES SERVICIOS"

        Public Function _mostrar_incidencias_clientes_servicios_por_codigo(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_incidencias_servicios_por_codigo")
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

        Public Function _mostrar_incidencias_clientes_servicios_por_n_doc(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_incidencias_servicios_por_n_doc")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_doc", dts.n_doc)
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

        Public Function _mostrar_incidencias_clientes_servicios_por_n_servicio(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_incidencias_servicios_por_n_servicio")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_servicio", dts.n_servicio)
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

#End Region

#Region "MOSTRAR INCIDENCIAS RECLAMOS "

        Public Function _mostrar_incidencias_reclamos_por_codigo(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_incidencias_reclamos_por_codigo")
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

        Public Function _mostrar_incidencias_reclamos_por_n_doc(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_incidencias_reclamos_por_n_doc")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_doc", dts.n_doc)
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

        Public Function _mostrar_incidencias_reclamos_por_n_servicio(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_incidencias_reclamos_por_n_servicio")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_servicio", dts.n_servicio)
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


#End Region

#Region "MOSTRAR DATOS CLIENTE EN TEXTBOX SEGUN BUSQUEDA"
        Public Function Buscar_datos_clientes_por_codigo(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "SELECT * FROM tb_datos_cliente where vc_codigo=@codigo"
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

        Public Function Buscar_datos_clientes_por_doc(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "SELECT * FROM TB_datos_cliente where vc_documento=@documento"
            cmd.Parameters.AddWithValue("@documento", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

        Public Function Buscar_datos_clientes_por_nservicio(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "SELECT * FROM TB_datos_cliente where n_servicio=@n_servicio"
            cmd.Parameters.AddWithValue("@n_servicio", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

#End Region

#Region "MOSTRAR SOLICITUDES OT CLIENTE EN GRIDVIEW - ANOTACIONES"
        Public Function _mostrar_anotaciones_ot_por_codigo(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_anotaciones_solicitudes_ot_por_codigo")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_codigo", dts.vc_codigo)
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

        Public Function _mostrar_anotaciones_ot_por_n_doc(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_anotaciones_solicitudes_ot_por_n_doc")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_doc", dts.vc_n_doc)
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

        Public Function _mostrar_anotaciones_ot_por_n_servicio(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_anotaciones_solicitudes_ot_por_n_servicio")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_n_servicio", dts.vc_n_servicio)
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

#End Region

#Region "MOSTRAR SOLICITUDES OT CLIENTE EN GRIDVIEW"
        Public Function _mostrar_detalle_ot_por_codigo(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_detalle_solicitudes_ot_por_codigo")
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

        Public Function _mostrar_detalle_ot_por_n_doc(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_detalle_solicitudes_ot_por_n_doc")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_doc", dts.vc_n_doc)
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

        Public Function _mostrar_detalle_ot_por_n_servicio(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_detalle_solicitudes_ot_por_n_servicio")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_servicio", dts.vc_n_servicio)
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

#End Region

#Region "MOSTRAR SOLCITUDES OT CLIENTE EN TEXTBOX SEGUN BUSQUEDA"
        Public Function Buscar_solicitudes_ot_por_codigo(id As String) As DataRow
            'Dim cmd As SqlCommand = con.CreateCommand()
            ' cmd = New SqlCommand("Usp_select_tb_solicitudes_ot_por_codigo")
            ' cmd.CommandType = CommandType.StoredProcedure
            'cmd.Connection = con
            'cmd.Parameters.AddWithValue("@codigo", codigo_cliente)
            'cmd.Parameters.AddWithValue("@codigo", id)
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select * from tb_solicitudes_ot where vc_codigo=@codigo"
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


        Public Function mostrar_cantidad_solicitudes_ot_por_codigo(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select count(*) as 'count' from tb_solicitudes_ot where vc_codigo=@codigo"
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

        Public Function mostrar_cantidad_solicitudes_ot_por_doc(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select count(*) as 'count' from tb_solicitudes_ot where vc_n_doc=@doc"
            cmd.Parameters.AddWithValue("@doc", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function


        Public Function mostrar_cantidad_solicitudes_ot_por_nservicio(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select count(*) as 'count' from tb_solicitudes_ot where vc_n_servicio=@servicio"
            cmd.Parameters.AddWithValue("@servicio", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function







        Public Function Buscar_solicitudes_ot_por_doc(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()

            cmd.CommandText = "select * from tb_solicitudes_ot where vc_n_doc=@documento"
            cmd.Parameters.AddWithValue("@documento", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

        Public Function Buscar_solicitudes_ot_por_nservicio(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select * from tb_solicitudes_ot where vc_n_servicio=@n_servicio"
            cmd.Parameters.AddWithValue("@n_servicio", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

#End Region

#Region "CONTACTOS_CLIENTES"

        Public Function _mostrar_contactos_clientes_por_codigo(ByVal dts As SOT.TB_contactos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_contactos_por_codigo")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@codigo", dts.codigo)
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

        Public Function _mostrar_contactos_clientes_por_doc(ByVal dts As SOT.TB_contactos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_contactos_por_doc")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_doc", dts.n_doc)
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

        Public Function _mostrar_contactos_clientes_por_n_servicio(ByVal dts As SOT.TB_contactos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_datos_por_n_servicio")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_servicio", dts.n_servicio)
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

#End Region

#Region "MOSTRAR SERVICIOS CONTRATADOS"


        Public Function _mostrar_servicios_contratados_por_codigo(ByVal dts As SOT.TB_servicios_contratados) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_servicios_contratados_por_codigo")
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

        Public Function _mostrar_servicios_contratados_por_n_doc(ByVal dts As SOT.TB_servicios_contratados, ByVal estado As String) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_servicios_contratados_por_n_doc")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_doc", dts.n_doc)
                cmd.Parameters.AddWithValue("@estado", estado)
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

        Public Function _mostrar_servicios_contratados_por_n_servicio(ByVal dts As SOT.TB_servicios_contratados) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_servicios_contratados_por_n_servicio")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_servicio", dts.n_servicio)
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

#End Region

#Region "MOSTRAR SERVICIOS CONTRATADOS TRANSACCIONES"


        Public Function _mostrar_servicios_contratados_transacciones_por_codigo(ByVal dts As SOT.TB_servicios_contratados) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_servicios_contratados_transacciones_por_codigo")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@codigo", dts.vc_codigo)
                cmd.Parameters.AddWithValue("@cid", dts.vc_cid)

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

        Public Function _mostrar_servicios_contratados_transacciones_por_n_doc(ByVal dts As SOT.TB_servicios_contratados) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_servicios_contratados_transacciones_por_n_doc")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_doc", dts.n_doc)
                cmd.Parameters.AddWithValue("@cid", dts.vc_cid)
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

        Public Function _mostrar_servicios_contratados_transacciones_por_n_servicio(ByVal dts As SOT.TB_servicios_contratados) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_servicios_contratados_transacciones_por_n_servicio")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_servicio", dts.n_servicio)
                cmd.Parameters.AddWithValue("@cid", dts.vc_cid)
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

#End Region


#Region "MOSTRAR FACTURA CLIENTE EN TEXTBOX SEGUN BUSQUEDA"
        Public Function mostrar_factura_clientes_por_codigo(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select * from tb_factura  where vc_codigo=@codigo"
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

        Public Function mostrar_factura_clientes_por_doc(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select * from tb_factura  where vc_ndoc=@ndoc"
            cmd.Parameters.AddWithValue("@ndoc", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

        Public Function mostrar_factura_clientes_por_nservicio(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select * from tb_factura  where vc_nservicio=@nservicio"
            cmd.Parameters.AddWithValue("@nservicio", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

#End Region

#Region "MOSTRAR  DETALLE FACTURA CLIENTE EN TEXTBOX SEGUN BUSQUEDA 1"
        Public Function mostrar_detalle_factura_clientes_por_codigo1(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "  select * from tb_detalle_factura where vc_codigo=@codigo and in_item=001"
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

        Public Function mostrar_detalle_factura_clientes_por_doc1(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = " select * from tb_detalle_factura where vc_ndoc=@ndoc and in_item=001"
            cmd.Parameters.AddWithValue("@ndoc", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

        Public Function mostrar_detalle_factura_clientes_por_nservicio1(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "  select * from tb_detalle_factura where vc_nservicio=@nservicio and in_item=001"
            cmd.Parameters.AddWithValue("@nservicio", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

#End Region

#Region "MOSTRAR DETALLE FACTURA CLIENTE EN TEXTBOX SEGUN BUSQUEDA 2"
        Public Function mostrar_detalle_factura_clientes_por_codigo2(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "  select * from tb_detalle_factura where vc_codigo=@codigo and in_item=002"
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

        Public Function mostrar_detalle_factura_clientes_por_doc2(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select * from tb_detalle_factura where vc_ndoc=@ndoc and in_item=002"
            cmd.Parameters.AddWithValue("@ndoc", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

        Public Function mostrar_detalle_factura_clientes_por_nservicio2(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select * from tb_detalle_factura where vc_nservicio=@nservicio and in_item=002"
            cmd.Parameters.AddWithValue("@nservicio", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

#End Region



        Public Function _Mostrar_clientes(ByVal dts As SOT.TB_datos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_buscar_cliente_f9")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@abreviado", dts.abreviado)
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
        Public Function _mostrar_cambios_estado_solicitudes_ot_por_codigo(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_cambios_estado_solicitures_ot_por_vc_codigo")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_codigo", dts.vc_codigo)


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

        Public Function _mostrar_cambios_estado_solicitudes_ot_por_doc(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_cambios_estado_solicitures_ot_por_vc_n_doc")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_n_doc", dts.n_doc)

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

        Public Function _mostrar_cambios_estado_solicitudes_ot_por_nservicio(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_cambios_estado_solicitures_ot_por_vc_n_servicio")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_n_servicio", dts.n_servicio)

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



        Public Function _mostrar_tarea_solicitudes_ot_por_codigo(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_tarea_solicitures_ot_por_codigo")
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

        Public Function _mostrar_tarea_solicitudes_ot_por_doc(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_tarea_solicitures_ot_por_n_doc")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_n_doc", dts.n_doc)

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

        Public Function _mostrar_tarea_solicitudes_ot_por_nservicio(ByVal dts As SOT.TB_incidencias_reclamos) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_tarea_solicitures_ot_por_n_servicio")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_n_servicio", dts.n_servicio)

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



#Region "MOSTRAR SOLCITUDES OT CLIENTE EN TEXTBOX SEGUN BUSQUEDA CON MOUSE"
        Public Function Buscar_solicitudes_ot_por_codigo_por_mouse(codigo_cliente As String, id As Integer) As DataRow
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd = New SqlCommand("Usp_select_tb_solicitudes_ot_por_codigo")
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@codigo", codigo_cliente)
            cmd.Parameters.AddWithValue("@id", id)


           
            'Dim cmd As SqlCommand = con.CreateCommand()
            'cmd.CommandText = "select * from tb_solicitudes_ot where vc_codigo=@codigo"
            'cmd.Parameters.AddWithValue("@codigo", id)

            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

        Public Function Buscar_solicitudes_ot_por_doc_por_mouse(codigo_cliente As String, id As Integer) As DataRow
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd = New SqlCommand("Usp_select_tb_solicitudes_ot_por_doc")
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@doc", codigo_cliente)
            cmd.Parameters.AddWithValue("@id", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

        Public Function Buscar_solicitudes_ot_por_nservicio_por_mouse(codigo_cliente As String, id As Integer) As DataRow
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd = New SqlCommand("Usp_select_tb_solicitudes_ot_por_n_servicio")
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@n_servicio", codigo_cliente)
            cmd.Parameters.AddWithValue("@id", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

#End Region



#Region "MOSTRAR SOLICITUDES OT CLIENTE EN GRIDVIEW CON MOUSE"
        Public Function _mostrar_detalle_ot_por_codigo_mouse(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_detalle_solicitudes_ot_por_codigo_mouse")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@codigo", dts.vc_codigo)
                cmd.Parameters.AddWithValue("@solicitud", dts.vc_solicitud)
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

        Public Function _mostrar_detalle_ot_por_n_doc_mouse(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_detalle_solicitudes_ot_por_n_doc_mouse")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_doc", dts.vc_n_doc)
                cmd.Parameters.AddWithValue("@solicitud", dts.vc_solicitud)
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

        Public Function _mostrar_detalle_ot_por_n_servicio_mouse(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_detalle_solicitudes_ot_por_n_servicio_mouse")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_servicio", dts.vc_n_servicio)
                cmd.Parameters.AddWithValue("@solicitud", dts.vc_solicitud)
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

#End Region

#Region "MOSTRAR SOLICITUDES OT CLIENTE EN GRIDVIEW - ANOTACIONES - MOUSE"
        Public Function _mostrar_anotaciones_ot_por_codigo_mouse(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_anotaciones_solicitudes_ot_por_codigo_mouse")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_codigo", dts.vc_codigo)
                cmd.Parameters.AddWithValue("@solicitud", dts.vc_solicitud)
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

        Public Function _mostrar_anotaciones_ot_por_n_doc_mouse(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_anotaciones_solicitudes_ot_por_n_doc_mouse")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@n_doc", dts.vc_n_doc)
                cmd.Parameters.AddWithValue("@solicitud", dts.vc_solicitud)
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

        Public Function _mostrar_anotaciones_ot_por_n_servicio_mouse(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_anotaciones_solicitudes_ot_por_n_servicio_mouse")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_n_servicio", dts.vc_n_servicio)
                cmd.Parameters.AddWithValue("@solicitud", dts.vc_solicitud)
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

#End Region


#Region "MOSTRAR SOLICITUDES CAMBIOS ESTADO CON MOUSE"
        Public Function _mostrar_cambios_estado_solicitudes_ot_por_codigo_mouse(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_cambios_estado_solicitures_ot_por_vc_codigo_MOUSE")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_codigo", dts.vc_codigo)
                cmd.Parameters.AddWithValue("@solicitud", dts.vc_solicitud)


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

        Public Function _mostrar_cambios_estado_solicitudes_ot_por_doc_mouse(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_cambios_estado_solicitures_ot_por_vc_n_doc_mouse")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_n_doc", dts.vc_n_doc)
                cmd.Parameters.AddWithValue("@solicitud", dts.vc_solicitud)

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

        Public Function _mostrar_cambios_estado_solicitudes_ot_por_nservicio_mouse(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_cambios_estado_solicitures_ot_por_vc_n_servicio_mouse")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_n_servicio", dts.vc_n_servicio)
                cmd.Parameters.AddWithValue("@solicitud", dts.vc_solicitud)

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
#End Region


#Region "MOSTRAR SOLICITUDES OT TAREAS CON MOUSE"
        Public Function _mostrar_tarea_solicitudes_ot_por_codigo_mouse(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_tarea_solicitures_ot_por_codigo_mouse")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@codigo", dts.vc_codigo)
                cmd.Parameters.AddWithValue("@solicitud", dts.vc_solicitud)


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

        Public Function _mostrar_tarea_solicitudes_ot_por_doc_mouse(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_tarea_solicitures_ot_por_n_doc")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_n_doc", dts.vc_n_doc)
                cmd.Parameters.AddWithValue("@solicitud", dts.vc_solicitud)

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

        Public Function _mostrar_tarea_solicitudes_ot_por_nservicio_mouse(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_tarea_solicitures_ot_por_n_servicio")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_n_servicio", dts.vc_n_servicio)
                cmd.Parameters.AddWithValue("@solicitud", dts.vc_solicitud)

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
#End Region


#Region "MOSTRAR COBRANZA DW"
        Public Function _mostrar_cobranza_por_codigo(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_cobranza_por_codigo")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_codigo", dts.vc_codigo)

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

        Public Function _mostrar_cobranza_por_nservicio(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_cobranza_por_n_servicio")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_n_serivico", dts.vc_n_servicio)


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

        Public Function _mostrar_cobranza_por_n_doc(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_cobranza_por_n_doc")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_n_doc", dts.vc_n_doc)


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
#End Region




#Region "MOSTRAR PAGOS APLICACIONES FACTURA DW"
        Public Function _mostrar_pagos_aplicaciones_factura_por_codigo(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_pagos_aplicaciones_factura_por_codigo")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_codigo", dts.vc_codigo)

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

        Public Function _mostrar_pagos_aplicaciones_factura_por_nservicio(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_pagos_aplicaciones_factura_por_nservicio")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_nserivico", dts.vc_n_servicio)


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

        Public Function _mostrar_pagos_aplicaciones_factura_por_n_doc(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_pagos_aplicaciones_factura_por_ndoc")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_ndoc", dts.vc_n_doc)


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
#End Region



#Region "MOSTRAR CANTIDAD FACTURA"
        Public Function mostrar_cantidad_facturas_por_codigo(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select COUNT(*) as 'count' from tb_factura where vc_codigo=@codigo"
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

        Public Function mostrar_cantidad_facturas_por_doc(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select COUNT(*) as 'count' from tb_factura where vc_ndoc=@doc"
            cmd.Parameters.AddWithValue("@doc", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function


        Public Function mostrar_cantidad_facturas_por_nservicio(id As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select COUNT(*) as 'count' from tb_factura where vc_nservicio=@servicio"
            cmd.Parameters.AddWithValue("@servicio", id)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function
#End Region


#Region "MOSTRAR FACTURA CLIENTE EN TEXTBOX SEGUN BUSQUEDA CON MOUSE"
        Public Function mostrar_factura_clientes_por_codigo_mouse(codigo As String, id As Integer) As DataRow
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd = New SqlCommand("Usp_select_tb_factura_por_codigo")
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@codigo", codigo)
            cmd.Parameters.AddWithValue("@id", id)

            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

        Public Function mostrar_facturas_clientes_por_doc_mouse(codigo As String, id As Integer) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd = New SqlCommand("Usp_select_tb_factura_por_ndoc")
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@ndoc", codigo)
            cmd.Parameters.AddWithValue("@id", id)

            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

        Public Function mostrar_factura_clientes_por_nservicio_mouse(codigo As String, id As Integer) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd = New SqlCommand("Usp_select_tb_factura_por_nservicio")
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@nservicio", codigo)
            cmd.Parameters.AddWithValue("@id", id)

            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

#End Region


#Region "MOSTRAR  DETALLE FACTURA CLIENTE EN TEXTBOX SEGUN BUSQUEDA 1 MOUSE"
        Public Function mostrar_detalle_factura_clientes_por_codigo1_mouse(codigo As String, id As Integer) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd = New SqlCommand("Usp_select_tb_detalle_factura_por_codigo_mouse")
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@codigo", codigo)
            cmd.Parameters.AddWithValue("@vc_factura", id)

            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function


        Public Function mostrar_detalle_factura_clientes_por_doc1_mouse(codigo As String, id As Integer) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd = New SqlCommand("Usp_select_tb_detalle_factura_por_ndoc_mouse")
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@ndoc", codigo)
            cmd.Parameters.AddWithValue("@vc_factura", id)

            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

        Public Function mostrar_detalle_factura_clientes_por_nservicio1_mouse(codigo As String, id As Integer) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd = New SqlCommand("Usp_select_tb_detalle_factura_por_nservicio_mouse")
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@nservicio", codigo)
            cmd.Parameters.AddWithValue("@vc_factura", id)

            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

#End Region

#Region "MOSTRAR DETALLE FACTURA CLIENTE EN TEXTBOX SEGUN BUSQUEDA 2 MOUSE"
        Public Function mostrar_detalle_factura_clientes_por_codigo2_mouse(codigo As String, id As Integer) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd = New SqlCommand("Usp_select_tb_detalle_factura_por_codigo2_mouse")
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@codigo", codigo)
            cmd.Parameters.AddWithValue("@vc_factura", id)

            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

        Public Function mostrar_detalle_factura_clientes_por_doc2_mouse(codigo As String, id As Integer) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd = New SqlCommand("Usp_select_tb_detalle_factura_por_ndoc2_mouse")
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@ndoc", codigo)
            cmd.Parameters.AddWithValue("@vc_factura", id)

            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

        Public Function mostrar_detalle_factura_clientes_por_nservicio2_mouse(codigo As String, id As Integer) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd = New SqlCommand("Usp_select_tb_detalle_factura_por_nservicio2_mouse")
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@nservicio", codigo)
            cmd.Parameters.AddWithValue("@vc_factura", id)

            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

#End Region


#Region "MOSTRAR PAGOS APLICACIONES FACTURA DW CON MOUSE"
        Public Function _mostrar_pagos_aplicaciones_factura_por_codigo_mouse(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_pagos_aplicaciones_factura_por_codigo_mouse")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_codigo", dts.vc_codigo)
                cmd.Parameters.AddWithValue("@vc_factura", dts.vc_solicitud)

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

        Public Function _mostrar_pagos_aplicaciones_factura_por_nservicio_mouse(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_pagos_aplicaciones_factura_por_nservicio_mouse")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_nserivico", dts.vc_n_servicio)
                cmd.Parameters.AddWithValue("@vc_factura", dts.vc_solicitud)


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

        Public Function _mostrar_pagos_aplicaciones_factura_por_n_doc_mouse(ByVal dts As SOT.TB_solicitudes_ot) As DataTable
            Dim cmd As New SqlCommand
            Try
                con.Open()
                cmd = New SqlCommand("Usp_select_tb_pagos_aplicaciones_factura_por_ndoc_mouse")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Connection = con
                cmd.Parameters.AddWithValue("@vc_ndoc", dts.vc_n_doc)
                cmd.Parameters.AddWithValue("@vc_factura", dts.vc_solicitud)


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
#End Region



    End Class
End Namespace

