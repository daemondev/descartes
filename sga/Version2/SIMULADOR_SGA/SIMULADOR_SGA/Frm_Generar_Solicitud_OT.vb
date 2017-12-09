Imports App_datos
Imports App_entidades
Imports App_negocio
Imports System.Windows.Forms
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Public Class Frm_Generar_Solicitud_OT

    Private Sub Frm_Generar_Solicitud_OT_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Me.MaximizeBox = False  ' boton maximizar
        Me.MinimizeBox = False   ' boton minimizar
        Me.txt_incidencia_sot.Text = Modulo1.n_incidencias
        Me.txt_codigo_cliente_sot.Text = Modulo1.codigo
        Me.txt_nom_cliente_sot.Text = Modulo1.cliente_incidencia
        Me.txt_direccion_sot.Text = Modulo1.direccion_cliente
        Me.txt_distrito_sot.Text = Modulo1.distrito_cliente

        Me.txt_solicitante_sot.Text = Modulo1.usuario








        Me.txt_fecha_comp.Text = Format(Now, "Short Date") '+ "18:00:00"
    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Dim result1 As Integer = MessageBox.Show("Seguro de ejecutar la SOT?", "Generar SOT", MessageBoxButtons.YesNo, MessageBoxIcon.Exclamation)
        If result1 = DialogResult.Yes Then

            generar_numero_solicitud_ot()
            guardar_solicitud_ot()
            guardar_detalle_solicitud_ot()


            Me.Close()

            frm5.Visible = False
            frm4.WindowState = FormWindowState.Maximized
            frm4.tabMain.SelectedIndex = 9
            frm4.TabControl4.SelectedIndex = 6
        End If

        'If Me.CheckBox10.Checked = True Then



        'ElseIf CheckBox1.Checked = True Or CheckBox2.Checked = True Or CheckBox3.Checked = True Or CheckBox4.Checked = True Or CheckBox5.Checked = True Or CheckBox6.Checked = True Or CheckBox7.Checked = True Or CheckBox8.Checked = True Or CheckBox9.Checked = True Then
        '    CheckBox1.BackColor = Color.Red
        '    CheckBox2.BackColor = Color.Red
        '    CheckBox3.BackColor = Color.Red
        '    CheckBox4.BackColor = Color.Red
        '    CheckBox5.BackColor = Color.Red
        '    CheckBox6.BackColor = Color.Red
        '    CheckBox7.BackColor = Color.Red
        '    CheckBox8.BackColor = Color.Red
        '    CheckBox9.BackColor = Color.Red
        '    Dim result2 As Integer = MessageBox.Show("No se puede seleccionar este horario, deberia seleccionar un horario superior", "Avisos", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
        'End If
    End Sub

    Public Sub generar_numero_solicitud_ot()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_solicitud_ot

            Dim row As DataRow = dto.generar_numero_solicitud_ot()

            If (row Is Nothing) Then
                MessageBox.Show("No hay registros que coincidan con el ID especificado.")
                ' Abandonamos el procedimiento
                Return
            End If

            txt_num_solicitud_sot.Text = Convert.ToString(row("solicitud"))
            Modulo1.num_solicitud_actual = txt_num_solicitud_sot.Text


        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub

    Public Sub guardar_solicitud_ot()
        Try
            Dim dts As New SOT.TB_solicitudes_ot
            Dim func As New DL.DL_solicitud_ot

            'enviamos los datos

            dts.vc_solicitud = txt_num_solicitud_sot.Text
            dts.vc_codigo = txt_codigo_cliente_sot.Text
            dts.vc_cliente = txt_nom_cliente_sot.Text
            dts.vc_direccion = txt_direccion_sot.Text
            dts.vc_distrito = txt_distrito_sot.Text
            dts.vc_incidencia = txt_incidencia_sot.Text
            dts.vc_tipo = ddl_tipo_trabajo_sot.SelectedItem.ToString
            dts.vc_motivo = ddl_motivo_sot.SelectedItem.ToString
            dts.vc_tipo_servicio = txt_tipo_servicio_sot.Text
            dts.vc_area = txt_area.Text
            dts.vc_f_comp = txt_fecha_comp.Text
            dts.vc_solicitante = txt_solicitante_sot.Text
            dts.vc_observacion = txt_observaciones_sot.Text
            'dts.vc_n_doc = Modulo1.n_doc
            'dts.vc_n_servicio = Modulo1.n_servicio

            If func.guardar_solicitud_ot(dts) Then

            Else
                MessageBox.Show("Error al intentar Guardar", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If


        Catch ex As Exception
        End Try
    End Sub


    Public Sub guardar_detalle_solicitud_ot()
        Try
            Dim dts As New SOT.TB_solicitudes_ot
            Dim func As New DL.DL_solicitud_ot

            'enviamos los datos

            dts.vc_codigo = txt_codigo_cliente_sot.Text
            dts.vc_numero_servicio = Modulo1.servicio
            dts.vc_cliente = txt_nom_cliente_sot.Text
            dts.vc_incidencia = txt_incidencia_sot.Text
            dts.vc_producto_contratado = Modulo1.producto_contratado
            dts.vc_solicitud = Modulo1.num_solicitud_actual

            If func.guardar_detalle_solicitud_ot(dts) Then

            Else
                MessageBox.Show("Error al intentar Guardar", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If


        Catch ex As Exception
        End Try
    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        Me.Close()
    End Sub

End Class