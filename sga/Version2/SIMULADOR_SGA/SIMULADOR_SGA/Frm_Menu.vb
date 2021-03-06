﻿Imports App_datos
Imports App_entidades
Imports App_negocio
Imports System.Windows.Forms
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Public Class Frm_Menu
    Private Sub Form2_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Dim frm3 As New Frm_Principal()
        frm3.MdiParent = Me
        frm3.WindowState = FormWindowState.Maximized
        frm3.Show()
        Me.WindowState = FormWindowState.Maximized
        Me.ToolStrip2.Visible = False

        If Util.debug Then
            debuAction()
        End If

    End Sub

    Sub debuAction()
        Frm_Principal.Close()
        frmConsultaHistorica.MdiParent = Me
        frmConsultaHistorica.WindowState = FormWindowState.Maximized
        frmConsultaHistorica.Show()
    End Sub


    Private Sub ToolStripButton5_Click(sender As Object, e As EventArgs) Handles Consulta_Historica.Click
        Frm_Principal.Close()
        frmConsultaHistorica.MdiParent = Me
        frmConsultaHistorica.WindowState = FormWindowState.Maximized
        frmConsultaHistorica.Show()
    End Sub

    Private Sub ToolStripButton23_Click(sender As Object, e As EventArgs) Handles Generar_Incidencia.Click
        'Boton Guardar - Puerta para generar incidencia.
        frmGenerarIncidencia.Generar_numero_incidencia()
        frmGenerarIncidencia.Generar_numero_ticket()

        'Grabar los cambios Despues que genera el numero de incidencia y numero de ticket
        Dim result As Integer
        Dim comeFromIncidence As Boolean = False
        If Util.incidenciaReady Then
            Util.incidenciaReady = False
            result = DialogResult.Yes
            comeFromIncidence = True
        Else
            result = MessageBox.Show("¿Desea grabar los cambios?",
        "SIMULADOR SGA Atención de Llamadas", MessageBoxButtons.YesNoCancel, MessageBoxIcon.Question)
        End If



        If result = DialogResult.Yes Then
            Modulo1.observaciones_incidencia = frmGenerarIncidencia.txt_observaciones.Text
            Modulo1.codigo = frmConsultaHistorica.txtcodigo1.Text
            Modulo1.n_doc = frmConsultaHistorica.txt_doc_cliente.Text
            Modulo1.n_servicio = frmConsultaHistorica.txt_nservicio_cliente.Text
            Modulo1.area_derivacion = frmGenerarIncidencia.txt_derivacion.Text
            Modulo1.asesor_derivacion = frmGenerarIncidencia.txt_asesor_derivacion.Text
            Guardar_incidencia()
            Guardar_cliente_servicios_incidencia()
            Guardar_seguimiento_incidencia()
            If frmConsultaHistorica.CheckBox1.Checked = True Then
                frmConsultaHistorica.mostrar_incidencias_lista_general_por_codigo()
            ElseIf frmConsultaHistorica.chkBNroDocIdentidad.Checked = True Then
                frmConsultaHistorica.mostrar_incidencias_lista_general_por_doc()
            ElseIf frmConsultaHistorica.CheckBox9.Checked = True Then
                frmConsultaHistorica.mostrar_incidencias_lista_general_por_nservicio()
            End If
            frmGenerarIncidencia.txt_incidencia.ForeColor = Color.Black
            frmGenerarIncidencia.txt_incidencia.Enabled = False
            frmGenerarIncidencia.txt_ticket.ForeColor = Color.Black
            frmGenerarIncidencia.txt_ticket.Enabled = False
            frmConsultaHistorica.WindowState = FormWindowState.Maximized
            If Not comeFromIncidence Then
                frmConsultaHistorica.tabMain.SelectedIndex = 9
                frmConsultaHistorica.TabControl4.SelectedIndex = 6
            End If

        End If
        'If frm4.CheckBox1.Checked = True Then
        '    frm4.mostrar_incidencias_lista_general_por_codigo()
        'ElseIf frm4.CheckBox3.Checked = True Then
        '    frm4.mostrar_incidencias_lista_general_por_doc()
        'ElseIf frm4.CheckBox9.Checked = True Then
        '    frm4.mostrar_incidencias_lista_general_por_nservicio()
        'End If
    End Sub
    Public Sub Guardar_incidencia()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos
            Dim func As New DL.DL_incidencia 'instanciamos a la clase funciones de la tabla trabajador
            'enviamos los datos
            dts.vc_incidencia = frmGenerarIncidencia.txt_incidencia.Text
            dts.vc_tipo_incidencia = frmGenerarIncidencia.txt_tipo_incidencia.Text
            dts.vc_nticket = frmGenerarIncidencia.txt_ticket.Text
            dts.vc_estado = frmGenerarIncidencia.txt_estado.Text
            dts.vc_area_registro = frmGenerarIncidencia.txt_derivacion.Text
            dts.vc_usuario_registro = frmGenerarIncidencia.txt_usuario_ingresado.Text
            dts.vc_canal_ingreso = frmGenerarIncidencia.ddl_canal_ingreso.SelectedItem.ToString()
            dts.vc_fecharegistro = frmGenerarIncidencia.txt_f_registro.Text
            dts.vc_fecha_env = frmGenerarIncidencia.txt_f_declarada.Text
            dts.vc_tipo_caso = frmGenerarIncidencia.txt_tipo_caso.Text
            dts.vc_codigo = Modulo1.codigo
            dts.n_doc = Modulo1.n_doc
            dts.n_servicio = Modulo1.n_servicio
            If func.guardar_incidencia(dts) Then
                frmGenerarIncidencia.Visible = False
            Else
                MessageBox.Show("Error al intentar Guardar", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
        End Try
    End Sub
    Public Sub Guardar_incidencia_con_sot()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos
            Dim func As New DL.DL_incidencia 'instanciamos a la clase funciones de la tabla trabajador
            'enviamos los datos
            dts.vc_incidencia = frmGenerarIncidencia.txt_incidencia.Text
            dts.vc_tipo_incidencia = frmGenerarIncidencia.txt_tipo_incidencia.Text
            dts.vc_nticket = frmGenerarIncidencia.txt_ticket.Text
            dts.vc_estado = frmGenerarIncidencia.txt_estado.Text
            dts.vc_area_registro = frmGenerarIncidencia.txt_derivacion.Text
            dts.vc_usuario_registro = frmGenerarIncidencia.txt_usuario_ingresado.Text
            dts.vc_canal_ingreso = frmGenerarIncidencia.ddl_canal_ingreso.SelectedItem.ToString()
            dts.vc_fecharegistro = frmGenerarIncidencia.txt_f_registro.Text
            dts.vc_fecha_env = frmGenerarIncidencia.txt_f_declarada.Text
            dts.vc_tipo_caso = frmGenerarIncidencia.txt_tipo_caso.Text
            dts.vc_codigo = Modulo1.codigo
            dts.n_doc = Modulo1.n_doc
            dts.n_servicio = Modulo1.n_servicio

            If func.guardar_incidencia(dts) Then
                ' frm5.Visible = False
            Else
                MessageBox.Show("Error al intentar Guardar", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
        End Try
    End Sub
    Public Sub Guardar_cliente_servicios_incidencia()
        Try
            Dim dts As New SOT.TB_incidencias_lista_general
            Dim func As New DL.DL_incidencia 'instanciamos a la clase funciones de la tabla trabajador
            'enviamos los datos
            dts.vc_codigo_incidencias = Modulo1.codigo_cliente_incidencia
            dts.vc_nombre_cliente = Modulo1.cliente_incidencia
            dts.vc_numero_servicio = Modulo1.servicio
            dts.vc_desc_servicio = Modulo1.producto_contratado
            dts.vc_tipo_servicio = frmGenerarIncidencia.ddl_tipo_servicio.SelectedItem.ToString()
            dts.vc_estado = Modulo1.estado_incidencia
            dts.vc_usuario = Modulo1.nombres_usuario
            dts.vc_incidencia_seguimiento = Modulo1.n_incidencias

            If func.guardar_cliente_servicios_incidencia(dts) Then
                frmGenerarIncidencia.Visible = False
            Else
                MessageBox.Show("Error al intentar Guardar", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
        End Try
    End Sub
    Public Sub Guardar_cliente_servicios_incidencia_con_sot()
        Try
            Dim dts As New SOT.TB_incidencias_lista_general
            Dim func As New DL.DL_incidencia 'instanciamos a la clase funciones de la tabla trabajador
            'enviamos los datos
            dts.vc_codigo_incidencias = Modulo1.codigo_cliente_incidencia
            dts.vc_nombre_cliente = Modulo1.cliente_incidencia
            dts.vc_numero_servicio = Modulo1.servicio
            dts.vc_desc_servicio = Modulo1.producto_contratado
            dts.vc_tipo_servicio = frmGenerarIncidencia.ddl_tipo_servicio.SelectedItem.ToString()
            dts.vc_estado = Modulo1.estado_incidencia
            dts.vc_usuario = Modulo1.nombres_usuario
            dts.vc_incidencia_seguimiento = Modulo1.n_incidencias
            If func.guardar_cliente_servicios_incidencia(dts) Then
                ' frm5.Visible = False
            Else
                MessageBox.Show("Error al intentar Guardar", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
        End Try
    End Sub
    Public Sub Guardar_seguimiento_incidencia()
        Try
            Dim dts As New SOT.TB_seguimiento_incidencia
            Dim func As New DL.DL_incidencia 'instanciamos a la clase funciones de la tabla trabajador
            'enviamos los datos
            dts.vc_recepcionista = Modulo1.usuario
            dts.vc_estado = Modulo1.estado_incidencia
            dts.vc_area_origen = "Atencion Telefonica HFC"
            dts.vc_usuario_origen = Modulo1.usuario
            dts.vc_area_destino = Modulo1.area_derivacion
            dts.vc_usuario_destino = Modulo1.usuario
            dts.vc_observacion = Modulo1.observaciones_incidencia
            dts.vc_incidencia_seguimiento = Modulo1.n_incidencias

            If func.guardar_seguimiento_incidencia(dts) Then
                frmGenerarIncidencia.Visible = False
            Else
                MessageBox.Show("Error al intentar Guardar", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
        End Try
    End Sub
    Public Sub Guardar_seguimiento_incidencia_con_sot()
        Try
            Dim dts As New SOT.TB_seguimiento_incidencia
            Dim func As New DL.DL_incidencia 'instanciamos a la clase funciones de la tabla trabajador
            'enviamos los datos
            dts.vc_recepcionista = Modulo1.usuario
            dts.vc_estado = Modulo1.estado_incidencia
            dts.vc_area_origen = "Atencion Telefonica HFC"
            dts.vc_usuario_origen = Modulo1.usuario
            dts.vc_area_destino = Modulo1.area_derivacion
            dts.vc_usuario_destino = Modulo1.usuario
            dts.vc_observacion = Modulo1.observaciones_incidencia
            dts.vc_incidencia_seguimiento = Modulo1.n_incidencias

            If func.guardar_seguimiento_incidencia(dts) Then
                'frm5.Visible = False
            Else
                MessageBox.Show("Error al intentar Guardar", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
        End Try
    End Sub
    Private Sub ToolStripButton22_Click(sender As Object, e As EventArgs) Handles Generar_SOT.Click
        'Generar SOT
        Frm_Generar_Solicitud_OT.Show()
    End Sub
    Private Sub ToolStripButton10_Click(sender As Object, e As EventArgs) Handles Guardar.Click
        'Boton Guardar Disquete para generar incidencia.
        frmGenerarIncidencia.Generar_numero_incidencia()
        frmGenerarIncidencia.Generar_numero_ticket()
        'Grabar los cambios Despues que genera el numero de incidencia y numero de ticket
        Dim result As Integer = MessageBox.Show("¿Desea grabar los cambios?",
        "SIMULADOR SGA Atención de Llamadas", MessageBoxButtons.YesNoCancel, MessageBoxIcon.Question)
        If result = DialogResult.Yes Then
            Modulo1.observaciones_incidencia = frmGenerarIncidencia.txt_observaciones.Text
            Modulo1.codigo = frmConsultaHistorica.txtcodigo1.Text
            Modulo1.n_doc = frmConsultaHistorica.txt_doc_cliente.Text
            Modulo1.n_servicio = frmConsultaHistorica.txt_nservicio_cliente.Text
            Modulo1.area_derivacion = frmGenerarIncidencia.txt_derivacion.Text
            Modulo1.asesor_derivacion = frmGenerarIncidencia.txt_asesor_derivacion.Text
            Guardar_incidencia_con_sot()
            Guardar_cliente_servicios_incidencia_con_sot()
            Guardar_seguimiento_incidencia_con_sot()
            frmGenerarIncidencia.txt_incidencia.ForeColor = Color.Black
            frmGenerarIncidencia.txt_incidencia.Enabled = False
            frmGenerarIncidencia.txt_ticket.ForeColor = Color.Black
            frmGenerarIncidencia.txt_ticket.Enabled = False
            frmGenerarIncidencia.WindowState = FormWindowState.Normal
            If frmConsultaHistorica.CheckBox1.Checked = True Then
                frmConsultaHistorica.mostrar_incidencias_lista_general_por_codigo()
            ElseIf frmConsultaHistorica.chkBNroDocIdentidad.Checked = True Then
                frmConsultaHistorica.mostrar_incidencias_lista_general_por_doc()
            ElseIf frmConsultaHistorica.CheckBox9.Checked = True Then
                frmConsultaHistorica.mostrar_incidencias_lista_general_por_nservicio()
            End If
            frmConsultaHistorica.tabMain.SelectedIndex = 9
            frmConsultaHistorica.TabControl4.SelectedIndex = 6
            Guardar.Enabled = False
        End If
    End Sub
    Private Sub FavoritosToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles FavoritosToolStripMenuItem.Click
        'MessageBox.Show("Desarrollado Por: Raúl Bellota", "Ayuda", MessageBoxButtons.OK, MessageBoxIcon.Warning)
    End Sub

    Private Sub Frm_Menu_FormClosing(sender As Object, e As FormClosingEventArgs) Handles MyBase.FormClosing

        'If Util.debug Then
        '    Frm_Login_SGA.Close()
        '    Application.Exit()
        'End If

        Frm_Login_SGA.Close()
        Application.Exit()
        
    End Sub
End Class