Imports App_datos
Imports App_entidades
Imports App_negocio
Imports System.Windows.Forms
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.Drawing.Drawing2D

Public Class Frm_Consulta_Histórica
    Public Sub New()
        InitializeComponent()
        Me.VScrollBar3.LargeChange = 1
        Me.VScrollBar3.Minimum = 1
        Me.VScrollBar3.Name = "VScrollBar1"
        Me.VScrollBar3.TabIndex = 1
        Me.VScrollBar3.Value = 1


        Me.VScrollBar4.LargeChange = 1
        Me.VScrollBar4.Minimum = 1
        Me.VScrollBar4.Name = "VScrollBar2"
        Me.VScrollBar4.TabIndex = 1
        Me.VScrollBar4.Value = 1
    End Sub
    Private dt As New DataTable
    Public varf8 As String
    Public varf9 As String

    Sub resizeGridColumns()
        Try
            dgvTVSServicios.Columns(0).Width = 70
            dgvTVSServicios.Columns(1).Width = 150
            dgvTVSServicios.Columns(2).Width = 150
            dgvTVSServicios.Columns(3).Width = 150
            dgvTVSServicios.Columns(4).Width = 50
            dgvTVSServicios.Columns(8).Width = 123
            dgvTVSServicios.Columns(10).Width = 200



            dgvTVSEquipos.Columns(0).Width = 60
            dgvTVSEquipos.Columns(1).Width = 40
            dgvTVSEquipos.Columns(2).Width = 200
            dgvTVSEquipos.Columns(3).Width = 200
            dgvTVSEquipos.Columns(6).Width = 200
            dgvTVSEquipos.Columns(4).Width = 50
            dgvTVSEquipos.Columns(7).Width = 50
            dgvTVSEquipos.Columns(8).Width = 40
        Catch ex As Exception
            MessageBox.Show("No hay Datos para mostrar")
        End Try
        
    End Sub

    Private Sub Frm_Consulta_Histórica_Load(sender As Object, e As EventArgs) Handles MyBase.Load

        If Util.debug Then
            txt_doc_cliente.Text = Util.clieDoc
            chkBNroDocIdentidad.Checked = True
            ddldocumento.SelectedText = "DNI/LE"

            'tabMain.SelectedTab = tabTVSatelitalContainner
            'tabTVSatelital.SelectedTab = tabInalambrico

            btn_buscar_cliente_Click(sender, e)
            'tabMain.SelectedTab = tabServiciosContratados
            'btn_generar_incidencia_Click(sender, e)

            tabTVSatelital.SelectedTab = tabServiciosContratados
        End If
        dgvTVSEquipos.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point)
        dgvTVSServicios.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point)



        Me.dgvTVSEquipos.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        Me.dgvTVSEquipos.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dgvTVSEquipos.AllowUserToAddRows = False
        dgvTVSEquipos.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
        dgvTVSEquipos.RowHeadersVisible = False

        Me.dgvTVSServicios.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        Me.dgvTVSServicios.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dgvTVSServicios.AllowUserToAddRows = False
        dgvTVSServicios.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
        dgvTVSServicios.RowHeadersVisible = False



        Manager.disableTextbox(gbxTVSCliente, gbxTVSContrato, gbxTVSFactInst, gbxTVSLeft, gbxTVSMotVenta, gbxTVSRecargas, gbxDCDatosBasicos, panel_solicitud_ot, gbxDCObservaciones)
        txtcategoria.ForeColor = Color.Red
        txt_incidencia_ot.ForeColor = Color.Black
        'Orden de los datagriedview
        dg_datos.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        dg_datos.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dg_datos.AllowUserToAddRows = False
        dg_datos.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
        dg_datos.RowHeadersVisible = False

        Me.dg_anotaciones_ot.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        Me.dg_anotaciones_ot.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dg_anotaciones_ot.AllowUserToAddRows = False
        dg_anotaciones_ot.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
        dg_anotaciones_ot.RowHeadersVisible = False

        Me.dgvDCcontactos.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        Me.dgvDCcontactos.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dgvDCcontactos.AllowUserToAddRows = False
        dgvDCcontactos.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
        dgvDCcontactos.RowHeadersVisible = False

        dg_detalle_ot.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        dg_detalle_ot.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dg_detalle_ot.AllowUserToAddRows = False
        dg_detalle_ot.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
        dg_detalle_ot.RowHeadersVisible = False


        dg_incidencias_clientes.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        dg_incidencias_clientes.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dg_incidencias_clientes.AllowUserToAddRows = False
        dg_incidencias_clientes.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
        dg_incidencias_clientes.RowHeadersVisible = False


        Me.dg_incidencias_lista_general.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        dg_incidencias_lista_general.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dg_incidencias_lista_general.AllowUserToAddRows = False
        dg_incidencias_lista_general.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
        dg_incidencias_lista_general.RowHeadersVisible = False

        Me.dg_incidencias_lista_general_clientes_servicios.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        dg_incidencias_lista_general_clientes_servicios.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dg_incidencias_lista_general_clientes_servicios.AllowUserToAddRows = False
        dg_incidencias_lista_general_clientes_servicios.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
        dg_incidencias_lista_general_clientes_servicios.RowHeadersVisible = False

        Me.dg_incidencias_lista_general_seguimiento.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        Me.dg_incidencias_lista_general_seguimiento.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dg_incidencias_lista_general_seguimiento.AllowUserToAddRows = False
        dg_incidencias_lista_general_seguimiento.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
        dg_incidencias_lista_general_seguimiento.RowHeadersVisible = False

        Me.dg_incidencias_reclamos.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        Me.dg_incidencias_reclamos.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dg_incidencias_reclamos.AllowUserToAddRows = False
        dg_incidencias_reclamos.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
        dg_incidencias_reclamos.RowHeadersVisible = False

        Me.dg_incidencias_seguimiento.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        Me.dg_incidencias_seguimiento.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dg_incidencias_seguimiento.AllowUserToAddRows = False
        dg_incidencias_seguimiento.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
        dg_incidencias_seguimiento.RowHeadersVisible = False

        dgvSCservicios.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        dgvSCservicios.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dgvSCservicios.AllowUserToAddRows = False
        dgvSCservicios.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
        dgvSCservicios.RowHeadersVisible = False

        Me.dgvSCTransacciones.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        dgvSCTransacciones.AllowUserToAddRows = False
        dgvSCTransacciones.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
        dgvSCTransacciones.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dgvSCTransacciones.RowHeadersVisible = False

        Me.dg_cambio_estado_solicitudes_ot.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        Me.dg_cambio_estado_solicitudes_ot.AllowUserToAddRows = False
        Me.dg_cambio_estado_solicitudes_ot.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dg_cambio_estado_solicitudes_ot.RowHeadersVisible = False

        Me.dg_tarea_solicitudes_ot.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        Me.dg_tarea_solicitudes_ot.AllowUserToAddRows = False
        Me.dg_tarea_solicitudes_ot.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dg_tarea_solicitudes_ot.RowHeadersVisible = False

        Me.dg_cobranza.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        dg_cobranza.AllowUserToAddRows = False
        dg_cobranza.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dg_cobranza.RowHeadersVisible = False


        dt_pagos_aplicaciones_factura.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        dt_pagos_aplicaciones_factura.AllowUserToAddRows = False
        dt_pagos_aplicaciones_factura.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        dt_pagos_aplicaciones_factura.RowHeadersVisible = False

    End Sub
    Sub alert(ByVal message As String)
        MessageBox.Show(message)
    End Sub
    Private Sub btn_buscar_cliente_Click(sender As Object, e As EventArgs) Handles btn_buscar_cliente.Click
        If CheckBox1.Checked = True And txt_codigo_cliente.Text <> "" And txt_estado_cliente.Text <> "" Then

            cboSCestado_servicio.SelectedItem = "Suspendido"

            mostrar_datos_clientes_por_codigo()
            mostrar_contactos_clientes_por_codigo()
            mostrar_solicitudes_ot_por_codigo()
            mostrar_detalle_ot_por_codigo_mouse()
            mostrar_anotaciones_ot_por_codigo()
            mostrar_incidencias_reclamos_por_codigo()
            mostrar_incidencias_clientes_servicios_por_codigo()
            mostrar_incidencias_lista_general_por_codigo()
            mostrar_factura_por_codigo()
            mostrar_detalle_factura_por_codigo1()
            mostrar_detalle_factura_por_codigo2()
            mostrar_pagos_aplicaciones_factura_por_codigo()
            tabMain.SelectedIndex = 1

            mostrar_cambios_estado_solicitudes_ot_por_codigo()
            mostrar_tarea_solicitudes_ot_por_codigo()
            mostrar_cantidad_solicitudes_ot_por_codigo()
            mostrar_cantidad_facturas_por_codigo()

            mostrar_cobranza_por_codigo()


            cboSCestado_servicio.SelectedItem = "Activo"

        ElseIf chkBNroDocIdentidad.Checked = True And txt_doc_cliente.Text <> "" Then
            'Here
            Util.sot = 0
            'cboSCestado_servicio.SelectedItem = "Suspendido"
            showTVSClientData()
            'If Not Util.haveData Then
            '    Return
            'End If

            mostrar_datos_clientes_por_doc()
            mostrar_contactos_clientes_por_doc()

            'xxx 
            mostrar_solicitudes_ot_por_doc(txt_doc_cliente.Text)
            mostrar_detalle_ot_por_doc_mouse(txt_doc_cliente.Text)
            mostrar_anotaciones_ot_por_doc()
            mostrar_incidencias_reclamos_por_doc()
            mostrar_incidencias_clientes_servicios_por_doc()
            mostrar_incidencias_lista_general_por_doc()
            mostrar_factura_por_doc()
            mostrar_detalle_factura_por_doc1()
            mostrar_detalle_factura_por_doc2()
            mostrar_pagos_aplicaciones_factura_por_doc()

            mostrar_cambios_estado_solicitudes_ot_por_doc()
            mostrar_tarea_solicitudes_ot_por_doc()


            mostrar_cantidad_solicitudes_ot_por_doc()
            mostrar_cantidad_facturas_por_doc()

            mostrar_cobranza_por_doc()

            cboSCestado_servicio.SelectedItem = "Activo"

            tabMain.SelectedIndex = 1

        ElseIf CheckBox9.Checked = True And txt_nservicio_cliente.Text <> "" Then

            cboSCestado_servicio.SelectedItem = "Suspendido"


            mostrar_datos_clientes_por_nservicio()
            mostrar_contactos_clientes_por_nservicio()
            mostrar_solicitudes_ot_por_nservicio()
            mostrar_detalle_ot_por_nservicio_mouse()
            mostrar_anotaciones_ot_por_nservicio()
            mostrar_incidencias_reclamos_por_nservicio()
            mostrar_incidencias_clientes_servicios_por_nservicio()
            mostrar_incidencias_lista_general_por_nservicio()
            mostrar_factura_por_nservicio()
            mostrar_detalle_factura_por_nservicio1()
            mostrar_detalle_factura_por_nservicio2()
            mostrar_pagos_aplicaciones_factura_por_nservicio()

            mostrar_cambios_estado_solicitudes_ot_por_nservicio()
            mostrar_tarea_solicitudes_ot_por_nservicio()

            mostrar_cantidad_solicitudes_ot_por_nservicio()
            mostrar_cantidad_facturas_por_nservicio()

            mostrar_cobranza_por_nservicio()

            cboSCestado_servicio.SelectedItem = "Activo"

            tabMain.SelectedIndex = 1

        Else
            MessageBox.Show("Complete los datos")
        End If

        Modulo1.direccion_cliente = txtdireccion.Text
        Modulo1.distrito_cliente = txtdistrito.Text


        'MOSTRAR SERVICIOS CONTRATADOS
    End Sub

    Sub showTVSClientData()

        Dim dtCliente As DataRow = Nothing
        Try
            dtCliente = Manager.getClientData(Integer.Parse(txt_doc_cliente.Text)).Rows(0)
        Catch ex As Exception
            Util.haveData = False
            Return
        End Try

        Util.haveData = True

        txtTVSNroRegistro.Text = dtCliente("nroRegistro").ToString()
        txtTVSEstadoRegistro.Text = dtCliente("estRegistro").ToString()
        txtTVSFecRegistro.Text = dtCliente("fecRegistro").ToString()
        txtTVSHoraRegistro.Text = dtCliente("horaRegistro").ToString()
        txtTVSUsuario.Text = dtCliente("usuario").ToString()
        txtTVSNroProyecto.Text = dtCliente("nroProyecto").ToString()
        txtTVSSolicitud.Text = dtCliente("solicitud").ToString()

        txtTVSContrata.Text = dtCliente("contrata").ToString()
        txtTVSConsultor.Text = dtCliente("consultor").ToString()
        txtTVSInstalador.Text = dtCliente("instalador").ToString()
        txtTVSClientePre.Text = dtCliente("cliPre").ToString()
        txtTVSClientePost.Text = dtCliente("vc_razon_social").ToString()
        txtTVSCliTipoDoc.Text = dtCliente("vc_documento_tipo").ToString()
        txtTVSCliNroDoc.Text = dtCliente("vc_documento").ToString()
        txtTVSContacto.Text = dtCliente("contacto").ToString()
        txtTVSCliTelefono1.Text = dtCliente("telefono1").ToString()
        txtTVSCliTelefono2.Text = dtCliente("telefono2").ToString()
        txtTVSPaquete.Text = dtCliente("paquete").ToString()
        txtTVSDirInstPre.Text = dtCliente("dirInstPre").ToString()
        txtTVSDirInstPost.Text = dtCliente("dirInstPost").ToString()
        txtTVSDirFacPre.Text = dtCliente("dirFacPre").ToString()
        txtTVSDirFacPost.Text = dtCliente("dirFacPost").ToString()
        txtTVSObservaciones.Text = dtCliente("observacion").ToString()

        txtTVSContratoTipoDoc.Text = dtCliente("contTipoDoc").ToString()
        txtTVSContratoNroDocumento.Text = dtCliente("contNroDocumento").ToString()
        txtTVSFactInstTipoDocumento.Text = dtCliente("facTipoDoc").ToString()
        txtTVSFactInstSerie.Text = dtCliente("facSerie").ToString()
        txtTVSFactInstNumero.Text = dtCliente("facNumero").ToString()

        txtTVSMotVenLugarVenta.Text = dtCliente("motLugarVenta").ToString()
        txtTVSMotVenTipoCliente.Text = dtCliente("motTipoCliente").ToString()
        txtTVSMotVenCompetidor.Text = dtCliente("motCompetidor").ToString()
        txtTVSMotVenTipoFacturacion.Text = dtCliente("motTipoFacturacion").ToString()

        txtTVSRecCodigoRecarga.Text = dtCliente("recCodigo").ToString()
        chkTVSEnSistemaRecarga.Checked = Convert.ToBoolean(dtCliente("recEnSistema"))
        txtTVSRecFecIniVigencia.Text = dtCliente("recFecIniVigencia").ToString()
        txtTVSRecFecFinVigencia.Text = dtCliente("recFecFinVigencia").ToString()
        txtTVSRecFecCorteProgramada.Text = dtCliente("recFecCorteProgramado").ToString()
        txtTVSRecNroUltRecarga.Text = dtCliente("recNumeroUltimaRecarga").ToString()

        Dim n_servicio As String = dtCliente("n_servicio").ToString()
        Dim id As Integer = Convert.ToInt32(dtCliente("id"))

        dgvTVSServicios.DataSource = Manager.getTVSServices(dtCliente("vc_documento").ToString())
        dgvTVSEquipos.DataSource = Manager.getTVSEquipo(id)

        If dgvTVSEquipos.RowCount > 1 Then
            'resizeGridColumns()
        End If

    End Sub


