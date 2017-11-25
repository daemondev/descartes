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

        frm4.TabControl1.SelectedIndex = 1

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
            frm4.txt_organizacion_2.Text = Convert.ToString(row("vc_organizacion"))
            frm4.txt_desc_2.Text = Convert.ToString(row("vc_desc_item"))
            frm4.txt_tipo_detalle_2.Text = Convert.ToString(row("vc_tipo_detalle"))
            frm4.txt_puertos_2.Text = Convert.ToString(row("vc_puertos"))
            frm4.txt_descuento_2.Text = Convert.ToString(row("vc_descuento"))
            frm4.txt_tipo_servicio_2.Text = Convert.ToString(row("vc_tipo_servicio"))
            frm4.txt_precio_unit_2.Text = Convert.ToString(row("vc_precio_unit"))
            frm4.txt_desde_2.Text = Convert.ToString(row("vc_desde"))
            frm4.txt_valor_venta_2.Text = Convert.ToString(row("vc_valor_venta"))
            frm4.txt_servicio_2.Text = Convert.ToString(row("vc_servicio"))
            frm4.txt_cantidad_2.Text = Convert.ToString(row("vc_cantidad"))
            frm4.txt_hasta_2.Text = Convert.ToString(row("vc_hasta"))
            frm4.txt_igv_2.Text = Convert.ToString(row("vc_igv"))
            frm4.txt_equipo_2.Text = Convert.ToString(row("vc_equipo"))
            frm4.txt_pago_2.Text = Convert.ToString(row("vc_pago"))
            frm4.txt_dias_2.Text = Convert.ToString(row("vc_dias"))
            frm4.txt_total_2.Text = Convert.ToString(row("vc_total_item"))



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

            frm4.txt_organizacion_1.Text = Convert.ToString(row("vc_organizacion"))
            frm4.txt_desc_1.Text = Convert.ToString(row("vc_desc_item"))
            frm4.txt_tipo_detalle_1.Text = Convert.ToString(row("vc_tipo_detalle"))
            frm4.txt_puertos_1.Text = Convert.ToString(row("vc_puertos"))
            frm4.txt_descuento_1.Text = Convert.ToString(row("vc_descuento"))
            frm4.txt_tipo_servicio_1.Text = Convert.ToString(row("vc_tipo_servicio"))
            frm4.txt_prec_unit_1.Text = Convert.ToString(row("vc_precio_unit"))
            frm4.txt_desde_1.Text = Convert.ToString(row("vc_desde"))
            frm4.txt_valor_venta.Text = Convert.ToString(row("vc_valor_venta"))
            frm4.txt_servicio_1.Text = Convert.ToString(row("vc_servicio"))
            frm4.txt_cantidad_1.Text = Convert.ToString(row("vc_cantidad"))
            frm4.txt_hasta_1.Text = Convert.ToString(row("vc_hasta"))
            frm4.txt_igv_1.Text = Convert.ToString(row("vc_igv"))
            frm4.txt_equipo_1.Text = Convert.ToString(row("vc_equipo"))
            frm4.txt_pago_1.Text = Convert.ToString(row("vc_pago"))
            frm4.txt_dias_1.Text = Convert.ToString(row("vc_dias"))
            frm4.txt_total_1.Text = Convert.ToString(row("vc_total_item"))
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
            frm4.txt_id_factura.Text = Convert.ToString(row("id_factura"))
            frm4.txt_cliente.Text = Convert.ToString(row("vc_cliente"))
            frm4.txt_direccion.Text = Convert.ToString(row("vc_direccion"))
            frm4.txt_documento.Text = Convert.ToString(row("vc_documento"))
            frm4.txt_impuesto.Text = Convert.ToString(row("vc_impuesto"))
            frm4.txt_moneda.Text = Convert.ToString(row("vc_moneda"))
            frm4.txt_f_emision.Text = Convert.ToString(row("vc_f_emision"))
            frm4.txt_f_vencimiento.Text = Convert.ToString(row("vc_f_vencim"))
            frm4.txt_f_canc.Text = Convert.ToString(row("vc_f_can"))

            frm4.txt_periodo_1.Text = Convert.ToString(row("vc_periodo_1"))
            frm4.txt_periodo_2.Text = Convert.ToString(row("vc_periodo_2"))
            frm4.txt_f_generacion.Text = Convert.ToString(row("vc_f_generacion"))
            frm4.txt_observacion.Text = Convert.ToString(row("vc_observacion"))
            frm4.txt_distrito.Text = Convert.ToString(row("vc_distrito"))
            frm4.txt_ciclo.Text = Convert.ToString(row("vc_ciclo"))
            frm4.txt_nfacturacion.Text = Convert.ToString(row("vc_nfacturacion"))
            frm4.txt_cuenta.Text = Convert.ToString(row("vc_cuenta"))
            frm4.txt_estado.Text = Convert.ToString(row("vc_estado"))
            frm4.txt_cid_telefono.Text = Convert.ToString(row("vc_cid_telefono"))
            frm4.txt_usuario_emision.Text = Convert.ToString(row("vc_u_emision"))
            frm4.txt_total.Text = Convert.ToString(row("vc_total_periodo"))
            frm4.txt_saldo_anterior.Text = Convert.ToString(row("vc_saldo_anterior"))

            frm4.txt_tipo_c.Text = Convert.ToString(row("vc_tipo"))
            frm4.txt_valor_venta.Text = Convert.ToString(row("vc_valor_venta"))
            frm4.txt_descuentos.Text = Convert.ToString(row("vc_descuentos"))
            frm4.txt_impuestos.Text = Convert.ToString(row("vc_impuestos"))
            frm4.txt_mora.Text = Convert.ToString(row("vc_mora"))
            frm4.txt_redondeo.Text = Convert.ToString(row("vc_redondeo"))
            frm4.txt_total_empresa.Text = Convert.ToString(row("vc_total_empresa"))

            frm4.txt_saldo_empresa.Text = Convert.ToString(row("vc_saldo_empresa"))

            frm4.txt_total_fco.Text = Convert.ToString(row("vc_total_fco"))
            frm4.txt_saldo_fco.Text = Convert.ToString(row("vc_saldo_fco"))

            frm4.txt_total_financiamiento.Text = Convert.ToString(row("vc_total_financiamiento"))
            frm4.txt_saldo_financiamiento.Text = Convert.ToString(row("vc_saldo_financiamiento"))

            frm4.txt_total_factura.Text = Convert.ToString(row("vc_total"))
            frm4.txt_saldo_factura.Text = Convert.ToString(row("vc_saldo"))



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
                frm4.dg_incidencias_lista_general.DataSource = dt
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
                frm4.dg_incidencias_clientes.DataSource = dt
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
                frm4.dg_incidencias_reclamos.DataSource = dt
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
                frm4.dg_anotaciones_ot.DataSource = dt
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
            frm4.txttipo_persona.Text = Convert.ToString(row("vc_tipo_persona"))
            frm4.txtseg_negocio.Text = Convert.ToString(row("vc_segmento_negocio"))
            frm4.txtcodigo1.Text = Convert.ToString(row("vc_codigo"))
            frm4.txttipo_cliente.Text = Convert.ToString(row("vc_tipo_cliente"))
            frm4.txtsec_negocio.Text = Convert.ToString(row("vc_sector_negocio"))
            frm4.txttipo_doc.Text = Convert.ToString(row("vc_documento_tipo"))
            frm4.txtdoc.Text = Convert.ToString(row("vc_documento"))
            frm4.txtsub_negocio.Text = Convert.ToString(row("vc_subsector_negocio"))
            frm4.txtrazon_social.Text = Convert.ToString(row("vc_razon_social"))
            frm4.txttipo_empresa.Text = Convert.ToString(row("vc_tipo_empresa"))
            frm4.txtabreviado.Text = Convert.ToString(row("vc_abreviado"))
            frm4.txtgrupo_economico.Text = Convert.ToString(row("vc_grupo_economico"))
            frm4.txtdireccion.Text = Convert.ToString(row("vc_direccion"))
            frm4.txtcategoria.Text = Convert.ToString(row("vc_categoria"))
            frm4.txtdistrito.Text = Convert.ToString(row("vc_distrito"))
            frm4.txtejectutivo_datos.Text = Convert.ToString(row("vc_ejecutivo_datos"))
            frm4.txtciudad.Text = Convert.ToString(row("vc_ciudad"))
            frm4.txtpais.Text = Convert.ToString(row("vc_pais"))
            frm4.txtintegrador.Text = Convert.ToString(row("vc_integrador"))
            frm4.txtemail.Text = Convert.ToString(row("vc_email"))
            frm4.txtadm_proyecto.Text = Convert.ToString(row("vc_adm_proyecto"))
            frm4.txtweb.Text = Convert.ToString(row("vc_web"))
            frm4.txtgestor_cobranza.Text = Convert.ToString(row("vc_gestor_cobranza"))
            frm4.txtIM.Text = Convert.ToString(row("vc_IM"))
            frm4.txtIE.Text = Convert.ToString(row("vc_IE"))
            frm4.txtactividad_economica.Text = Convert.ToString(row("vc_act_economica"))

            frm4.txtobservaciones.Text = Convert.ToString(row("vc_observaciones"))

            frm4.txttipo_act.Text = Convert.ToString(row("vc_tipo_act"))
            frm4.txt_fecha.Text = CStr(Convert.ToDateTime(row("dt_fecha")))

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
                frm4.dg_contactos.DataSource = dt
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
                frm4.dg_detalle_ot.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

End Class