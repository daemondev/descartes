Imports App_datos
Imports App_entidades
Imports App_negocio
Imports System.Windows.Forms
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient

Public Class Frm_contactos_incidencia

    Public Sub New()

        ' Llamada necesaria para el diseñador.
        InitializeComponent()

        Me.txt_tipo_incidencia_contactos.Text = Modulo1.lb_tipo_incidencia


        ' Agregue cualquier inicialización después de la llamada a InitializeComponent().

    End Sub

    Public varf4 As String
    Public varf5 As String




    Private Sub Frm_contactos_incidencia_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        ControlBox = False
        mostrar_departamentos()
        ddl_departamento.Text = "Atencion Telefónica HFC - LIMA"
    End Sub
    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Me.Close()
    End Sub

    Public Sub mostrar_departamentos()
        Dim Dt As DataTable
        Dim Da As New SqlDataAdapter
        Dim Cmd As New SqlCommand

        With Cmd
            .CommandType = CommandType.Text
            .CommandText = "select * from  tb_departamento_usuario_incidencia"
            .Connection = con
        End With

        Da.SelectCommand = Cmd
        Dt = New DataTable
        Da.Fill(Dt)
        With ddl_departamento
            .DataSource = Dt
            .DisplayMember = "vc_departamento"
            .ValueMember = "id"
        End With

    End Sub

    Private Sub btn_seleccionar_usuario_Click(sender As Object, e As EventArgs) Handles btn_seleccionar_usuario.Click
        Modulo1.lb_contactos_incidencia = Me.lb_contactos_disponibles.SelectedItem.ToString()
        Me.txt_usuario_seleccionado.Text = Modulo1.lb_contactos_incidencia


        varf5 = txt_usuario_seleccionado.Text
        varf4 = txt_departamento_seleccionado.Text

    End Sub

    Private Sub ddl_departamento_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddl_departamento.SelectedIndexChanged
        Me.txt_departamento_seleccionado.Text = ddl_departamento.Text

        If ddl_departamento.Text = "Atencion Telefónica HFC - LIMA" And Me.txt_tipo_incidencia_contactos.Text = "SOLICITUD-Cliente" Then
            mostrar_lb_contactos_disponibles_Atencion_telefonica()
        ElseIf ddl_departamento.Text = "Back Office ATC fija - LIMA" And Me.txt_tipo_incidencia_contactos.Text = "SOLICITUD-Cliente" Then
            mostrar_lb_contactos_disponibles_back_office()

        ElseIf ddl_departamento.Text = "Validación de Reportes - HFC - LIMA" And Me.txt_tipo_incidencia_contactos.Text = "Incidencia-Cliente" Then
			mostrar_lb_contactos_disponibles_validacion_reportes()

ElseIf ddl_departamento.Text = "Retenciones Masivo - LIMA" And Me.txt_tipo_incidencia_contactos.Text = "SOLICITUD-Cliente" Then
mostrar_lb_disponibles_Retenciones_masivo()

		End If
	End Sub
	 Public Sub mostrar_lb_disponibles_Retenciones_masivo()
		Dim oComando As New SqlCommand("Select * from tb_usuarios_disponibles where vc_tipo_incidencia='" & Me.txt_tipo_incidencia_contactos.Text & "' and vc_departamento='" & Me.txt_departamento_seleccionado.Text & "'", con)
		Dim oDataReader As SqlDataReader
		con.Open()
		oDataReader = oComando.ExecuteReader()

		While oDataReader.Read()
			Me.lb_contactos_disponibles.Items.Add(oDataReader("vc_usuario"))
		End While
		oDataReader.Close()
		con.Close()

	 End Sub

    Public Sub mostrar_lb_contactos_disponibles_Atencion_telefonica()
        Dim oComando As New SqlCommand("Select * from tb_usuarios_disponibles where vc_tipo_incidencia='" & Me.txt_tipo_incidencia_contactos.Text & "' and vc_departamento='" & Me.txt_departamento_seleccionado.Text & "'", con)
        Dim oDataReader As SqlDataReader
        con.Open()
        oDataReader = oComando.ExecuteReader()

        While oDataReader.Read()
            Me.lb_contactos_disponibles.Items.Add(oDataReader("vc_usuario"))
        End While
        oDataReader.Close()
        con.Close()

    End Sub

    Public Sub mostrar_lb_contactos_disponibles_back_office()
        Dim oComando As New SqlCommand("Select * from tb_usuarios_disponibles where vc_tipo_incidencia='" & Me.txt_tipo_incidencia_contactos.Text & "' and vc_departamento='" & Me.txt_departamento_seleccionado.Text & "'", con)
        Dim oDataReader As SqlDataReader
        con.Open()
        oDataReader = oComando.ExecuteReader()

        While oDataReader.Read()
            Me.lb_contactos_disponibles.Items.Add(oDataReader("vc_usuario"))
        End While
        oDataReader.Close()
        con.Close()
    End Sub

    Public Sub mostrar_lb_contactos_disponibles_validacion_reportes()
        Dim oComando As New SqlCommand("Select * from tb_usuarios_disponibles where vc_tipo_incidencia='" & Me.txt_tipo_incidencia_contactos.Text & "' and vc_departamento='" & Me.txt_departamento_seleccionado.Text & "'", con)
        Dim oDataReader As SqlDataReader
        con.Open()
        oDataReader = oComando.ExecuteReader()

        While oDataReader.Read()
            Me.lb_contactos_disponibles.Items.Add(oDataReader("vc_usuario"))
        End While
        oDataReader.Close()
        con.Close()
    End Sub

    Private Sub lb_contactos_disponibles_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lb_contactos_disponibles.SelectedIndexChanged

    End Sub
End Class