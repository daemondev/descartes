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

    Public Class DL_DEPARTAMENTO
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("dbConexion").ConnectionString)

        Public Function mostrar_departamentos() As DataRow
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select vc_departamento from  tb_departamento_usuario_incidencia"
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function


        Public Function mostrar_contactos_disponibles() As DataRow
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select vc_usuario from tb_usuarios_disponibles"
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function

        '        Dim comando As New SqlCommand("Select campo1, campo2, campo3 from Tabla", conexion)
        '        Dim lector As SqlDataReader
        'lector = comando.ExecuteReader
        'While (lector.Read)
        '        'Aquí debe agregar los datos a todos los listbox
        'LST1.Items.Add(lector(0))
        'LST2.Items.Add(lector(1))
        'LST3.Items.Add(lector(2))
        'End While
        'conexion.Close()


        Public Function mostrar_lb_contactos_disponibles_atencion_telefonica(id As String, id1 As String) As DataRow
            If (String.IsNullOrEmpty(id)) Then
                Throw New ArgumentNullException("id")
                Throw New ArgumentNullException("id1")
            End If
            Dim returnValue As DataRow = Nothing
            con.Open()
            Dim cmd As SqlCommand = con.CreateCommand()
            cmd.CommandText = "select vc_usuario from tb_usuarios_disponibles where vc_tipo_incidencia=@tipo_incidencia and vc_departamento=@departamento"
            cmd.Parameters.AddWithValue("@tipo_incidencia", id)
            cmd.Parameters.AddWithValue("@departamento", id1)
            Dim da As New SqlDataAdapter(cmd)
            Using dt As New DataTable()
                da.Fill(dt)
                If (dt.Rows.Count > 0) Then
                    returnValue = dt.Rows(0)
                End If
            End Using
            Return returnValue
        End Function






    End Class
End Namespace

