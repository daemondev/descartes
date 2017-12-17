Imports App_datos
Imports App_entidades
Imports App_negocio
Imports System.Windows.Forms
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient

Public Class Frm_Buscar_Cliente
    Private dt As New DataTable
    Private Sub Frm_Buscar_Cliente_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Me.MaximizeBox = False  ' boton maximizar
        Me.MinimizeBox = False  ' boton minimizar

        ddl_estado.SelectedItem = "Activo"
        Me.dg_buscar_cliente.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        Me.dg_buscar_cliente.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells
        Me.dg_buscar_cliente.AllowUserToAddRows = False
        Me.dg_buscar_cliente.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
        Me.dg_buscar_cliente.RowHeadersVisible = False

    End Sub


    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        'Boton buscar

        Mostrar_cliente()

    End Sub
    Public Sub Mostrar_cliente()
        Try
            Dim dts As New SOT.TB_datos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts

                .abreviado = "%" & txt_nombre.Text.Trim.ToUpper & "%"

            End With
            'enviamos los datos
            dt = func._Mostrar_clientes(dts)

            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_buscar_cliente.DataSource = dt
            Else
                Me.dg_buscar_cliente.DataSource = dt
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

    End Sub

    Private Sub dg_buscar_cliente_DoubleClick(sender As Object, e As EventArgs) Handles dg_buscar_cliente.DoubleClick
        Me.txt_5.Text = CStr(dg_buscar_cliente.Item("Código cliente", dg_buscar_cliente.SelectedRows(0).Index).Value)

        mostrar_datos_clientes_por_codigo1()
        mostrar_contactos_clientes_por_codigo1()

        ' mostrar_solicitudes_ot_por_codigo1()
        mostrar_detalle_ot_por_codigo1()
        mostrar_anotaciones_ot_por_codigo1()


        mostrar_incidencias_reclamos_por_codigo1()
        mostrar_incidencias_clientes_servicios_por_codigo1()

        mostrar_incidencias_lista_general_por_codigo1()

        mostrar_factura_por_codigo1()
        mostrar_detalle_factura_por_codigo11()
        mostrar_detalle_factura_por_codigo21()

        frmConsultaHistorica.tabMain.SelectedIndex = 1

        Me.Close()

    End Sub

    Public Sub mostrar_detalle_factura_por_codigo21()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_detalle_factura_clientes_por_codigo2(txt_5.Text)

            If (row Is Nothing) Then
                MessageBox.Show("No hay registros que coincidan con el ID especificado.")
                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            frmConsultaHistorica.txt_organizacion_2.Text = Convert.ToString(row("vc_organizacion"))
            frmConsultaHistorica.txt_desc_2.Text = Convert.ToString(row("vc_desc_item"))
            frmConsultaHistorica.txt_tipo_detalle_2.Text = Convert.ToString(row("vc_tipo_detalle"))
            frmConsultaHistorica.txt_puertos_2.Text = Convert.ToString(row("vc_puertos"))
            frmConsultaHistorica.txt_descuento_2.Text = Convert.ToString(row("vc_descuento"))
            frmConsultaHistorica.txt_tipo_servicio_2.Text = Convert.ToString(row("vc_tipo_servicio"))
            frmConsultaHistorica.txt_precio_unit_2.Text = Convert.ToString(row("vc_precio_unit"))
            frmConsultaHistorica.txt_desde_2.Text = Convert.ToString(row("vc_desde"))
            frmConsultaHistorica.txt_valor_venta_2.Text = Convert.ToString(row("vc_valor_venta"))
            frmConsultaHistorica.txt_servicio_2.Text = Convert.ToString(row("vc_servicio"))
            frmConsultaHistorica.txt_cantidad_2.Text = Convert.ToString(row("vc_cantidad"))
            frmConsultaHistorica.txt_hasta_2.Text = Convert.ToString(row("vc_hasta"))
            frmConsultaHistorica.txt_igv_2.Text = Convert.ToString(row("vc_igv"))
            frmConsultaHistorica.txt_equipo_2.Text = Convert.ToString(row("vc_equipo"))
            frmConsultaHistorica.txt_pago_2.Text = Convert.ToString(row("vc_pago"))
            frmConsultaHistorica.txt_dias_2.Text = Convert.ToString(row("vc_dias"))
            frmConsultaHistorica.txt_total_2.Text = Convert.ToString(row("vc_total_item"))



        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub


    Public Sub mostrar_detalle_factura_por_codigo11()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_detalle_factura_clientes_por_codigo1(txt_5.Text)

            If (row Is Nothing) Then
                MessageBox.Show("No hay registros que coincidan con el ID especificado.")
                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.

            frmConsultaHistorica.txt_organizacion_1.Text = Convert.ToString(row("vc_organizacion"))
            frmConsultaHistorica.txt_desc_1.Text = Convert.ToString(row("vc_desc_item"))
            frmConsultaHistorica.txt_tipo_detalle_1.Text = Convert.ToString(row("vc_tipo_detalle"))
            frmConsultaHistorica.txt_puertos_1.Text = Convert.ToString(row("vc_puertos"))
            frmConsultaHistorica.txt_descuento_1.Text = Convert.ToString(row("vc_descuento"))
            frmConsultaHistorica.txt_tipo_servicio_1.Text = Convert.ToString(row("vc_tipo_servicio"))
            frmConsultaHistorica.txt_prec_unit_1.Text = Convert.ToString(row("vc_precio_unit"))
            frmConsultaHistorica.txt_desde_1.Text = Convert.ToString(row("vc_desde"))
            frmConsultaHistorica.txt_valor_venta.Text = Convert.ToString(row("vc_valor_venta"))
            frmConsultaHistorica.txt_servicio_1.Text = Convert.ToString(row("vc_servicio"))
            frmConsultaHistorica.txt_cantidad_1.Text = Convert.ToString(row("vc_cantidad"))
            frmConsultaHistorica.txt_hasta_1.Text = Convert.ToString(row("vc_hasta"))
            frmConsultaHistorica.txt_igv_1.Text = Convert.ToString(row("vc_igv"))
            frmConsultaHistorica.txt_equipo_1.Text = Convert.ToString(row("vc_equipo"))
            frmConsultaHistorica.txt_pago_1.Text = Convert.ToString(row("vc_pago"))
            frmConsultaHistorica.txt_dias_1.Text = Convert.ToString(row("vc_dias"))
            frmConsultaHistorica.txt_total_1.Text = Convert.ToString(row("vc_total_item"))
        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_factura_por_codigo1()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.mostrar_factura_clientes_por_codigo(txt_5.Text)

            If (row Is Nothing) Then
                MessageBox.Show("No hay registros que coincidan con el ID especificado.")
                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            frmConsultaHistorica.txt_id_factura.Text = Convert.ToString(row("id_factura"))
            frmConsultaHistorica.txt_cliente.Text = Convert.ToString(row("vc_cliente"))
            frmConsultaHistorica.txt_direccion.Text = Convert.ToString(row("vc_direccion"))
            frmConsultaHistorica.txt_documento.Text = Convert.ToString(row("vc_documento"))
            frmConsultaHistorica.txt_impuesto.Text = Convert.ToString(row("vc_impuesto"))
            frmConsultaHistorica.txt_moneda.Text = Convert.ToString(row("vc_moneda"))
            frmConsultaHistorica.txt_f_emision.Text = Convert.ToString(row("vc_f_emision"))
            frmConsultaHistorica.txt_f_vencimiento.Text = Convert.ToString(row("vc_f_vencim"))
            frmConsultaHistorica.txt_f_canc.Text = Convert.ToString(row("vc_f_can"))

            frmConsultaHistorica.txt_periodo_1.Text = Convert.ToString(row("vc_periodo_1"))
            frmConsultaHistorica.txt_periodo_2.Text = Convert.ToString(row("vc_periodo_2"))
            frmConsultaHistorica.txt_f_generacion.Text = Convert.ToString(row("vc_f_generacion"))
            frmConsultaHistorica.txt_observacion.Text = Convert.ToString(row("vc_observacion"))
            frmConsultaHistorica.txt_distrito.Text = Convert.ToString(row("vc_distrito"))
            frmConsultaHistorica.txt_ciclo.Text = Convert.ToString(row("vc_ciclo"))
            frmConsultaHistorica.txt_nfacturacion.Text = Convert.ToString(row("vc_nfacturacion"))
            frmConsultaHistorica.txt_cuenta.Text = Convert.ToString(row("vc_cuenta"))
            frmConsultaHistorica.txt_estado.Text = Convert.ToString(row("vc_estado"))
            frmConsultaHistorica.txt_cid_telefono.Text = Convert.ToString(row("vc_cid_telefono"))
            frmConsultaHistorica.txt_usuario_emision.Text = Convert.ToString(row("vc_u_emision"))
            frmConsultaHistorica.txt_total.Text = Convert.ToString(row("vc_total_periodo"))
            frmConsultaHistorica.txt_saldo_anterior.Text = Convert.ToString(row("vc_saldo_anterior"))

            frmConsultaHistorica.txt_tipo_c.Text = Convert.ToString(row("vc_tipo"))
            frmConsultaHistorica.txt_valor_venta.Text = Convert.ToString(row("vc_valor_venta"))
            frmConsultaHistorica.txt_descuentos.Text = Convert.ToString(row("vc_descuentos"))
            frmConsultaHistorica.txt_impuestos.Text = Convert.ToString(row("vc_impuestos"))
            frmConsultaHistorica.txt_mora.Text = Convert.ToString(row("vc_mora"))
            frmConsultaHistorica.txt_redondeo.Text = Convert.ToString(row("vc_redondeo"))
            frmConsultaHistorica.txt_total_empresa.Text = Convert.ToString(row("vc_total_empresa"))

            frmConsultaHistorica.txt_saldo_empresa.Text = Convert.ToString(row("vc_saldo_empresa"))

            frmConsultaHistorica.txt_total_fco.Text = Convert.ToString(row("vc_total_fco"))
            frmConsultaHistorica.txt_saldo_fco.Text = Convert.ToString(row("vc_saldo_fco"))

            frmConsultaHistorica.txt_total_financiamiento.Text = Convert.ToString(row("vc_total_financiamiento"))
            frmConsultaHistorica.txt_saldo_financiamiento.Text = Convert.ToString(row("vc_saldo_financiamiento"))

            frmConsultaHistorica.txt_total_factura.Text = Convert.ToString(row("vc_total"))
            frmConsultaHistorica.txt_saldo_factura.Text = Convert.ToString(row("vc_saldo"))



        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub



    Public Sub mostrar_incidencias_lista_general_por_codigo1()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_5.Text
            End With
            'enviamos los datos
            dt = func._mostrar_incidencias_lista_general_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                frmConsultaHistorica.dg_incidencias_lista_general.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_incidencias_clientes_servicios_por_codigo1()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_5.Text
            End With
            'enviamos los datos
            dt = func._mostrar_incidencias_clientes_servicios_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                frmConsultaHistorica.dg_incidencias_clientes.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_incidencias_reclamos_por_codigo1()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_5.Text
            End With
            'enviamos los datos
            dt = func._mostrar_incidencias_reclamos_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                frmConsultaHistorica.dg_incidencias_reclamos.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub mostrar_anotaciones_ot_por_codigo1()
        Try
            Dim dts As New SOT.TB_solicitudes_ot  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_5.Text
            End With
            'enviamos los datos
            dt = func._mostrar_anotaciones_ot_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                frmConsultaHistorica.dg_anotaciones_ot.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_datos_clientes_por_codigo1()
        Try
            ' Obtenemos un objeto DataRow correspondiente con
            ' el ID escrito en un control TextBox
            '
            Dim dto As New DL.DL_cliente

            Dim row As DataRow = dto.Buscar_datos_clientes_por_codigo(txt_5.Text)

            If (row Is Nothing) Then
                MessageBox.Show("No hay registros que coincidan con el ID especificado.")
                ' Abandonamos el procedimiento
                Return
            End If

            ' Rellenamos los correspondientes controles TextBox
            ' con los datos existentes en el objeto DataRow
            ' obtenido.
            frmConsultaHistorica.txttipo_persona.Text = Convert.ToString(row("vc_tipo_persona"))
            frmConsultaHistorica.txtseg_negocio.Text = Convert.ToString(row("vc_segmento_negocio"))
            frmConsultaHistorica.txtcodigo1.Text = Convert.ToString(row("vc_codigo"))
            frmConsultaHistorica.txttipo_cliente.Text = Convert.ToString(row("vc_tipo_cliente"))
            frmConsultaHistorica.txtsec_negocio.Text = Convert.ToString(row("vc_sector_negocio"))
            frmConsultaHistorica.txttipo_doc.Text = Convert.ToString(row("vc_documento_tipo"))
            frmConsultaHistorica.txtdoc.Text = Convert.ToString(row("vc_documento"))
            frmConsultaHistorica.txtsub_negocio.Text = Convert.ToString(row("vc_subsector_negocio"))
            frmConsultaHistorica.txtrazon_social.Text = Convert.ToString(row("vc_razon_social"))
            frmConsultaHistorica.txttipo_empresa.Text = Convert.ToString(row("vc_tipo_empresa"))
            frmConsultaHistorica.txtabreviado.Text = Convert.ToString(row("vc_abreviado"))
            frmConsultaHistorica.txtgrupo_economico.Text = Convert.ToString(row("vc_grupo_economico"))
            frmConsultaHistorica.txtdireccion.Text = Convert.ToString(row("vc_direccion"))
            frmConsultaHistorica.txtcategoria.Text = Convert.ToString(row("vc_categoria"))
            frmConsultaHistorica.txtdistrito.Text = Convert.ToString(row("vc_distrito"))
            frmConsultaHistorica.txtejectutivo_datos.Text = Convert.ToString(row("vc_ejecutivo_datos"))
            frmConsultaHistorica.txtciudad.Text = Convert.ToString(row("vc_ciudad"))
            frmConsultaHistorica.txtpais.Text = Convert.ToString(row("vc_pais"))
            frmConsultaHistorica.txtintegrador.Text = Convert.ToString(row("vc_integrador"))
            frmConsultaHistorica.txtemail.Text = Convert.ToString(row("vc_email"))
            frmConsultaHistorica.txtadm_proyecto.Text = Convert.ToString(row("vc_adm_proyecto"))
            frmConsultaHistorica.txtweb.Text = Convert.ToString(row("vc_web"))
            frmConsultaHistorica.txtgestor_cobranza.Text = Convert.ToString(row("vc_gestor_cobranza"))
            frmConsultaHistorica.txtIM.Text = Convert.ToString(row("vc_IM"))
            frmConsultaHistorica.txtIE.Text = Convert.ToString(row("vc_IE"))
            frmConsultaHistorica.txtactividad_economica.Text = Convert.ToString(row("vc_act_economica"))

            frmConsultaHistorica.txtobservaciones.Text = Convert.ToString(row("vc_observaciones"))

            frmConsultaHistorica.txttipo_act.Text = Convert.ToString(row("vc_tipo_act"))
            frmConsultaHistorica.txt_fecha.Text = CStr(Convert.ToDateTime(row("dt_fecha")))

        Catch ex As Exception
            ' Se ha producido un error
            MessageBox.Show(ex.Message)
        End Try
    End Sub

    Public Sub mostrar_contactos_clientes_por_codigo1()
        Try
            Dim dts As New SOT.TB_contactos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .codigo = Me.txt_5.Text
            End With
            'enviamos los datos
            dt = func._mostrar_contactos_clientes_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                frmConsultaHistorica.dgvDCcontactos.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    'Public Sub mostrar_solicitudes_ot_por_codigo1()
    '    Try
    '        ' Obtenemos un objeto DataRow correspondiente con
    '        ' el ID escrito en un control TextBox
    '        '
    '        Dim dto As New DL.DL_cliente

    '        Dim row As DataRow = dto.Buscar_solicitudes_ot_por_codigo(txt_5.Text)

    '        If (row Is Nothing) Then
    '            MessageBox.Show("No hay registros que coincidan con el ID especificado.")
    '            ' Abandonamos el procedimiento
    '            Return
    '        End If

    '        ' Rellenamos los correspondientes controles TextBox
    '        ' con los datos existentes en el objeto DataRow
    '        ' obtenido.
    '        frm4.txt_solicitud_ot.Text = Convert.ToString(row("vc_solicitud"))
    '        frm4.txt_estado_ot.Text = Convert.ToString(row("vc_estado"))
    '        frm4.txt_doc_cliente_ot.Text = Convert.ToString(row("vc_codigo"))
    '        frm4.txt_nom_cliente_ot.Text = Convert.ToString(row("vc_cliente"))
    '        frm4.txt_direccion_ot.Text = Convert.ToString(row("vc_direccion"))
    '        frm4.txt_distrito_ot.Text = Convert.ToString(row("vc_distrito"))
    '        frm4.txt_proyecto_ot.Text = Convert.ToString(row("vc_proyecto"))
    '        frm4.txt_incidencia_ot.Text = Convert.ToString(row("vc_incidencia"))
    '        frm4.txt_tipo_ot.Text = Convert.ToString(row("vc_tipo"))
    '        frm4.txt_motivo_ot.Text = Convert.ToString(row("vc_motivo"))
    '        frm4.txt_area_ot.Text = Convert.ToString(row("vc_area"))
    '        frm4.txt_tipo_servicio_ot.Text = Convert.ToString(row("vc_tipo_servicio"))
    '        frm4.txt_fcomp_ot.Text = Convert.ToString(row("vc_f_comp"))
    '        frm4.txt_pcontable_ot.Text = Convert.ToString(row("vc_p_contable"))
    '        frm4.txt_fgen_ot.Text = Convert.ToString(row("vc_f_gen"))
    '        frm4.txt_solicitante_ot.Text = Convert.ToString(row("vc_solicitante"))
    '        frm4.txt_finicio_ot.Text = Convert.ToString(row("vc_f_inicio"))
    '        frm4.txt_ffin_ot.Text = Convert.ToString(row("vc_f_fin"))
    '        frm4.txt_fapr_ot.Text = Convert.ToString(row("vc_f_apr"))
    '        frm4.txt_act_instalacion_ot.Text = Convert.ToString(row("vc_acta_instalacion"))
    '        frm4.txt_observaciones_ot.Text = Convert.ToString(row("vc_observacion"))






    '    Catch ex As Exception
    '        ' Se ha producido un error
    '        MessageBox.Show(ex.Message)
    '    End Try
    'End Sub


    Public Sub mostrar_detalle_ot_por_codigo1()
        Try
            Dim dts As New SOT.TB_solicitudes_ot  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_cliente 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_codigo = Me.txt_5.Text
            End With
            'enviamos los datos
            dt = func._mostrar_detalle_ot_por_codigo(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                frmConsultaHistorica.dg_detalle_ot.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

End Class