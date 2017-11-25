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

Module Modulo1
    Public frm5 As New Frm_Generar_incidencia()
    Public frm4 As New Frm_Consulta_Histórica()
    Public frm9 As New Frm_Buscar_Cliente()

    Public con As New SqlConnection(ConfigurationManager.ConnectionStrings("dbConexion").ConnectionString)
    'Numeroo de servicio contratado al momento de generar una incidencia
    Public servicio As String

    'Producto de servicio contrataado al momento de generar una incidencia
    Public producto_contratado As String

    'Tipo de incidencia seleccionada para almacenar en el textbox
    Public lb_tipo_incidencia As String

    Public lb_contactos_incidencia As String
    'Nombre del usuario E al loguearse
    Public usuario As String

    'Seleccionar tipo de caso
    Public tipo_caso As String

    'Contraseña del usuario al loguearse
    Public contraseña As String

    'Nombres del usuario al loguearse
    Public nombres_usuario As String


    Public incidencia_general As String


    Public asesor_derivacion As String

    Public area_derivacion As String

    'Generar numero de incidencia
    Public n_incidencias As String

    'Generar numero de ticket
    Public n_tikect As String

    Public estado_incidencia As String


    Public cliente_incidencia As String
    Public codigo_cliente_incidencia As String


    Public observaciones_incidencia As String

    Public codigo_cliente_f9 As String

    'Public incidencia As String

    Public contador_solicitudes_ot As Integer
    Public contador_facturas As Integer


    Public direccion_cliente As String
    Public distrito_cliente As String


    Public num_solicitud_actual As String


Public codigo As String
Public n_doc As String
    Public n_servicio As String

    Public Sub maximizar_consulta_historica()
        frm5.WindowState = FormWindowState.Maximized
    End Sub


    Public Sub generar()
        Dim f2 As New Frm_tipo_incidencia()
        Dim res As DialogResult = f2.ShowDialog()


        If res = DialogResult.OK Then

            Frm_Generar_incidencia.varf1 = Modulo1.lb_tipo_incidencia
            Frm_Generar_incidencia.txt_tipo_incidencia.Text = Modulo1.lb_tipo_incidencia
        End If


    End Sub


End Module