#Region "MOSTRAR CAMBIOS DE ESTADO SOLICITUDES OT"
    Public Sub mostrar_cambios_estado_solicitudes_ot_por_codigo()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_codigo_cliente.Text

            End With
            'enviamos los datos
            dt = func._mostrar_cambios_estado_solicitudes_ot_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dg_cambio_estado_solicitudes_ot.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_cambios_estado_solicitudes_ot_por_doc()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                ' .vc_codigo = Me.txt_codigo_cliente.Text
                .n_doc = txt_doc_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_cambios_estado_solicitudes_ot_por_doc(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dg_cambio_estado_solicitudes_ot.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_cambios_estado_solicitudes_ot_por_nservicio()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .n_servicio = Me.txt_nservicio_cliente.Text

            End With
            'enviamos los datos
            dt = func._mostrar_cambios_estado_solicitudes_ot_por_nservicio(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dg_cambio_estado_solicitudes_ot.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub


#End Region


#Region "MOSTRAR TAREA SOLICITUDES OT"
    Public Sub mostrar_tarea_solicitudes_ot_por_codigo()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_codigo_cliente.Text

            End With
            'enviamos los datos
            dt = func._mostrar_tarea_solicitudes_ot_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dg_tarea_solicitudes_ot.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_tarea_solicitudes_ot_por_doc()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                ' .vc_codigo = Me.txt_codigo_cliente.Text
                .n_doc = txt_doc_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_cambios_estado_solicitudes_ot_por_doc(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dg_tarea_solicitudes_ot.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_tarea_solicitudes_ot_por_nservicio()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .n_servicio = Me.txt_nservicio_cliente.Text

            End With
            'enviamos los datos
            dt = func._mostrar_tarea_solicitudes_ot_por_nservicio(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dg_tarea_solicitudes_ot.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
#End Region



#Region "MOSTRAR CANTIDADE DE  SOLICITUDES OT"
    Public Sub mostrar_cantidad_solicitudes_ot_por_codigo()
        Try
            Dim dto As New DL.DL_cliente
            Dim row As DataRow = dto.mostrar_cantidad_solicitudes_ot_por_codigo(txt_codigo_cliente.Text)
            If (row Is Nothing) Then
                Return
            End If
            Me.txt_count.Text = Convert.ToString(row("count"))
            Modulo1.contador_solicitudes_ot = CInt(txt_count.Text)
            Me.VScrollBar3.Maximum = Modulo1.contador_solicitudes_ot

            If Modulo1.contador_solicitudes_ot = 1 Then
                VScrollBar3.Visible = False
                btn_contar_solicitudes.Text = CStr(Modulo1.contador_solicitudes_ot - 1)
            End If



        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_cantidad_solicitudes_ot_por_doc()
        Try
            Dim dto As New DL.DL_cliente
            Dim row As DataRow = dto.mostrar_cantidad_solicitudes_ot_por_doc(txt_doc_cliente.Text)
            If (row Is Nothing) Then
                Return
            End If
            Me.txt_count.Text = Convert.ToString(row("count"))
            Modulo1.contador_solicitudes_ot = CInt(txt_count.Text)
            Me.VScrollBar3.Maximum = Modulo1.contador_solicitudes_ot

            If Modulo1.contador_solicitudes_ot = 1 Then
                VScrollBar3.Visible = False
                btn_contar_solicitudes.Text = CStr(Modulo1.contador_solicitudes_ot - 1)
            End If


        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_cantidad_solicitudes_ot_por_nservicio()
        Try
            Dim dto As New DL.DL_cliente
            Dim row As DataRow = dto.mostrar_cantidad_solicitudes_ot_por_nservicio(txt_nservicio_cliente.Text)
            If (row Is Nothing) Then
                Return
            End If
            Me.txt_count.Text = Convert.ToString(row("count"))
            Modulo1.contador_solicitudes_ot = CInt(txt_count.Text)
            Me.VScrollBar3.Maximum = Modulo1.contador_solicitudes_ot

            If Modulo1.contador_solicitudes_ot = 1 Then
                VScrollBar3.Visible = False
                btn_contar_solicitudes.Text = CStr(Modulo1.contador_solicitudes_ot - 1)
            End If


        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try

    End Sub
#End Region



#Region "INCIDENCIAS SEGUIMIENTO LISTA GENERAL"
    'Usp_select_incidencias_servicios_por_codigo
    Public Sub mostrar_incidencias_lista_general_seguimiento()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                ' .vc_codigo = Me.txt_codigo_cliente.Text
                .vc_incidencia_seguimiento = Me.txt_2.Text
            End With
            'enviamos los datos
            dt = func._mostrar_seguimiento_lista_general_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_incidencias_lista_general_seguimiento.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_incidencias_lista_general_seguimiento_por_codigo1()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = frm9.txt_5.Text
                .vc_incidencia_seguimiento = Me.txt_2.Text
            End With
            'enviamos los datos
            dt = func._mostrar_seguimiento_lista_general_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_incidencias_lista_general_seguimiento.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
#End Region



#Region "INCIDENCIAS CLIENTES SERVICIO LISTA GENERAL"
    'Usp_select_incidencias_servicios_por_codigo
    Public Sub mostrar_incidencias_lista_general_clientes_servicios()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_incidencia_seguimiento = Me.txt_2.Text
            End With
            'enviamos los datos
            dt = func._mostrar_incidencias_servicios_lista_general_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_incidencias_lista_general_clientes_servicios.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_incidencias_lista_general_clientes_servicios_por_codigo1()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = frm9.txt_5.Text
                .vc_incidencia_seguimiento = Me.txt_2.Text
            End With
            'enviamos los datos
            dt = func._mostrar_incidencias_servicios_lista_general_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_incidencias_lista_general_clientes_servicios.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
#End Region


#Region "INCIDENCIAS CLIENTES LISTA GENERAL"
    'Usp_select_incidencias_servicios_por_codigo
    Public Sub mostrar_incidencias_lista_general_por_codigo()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_codigo_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_incidencias_lista_general_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_incidencias_lista_general.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_incidencias_lista_general_por_doc()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .n_doc = txt_doc_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_incidencias_lista_general_por_n_doc(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_incidencias_lista_general.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_incidencias_lista_general_por_nservicio()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .n_servicio = Me.txt_nservicio_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_incidencias_lista_general_por_n_servicio(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_incidencias_lista_general.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub


#End Region



#Region "INCIDENCIAS CLIENTES SERVICIOS"
    'Usp_select_incidencias_servicios_por_codigo
    Public Sub mostrar_incidencias_clientes_servicios_por_codigo()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_codigo_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_incidencias_clientes_servicios_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_incidencias_clientes.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_incidencias_clientes_servicios_por_doc()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .n_doc = txt_doc_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_incidencias_clientes_servicios_por_n_doc(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_incidencias_clientes.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_incidencias_clientes_servicios_por_nservicio()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .n_servicio = Me.txt_nservicio_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_incidencias_clientes_servicios_por_n_servicio(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_incidencias_clientes.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub


#End Region


#Region "MOSTRAR INCIDENCIAS RECLAMOS"
    Public Sub mostrar_incidencias_reclamos_por_codigo()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_codigo_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_incidencias_reclamos_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_incidencias_reclamos.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_incidencias_reclamos_por_doc()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .n_doc = txt_doc_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_incidencias_reclamos_por_n_doc(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_incidencias_reclamos.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_incidencias_reclamos_por_nservicio()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .n_servicio = Me.txt_nservicio_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_incidencias_reclamos_por_n_servicio(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_incidencias_reclamos.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub


#End Region

#Region "MOSTRAR SOLICITUES OT CLIENTE- ANOTACIONES"

    Public Sub mostrar_anotaciones_ot_por_codigo()
        Try
            Dim dts As New SOT.TB_solicitudes_ot  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_codigo_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_anotaciones_ot_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_anotaciones_ot.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_anotaciones_ot_por_doc()
        Try
            Dim dts As New SOT.TB_solicitudes_ot
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_doc = txt_doc_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_anotaciones_ot_por_n_doc(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_anotaciones_ot.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_anotaciones_ot_por_nservicio()
        Try
            Dim dts As New SOT.TB_solicitudes_ot
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_servicio = Me.txt_nservicio_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_anotaciones_ot_por_n_servicio(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_anotaciones_ot.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
#End Region

#Region "MOSTRAR SOLICITUES OT CLIENTE"

    Public Sub mostrar_detalle_ot_por_codigo()
        Try
            Dim dts As New SOT.TB_solicitudes_ot  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_codigo_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_detalle_ot_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_detalle_ot.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_detalle_ot_por_doc()
        Try
            Dim dts As New SOT.TB_solicitudes_ot
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_doc = txt_doc_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_detalle_ot_por_n_doc(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_detalle_ot.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_detalle_ot_por_nservicio()
        Try
            Dim dts As New SOT.TB_solicitudes_ot
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_servicio = Me.txt_nservicio_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_detalle_ot_por_n_servicio(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_detalle_ot.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
#End Region

#Region "MOSTRAR  SOLICITUDES OT CLIENTE EN TEXTBOX"
    Public Sub mostrar_solicitudes_ot_por_codigo()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.Buscar_solicitudes_ot_por_codigo(txt_codigo_cliente.Text)

            If (row Is Nothing) Then
                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            txt_solicitud_ot.Text = Convert.ToString(row("vc_solicitud"))
            txt_estado_ot.Text = Convert.ToString(row("vc_estado"))
            txt_doc_cliente_ot.Text = Convert.ToString(row("vc_codigo"))
            txt_nom_cliente_ot.Text = Convert.ToString(row("vc_cliente"))
            txt_direccion_ot.Text = Convert.ToString(row("vc_direccion"))
            txt_distrito_ot.Text = Convert.ToString(row("vc_distrito"))
            txt_proyecto_ot.Text = Convert.ToString(row("vc_proyecto"))
            txt_incidencia_ot.Text = Convert.ToString(row("vc_incidencia"))
            txt_tipo_ot.Text = Convert.ToString(row("vc_tipo"))
            txt_motivo_ot.Text = Convert.ToString(row("vc_motivo"))
            txt_area_ot.Text = Convert.ToString(row("vc_area"))
            txt_tipo_servicio_ot.Text = Convert.ToString(row("vc_tipo_servicio"))
            txt_fcomp_ot.Text = Convert.ToString(row("vc_f_comp"))
            txt_pcontable_ot.Text = Convert.ToString(row("vc_p_contable"))
            txt_fgen_ot.Text = Convert.ToString(row("vc_f_gen"))
            txt_solicitante_ot.Text = Convert.ToString(row("vc_solicitante"))
            txt_finicio_ot.Text = Convert.ToString(row("vc_f_inicio"))
            txt_ffin_ot.Text = Convert.ToString(row("vc_f_fin"))
            txt_fapr_ot.Text = Convert.ToString(row("vc_f_apr"))
            txt_act_instalacion_ot.Text = Convert.ToString(row("vc_acta_instalacion"))
            txt_observaciones_ot.Text = Convert.ToString(row("vc_observacion"))






        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_solicitudes_ot_por_doc(ByVal search As String)
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente



            Dim row As DataRow = Nothing


            If Not Util.sot.Equals(0) Then
                Try
                    row = Manager.getCurrentSOT(search).Rows(0)
                Catch ex As Exception
                    row = Nothing
                End Try

            Else
                row = dto.Buscar_solicitudes_ot_por_doc(search)
            End If

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            txt_solicitud_ot.Text = Convert.ToString(row("vc_solicitud"))
            txt_estado_ot.Text = Convert.ToString(row("vc_estado"))
            txt_doc_cliente_ot.Text = Convert.ToString(row("vc_codigo"))
            txt_nom_cliente_ot.Text = Convert.ToString(row("vc_cliente"))
            txt_direccion_ot.Text = Convert.ToString(row("vc_direccion"))
            txt_distrito_ot.Text = Convert.ToString(row("vc_distrito"))
            txt_proyecto_ot.Text = Convert.ToString(row("vc_proyecto"))
            txt_incidencia_ot.Text = Convert.ToString(row("vc_incidencia"))
            txt_tipo_ot.Text = Convert.ToString(row("vc_tipo"))
            txt_motivo_ot.Text = Convert.ToString(row("vc_motivo"))
            txt_area_ot.Text = Convert.ToString(row("vc_area"))
            txt_tipo_servicio_ot.Text = Convert.ToString(row("vc_tipo_servicio"))
            txt_fcomp_ot.Text = Convert.ToString(row("vc_f_comp"))
            txt_pcontable_ot.Text = Convert.ToString(row("vc_p_contable"))
            txt_fgen_ot.Text = Convert.ToString(row("vc_f_gen"))
            txt_solicitante_ot.Text = Convert.ToString(row("vc_solicitante"))
            txt_finicio_ot.Text = Convert.ToString(row("vc_f_inicio"))
            txt_ffin_ot.Text = Convert.ToString(row("vc_f_fin"))
            txt_fapr_ot.Text = Convert.ToString(row("vc_f_apr"))
            txt_act_instalacion_ot.Text = Convert.ToString(row("vc_acta_instalacion"))
            txt_observaciones_ot.Text = Convert.ToString(row("vc_observacion"))

        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub


    Public Sub mostrar_solicitudes_ot_por_nservicio()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.Buscar_solicitudes_ot_por_nservicio(txt_nservicio_cliente.Text)

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            txt_solicitud_ot.Text = Convert.ToString(row("vc_solicitud"))
            txt_estado_ot.Text = Convert.ToString(row("vc_estado"))
            txt_doc_cliente_ot.Text = Convert.ToString(row("vc_codigo"))
            txt_nom_cliente_ot.Text = Convert.ToString(row("vc_cliente"))
            txt_direccion_ot.Text = Convert.ToString(row("vc_direccion"))
            txt_distrito_ot.Text = Convert.ToString(row("vc_distrito"))
            txt_proyecto_ot.Text = Convert.ToString(row("vc_proyecto"))
            txt_incidencia_ot.Text = Convert.ToString(row("vc_incidencia"))
            txt_tipo_ot.Text = Convert.ToString(row("vc_tipo"))
            txt_motivo_ot.Text = Convert.ToString(row("vc_motivo"))
            txt_area_ot.Text = Convert.ToString(row("vc_area"))
            txt_tipo_servicio_ot.Text = Convert.ToString(row("vc_tipo_servicio"))
            txt_fcomp_ot.Text = Convert.ToString(row("vc_f_comp"))
            txt_pcontable_ot.Text = Convert.ToString(row("vc_p_contable"))
            txt_fgen_ot.Text = Convert.ToString(row("vc_f_gen"))
            txt_solicitante_ot.Text = Convert.ToString(row("vc_solicitante"))
            txt_finicio_ot.Text = Convert.ToString(row("vc_f_inicio"))
            txt_ffin_ot.Text = Convert.ToString(row("vc_f_fin"))
            txt_fapr_ot.Text = Convert.ToString(row("vc_f_apr"))
            txt_act_instalacion_ot.Text = Convert.ToString(row("vc_acta_instalacion"))
            txt_observaciones_ot.Text = Convert.ToString(row("vc_observacion"))
        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub



#End Region

#Region "MOSTRAR SERVICIOS CONTRATADOS"


    Public Sub mostrar_servicios_contratados_por_codigo()
        Try
            Dim dts As New SOT.TB_servicios_contratados  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = txt_codigo_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_servicios_contratados_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dgvSCservicios.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_servicios_contratados_por_codigo1()
        Try
            Dim dts As New SOT.TB_servicios_contratados  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = frm9.txt_5.Text
            End With
            'enviamos los datos
            dt = func._mostrar_servicios_contratados_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dgvSCservicios.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_servicios_contratados_por_n_doc()
        Try
            Dim dts As New SOT.TB_servicios_contratados
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .n_doc = txt_doc_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_servicios_contratados_por_n_doc(dts, cboSCestado_servicio.SelectedItem.ToString())
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dgvSCservicios.DataSource = dt
                'dgvSCservicios.Columns(0).Visible = False
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_servicios_contratados_por_nservicio()
        Try
            Dim dts As New SOT.TB_servicios_contratados
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .n_servicio = Me.txt_nservicio_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_servicios_contratados_por_n_servicio(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dgvSCservicios.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub


#End Region

#Region "MOSTRAR DATOS CLIENTES EN TEXTBOX"
    Public Sub mostrar_datos_clientes_por_codigo()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.Buscar_datos_clientes_por_codigo(txt_codigo_cliente.Text)

            If (row Is Nothing) Then
                MessageBox.Show("No hay registros que coincidan con el ID especificado.")
                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            txttipo_persona.Text = Convert.ToString(row("vc_tipo_persona"))
            txtseg_negocio.Text = Convert.ToString(row("vc_segmento_negocio"))
            txtcodigo1.Text = Convert.ToString(row("vc_codigo"))
            txttipo_cliente.Text = Convert.ToString(row("vc_tipo_cliente"))
            txtsec_negocio.Text = Convert.ToString(row("vc_sector_negocio"))
            txttipo_doc.Text = Convert.ToString(row("vc_documento_tipo"))
            txtdoc.Text = Convert.ToString(row("vc_documento"))
            txtsub_negocio.Text = Convert.ToString(row("vc_subsector_negocio"))
            txtrazon_social.Text = Convert.ToString(row("vc_razon_social"))
            txttipo_empresa.Text = Convert.ToString(row("vc_tipo_empresa"))
            txtabreviado.Text = Convert.ToString(row("vc_abreviado"))
            txtgrupo_economico.Text = Convert.ToString(row("vc_grupo_economico"))
            txtdireccion.Text = Convert.ToString(row("vc_direccion"))
            txtcategoria.Text = Convert.ToString(row("vc_categoria"))
            txtdistrito.Text = Convert.ToString(row("vc_distrito"))
            txtejectutivo_datos.Text = Convert.ToString(row("vc_ejecutivo_datos"))
            txtciudad.Text = Convert.ToString(row("vc_ciudad"))
            txtpais.Text = Convert.ToString(row("vc_pais"))
            txtintegrador.Text = Convert.ToString(row("vc_integrador"))
            txtemail.Text = Convert.ToString(row("vc_email"))
            txtadm_proyecto.Text = Convert.ToString(row("vc_adm_proyecto"))
            txtweb.Text = Convert.ToString(row("vc_web"))
            txtgestor_cobranza.Text = Convert.ToString(row("vc_gestor_cobranza"))
            txtIM.Text = Convert.ToString(row("vc_IM"))
            txtIE.Text = Convert.ToString(row("vc_IE"))
            txtactividad_economica.Text = Convert.ToString(row("vc_act_economica"))

            txtobservaciones.Text = Convert.ToString(row("vc_observaciones"))

            txttipo_act.Text = Convert.ToString(row("vc_tipo_act"))
            txt_fecha.Text = CStr(Convert.ToDateTime(row("dt_fecha")))

        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub



    Public Sub mostrar_datos_clientes_por_doc()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            'Dim row As DataRow = dto.Buscar_datos_clientes_por_doc(txt_doc_cliente.Text)
            Dim row As DataRow = Nothing
            Try
                row = R.get("getClientByDOC", txt_doc_cliente.Text).Rows(0)
            Catch ex As Exception
                Return
            End Try

            If (row Is Nothing) Then
                MessageBox.Show("No hay registros que coincidan con el ID especificado.")
                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            txttipo_persona.Text = Convert.ToString(row("vc_tipo_persona"))
            txtseg_negocio.Text = Convert.ToString(row("vc_segmento_negocio"))
            txtcodigo1.Text = Convert.ToString(row("vc_codigo"))
            txttipo_cliente.Text = Convert.ToString(row("vc_tipo_cliente"))
            txtsec_negocio.Text = Convert.ToString(row("vc_sector_negocio"))
            txttipo_doc.Text = Convert.ToString(row("vc_documento_tipo"))
            txtdoc.Text = Convert.ToString(row("vc_documento"))
            txtsub_negocio.Text = Convert.ToString(row("vc_subsector_negocio"))
            txtrazon_social.Text = Convert.ToString(row("vc_razon_social"))
            txttipo_empresa.Text = Convert.ToString(row("vc_tipo_empresa"))
            txtabreviado.Text = Convert.ToString(row("vc_abreviado"))
            txtgrupo_economico.Text = Convert.ToString(row("vc_grupo_economico"))
            txtdireccion.Text = Convert.ToString(row("vc_direccion"))
            txtcategoria.Text = Convert.ToString(row("vc_categoria"))
            txtdistrito.Text = Convert.ToString(row("vc_distrito"))
            txtejectutivo_datos.Text = Convert.ToString(row("vc_ejecutivo_datos"))
            txtciudad.Text = Convert.ToString(row("vc_ciudad"))
            txtpais.Text = Convert.ToString(row("vc_pais"))
            txtintegrador.Text = Convert.ToString(row("vc_integrador"))
            txtemail.Text = Convert.ToString(row("vc_email"))
            txtadm_proyecto.Text = Convert.ToString(row("vc_adm_proyecto"))
            txtweb.Text = Convert.ToString(row("vc_web"))
            txtgestor_cobranza.Text = Convert.ToString(row("vc_gestor_cobranza"))
            txtIM.Text = Convert.ToString(row("vc_IM"))
            txtIE.Text = Convert.ToString(row("vc_IE"))
            txtactividad_economica.Text = Convert.ToString(row("vc_act_economica"))

            txtobservaciones.Text = Convert.ToString(row("vc_observaciones"))

            txttipo_act.Text = Convert.ToString(row("vc_tipo_act"))
            txt_fecha.Text = CStr(Convert.ToDateTime(row("dt_fecha")))

        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub


    Public Sub mostrar_datos_clientes_por_nservicio()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.Buscar_datos_clientes_por_nservicio(txt_nservicio_cliente.Text)

            If (row Is Nothing) Then
                MessageBox.Show("No hay registros que coincidan con el ID especificado.")
                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            txttipo_persona.Text = Convert.ToString(row("vc_tipo_persona"))
            txtseg_negocio.Text = Convert.ToString(row("vc_segmento_negocio"))
            txtcodigo1.Text = Convert.ToString(row("vc_codigo"))
            txttipo_cliente.Text = Convert.ToString(row("vc_tipo_cliente"))
            txtsec_negocio.Text = Convert.ToString(row("vc_sector_negocio"))
            txttipo_doc.Text = Convert.ToString(row("vc_documento_tipo"))
            txtdoc.Text = Convert.ToString(row("vc_documento"))
            txtsub_negocio.Text = Convert.ToString(row("vc_subsector_negocio"))
            txtrazon_social.Text = Convert.ToString(row("vc_razon_social"))
            txttipo_empresa.Text = Convert.ToString(row("vc_tipo_empresa"))
            txtabreviado.Text = Convert.ToString(row("vc_abreviado"))
            txtgrupo_economico.Text = Convert.ToString(row("vc_grupo_economico"))
            txtdireccion.Text = Convert.ToString(row("vc_direccion"))
            txtcategoria.Text = Convert.ToString(row("vc_categoria"))
            txtdistrito.Text = Convert.ToString(row("vc_distrito"))
            txtejectutivo_datos.Text = Convert.ToString(row("vc_ejecutivo_datos"))
            txtciudad.Text = Convert.ToString(row("vc_ciudad"))
            txtpais.Text = Convert.ToString(row("vc_pais"))
            txtintegrador.Text = Convert.ToString(row("vc_integrador"))
            txtemail.Text = Convert.ToString(row("vc_email"))
            txtadm_proyecto.Text = Convert.ToString(row("vc_adm_proyecto"))
            txtweb.Text = Convert.ToString(row("vc_web"))
            txtgestor_cobranza.Text = Convert.ToString(row("vc_gestor_cobranza"))
            txtIM.Text = Convert.ToString(row("vc_IM"))
            txtIE.Text = Convert.ToString(row("vc_IE"))
            txtactividad_economica.Text = Convert.ToString(row("vc_act_economica"))

            txtobservaciones.Text = Convert.ToString(row("vc_observaciones"))

            txttipo_act.Text = Convert.ToString(row("vc_tipo_act"))
            txt_fecha.Text = CStr(Convert.ToDateTime(row("dt_fecha")))

        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub

#End Region

#Region "MOSTRAR FACTURA EN TEXTBOX"
    Public Sub mostrar_factura_por_codigo()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_factura_clientes_por_codigo(txt_codigo_cliente.Text)

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            Me.txt_id_factura.Text = Convert.ToString(row("id_factura"))
            Me.txt_cliente.Text = Convert.ToString(row("vc_cliente"))
            Me.txt_direccion.Text = Convert.ToString(row("vc_direccion"))
            Me.txt_documento.Text = Convert.ToString(row("vc_documento"))
            Me.txt_impuesto.Text = Convert.ToString(row("vc_impuesto"))
            Me.txt_moneda.Text = Convert.ToString(row("vc_moneda"))
            Me.txt_f_emision.Text = Convert.ToString(row("vc_f_emision"))
            Me.txt_f_vencimiento.Text = Convert.ToString(row("vc_f_vencim"))
            Me.txt_f_canc.Text = Convert.ToString(row("vc_f_can"))

            Me.txt_periodo_1.Text = Convert.ToString(row("vc_periodo_1"))
            Me.txt_periodo_2.Text = Convert.ToString(row("vc_periodo_2"))
            Me.txt_f_generacion.Text = Convert.ToString(row("vc_f_generacion"))
            Me.txt_observacion.Text = Convert.ToString(row("vc_observacion"))
            Me.txt_distrito.Text = Convert.ToString(row("vc_distrito"))
            Me.txt_ciclo.Text = Convert.ToString(row("vc_ciclo"))
            txt_nfacturacion.Text = Convert.ToString(row("vc_nfacturacion"))
            txt_cuenta.Text = Convert.ToString(row("vc_cuenta"))
            txt_estado.Text = Convert.ToString(row("vc_estado"))
            txt_cid_telefono.Text = Convert.ToString(row("vc_cid_telefono"))
            txt_usuario_emision.Text = Convert.ToString(row("vc_u_emision"))
            txt_total.Text = Convert.ToString(row("vc_total_periodo"))
            txt_saldo_anterior.Text = Convert.ToString(row("vc_saldo_anterior"))

            txt_tipo_c.Text = Convert.ToString(row("vc_tipo"))
            txt_valor_venta.Text = Convert.ToString(row("vc_valor_venta"))
            txt_descuentos.Text = Convert.ToString(row("vc_descuentos"))
            txt_impuestos.Text = Convert.ToString(row("vc_impuestos"))
            txt_mora.Text = Convert.ToString(row("vc_mora"))
            txt_redondeo.Text = Convert.ToString(row("vc_redondeo"))
            txt_total_empresa.Text = Convert.ToString(row("vc_total_empresa"))

            txt_saldo_empresa.Text = Convert.ToString(row("vc_saldo_empresa"))

            txt_total_fco.Text = Convert.ToString(row("vc_total_fco"))
            txt_saldo_fco.Text = Convert.ToString(row("vc_saldo_fco"))

            txt_total_financiamiento.Text = Convert.ToString(row("vc_total_financiamiento"))
            txt_saldo_financiamiento.Text = Convert.ToString(row("vc_saldo_financiamiento"))

            txt_total_Factura.Text = Convert.ToString(row("vc_total"))
            txt_saldo_factura.Text = Convert.ToString(row("vc_saldo"))



        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub



    Public Sub mostrar_factura_por_doc()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_factura_clientes_por_doc(txt_doc_cliente.Text)

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            Me.txt_id_factura.Text = Convert.ToString(row("id_factura"))
            Me.txt_cliente.Text = Convert.ToString(row("vc_cliente"))
            Me.txt_direccion.Text = Convert.ToString(row("vc_direccion"))
            Me.txt_documento.Text = Convert.ToString(row("vc_documento"))
            Me.txt_impuesto.Text = Convert.ToString(row("vc_impuesto"))
            Me.txt_moneda.Text = Convert.ToString(row("vc_moneda"))
            Me.txt_f_emision.Text = Convert.ToString(row("vc_f_emision"))
            Me.txt_f_vencimiento.Text = Convert.ToString(row("vc_f_vencim"))
            Me.txt_f_canc.Text = Convert.ToString(row("vc_f_can"))

            Me.txt_periodo_1.Text = Convert.ToString(row("vc_periodo_1"))
            Me.txt_periodo_2.Text = Convert.ToString(row("vc_periodo_2"))
            Me.txt_f_generacion.Text = Convert.ToString(row("vc_f_generacion"))
            Me.txt_observacion.Text = Convert.ToString(row("vc_observacion"))
            Me.txt_distrito.Text = Convert.ToString(row("vc_distrito"))
            Me.txt_ciclo.Text = Convert.ToString(row("vc_ciclo"))
            txt_nfacturacion.Text = Convert.ToString(row("vc_nfacturacion"))
            txt_cuenta.Text = Convert.ToString(row("vc_cuenta"))
            txt_estado.Text = Convert.ToString(row("vc_estado"))
            txt_cid_telefono.Text = Convert.ToString(row("vc_cid_telefono"))
            txt_usuario_emision.Text = Convert.ToString(row("vc_u_emision"))
            txt_total.Text = Convert.ToString(row("vc_total_periodo"))
            txt_saldo_anterior.Text = Convert.ToString(row("vc_saldo_anterior"))

            txt_tipo_c.Text = Convert.ToString(row("vc_tipo"))
            txt_valor_venta.Text = Convert.ToString(row("vc_valor_venta"))
            txt_descuentos.Text = Convert.ToString(row("vc_descuentos"))
            txt_impuestos.Text = Convert.ToString(row("vc_impuestos"))
            txt_mora.Text = Convert.ToString(row("vc_mora"))
            txt_redondeo.Text = Convert.ToString(row("vc_redondeo"))
            txt_total_empresa.Text = Convert.ToString(row("vc_total_empresa"))

            txt_saldo_empresa.Text = Convert.ToString(row("vc_saldo_empresa"))

            txt_total_fco.Text = Convert.ToString(row("vc_total_fco"))
            txt_saldo_fco.Text = Convert.ToString(row("vc_saldo_fco"))

            txt_total_financiamiento.Text = Convert.ToString(row("vc_total_financiamiento"))
            txt_saldo_financiamiento.Text = Convert.ToString(row("vc_saldo_financiamiento"))

            txt_total_Factura.Text = Convert.ToString(row("vc_total"))
            txt_saldo_factura.Text = Convert.ToString(row("vc_saldo"))
        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub


    Public Sub mostrar_factura_por_nservicio()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_factura_clientes_por_nservicio(txt_nservicio_cliente.Text)

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            Me.txt_id_factura.Text = Convert.ToString(row("id_factura"))
            Me.txt_cliente.Text = Convert.ToString(row("vc_cliente"))
            Me.txt_direccion.Text = Convert.ToString(row("vc_direccion"))
            Me.txt_documento.Text = Convert.ToString(row("vc_documento"))
            Me.txt_impuesto.Text = Convert.ToString(row("vc_impuesto"))
            Me.txt_moneda.Text = Convert.ToString(row("vc_moneda"))
            Me.txt_f_emision.Text = Convert.ToString(row("vc_f_emision"))
            Me.txt_f_vencimiento.Text = Convert.ToString(row("vc_f_vencim"))
            Me.txt_f_canc.Text = Convert.ToString(row("vc_f_can"))

            Me.txt_periodo_1.Text = Convert.ToString(row("vc_periodo_1"))
            Me.txt_periodo_2.Text = Convert.ToString(row("vc_periodo_2"))
            Me.txt_f_generacion.Text = Convert.ToString(row("vc_f_generacion"))
            Me.txt_observacion.Text = Convert.ToString(row("vc_observacion"))
            Me.txt_distrito.Text = Convert.ToString(row("vc_distrito"))
            Me.txt_ciclo.Text = Convert.ToString(row("vc_ciclo"))
            txt_nfacturacion.Text = Convert.ToString(row("vc_nfacturacion"))
            txt_cuenta.Text = Convert.ToString(row("vc_cuenta"))
            txt_estado.Text = Convert.ToString(row("vc_estado"))
            txt_cid_telefono.Text = Convert.ToString(row("vc_cid_telefono"))
            txt_usuario_emision.Text = Convert.ToString(row("vc_u_emision"))
            txt_total.Text = Convert.ToString(row("vc_total_periodo"))
            txt_saldo_anterior.Text = Convert.ToString(row("vc_saldo_anterior"))

            txt_tipo_c.Text = Convert.ToString(row("vc_tipo"))
            txt_valor_venta.Text = Convert.ToString(row("vc_valor_venta"))
            txt_descuentos.Text = Convert.ToString(row("vc_descuentos"))
            txt_impuestos.Text = Convert.ToString(row("vc_impuestos"))
            txt_mora.Text = Convert.ToString(row("vc_mora"))
            txt_redondeo.Text = Convert.ToString(row("vc_redondeo"))
            txt_total_empresa.Text = Convert.ToString(row("vc_total_empresa"))

            txt_saldo_empresa.Text = Convert.ToString(row("vc_saldo_empresa"))

            txt_total_fco.Text = Convert.ToString(row("vc_total_fco"))
            txt_saldo_fco.Text = Convert.ToString(row("vc_saldo_fco"))

            txt_total_financiamiento.Text = Convert.ToString(row("vc_total_financiamiento"))
            txt_saldo_financiamiento.Text = Convert.ToString(row("vc_saldo_financiamiento"))

            txt_total_Factura.Text = Convert.ToString(row("vc_total"))
            txt_saldo_factura.Text = Convert.ToString(row("vc_saldo"))
        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub

#End Region

#Region "MOSTRAR DETALLE DE FACTURA EN TEXTBOX 1"
    Public Sub mostrar_detalle_factura_por_codigo1()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_detalle_factura_clientes_por_codigo1(txt_codigo_cliente.Text)

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.

            Me.txt_organizacion_1.Text = Convert.ToString(row("vc_organizacion"))
            Me.txt_desc_1.Text = Convert.ToString(row("vc_desc_item"))
            Me.txt_tipo_detalle_1.Text = Convert.ToString(row("vc_tipo_detalle"))
            Me.txt_puertos_1.Text = Convert.ToString(row("vc_puertos"))
            Me.txt_descuento_1.Text = Convert.ToString(row("vc_descuento"))
            Me.txt_tipo_servicio_1.Text = Convert.ToString(row("vc_tipo_servicio"))
            Me.txt_prec_unit_1.Text = Convert.ToString(row("vc_precio_unit"))
            Me.txt_desde_1.Text = Convert.ToString(row("vc_desde"))
            Me.txt_valor_venta.Text = Convert.ToString(row("vc_valor_venta"))
            txt_servicio_1.Text = Convert.ToString(row("vc_servicio"))
            txt_cantidad_1.Text = Convert.ToString(row("vc_cantidad"))
            txt_hasta_1.Text = Convert.ToString(row("vc_hasta"))
            txt_igv_1.Text = Convert.ToString(row("vc_igv"))
            txt_equipo_1.Text = Convert.ToString(row("vc_equipo"))
            txt_pago_1.Text = Convert.ToString(row("vc_pago"))
            txt_dias_1.Text = Convert.ToString(row("vc_dias"))
            txt_total_1.Text = Convert.ToString(row("vc_total_item"))










        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub



    Public Sub mostrar_detalle_factura_por_doc1()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_detalle_factura_clientes_por_doc1(txt_doc_cliente.Text)

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            Me.txt_organizacion_1.Text = Convert.ToString(row("vc_organizacion"))
            Me.txt_desc_1.Text = Convert.ToString(row("vc_desc_item"))
            Me.txt_tipo_detalle_1.Text = Convert.ToString(row("vc_tipo_detalle"))
            Me.txt_puertos_1.Text = Convert.ToString(row("vc_puertos"))
            Me.txt_descuento_1.Text = Convert.ToString(row("vc_descuento"))
            Me.txt_tipo_servicio_1.Text = Convert.ToString(row("vc_tipo_servicio"))
            Me.txt_prec_unit_1.Text = Convert.ToString(row("vc_precio_unit"))
            Me.txt_desde_1.Text = Convert.ToString(row("vc_desde"))
            Me.txt_valor_venta.Text = Convert.ToString(row("vc_valor_venta"))
            txt_servicio_1.Text = Convert.ToString(row("vc_servicio"))
            txt_cantidad_1.Text = Convert.ToString(row("vc_cantidad"))
            txt_hasta_1.Text = Convert.ToString(row("vc_hasta"))
            txt_igv_1.Text = Convert.ToString(row("vc_igv"))
            txt_equipo_1.Text = Convert.ToString(row("vc_equipo"))
            txt_pago_1.Text = Convert.ToString(row("vc_pago"))
            txt_dias_1.Text = Convert.ToString(row("vc_dias"))
            txt_total_1.Text = Convert.ToString(row("vc_total_item"))

        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub


    Public Sub mostrar_detalle_factura_por_nservicio1()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_detalle_factura_clientes_por_nservicio1(txt_nservicio_cliente.Text)

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            Me.txt_organizacion_1.Text = Convert.ToString(row("vc_organizacion"))
            Me.txt_desc_1.Text = Convert.ToString(row("vc_desc_item"))
            Me.txt_tipo_detalle_1.Text = Convert.ToString(row("vc_tipo_detalle"))
            Me.txt_puertos_1.Text = Convert.ToString(row("vc_puertos"))
            Me.txt_descuento_1.Text = Convert.ToString(row("vc_descuento"))
            Me.txt_tipo_servicio_1.Text = Convert.ToString(row("vc_tipo_servicio"))
            Me.txt_prec_unit_1.Text = Convert.ToString(row("vc_precio_unit"))
            Me.txt_desde_1.Text = Convert.ToString(row("vc_desde"))
            Me.txt_valor_venta.Text = Convert.ToString(row("vc_valor_venta"))
            txt_servicio_1.Text = Convert.ToString(row("vc_servicio"))
            txt_cantidad_1.Text = Convert.ToString(row("vc_cantidad"))
            txt_hasta_1.Text = Convert.ToString(row("vc_hasta"))
            txt_igv_1.Text = Convert.ToString(row("vc_igv"))
            txt_equipo_1.Text = Convert.ToString(row("vc_equipo"))
            txt_pago_1.Text = Convert.ToString(row("vc_pago"))
            txt_dias_1.Text = Convert.ToString(row("vc_dias"))
            txt_total_1.Text = Convert.ToString(row("vc_total_item"))

        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub

#End Region


#Region "MOSTRAR DETALLE DE FACTURA EN TEXTBOX 2"
    Public Sub mostrar_detalle_factura_por_codigo2()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_detalle_factura_clientes_por_codigo2(txt_codigo_cliente.Text)

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            Me.txt_organizacion_2.Text = Convert.ToString(row("vc_organizacion"))
            Me.txt_desc_2.Text = Convert.ToString(row("vc_desc_item"))
            Me.txt_tipo_detalle_2.Text = Convert.ToString(row("vc_tipo_detalle"))
            Me.txt_puertos_2.Text = Convert.ToString(row("vc_puertos"))
            Me.txt_descuento_2.Text = Convert.ToString(row("vc_descuento"))
            Me.txt_tipo_servicio_2.Text = Convert.ToString(row("vc_tipo_servicio"))
            Me.txt_precio_unit_2.Text = Convert.ToString(row("vc_precio_unit"))
            Me.txt_desde_2.Text = Convert.ToString(row("vc_desde"))
            Me.txt_valor_venta_2.Text = Convert.ToString(row("vc_valor_venta"))
            txt_servicio_2.Text = Convert.ToString(row("vc_servicio"))
            txt_cantidad_2.Text = Convert.ToString(row("vc_cantidad"))
            txt_hasta_2.Text = Convert.ToString(row("vc_hasta"))
            txt_igv_2.Text = Convert.ToString(row("vc_igv"))
            txt_equipo_2.Text = Convert.ToString(row("vc_equipo"))
            txt_pago_2.Text = Convert.ToString(row("vc_pago"))
            txt_dias_2.Text = Convert.ToString(row("vc_dias"))
            txt_total_2.Text = Convert.ToString(row("vc_total_item"))



        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub



    Public Sub mostrar_detalle_factura_por_doc2()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_detalle_factura_clientes_por_doc2(txt_doc_cliente.Text)

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            Me.txt_organizacion_2.Text = Convert.ToString(row("vc_organizacion"))
            Me.txt_desc_2.Text = Convert.ToString(row("vc_desc_item"))
            Me.txt_tipo_detalle_2.Text = Convert.ToString(row("vc_tipo_detalle"))
            Me.txt_puertos_2.Text = Convert.ToString(row("vc_puertos"))
            Me.txt_descuento_2.Text = Convert.ToString(row("vc_descuento"))
            Me.txt_tipo_servicio_2.Text = Convert.ToString(row("vc_tipo_servicio"))
            Me.txt_precio_unit_2.Text = Convert.ToString(row("vc_precio_unit"))
            Me.txt_desde_2.Text = Convert.ToString(row("vc_desde"))
            Me.txt_valor_venta_2.Text = Convert.ToString(row("vc_valor_venta"))
            txt_servicio_2.Text = Convert.ToString(row("vc_servicio"))
            txt_cantidad_2.Text = Convert.ToString(row("vc_cantidad"))
            txt_hasta_2.Text = Convert.ToString(row("vc_hasta"))
            txt_igv_2.Text = Convert.ToString(row("vc_igv"))
            txt_equipo_2.Text = Convert.ToString(row("vc_equipo"))
            txt_pago_2.Text = Convert.ToString(row("vc_pago"))
            txt_dias_2.Text = Convert.ToString(row("vc_dias"))
            txt_total_2.Text = Convert.ToString(row("vc_total_item"))
        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub


    Public Sub mostrar_detalle_factura_por_nservicio2()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_detalle_factura_clientes_por_nservicio2(txt_nservicio_cliente.Text)

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            Me.txt_organizacion_2.Text = Convert.ToString(row("vc_organizacion"))
            Me.txt_desc_2.Text = Convert.ToString(row("vc_desc_item"))
            Me.txt_tipo_detalle_2.Text = Convert.ToString(row("vc_tipo_detalle"))
            Me.txt_puertos_2.Text = Convert.ToString(row("vc_puertos"))
            Me.txt_descuento_2.Text = Convert.ToString(row("vc_descuento"))
            Me.txt_tipo_servicio_2.Text = Convert.ToString(row("vc_tipo_servicio"))
            Me.txt_precio_unit_2.Text = Convert.ToString(row("vc_precio_unit"))
            Me.txt_desde_2.Text = Convert.ToString(row("vc_desde"))
            Me.txt_valor_venta_2.Text = Convert.ToString(row("vc_valor_venta"))
            txt_servicio_2.Text = Convert.ToString(row("vc_servicio"))
            txt_cantidad_2.Text = Convert.ToString(row("vc_cantidad"))
            txt_hasta_2.Text = Convert.ToString(row("vc_hasta"))
            txt_igv_2.Text = Convert.ToString(row("vc_igv"))
            txt_equipo_2.Text = Convert.ToString(row("vc_equipo"))
            txt_pago_2.Text = Convert.ToString(row("vc_pago"))
            txt_dias_2.Text = Convert.ToString(row("vc_dias"))
            txt_total_2.Text = Convert.ToString(row("vc_total_item"))
        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub

#End Region


#Region "MOSTRAR SERVICIOS CONTRATADOS TRANSACCIONES"


    Public Sub mostrar_servicios_contratados_transacciones_por_codigo()
        Try
            Dim dts As New SOT.TB_servicios_contratados  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts

                .vc_codigo = Me.txt_codigo_cliente.Text
                .vc_cid = Me.txt_1.Text
            End With
            'enviamos los datos
            dt = func._mostrar_servicios_contratados_transacciones_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dgvSCTransacciones.DataSource = dt
            Else
                Me.dgvSCTransacciones.DataSource = dt
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_servicios_contratados_transacciones_por_codigo1()
        Try
            Dim dts As New SOT.TB_servicios_contratados  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts

                .vc_codigo = frm9.txt_5.Text
                .vc_cid = Me.txt_1.Text
            End With
            'enviamos los datos
            dt = func._mostrar_servicios_contratados_transacciones_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dgvSCTransacciones.DataSource = dt
            Else
                Me.dgvSCTransacciones.DataSource = dt
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    'Public Sub mostrar_servicios_contratados_transacciones_por_n_doc(ByVal search As String)
    Public Sub mostrar_servicios_contratados_transacciones_por_n_doc()
        Try
            Dim dts As New SOT.TB_servicios_contratados
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .n_doc = txt_doc_cliente.Text
                .vc_cid = Me.txt_1.Text
            End With
            'enviamos los datos


            'txt_doc_cliente.Text

            If Not Util.sot.Equals(0) Then
                'Try
                '    dt = Manager.getTransactionSOT(txt_doc_cliente.Text, cboSCestado_servicio.Text)
                'Catch ex As Exception
                '    dt = Nothing
                'End Try
                dt = Nothing
            Else
                'dt = func._mostrar_servicios_contratados_transacciones_por_n_doc(dts)
                dt = Manager.getTransactionSOT(txt_doc_cliente.Text, cboSCestado_servicio.Text)

            End If



            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dgvSCTransacciones.DataSource = dt
            Else
                Me.dgvSCTransacciones.DataSource = dt
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_servicios_contratados_transacciones_por_n_servicio()
        Try
            Dim dts As New SOT.TB_servicios_contratados
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .n_servicio = Me.txt_nservicio_cliente.Text
                .vc_cid = Me.txt_1.Text
            End With
            'enviamos los datos
            dt = func._mostrar_servicios_contratados_transacciones_por_n_servicio(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dgvSCTransacciones.DataSource = dt
            Else
                Me.dgvSCTransacciones.DataSource = dt
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub


#End Region

    Private Sub CheckBox1_CheckedChanged(sender As Object, e As EventArgs) Handles CheckBox1.CheckedChanged
        'CHECK BUSQUEDA POR CODIGO DE CLIENTE
        If CheckBox1.Checked = True And txt_codigo_cliente.Text <> "" Then
            mostrar_por_codigo_cliente()
        End If
    End Sub
    Private Sub CheckBox9_CheckedChanged(sender As Object, e As EventArgs) Handles CheckBox9.CheckedChanged
        If CheckBox9.Checked = True And txt_nservicio_cliente.Text <> "" Then
            mostrar_por_n_servicio()
        End If
    End Sub
    Public Sub mostrar_por_codigo_cliente()
        Try
            Dim dts As New SOT.TB_datos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .codigo = Me.txt_codigo_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_por_codigo_cliente(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dg_datos.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_por_n_doc()
        Try
            Dim dts As New SOT.TB_datos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .n_doc = Me.txt_doc_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_por_n_doc(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dg_datos.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_por_n_servicio()
        Try
            Dim dts As New SOT.TB_datos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .n_servicio = Me.txt_nservicio_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_por_n_servicio(dts)
            If dt.Rows.Count <> 0 Then
                'MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dg_datos.DataSource = dt
            Else
                'MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Private Sub CheckBox3_CheckedChanged_1(sender As Object, e As EventArgs) Handles chkBNroDocIdentidad.CheckedChanged
        If chkBNroDocIdentidad.Checked = True And txt_doc_cliente.Text <> "" Then
            mostrar_por_n_doc()
        End If
    End Sub


    Public Sub mostrar_contactos_clientes_por_codigo()
        Try
            Dim dts As New SOT.TB_contactos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .codigo = Me.txt_codigo_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_contactos_clientes_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dgvDCcontactos.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_contactos_clientes_por_doc()
        Try
            Dim dts As New SOT.TB_contactos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .n_doc = txt_doc_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_contactos_clientes_por_doc(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dgvDCcontactos.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_contactos_clientes_por_nservicio()
        Try
            Dim dts As New SOT.TB_contactos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .n_servicio = Me.txt_nservicio_cliente.Text
            End With
            'enviamos los datos
            dt = func._mostrar_contactos_clientes_por_n_servicio(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dgvDCcontactos.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Private Sub ddlestado_servicio_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cboSCestado_servicio.SelectedIndexChanged
        If cboSCestado_servicio.SelectedItem.ToString = "Activo" And CheckBox1.Checked = True Then
            mostrar_servicios_contratados_por_codigo()
        ElseIf frm9.txt_5.Text <> "" And cboSCestado_servicio.SelectedItem.ToString = "Activo" Then
            mostrar_servicios_contratados_por_codigo1()
            'ElseIf cboSCestado_servicio.SelectedItem.ToString = "Activo" And chkBNroDocIdentidad.Checked = True Then
        ElseIf chkBNroDocIdentidad.Checked = True Then
            mostrar_servicios_contratados_por_n_doc()
        ElseIf cboSCestado_servicio.SelectedItem.ToString = "Activo" And CheckBox9.Checked = True Then
            mostrar_servicios_contratados_por_nservicio()
        Else
            dgvSCservicios.DataSource = Nothing
            dgvSCTransacciones.DataSource = Nothing

        End If
    End Sub
    Private Sub btn_generar_incidencia_Click(sender As Object, e As EventArgs) Handles btn_generar_incidencia.Click
        Dim nombre As String
        nombre = txtrazon_social.Text
        Modulo1.servicio = txt_1.Text
        Modulo1.codigo = txtcodigo1.Text
        'Dim result As Integer = MessageBox.Show("Cliente:" + nombre + " Servicio: " + Modulo1.servicio + " ¿Desea Continuar?", "Generación de Incidencias desde Consulta Histórica", MessageBoxButtons.YesNoCancel, MessageBoxIcon.Question)

        If DialogResult.Yes = DialogResult.Yes Then
            'Frm_Generar_incidencia.Show()
            frmGenerarIncidencia.MdiParent = Frm_Menu
            frmGenerarIncidencia.WindowState = FormWindowState.Normal
            Me.WindowState = FormWindowState.Minimized
            frmGenerarIncidencia.Limpiar_incidencias()
            frmGenerarIncidencia.Show()
            frmGenerarIncidencia.txt_estado.Text = "0 - Sin Valor"
            frmGenerarIncidencia.pnlHideDocRel.Visible = True
            frmGenerarIncidencia.ddl_tipo_servicio.Text = ""
            frmGenerarIncidencia.txt_tipo_atencion.Text = ""
            frmGenerarIncidencia.dgvGIIncidencias.DataSource = Nothing

            Util.tipo_servicio = ""

            frmGenerarIncidencia.txt_incidencia.Text = ""

            Util.idincidencia = 0
            Util.idTicket = 0


            frmGenerarIncidencia.txt_usuario.Text = ""
            frmGenerarIncidencia.txt_ticket.Text = ""
            frmGenerarIncidencia.txt_f_registro.Text = "00/00/0000 00:00"


            frmGenerarIncidencia.generar()
            Frm_Menu.ToolStrip2.Visible = True
        End If
    End Sub
    Private Sub dg_servicios_SelectionChanged(sender As Object, e As EventArgs) Handles dgvSCservicios.SelectionChanged
        If Me.dgvSCservicios.SelectedRows.Count > 0 Then
            Me.txt_1.Text = CStr(dgvSCservicios.Item("Numero servicio", dgvSCservicios.SelectedRows(0).Index).Value)
            Me.txt_2_2.Text = CStr(dgvSCservicios.Item("Producto", dgvSCservicios.SelectedRows(0).Index).Value)

            Modulo1.producto_contratado = txt_2_2.Text
            If CheckBox1.Checked = True Then
                mostrar_servicios_contratados_transacciones_por_codigo()
            ElseIf frm9.txt_5.Text <> "" Then
                mostrar_servicios_contratados_transacciones_por_codigo1()
            End If

            If chkBNroDocIdentidad.Checked = True Then
                mostrar_servicios_contratados_transacciones_por_n_doc()
            End If

            If CheckBox9.Checked = True Then
                mostrar_servicios_contratados_transacciones_por_n_servicio()
            End If
        End If
    End Sub
    Private Sub dg_incidencias_lista_general_SelectionChanged(sender As Object, e As EventArgs) Handles dg_incidencias_lista_general.SelectionChanged
        If Me.dg_incidencias_lista_general.SelectedRows.Count > 0 Then
            Me.txt_2.Text = CStr(dg_incidencias_lista_general.Item("Incidencia", dg_incidencias_lista_general.SelectedRows(0).Index).Value)
            mostrar_incidencias_lista_general_seguimiento()
            mostrar_incidencias_lista_general_clientes_servicios()
            If frm9.txt_5.Text <> "" Then
                mostrar_incidencias_lista_general_seguimiento_por_codigo1()
                mostrar_incidencias_lista_general_clientes_servicios_por_codigo1()
            End If
        End If
    End Sub
    Private Sub txt_codigo_cliente_KeyUp(sender As Object, e As KeyEventArgs) Handles txt_codigo_cliente.KeyUp
        Select Case (e.KeyCode)
            Case Keys.F9
                frm9.ShowDialog()
        End Select
    End Sub
    Private Sub VScrollBar3_Scroll(sender As Object, e As ScrollEventArgs) Handles VScrollBar3.Scroll
        txt_count.Text = CStr(VScrollBar3.Value)
        If CheckBox1.Checked = True Then
            mostrar_solicitudes_ot_por_codigo_mouse()
        ElseIf chkBNroDocIdentidad.Checked = True Then
            mostrar_solicitudes_ot_por_doc_mouse()
        ElseIf CheckBox9.Checked = True Then
            mostrar_solicitudes_ot_por_nservicio_por_mouse()
        End If
    End Sub
    Private Sub Frm_Consulta_Histórica_MouseWheel(sender As Object, e As MouseEventArgs) Handles Me.MouseWheel

        'FACTURAS
        If tabMain.SelectedIndex = 4 Then

            If (e.Delta > 0) Then
                'el mouse sube facturas
                If Modulo1.contador_facturas = 1 Then
                    btn_contador_facturas.Text = CStr(Modulo1.contador_facturas)
                    txt_count_facturas.Text = CStr(Modulo1.contador_facturas)
                    VScrollBar4.Visible = False
                ElseIf CDbl(txt_count_facturas.Text) = 1 Then
                    btn_contador_facturas.Text = CStr(CDbl(txt_count_facturas.Text))
                    txt_count_facturas.Text = CStr(CDbl(txt_count_facturas.Text))
                ElseIf CDbl(txt_count_facturas.Text) > 1 Then
                    VScrollBar4.Value = CInt(CStr(CDbl(txt_count_facturas.Text) - 1))
                    btn_contador_facturas.Text = CStr(CDbl(txt_count_facturas.Text) - 1)
                    Me.txt_count_facturas.Text = CStr(CDbl(txt_count_facturas.Text) - 1)
                End If

                If CheckBox1.Checked = True Then
                    mostrar_facturas_por_codigo_mouse()
                    mostrar_detalle_factura_por_cod1_mouse()
                    mostrar_detalle_factura_por_codigo2_mouse()
                    mostrar_pagos_aplicaciones_factura_por_codigo_mouse()
                ElseIf chkBNroDocIdentidad.Checked = True Then
                    mostrar_facturas_por_doc_mouse()
                    mostrar_detalle_factura_por_doc1_mouse()
                    mostrar_detalle_factura_por_doc2_mouse()
                    mostrar_pagos_aplicaciones_factura_por_doc_mouse()
                ElseIf CheckBox9.Checked = True Then
                    mostrar_facturas_por_nservicio_mouse()
                    mostrar_detalle_factura_por_nservicio1_mouse()
                    mostrar_detalle_factura_por_nservicio2_mouse()
                    mostrar_pagos_aplicaciones_factura_por_nservicio_mouse()
                End If

            Else
                'el mouse baja facturas

                If Modulo1.contador_facturas = 1 Then
                    VScrollBar4.Visible = False
                    btn_contador_facturas.Text = CStr(Modulo1.contador_facturas)
                    txt_count_facturas.Text = CStr(Modulo1.contador_facturas)
                ElseIf CDbl(btn_contador_facturas.Text) = Modulo1.contador_facturas Then
                    VScrollBar4.Value = CInt(CStr(CDbl(CDbl(btn_contador_facturas.Text))))
                    btn_contador_facturas.Text = CStr(CDbl(CDbl(btn_contador_facturas.Text)))
                    Me.txt_count_facturas.Text = CStr(CDbl(CDbl(btn_contador_facturas.Text)))
                ElseIf CDbl(btn_contador_facturas.Text) = 1 Then

                    btn_contador_facturas.Text = CStr(CDbl(CDbl(btn_contador_facturas.Text) + 1))
                    VScrollBar4.Value = CInt(CStr(CDbl(CDbl(btn_contador_facturas.Text))))
                    txt_count_facturas.Text = CStr(CDbl(CDbl(btn_contador_facturas.Text)))

                ElseIf CDbl(btn_contador_facturas.Text) > 1 Then
                    btn_contador_facturas.Text = CStr(CDbl(CDbl(btn_contador_facturas.Text) + 1))
                    VScrollBar4.Value = CInt(CStr(CDbl(CDbl(btn_contador_facturas.Text))))
                    Me.txt_count_facturas.Text = CStr(CDbl(CDbl(btn_contador_facturas.Text)))
                End If


                If CheckBox1.Checked = True Then
                    mostrar_facturas_por_codigo_mouse()
                    mostrar_detalle_factura_por_cod1_mouse()
                    mostrar_detalle_factura_por_codigo2_mouse()
                    mostrar_pagos_aplicaciones_factura_por_codigo_mouse()
                ElseIf chkBNroDocIdentidad.Checked = True Then
                    mostrar_facturas_por_doc_mouse()
                    mostrar_detalle_factura_por_doc1_mouse()
                    mostrar_detalle_factura_por_doc2_mouse()
                    mostrar_pagos_aplicaciones_factura_por_doc_mouse()
                ElseIf CheckBox9.Checked = True Then
                    mostrar_facturas_por_nservicio_mouse()
                    mostrar_detalle_factura_por_nservicio1_mouse()
                    mostrar_detalle_factura_por_nservicio2_mouse()
                    mostrar_pagos_aplicaciones_factura_por_nservicio_mouse()
                End If




            End If
            'SOLICITUDES DE OT
        ElseIf tabMain.SelectedIndex = 16 Then
            If e.Delta > 0 Then
                'el mouse sube solicitudes de ot
                If Modulo1.contador_solicitudes_ot = 1 Then
                    btn_contar_solicitudes.Text = CStr(Modulo1.contador_solicitudes_ot)
                    txt_count.Text = CStr(Modulo1.contador_solicitudes_ot)
                    VScrollBar3.Visible = False
                ElseIf CDbl(txt_count.Text) = 1 Then
                    btn_contar_solicitudes.Text = CStr(CDbl(txt_count.Text))
                    txt_count.Text = CStr(CDbl(txt_count.Text))
                ElseIf CDbl(txt_count.Text) > 1 Then
                    VScrollBar3.Value = CInt(CStr(CDbl(txt_count.Text) - 1))
                    btn_contar_solicitudes.Text = CStr(CDbl(txt_count.Text) - 1)
                    Me.txt_count.Text = CStr(CDbl(txt_count.Text) - 1)
                End If

                'Enviando datos necesarios
                If CheckBox1.Checked = True Then
                    mostrar_solicitudes_ot_por_codigo_mouse()
                    mostrar_detalle_ot_por_codigo_mouse()
                    mostrar_anotaciones_ot_por_codigo_mouse()
                    mostrar_cambios_estado_solicitudes_ot_por_codigo_mouse()
                    mostrar_tarea_solicitudes_ot_por_codigo_mouse()

                ElseIf chkBNroDocIdentidad.Checked = True Then
                    mostrar_solicitudes_ot_por_doc_mouse()
                    mostrar_detalle_ot_por_doc_mouse(txt_doc_cliente.Text)
                    mostrar_anotaciones_ot_por_doc_mouse()
                    mostrar_cambios_estado_solicitudes_ot_por_doc_mouse()
                    mostrar_tarea_solicitudes_ot_por_doc_mouse()

                ElseIf CheckBox9.Checked = True Then
                    mostrar_solicitudes_ot_por_nservicio_por_mouse()
                    mostrar_detalle_ot_por_nservicio_mouse()
                    mostrar_anotaciones_ot_por_nservicio_mouse()
                    mostrar_cambios_estado_solicitudes_ot_por_nservicio_mouse()
                    mostrar_tarea_solicitudes_ot_por_nservicio_mouse()
                End If
            Else
                'el mouse baja solicitudes de ot
                'Recalculando
                If Modulo1.contador_solicitudes_ot = 1 Then
                    VScrollBar3.Visible = False
                    btn_contar_solicitudes.Text = CStr(Modulo1.contador_solicitudes_ot)
                    txt_count.Text = CStr(Modulo1.contador_solicitudes_ot)
                ElseIf CDbl(btn_contar_solicitudes.Text) = Modulo1.contador_solicitudes_ot Then
                    VScrollBar3.Value = CInt(CStr(CDbl(CDbl(btn_contar_solicitudes.Text))))
                    btn_contar_solicitudes.Text = CStr(CDbl(CDbl(btn_contar_solicitudes.Text)))
                    Me.txt_count.Text = CStr(CDbl(CDbl(btn_contar_solicitudes.Text)))
                ElseIf CDbl(btn_contar_solicitudes.Text) = 1 Then

                    btn_contar_solicitudes.Text = CStr(CDbl(CDbl(btn_contar_solicitudes.Text) + 1))
                    VScrollBar3.Value = CInt(CStr(CDbl(CDbl(btn_contar_solicitudes.Text))))
                    txt_count.Text = CStr(CDbl(CDbl(btn_contar_solicitudes.Text)))

                ElseIf CDbl(btn_contar_solicitudes.Text) > 1 Then
                    btn_contar_solicitudes.Text = CStr(CDbl(CDbl(btn_contar_solicitudes.Text) + 1))
                    VScrollBar3.Value = CInt(CStr(CDbl(CDbl(btn_contar_solicitudes.Text))))
                    Me.txt_count.Text = CStr(CDbl(CDbl(btn_contar_solicitudes.Text)))
                End If


                'Enviando datos necesarios
                If CheckBox1.Checked = True Then
                    mostrar_solicitudes_ot_por_codigo_mouse()
                    mostrar_detalle_ot_por_codigo_mouse()
                    mostrar_anotaciones_ot_por_codigo_mouse()
                    mostrar_cambios_estado_solicitudes_ot_por_codigo_mouse()
                    mostrar_tarea_solicitudes_ot_por_codigo_mouse()

                ElseIf chkBNroDocIdentidad.Checked = True Then
                    mostrar_solicitudes_ot_por_doc_mouse()
                    mostrar_detalle_ot_por_doc_mouse(txt_doc_cliente.Text)
                    mostrar_anotaciones_ot_por_doc_mouse()
                    mostrar_cambios_estado_solicitudes_ot_por_doc_mouse()
                    mostrar_tarea_solicitudes_ot_por_doc_mouse()

                ElseIf CheckBox9.Checked = True Then
                    mostrar_solicitudes_ot_por_nservicio_por_mouse()
                    mostrar_detalle_ot_por_nservicio_mouse()
                    mostrar_anotaciones_ot_por_nservicio_mouse()
                    mostrar_cambios_estado_solicitudes_ot_por_nservicio_mouse()
                    mostrar_tarea_solicitudes_ot_por_nservicio_mouse()
                End If

            End If
        End If
    End Sub
    Private Sub VScrollBar4_Scroll(sender As Object, e As ScrollEventArgs) Handles VScrollBar4.Scroll
        txt_count_facturas.Text = CStr(VScrollBar4.Value)
    End Sub

#Region "MOSTRAR  SOLICITUDES OT CLIENTE EN TEXTBOX CON MOUSE"
    Public Sub mostrar_solicitudes_ot_por_codigo_mouse()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.Buscar_solicitudes_ot_por_codigo_por_mouse(txt_codigo_cliente.Text, CInt(txt_count.Text))

            If (row Is Nothing) Then
                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            txt_solicitud_ot.Text = Convert.ToString(row("vc_solicitud"))
            txt_estado_ot.Text = Convert.ToString(row("vc_estado"))
            txt_doc_cliente_ot.Text = Convert.ToString(row("vc_codigo"))
            txt_nom_cliente_ot.Text = Convert.ToString(row("vc_cliente"))
            txt_direccion_ot.Text = Convert.ToString(row("vc_direccion"))
            txt_distrito_ot.Text = Convert.ToString(row("vc_distrito"))
            txt_proyecto_ot.Text = Convert.ToString(row("vc_proyecto"))
            txt_incidencia_ot.Text = Convert.ToString(row("vc_incidencia"))
            txt_tipo_ot.Text = Convert.ToString(row("vc_tipo"))
            txt_motivo_ot.Text = Convert.ToString(row("vc_motivo"))
            txt_area_ot.Text = Convert.ToString(row("vc_area"))
            txt_tipo_servicio_ot.Text = Convert.ToString(row("vc_tipo_servicio"))
            txt_fcomp_ot.Text = Convert.ToString(row("vc_f_comp"))
            txt_pcontable_ot.Text = Convert.ToString(row("vc_p_contable"))
            txt_fgen_ot.Text = Convert.ToString(row("vc_f_gen"))
            txt_solicitante_ot.Text = Convert.ToString(row("vc_solicitante"))
            txt_finicio_ot.Text = Convert.ToString(row("vc_f_inicio"))
            txt_ffin_ot.Text = Convert.ToString(row("vc_f_fin"))
            txt_fapr_ot.Text = Convert.ToString(row("vc_f_apr"))
            txt_act_instalacion_ot.Text = Convert.ToString(row("vc_acta_instalacion"))
            txt_observaciones_ot.Text = Convert.ToString(row("vc_observacion"))






        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_solicitudes_ot_por_doc_mouse()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.Buscar_solicitudes_ot_por_doc_por_mouse(txt_doc_cliente.Text, CInt(txt_count.Text))

            If (row Is Nothing) Then
                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            txt_solicitud_ot.Text = Convert.ToString(row("vc_solicitud"))
            txt_estado_ot.Text = Convert.ToString(row("vc_estado"))
            txt_doc_cliente_ot.Text = Convert.ToString(row("vc_codigo"))
            txt_nom_cliente_ot.Text = Convert.ToString(row("vc_cliente"))
            txt_direccion_ot.Text = Convert.ToString(row("vc_direccion"))
            txt_distrito_ot.Text = Convert.ToString(row("vc_distrito"))
            txt_proyecto_ot.Text = Convert.ToString(row("vc_proyecto"))
            txt_incidencia_ot.Text = Convert.ToString(row("vc_incidencia"))
            txt_tipo_ot.Text = Convert.ToString(row("vc_tipo"))
            txt_motivo_ot.Text = Convert.ToString(row("vc_motivo"))
            txt_area_ot.Text = Convert.ToString(row("vc_area"))
            txt_tipo_servicio_ot.Text = Convert.ToString(row("vc_tipo_servicio"))
            txt_fcomp_ot.Text = Convert.ToString(row("vc_f_comp"))
            txt_pcontable_ot.Text = Convert.ToString(row("vc_p_contable"))
            txt_fgen_ot.Text = Convert.ToString(row("vc_f_gen"))
            txt_solicitante_ot.Text = Convert.ToString(row("vc_solicitante"))
            txt_finicio_ot.Text = Convert.ToString(row("vc_f_inicio"))
            txt_ffin_ot.Text = Convert.ToString(row("vc_f_fin"))
            txt_fapr_ot.Text = Convert.ToString(row("vc_f_apr"))
            txt_act_instalacion_ot.Text = Convert.ToString(row("vc_acta_instalacion"))
            txt_observaciones_ot.Text = Convert.ToString(row("vc_observacion"))






        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_solicitudes_ot_por_nservicio_por_mouse()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.Buscar_solicitudes_ot_por_nservicio_por_mouse(txt_nservicio_cliente.Text, CInt(txt_count.Text))

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If
            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            txt_solicitud_ot.Text = Convert.ToString(row("vc_solicitud"))
            txt_estado_ot.Text = Convert.ToString(row("vc_estado"))
            txt_doc_cliente_ot.Text = Convert.ToString(row("vc_codigo"))
            txt_nom_cliente_ot.Text = Convert.ToString(row("vc_cliente"))
            txt_direccion_ot.Text = Convert.ToString(row("vc_direccion"))
            txt_distrito_ot.Text = Convert.ToString(row("vc_distrito"))
            txt_proyecto_ot.Text = Convert.ToString(row("vc_proyecto"))
            txt_incidencia_ot.Text = Convert.ToString(row("vc_incidencia"))
            txt_tipo_ot.Text = Convert.ToString(row("vc_tipo"))
            txt_motivo_ot.Text = Convert.ToString(row("vc_motivo"))
            txt_area_ot.Text = Convert.ToString(row("vc_area"))
            txt_tipo_servicio_ot.Text = Convert.ToString(row("vc_tipo_servicio"))
            txt_fcomp_ot.Text = Convert.ToString(row("vc_f_comp"))
            txt_pcontable_ot.Text = Convert.ToString(row("vc_p_contable"))
            txt_fgen_ot.Text = Convert.ToString(row("vc_f_gen"))
            txt_solicitante_ot.Text = Convert.ToString(row("vc_solicitante"))
            txt_finicio_ot.Text = Convert.ToString(row("vc_f_inicio"))
            txt_ffin_ot.Text = Convert.ToString(row("vc_f_fin"))
            txt_fapr_ot.Text = Convert.ToString(row("vc_f_apr"))
            txt_act_instalacion_ot.Text = Convert.ToString(row("vc_acta_instalacion"))
            txt_observaciones_ot.Text = Convert.ToString(row("vc_observacion"))
        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub



#End Region


#Region "MOSTRAR SOLICITUES OT CLIENTE CON MOUSE"

    Public Sub mostrar_detalle_ot_por_codigo_mouse()
        Try
            Dim dts As New SOT.TB_solicitudes_ot  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_codigo_cliente.Text
                .vc_solicitud = Me.txt_solicitud_ot.Text
            End With
            'enviamos los datos
            dt = func._mostrar_detalle_ot_por_codigo_mouse(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_detalle_ot.DataSource = dt
            Else
                dg_detalle_ot.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_detalle_ot_por_doc_mouse(ByVal search As String)
        Try
            Dim dts As New SOT.TB_solicitudes_ot
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_doc = search
                '.vc_n_doc = txt_doc_cliente.Text
                .vc_solicitud = Me.txt_solicitud_ot.Text
            End With
            'enviamos los datos

            If Not Util.sot.Equals(0) Then
                dt = R.get("getDetSOT", search)
            Else
                dt = func._mostrar_detalle_ot_por_n_doc_mouse(dts)
            End If







            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_detalle_ot.DataSource = dt
            Else
                dg_detalle_ot.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_detalle_ot_por_nservicio_mouse()
        Try
            Dim dts As New SOT.TB_solicitudes_ot
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_servicio = Me.txt_nservicio_cliente.Text
                .vc_solicitud = Me.txt_solicitud_ot.Text
            End With
            'enviamos los datos
            dt = func._mostrar_detalle_ot_por_n_servicio_mouse(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_detalle_ot.DataSource = dt
            Else
                dg_detalle_ot.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
#End Region

#Region "MOSTRAR SOLICITUES OT CLIENTE- ANOTACIONES mouse"

    Public Sub mostrar_anotaciones_ot_por_codigo_mouse()
        Try
            Dim dts As New SOT.TB_solicitudes_ot  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_codigo_cliente.Text
                .vc_solicitud = Me.txt_solicitud_ot.Text
            End With
            'enviamos los datos
            dt = func._mostrar_anotaciones_ot_por_codigo_mouse(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_anotaciones_ot.DataSource = dt
            Else
                Me.dg_anotaciones_ot.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_anotaciones_ot_por_doc_mouse()
        Try
            Dim dts As New SOT.TB_solicitudes_ot
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_doc = txt_doc_cliente.Text
                .vc_solicitud = Me.txt_solicitud_ot.Text
            End With
            'enviamos los datos
            dt = func._mostrar_anotaciones_ot_por_n_doc_mouse(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_anotaciones_ot.DataSource = dt
            Else
                Me.dg_anotaciones_ot.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_anotaciones_ot_por_nservicio_mouse()
        Try
            Dim dts As New SOT.TB_solicitudes_ot
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_servicio = Me.txt_nservicio_cliente.Text
                .vc_solicitud = Me.txt_solicitud_ot.Text
            End With
            'enviamos los datos
            dt = func._mostrar_anotaciones_ot_por_n_servicio_mouse(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_anotaciones_ot.DataSource = dt
            Else
                Me.dg_anotaciones_ot.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
#End Region

#Region "MOSTRAR CAMBIOS DE ESTADO SOLICITUDES OT mouse"
    Public Sub mostrar_cambios_estado_solicitudes_ot_por_codigo_mouse()
        Try
            Dim dts As New SOT.TB_solicitudes_ot   'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_codigo_cliente.Text
                .vc_solicitud = Me.txt_solicitud_ot.Text

            End With
            'enviamos los datos
            dt = func._mostrar_cambios_estado_solicitudes_ot_por_codigo_mouse(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dg_cambio_estado_solicitudes_ot.DataSource = dt
            Else
                dg_cambio_estado_solicitudes_ot.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_cambios_estado_solicitudes_ot_por_doc_mouse()
        Try
            Dim dts As New SOT.TB_solicitudes_ot   'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                ' .vc_codigo = Me.txt_codigo_cliente.Text
                .vc_n_doc = txt_doc_cliente.Text
                .vc_solicitud = Me.txt_solicitud_ot.Text
            End With
            'enviamos los datos
            dt = func._mostrar_cambios_estado_solicitudes_ot_por_doc_mouse(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dg_cambio_estado_solicitudes_ot.DataSource = dt
            Else
                dg_cambio_estado_solicitudes_ot.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_cambios_estado_solicitudes_ot_por_nservicio_mouse()
        Try
            Dim dts As New SOT.TB_solicitudes_ot   'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_servicio = Me.txt_nservicio_cliente.Text
                .vc_solicitud = Me.txt_solicitud_ot.Text
            End With
            'enviamos los datos
            dt = func._mostrar_cambios_estado_solicitudes_ot_por_nservicio_mouse(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dg_cambio_estado_solicitudes_ot.DataSource = dt
            Else
                dg_cambio_estado_solicitudes_ot.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub


#End Region

#Region "MOSTRAR TAREA SOLICITUDES OT mouse"
    Public Sub mostrar_tarea_solicitudes_ot_por_codigo_mouse()
        Try
            Dim dts As New SOT.TB_solicitudes_ot   'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_codigo_cliente.Text
                .vc_solicitud = Me.txt_solicitud_ot.Text

            End With
            'enviamos los datos
            dt = func._mostrar_tarea_solicitudes_ot_por_codigo_mouse(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dg_tarea_solicitudes_ot.DataSource = dt
            Else
                dg_tarea_solicitudes_ot.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_tarea_solicitudes_ot_por_doc_mouse()
        Try
            Dim dts As New SOT.TB_solicitudes_ot   'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_doc = txt_doc_cliente.Text
                .vc_solicitud = Me.txt_solicitud_ot.Text
            End With
            'enviamos los datos
            dt = func._mostrar_cambios_estado_solicitudes_ot_por_doc_mouse(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dg_tarea_solicitudes_ot.DataSource = dt
            Else
                dg_tarea_solicitudes_ot.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_tarea_solicitudes_ot_por_nservicio_mouse()
        Try
            Dim dts As New SOT.TB_solicitudes_ot   'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_servicio = Me.txt_nservicio_cliente.Text
                .vc_solicitud = Me.txt_solicitud_ot.Text
            End With
            'enviamos los datos
            dt = func._mostrar_tarea_solicitudes_ot_por_nservicio_mouse(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                dg_tarea_solicitudes_ot.DataSource = dt
            Else
                dg_tarea_solicitudes_ot.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
#End Region

#Region "MOSTRAR COBRANZA"
    Public Sub mostrar_cobranza_por_codigo()
        Try
            Dim dts As New SOT.TB_solicitudes_ot   'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_codigo_cliente.Text

            End With
            'enviamos los datos
            dt = func._mostrar_cobranza_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_cobranza.DataSource = dt
            Else
                Me.dg_cobranza.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_cobranza_por_doc()
        Try
            Dim dts As New SOT.TB_solicitudes_ot   'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_doc = Me.txt_doc_cliente.Text

            End With
            'enviamos los datos
            dt = func._mostrar_cobranza_por_n_doc(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_cobranza.DataSource = dt
            Else
                Me.dg_cobranza.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_cobranza_por_nservicio()
        Try
            Dim dts As New SOT.TB_solicitudes_ot   'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_servicio = Me.txt_nservicio_cliente.Text

            End With
            'enviamos los datos
            dt = func._mostrar_cobranza_por_nservicio(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_cobranza.DataSource = dt
            Else
                dg_cobranza.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

    End Sub
#End Region

#Region "MOSTRAR PAGOS APLICACIONES FACTURA"
    Public Sub mostrar_pagos_aplicaciones_factura_por_codigo()
        Try
            Dim dts As New SOT.TB_solicitudes_ot   'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_codigo_cliente.Text

            End With
            'enviamos los datos
            dt = func._mostrar_pagos_aplicaciones_factura_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dt_pagos_aplicaciones_factura.DataSource = dt
            Else
                Me.dt_pagos_aplicaciones_factura.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_pagos_aplicaciones_factura_por_doc()
        Try
            Dim dts As New SOT.TB_solicitudes_ot   'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_doc = Me.txt_doc_cliente.Text

            End With
            'enviamos los datos
            dt = func._mostrar_pagos_aplicaciones_factura_por_n_doc(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dt_pagos_aplicaciones_factura.DataSource = dt
            Else
                Me.dt_pagos_aplicaciones_factura.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_pagos_aplicaciones_factura_por_nservicio()
        Try
            Dim dts As New SOT.TB_solicitudes_ot   'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_servicio = Me.txt_nservicio_cliente.Text

            End With
            'enviamos los datos
            dt = func._mostrar_pagos_aplicaciones_factura_por_nservicio(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dt_pagos_aplicaciones_factura.DataSource = dt
            Else
                Me.dt_pagos_aplicaciones_factura.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

    End Sub
#End Region


#Region "MOSTRAR CANTIDADE DE  FACTURAS"
    Public Sub mostrar_cantidad_facturas_por_codigo()
        Try
            Dim dto As New DL.DL_cliente
            Dim row As DataRow = dto.mostrar_cantidad_facturas_por_codigo(txt_codigo_cliente.Text)
            If (row Is Nothing) Then
                Return
            End If
            Me.txt_count_facturas.Text = Convert.ToString(row("count"))
            Modulo1.contador_facturas = CInt(txt_count_facturas.Text)
            Me.VScrollBar4.Maximum = Modulo1.contador_facturas

            If Modulo1.contador_facturas = 1 Then
                VScrollBar4.Visible = False
                btn_contador_facturas.Text = CStr(Modulo1.contador_facturas - 1)
            End If



        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_cantidad_facturas_por_doc()
        Try
            Dim dto As New DL.DL_cliente
            Dim row As DataRow = dto.mostrar_cantidad_solicitudes_ot_por_doc(txt_doc_cliente.Text)
            If (row Is Nothing) Then
                Return
            End If
            Me.txt_count_facturas.Text = Convert.ToString(row("count"))
            Modulo1.contador_facturas = CInt(txt_count_facturas.Text)
            Me.VScrollBar4.Maximum = Modulo1.contador_facturas

            If Modulo1.contador_facturas = 1 Then
                VScrollBar4.Visible = False
                btn_contador_facturas.Text = CStr(Modulo1.contador_facturas - 1)
            End If


        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_cantidad_facturas_por_nservicio()
        Try
            Dim dto As New DL.DL_cliente
            Dim row As DataRow = dto.mostrar_cantidad_solicitudes_ot_por_nservicio(txt_nservicio_cliente.Text)
            If (row Is Nothing) Then
                Return
            End If
            Me.txt_count_facturas.Text = Convert.ToString(row("count"))
            Modulo1.contador_facturas = CInt(txt_count_facturas.Text)
            Me.VScrollBar4.Maximum = Modulo1.contador_facturas

            If Modulo1.contador_facturas = 1 Then
                VScrollBar4.Visible = False
                btn_contador_facturas.Text = CStr(Modulo1.contador_facturas - 1)
            End If


        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try

    End Sub
#End Region
#Region "MOSTRAR FACTURA EN TEXTBOX"
    Public Sub mostrar_facturas_por_codigo_mouse()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_factura_clientes_por_codigo_mouse(txt_codigo_cliente.Text, CInt(txt_count_facturas.Text))

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            Me.txt_id_factura.Text = Convert.ToString(row("id_factura"))
            Me.txt_cliente.Text = Convert.ToString(row("vc_cliente"))
            Me.txt_direccion.Text = Convert.ToString(row("vc_direccion"))
            Me.txt_documento.Text = Convert.ToString(row("vc_documento"))
            Me.txt_impuesto.Text = Convert.ToString(row("vc_impuesto"))
            Me.txt_moneda.Text = Convert.ToString(row("vc_moneda"))
            Me.txt_f_emision.Text = Convert.ToString(row("vc_f_emision"))
            Me.txt_f_vencimiento.Text = Convert.ToString(row("vc_f_vencim"))
            Me.txt_f_canc.Text = Convert.ToString(row("vc_f_can"))

            Me.txt_periodo_1.Text = Convert.ToString(row("vc_periodo_1"))
            Me.txt_periodo_2.Text = Convert.ToString(row("vc_periodo_2"))
            Me.txt_f_generacion.Text = Convert.ToString(row("vc_f_generacion"))
            Me.txt_observacion.Text = Convert.ToString(row("vc_observacion"))
            Me.txt_distrito.Text = Convert.ToString(row("vc_distrito"))
            Me.txt_ciclo.Text = Convert.ToString(row("vc_ciclo"))
            txt_nfacturacion.Text = Convert.ToString(row("vc_nfacturacion"))
            txt_cuenta.Text = Convert.ToString(row("vc_cuenta"))
            txt_estado.Text = Convert.ToString(row("vc_estado"))
            txt_cid_telefono.Text = Convert.ToString(row("vc_cid_telefono"))
            txt_usuario_emision.Text = Convert.ToString(row("vc_u_emision"))
            txt_total.Text = Convert.ToString(row("vc_total_periodo"))
            txt_saldo_anterior.Text = Convert.ToString(row("vc_saldo_anterior"))

            txt_tipo_c.Text = Convert.ToString(row("vc_tipo"))
            txt_valor_venta.Text = Convert.ToString(row("vc_valor_venta"))
            txt_descuentos.Text = Convert.ToString(row("vc_descuentos"))
            txt_impuestos.Text = Convert.ToString(row("vc_impuestos"))
            txt_mora.Text = Convert.ToString(row("vc_mora"))
            txt_redondeo.Text = Convert.ToString(row("vc_redondeo"))
            txt_total_empresa.Text = Convert.ToString(row("vc_total_empresa"))

            txt_saldo_empresa.Text = Convert.ToString(row("vc_saldo_empresa"))

            txt_total_fco.Text = Convert.ToString(row("vc_total_fco"))
            txt_saldo_fco.Text = Convert.ToString(row("vc_saldo_fco"))

            txt_total_financiamiento.Text = Convert.ToString(row("vc_total_financiamiento"))
            txt_saldo_financiamiento.Text = Convert.ToString(row("vc_saldo_financiamiento"))

            txt_total_Factura.Text = Convert.ToString(row("vc_total"))
            txt_saldo_factura.Text = Convert.ToString(row("vc_saldo"))



        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub



    Public Sub mostrar_facturas_por_doc_mouse()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_facturas_clientes_por_doc_mouse(txt_doc_cliente.Text, CInt(txt_count_facturas.Text))

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            Me.txt_id_factura.Text = Convert.ToString(row("id_factura"))
            Me.txt_cliente.Text = Convert.ToString(row("vc_cliente"))
            Me.txt_direccion.Text = Convert.ToString(row("vc_direccion"))
            Me.txt_documento.Text = Convert.ToString(row("vc_documento"))
            Me.txt_impuesto.Text = Convert.ToString(row("vc_impuesto"))
            Me.txt_moneda.Text = Convert.ToString(row("vc_moneda"))
            Me.txt_f_emision.Text = Convert.ToString(row("vc_f_emision"))
            Me.txt_f_vencimiento.Text = Convert.ToString(row("vc_f_vencim"))
            Me.txt_f_canc.Text = Convert.ToString(row("vc_f_can"))

            Me.txt_periodo_1.Text = Convert.ToString(row("vc_periodo_1"))
            Me.txt_periodo_2.Text = Convert.ToString(row("vc_periodo_2"))
            Me.txt_f_generacion.Text = Convert.ToString(row("vc_f_generacion"))
            Me.txt_observacion.Text = Convert.ToString(row("vc_observacion"))
            Me.txt_distrito.Text = Convert.ToString(row("vc_distrito"))
            Me.txt_ciclo.Text = Convert.ToString(row("vc_ciclo"))
            txt_nfacturacion.Text = Convert.ToString(row("vc_nfacturacion"))
            txt_cuenta.Text = Convert.ToString(row("vc_cuenta"))
            txt_estado.Text = Convert.ToString(row("vc_estado"))
            txt_cid_telefono.Text = Convert.ToString(row("vc_cid_telefono"))
            txt_usuario_emision.Text = Convert.ToString(row("vc_u_emision"))
            txt_total.Text = Convert.ToString(row("vc_total_periodo"))
            txt_saldo_anterior.Text = Convert.ToString(row("vc_saldo_anterior"))

            txt_tipo_c.Text = Convert.ToString(row("vc_tipo"))
            txt_valor_venta.Text = Convert.ToString(row("vc_valor_venta"))
            txt_descuentos.Text = Convert.ToString(row("vc_descuentos"))
            txt_impuestos.Text = Convert.ToString(row("vc_impuestos"))
            txt_mora.Text = Convert.ToString(row("vc_mora"))
            txt_redondeo.Text = Convert.ToString(row("vc_redondeo"))
            txt_total_empresa.Text = Convert.ToString(row("vc_total_empresa"))

            txt_saldo_empresa.Text = Convert.ToString(row("vc_saldo_empresa"))

            txt_total_fco.Text = Convert.ToString(row("vc_total_fco"))
            txt_saldo_fco.Text = Convert.ToString(row("vc_saldo_fco"))

            txt_total_financiamiento.Text = Convert.ToString(row("vc_total_financiamiento"))
            txt_saldo_financiamiento.Text = Convert.ToString(row("vc_saldo_financiamiento"))

            txt_total_Factura.Text = Convert.ToString(row("vc_total"))
            txt_saldo_factura.Text = Convert.ToString(row("vc_saldo"))
        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub


    Public Sub mostrar_facturas_por_nservicio_mouse()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_factura_clientes_por_nservicio_mouse(txt_nservicio_cliente.Text, CInt(txt_count_facturas.Text))

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            Me.txt_id_factura.Text = Convert.ToString(row("id_factura"))
            Me.txt_cliente.Text = Convert.ToString(row("vc_cliente"))
            Me.txt_direccion.Text = Convert.ToString(row("vc_direccion"))
            Me.txt_documento.Text = Convert.ToString(row("vc_documento"))
            Me.txt_impuesto.Text = Convert.ToString(row("vc_impuesto"))
            Me.txt_moneda.Text = Convert.ToString(row("vc_moneda"))
            Me.txt_f_emision.Text = Convert.ToString(row("vc_f_emision"))
            Me.txt_f_vencimiento.Text = Convert.ToString(row("vc_f_vencim"))
            Me.txt_f_canc.Text = Convert.ToString(row("vc_f_can"))

            Me.txt_periodo_1.Text = Convert.ToString(row("vc_periodo_1"))
            Me.txt_periodo_2.Text = Convert.ToString(row("vc_periodo_2"))
            Me.txt_f_generacion.Text = Convert.ToString(row("vc_f_generacion"))
            Me.txt_observacion.Text = Convert.ToString(row("vc_observacion"))
            Me.txt_distrito.Text = Convert.ToString(row("vc_distrito"))
            Me.txt_ciclo.Text = Convert.ToString(row("vc_ciclo"))
            txt_nfacturacion.Text = Convert.ToString(row("vc_nfacturacion"))
            txt_cuenta.Text = Convert.ToString(row("vc_cuenta"))
            txt_estado.Text = Convert.ToString(row("vc_estado"))
            txt_cid_telefono.Text = Convert.ToString(row("vc_cid_telefono"))
            txt_usuario_emision.Text = Convert.ToString(row("vc_u_emision"))
            txt_total.Text = Convert.ToString(row("vc_total_periodo"))
            txt_saldo_anterior.Text = Convert.ToString(row("vc_saldo_anterior"))

            txt_tipo_c.Text = Convert.ToString(row("vc_tipo"))
            txt_valor_venta.Text = Convert.ToString(row("vc_valor_venta"))
            txt_descuentos.Text = Convert.ToString(row("vc_descuentos"))
            txt_impuestos.Text = Convert.ToString(row("vc_impuestos"))
            txt_mora.Text = Convert.ToString(row("vc_mora"))
            txt_redondeo.Text = Convert.ToString(row("vc_redondeo"))
            txt_total_empresa.Text = Convert.ToString(row("vc_total_empresa"))

            txt_saldo_empresa.Text = Convert.ToString(row("vc_saldo_empresa"))

            txt_total_fco.Text = Convert.ToString(row("vc_total_fco"))
            txt_saldo_fco.Text = Convert.ToString(row("vc_saldo_fco"))

            txt_total_financiamiento.Text = Convert.ToString(row("vc_total_financiamiento"))
            txt_saldo_financiamiento.Text = Convert.ToString(row("vc_saldo_financiamiento"))

            txt_total_Factura.Text = Convert.ToString(row("vc_total"))
            txt_saldo_factura.Text = Convert.ToString(row("vc_saldo"))
        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub

#End Region


#Region "MOSTRAR DETALLE DE FACTURA EN TEXTBOX 1 CON MOUSE"
    Public Sub mostrar_detalle_factura_por_cod1_mouse()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_detalle_factura_clientes_por_codigo1_mouse(txt_codigo_cliente.Text, CInt(txt_id_factura.Text))

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.

            Me.txt_organizacion_1.Text = Convert.ToString(row("vc_organizacion"))
            Me.txt_desc_1.Text = Convert.ToString(row("vc_desc_item"))
            Me.txt_tipo_detalle_1.Text = Convert.ToString(row("vc_tipo_detalle"))
            Me.txt_puertos_1.Text = Convert.ToString(row("vc_puertos"))
            Me.txt_descuento_1.Text = Convert.ToString(row("vc_descuento"))
            Me.txt_tipo_servicio_1.Text = Convert.ToString(row("vc_tipo_servicio"))
            Me.txt_prec_unit_1.Text = Convert.ToString(row("vc_precio_unit"))
            Me.txt_desde_1.Text = Convert.ToString(row("vc_desde"))
            Me.txt_valor_venta.Text = Convert.ToString(row("vc_valor_venta"))
            txt_servicio_1.Text = Convert.ToString(row("vc_servicio"))
            txt_cantidad_1.Text = Convert.ToString(row("vc_cantidad"))
            txt_hasta_1.Text = Convert.ToString(row("vc_hasta"))
            txt_igv_1.Text = Convert.ToString(row("vc_igv"))
            txt_equipo_1.Text = Convert.ToString(row("vc_equipo"))
            txt_pago_1.Text = Convert.ToString(row("vc_pago"))
            txt_dias_1.Text = Convert.ToString(row("vc_dias"))
            txt_total_1.Text = Convert.ToString(row("vc_total_item"))

        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub



    Public Sub mostrar_detalle_factura_por_doc1_mouse()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_detalle_factura_clientes_por_doc1_mouse(txt_doc_cliente.Text, CInt(txt_id_factura.Text))

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            Me.txt_organizacion_1.Text = Convert.ToString(row("vc_organizacion"))
            Me.txt_desc_1.Text = Convert.ToString(row("vc_desc_item"))
            Me.txt_tipo_detalle_1.Text = Convert.ToString(row("vc_tipo_detalle"))
            Me.txt_puertos_1.Text = Convert.ToString(row("vc_puertos"))
            Me.txt_descuento_1.Text = Convert.ToString(row("vc_descuento"))
            Me.txt_tipo_servicio_1.Text = Convert.ToString(row("vc_tipo_servicio"))
            Me.txt_prec_unit_1.Text = Convert.ToString(row("vc_precio_unit"))
            Me.txt_desde_1.Text = Convert.ToString(row("vc_desde"))
            Me.txt_valor_venta.Text = Convert.ToString(row("vc_valor_venta"))
            txt_servicio_1.Text = Convert.ToString(row("vc_servicio"))
            txt_cantidad_1.Text = Convert.ToString(row("vc_cantidad"))
            txt_hasta_1.Text = Convert.ToString(row("vc_hasta"))
            txt_igv_1.Text = Convert.ToString(row("vc_igv"))
            txt_equipo_1.Text = Convert.ToString(row("vc_equipo"))
            txt_pago_1.Text = Convert.ToString(row("vc_pago"))
            txt_dias_1.Text = Convert.ToString(row("vc_dias"))
            txt_total_1.Text = Convert.ToString(row("vc_total_item"))

        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub


    Public Sub mostrar_detalle_factura_por_nservicio1_mouse()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_detalle_factura_clientes_por_nservicio1_mouse(txt_nservicio_cliente.Text, CInt(txt_id_factura.Text))

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            Me.txt_organizacion_1.Text = Convert.ToString(row("vc_organizacion"))
            Me.txt_desc_1.Text = Convert.ToString(row("vc_desc_item"))
            Me.txt_tipo_detalle_1.Text = Convert.ToString(row("vc_tipo_detalle"))
            Me.txt_puertos_1.Text = Convert.ToString(row("vc_puertos"))
            Me.txt_descuento_1.Text = Convert.ToString(row("vc_descuento"))
            Me.txt_tipo_servicio_1.Text = Convert.ToString(row("vc_tipo_servicio"))
            Me.txt_prec_unit_1.Text = Convert.ToString(row("vc_precio_unit"))
            Me.txt_desde_1.Text = Convert.ToString(row("vc_desde"))
            Me.txt_valor_venta.Text = Convert.ToString(row("vc_valor_venta"))
            txt_servicio_1.Text = Convert.ToString(row("vc_servicio"))
            txt_cantidad_1.Text = Convert.ToString(row("vc_cantidad"))
            txt_hasta_1.Text = Convert.ToString(row("vc_hasta"))
            txt_igv_1.Text = Convert.ToString(row("vc_igv"))
            txt_equipo_1.Text = Convert.ToString(row("vc_equipo"))
            txt_pago_1.Text = Convert.ToString(row("vc_pago"))
            txt_dias_1.Text = Convert.ToString(row("vc_dias"))
            txt_total_1.Text = Convert.ToString(row("vc_total_item"))

        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub

#End Region


#Region "MOSTRAR DETALLE DE FACTURA EN TEXTBOX 2"
    Public Sub mostrar_detalle_factura_por_codigo2_mouse()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_detalle_factura_clientes_por_codigo2_mouse(txt_codigo_cliente.Text, CInt(txt_id_factura.Text))

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            Me.txt_organizacion_2.Text = Convert.ToString(row("vc_organizacion"))
            Me.txt_desc_2.Text = Convert.ToString(row("vc_desc_item"))
            Me.txt_tipo_detalle_2.Text = Convert.ToString(row("vc_tipo_detalle"))
            Me.txt_puertos_2.Text = Convert.ToString(row("vc_puertos"))
            Me.txt_descuento_2.Text = Convert.ToString(row("vc_descuento"))
            Me.txt_tipo_servicio_2.Text = Convert.ToString(row("vc_tipo_servicio"))
            Me.txt_precio_unit_2.Text = Convert.ToString(row("vc_precio_unit"))
            Me.txt_desde_2.Text = Convert.ToString(row("vc_desde"))
            Me.txt_valor_venta_2.Text = Convert.ToString(row("vc_valor_venta"))
            txt_servicio_2.Text = Convert.ToString(row("vc_servicio"))
            txt_cantidad_2.Text = Convert.ToString(row("vc_cantidad"))
            txt_hasta_2.Text = Convert.ToString(row("vc_hasta"))
            txt_igv_2.Text = Convert.ToString(row("vc_igv"))
            txt_equipo_2.Text = Convert.ToString(row("vc_equipo"))
            txt_pago_2.Text = Convert.ToString(row("vc_pago"))
            txt_dias_2.Text = Convert.ToString(row("vc_dias"))
            txt_total_2.Text = Convert.ToString(row("vc_total_item"))



        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub



    Public Sub mostrar_detalle_factura_por_doc2_mouse()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_detalle_factura_clientes_por_doc2_mouse(txt_doc_cliente.Text, CInt(txt_id_factura.Text))

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            Me.txt_organizacion_2.Text = Convert.ToString(row("vc_organizacion"))
            Me.txt_desc_2.Text = Convert.ToString(row("vc_desc_item"))
            Me.txt_tipo_detalle_2.Text = Convert.ToString(row("vc_tipo_detalle"))
            Me.txt_puertos_2.Text = Convert.ToString(row("vc_puertos"))
            Me.txt_descuento_2.Text = Convert.ToString(row("vc_descuento"))
            Me.txt_tipo_servicio_2.Text = Convert.ToString(row("vc_tipo_servicio"))
            Me.txt_precio_unit_2.Text = Convert.ToString(row("vc_precio_unit"))
            Me.txt_desde_2.Text = Convert.ToString(row("vc_desde"))
            Me.txt_valor_venta_2.Text = Convert.ToString(row("vc_valor_venta"))
            txt_servicio_2.Text = Convert.ToString(row("vc_servicio"))
            txt_cantidad_2.Text = Convert.ToString(row("vc_cantidad"))
            txt_hasta_2.Text = Convert.ToString(row("vc_hasta"))
            txt_igv_2.Text = Convert.ToString(row("vc_igv"))
            txt_equipo_2.Text = Convert.ToString(row("vc_equipo"))
            txt_pago_2.Text = Convert.ToString(row("vc_pago"))
            txt_dias_2.Text = Convert.ToString(row("vc_dias"))
            txt_total_2.Text = Convert.ToString(row("vc_total_item"))
        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub


    Public Sub mostrar_detalle_factura_por_nservicio2_mouse()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_detalle_factura_clientes_por_nservicio2_mouse(txt_nservicio_cliente.Text, CInt(txt_id_factura.Text))

            If (row Is Nothing) Then

                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            Me.txt_organizacion_2.Text = Convert.ToString(row("vc_organizacion"))
            Me.txt_desc_2.Text = Convert.ToString(row("vc_desc_item"))
            Me.txt_tipo_detalle_2.Text = Convert.ToString(row("vc_tipo_detalle"))
            Me.txt_puertos_2.Text = Convert.ToString(row("vc_puertos"))
            Me.txt_descuento_2.Text = Convert.ToString(row("vc_descuento"))
            Me.txt_tipo_servicio_2.Text = Convert.ToString(row("vc_tipo_servicio"))
            Me.txt_precio_unit_2.Text = Convert.ToString(row("vc_precio_unit"))
            Me.txt_desde_2.Text = Convert.ToString(row("vc_desde"))
            Me.txt_valor_venta_2.Text = Convert.ToString(row("vc_valor_venta"))
            txt_servicio_2.Text = Convert.ToString(row("vc_servicio"))
            txt_cantidad_2.Text = Convert.ToString(row("vc_cantidad"))
            txt_hasta_2.Text = Convert.ToString(row("vc_hasta"))
            txt_igv_2.Text = Convert.ToString(row("vc_igv"))
            txt_equipo_2.Text = Convert.ToString(row("vc_equipo"))
            txt_pago_2.Text = Convert.ToString(row("vc_pago"))
            txt_dias_2.Text = Convert.ToString(row("vc_dias"))
            txt_total_2.Text = Convert.ToString(row("vc_total_item"))
        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub

#End Region

#Region "MOSTRAR PAGOS APLICACIONES FACTURA CON MOUSE"
    Public Sub mostrar_pagos_aplicaciones_factura_por_codigo_mouse()
        Try
            Dim dts As New SOT.TB_solicitudes_ot   'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_codigo_cliente.Text
                .vc_solicitud = txt_id_factura.Text

            End With
            'enviamos los datos
            dt = func._mostrar_pagos_aplicaciones_factura_por_codigo_mouse(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dt_pagos_aplicaciones_factura.DataSource = dt
            Else
                Me.dt_pagos_aplicaciones_factura.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_pagos_aplicaciones_factura_por_doc_mouse()
        Try
            Dim dts As New SOT.TB_solicitudes_ot   'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_doc = Me.txt_doc_cliente.Text
                .vc_solicitud = txt_id_factura.Text

            End With
            'enviamos los datos
            dt = func._mostrar_pagos_aplicaciones_factura_por_n_doc_mouse(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dt_pagos_aplicaciones_factura.DataSource = dt
            Else
                Me.dt_pagos_aplicaciones_factura.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_pagos_aplicaciones_factura_por_nservicio_mouse()
        Try
            Dim dts As New SOT.TB_solicitudes_ot   'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_n_servicio = Me.txt_nservicio_cliente.Text
                .vc_solicitud = txt_id_factura.Text

            End With
            'enviamos los datos
            dt = func._mostrar_pagos_aplicaciones_factura_por_nservicio_mouse(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dt_pagos_aplicaciones_factura.DataSource = dt
            Else
                Me.dt_pagos_aplicaciones_factura.DataSource = Nothing
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

    End Sub
#End Region


    Private Sub Frm_Consulta_Histórica_FormClosing(sender As Object, e As FormClosingEventArgs) Handles MyBase.FormClosing
        'Me.Close()
        frmConsultaHistorica.Hide()
        e.Cancel = True
    End Sub

    Private Sub Frm_Consulta_Histórica_FormClosed(sender As Object, e As FormClosedEventArgs) Handles MyBase.FormClosed
        'Me.Close()
    End Sub

    Private Sub txtcategoria_EnabledChanged(sender As Object, e As EventArgs) Handles txtcategoria.EnabledChanged
        DirectCast(sender, TextBox).ForeColor = Color.Red
    End Sub
End Class

