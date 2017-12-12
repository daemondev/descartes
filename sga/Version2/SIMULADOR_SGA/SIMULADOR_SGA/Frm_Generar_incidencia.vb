Imports App_datos
Imports App_entidades
Imports App_negocio
Imports System.Windows.Forms
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient

Public Class Frm_Generar_incidencia
    Public Sub New()

        InitializeComponent()
        txt_tipo_incidencia.Text = Modulo1.lb_tipo_incidencia
        varf1 = txt_tipo_incidencia.Text
        varf6 = txt_incidencia.Text
        varf7 = txt_ticket.Text
        txt_codigo5_incidencia.Text = Modulo1.codigo
        Me.WindowState = FormWindowState.Minimized
        Me.Refresh()

    End Sub
    Public varf1 As String
    Public varf6 As String
    Public varf7 As String
    Private dt As New DataTable

    Public Sub generar()

        Dim f2 As New Frm_tipo_incidencia()
        Dim res As DialogResult = f2.ShowDialog()
        'Dim res As Boolean

        If (f2.txt_tipo_incidencia5.Text <> "") Then
            txt_tipo_incidencia.Text = f2.varf2
        End If
    End Sub

    Public Sub Limpiar_incidencias()
        txt_incidencia.Clear()
        txt_ticket.Clear()
        txt_tipo_incidencia.Clear()
        ddl_canal_ingreso.SelectedValue = ""
        ddl_tipo_servicio.SelectedValue = ""
        txt_tipo_caso.Clear()
    End Sub

    Private Sub Frm_Generar_incidencia_Load(sender As Object, e As EventArgs) Handles MyBase.Load

        Frm_Tipificacion.txt_numero_servicio_tipo_caso.Text = Modulo1.servicio

        Me.txt_usuario_ingresado.Text = Modulo1.usuario
        Me.txt_nombre_ingresado.Text = Modulo1.nombres_usuario
        Me.txt_cid_generado.Text = Modulo1.servicio
        Me.txt_producto_contratado.Text = Modulo1.producto_contratado
        txt_codigo5_incidencia.Text = Modulo1.codigo


        Me.dg_generacion_incidencias.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        dg_generacion_incidencias.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dg_generacion_incidencias.AllowUserToAddRows = False
        dg_generacion_incidencias.ReadOnly = False
        dg_generacion_incidencias.RowHeadersVisible = False

        mostrar_contactos_incidencias()
        mostrar_datos_incidencias()
        mostrar_clientes_incidencias()
        ddl_canal_ingreso.SelectedItem = "Telefono"

        ddl_tipo_servicio.Text = "Cable"
    End Sub
    Public Sub Generar_numero_incidencia()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_incidencia

            Dim row As DataRow = dto.generar_numero_incidencia()

            If (row Is Nothing) Then
                MessageBox.Show("No hay registros que coincidan con el ID especificado.")
                ' Abandonamos el procedimiento
                Return
            End If


            Modulo1.n_incidencias = Convert.ToString(row("incidencia"))



        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try

        Me.txt_incidencia.Text = Modulo1.n_incidencias

    End Sub
    Public Sub Generar_numero_ticket()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_incidencia

            Dim row As DataRow = dto.generar_numero_ticket()

            If (row Is Nothing) Then
                MessageBox.Show("No hay registros que coincidan con el ID especificado.")
                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            Modulo1.n_tikect = Convert.ToString(row("ticket"))
            Me.txt_ticket.Text = Modulo1.n_tikect

        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try

    End Sub

    Public Sub mostrar_clientes_incidencias()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos
            Dim func As New DL.DL_incidencia

            dts.vc_codigo = Me.txt_codigo_cliente.Text

            dt = func._mostrar_clientes_incidencias(dts)
            If dt.Rows.Count <> 0 Then
                Me.dg_generacion_incidencias.DataSource = dt
            Else
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_contactos_incidencias()
        Try
            Dim dto As New DL.DL_incidencia
            Dim row As DataRow = dto.mostrar_contactos_incidencias(txt_codigo5_incidencia.Text)
            If (row Is Nothing) Then
                MessageBox.Show("No hay registros que coincidan con el ID especificado.")
                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow

            Modulo1.codigo_cliente_incidencia = Convert.ToString(row("vc_codigo_cliente"))
            Modulo1.cliente_incidencia = Convert.ToString(row("vc_cliente"))
            txt_contacto_cliente.Text = Convert.ToString(row("vc_contacto_cliente"))
            txt_contacto.Text = Convert.ToString(row("vc_contacto"))
            txt_segmento_negocio.Text = Convert.ToString(row("vc_segmento_negocio"))
            txt_observaciones.Text = Convert.ToString(row("vc_observaciones"))
            txt_derivacion.Text = Convert.ToString(row("vc_area_derivacion"))
            txt_asesor_derivacion.Text = Convert.ToString(row("vc_usuario_derivacion"))


            Me.txt_codigo_cliente.Text = Modulo1.codigo_cliente_incidencia
            Me.txt_cliente.Text = Modulo1.cliente_incidencia
            '  Me.txt_observaciones.Text = Modulo1.observaciones_incidencia



        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try

    End Sub
    Public Sub mostrar_datos_incidencias()
        Try
            Dim dto As New DL.DL_incidencia
            Dim row As DataRow = dto.mostrar_datos_incidencias()
            If (row Is Nothing) Then
                MessageBox.Show("No hay registros que coincidan con el ID especificado.")
                ' Abandonamos el procedimiento
                Return
            End If

            txt_incidencia.Text = Convert.ToString(row("vc_incidencia"))
            txt_f_registro.Text = Convert.ToString(row("vc_f_registro"))
            txt_usuario.Text = Convert.ToString(row("vc_usuario"))
            txt_rep_atc.Text = Convert.ToString(row("vc_rep_atc"))
            txt_ticket.Text = Convert.ToString(row("vc_ticket"))
            txt_prioridad.Text = Convert.ToString(row("in_prioridad"))
            Modulo1.estado_incidencia = Convert.ToString(row("vc_estadp"))
            txt_tipo_atencion.Text = Convert.ToString(row("vc_tipo_atencion"))
            txt_f_declarada.Text = Convert.ToString(row("vc_f_declarada"))

            txt_estado.Text = Modulo1.estado_incidencia
        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try
    End Sub
    Private Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        'Presionar tipo de incidencia
        Dim f2 As New Frm_tipo_incidencia()
        'creamos un objeto del formulario 2
        Dim res As DialogResult = f2.ShowDialog()
        'abrimos el formulario 2 como cuadro de dialogo modal

        If f2.txt_tipo_incidencia5.Text <> "" Then
            'recuperando la variable publica del formulario 2
            'asignamos al texbox el dato de la variable
            txt_tipo_incidencia.Text = f2.varf2

            If txt_tipo_incidencia.Text = "SOLICITUD- Cliente" Then
                txt_estado.Text = "Generado"

            ElseIf txt_tipo_incidencia.Text = "INFORMACIÓN-Información" Then
                txt_estado.Text = "Registrado"

            ElseIf txt_tipo_incidencia.Text <> "" Then
                txt_estado.Text = "Generado"
            End If
        End If
    End Sub
    Private Sub Button5_Click(sender As Object, e As EventArgs) Handles Button5.Click

        Dim frmTipificacion As New Frm_Tipificacion()
        frmTipificacion.tipoGestion = ddl_tipo_servicio.Text
        Dim res As DialogResult = frmTipificacion.ShowDialog()

        'Presiona el boton de tipo de caso
        If frmTipificacion.txt_3.Text <> "" Then
            txt_tipo_caso.Text = frmTipificacion.varf3
        End If


        If res = DialogResult.OK Then
            txt_tipo_caso.Text = frmTipificacion.varf3
        End If

    End Sub

    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
		Dim result As Integer = MessageBox.Show("Existen incidencias relacionadas a la designación o servicio seleccionado.Desea revisarlos?",
	  "Incidencias Relacionadas", MessageBoxButtons.YesNo, MessageBoxIcon.Warning)

		If result = DialogResult.No Then
            ddl_tipo_servicio.SelectedItem = "Acceso Dedicado a Internet"

		End If
    End Sub

    Private Sub Button7_Click(sender As Object, e As EventArgs) Handles Button7.Click

        Dim f4 As New Frm_contactos_incidencia()
        Dim res As DialogResult = f4.ShowDialog()
        If res = DialogResult.OK Then
            txt_asesor_derivacion.Text = f4.varf5
            txt_derivacion.Text = f4.varf4
        End If
    End Sub
End Class