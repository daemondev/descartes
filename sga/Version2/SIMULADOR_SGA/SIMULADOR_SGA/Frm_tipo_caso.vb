Imports App_datos
Imports App_entidades
Imports App_negocio
Imports System.Windows.Forms
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Public Class Frm_tipo_caso
    Private dt As New DataTable

    Public Sub New()
        InitializeComponent()
        Me.txt_tipo_incidencia_general.Text = Modulo1.lb_tipo_incidencia
        Me.txt_numero_servicio_tipo_caso.Text = Modulo1.servicio
        'Modulo1.lb_tipo_incidencia = Frm_tipo_incidencia.txt_tipo_incidencia5.Text
    End Sub
    Public varf3 As String
    Private Sub Frm_tipo_caso_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        mostrar_tipo_caso()
        mostrar_tipo_atencion()

        dg_tipo_caso.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        Me.dg_tipo_caso.AllowUserToAddRows = False
        dg_tipo_caso.RowHeadersVisible = False


        dg_tipo_atencion_tipo_caso.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        dg_tipo_atencion_tipo_caso.AllowUserToAddRows = False
        dg_tipo_atencion_tipo_caso.RowHeadersVisible = False
    End Sub
    Public Sub mostrar_tipo_caso()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_incidencia 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos
            With dts
                .vc_tipo_caso_tipificacion = Me.txt_tipo_incidencia_general.Text
            End With
            'enviamos los datos
            dt = func._mostrar_tipo_caso(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_tipo_caso.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

        Dim checkBoxColumn As New DataGridViewCheckBoxColumn()
        checkBoxColumn.HeaderText = "Calidad"
        checkBoxColumn.Width = 30
        checkBoxColumn.Name = "checkBoxColumn"
        dg_tipo_caso.Columns.Insert(2, checkBoxColumn)


        Dim checkBoxColumn1 As New DataGridViewCheckBoxColumn()
        checkBoxColumn1.HeaderText = "Monto Rec."
        checkBoxColumn1.Width = 30
        checkBoxColumn1.Name = "checkBoxColumn1"
        dg_tipo_caso.Columns.Insert(2, checkBoxColumn1)
    End Sub
    Public Sub mostrar_tipo_atencion()
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_incidencia 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos

            With dts
                .vc_tipo_atencion = Me.txt_numero_servicio_tipo_caso.Text
            End With
            'enviamos los datos
            dt = func.__mostrar_tipo_atencion(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_tipo_atencion_tipo_caso.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Private Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        Me.Close()
    End Sub
    Private Sub btn_buscar_tipo_caso_Click(sender As Object, e As EventArgs) Handles btn_buscar_tipo_caso.Click
        If txt_numero_servicio_tipo_caso.Text <> "" Then
            buscar_tipo_caso()
        Else
            mostrar_tipo_caso()
        End If
    End Sub
    Public Sub buscar_tipo_caso()
        'GENERAR BUSQUEDA DE CASOS DE INCIDENCIAS SEGUN PALABRA
        Try
            Dim dts As New SOT.TB_incidencias_reclamos  'instanciamos a la clase BL_CLIENTE  atributos de la tabla tb_datos
            Dim func As New DL.DL_incidencia 'instanciamos a la clase DL_CLIENTE de la tabla tb_datos
            With dts
                .vc_tipo_caso_tipificacion = txt_tipo_incidencia_general.Text
                .buscar_caso = "%" & txt_buscar_tipo_caso.Text.Trim.ToUpper & "%"
            End With
            'enviamos los datos
            dt = func._buscar_tipo_caso(dts)
            If dt.Rows.Count <> 0 Then
                '     MessageBox.Show("codigo valido", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Me.dg_tipo_caso.DataSource = dt
            Else
                '  MessageBox.Show("Error", "Guardando registros", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        Modulo1.tipo_caso = Me.txt_3.Text
        varf3 = txt_3.Text
    End Sub
    Private Sub dg_tipo_caso_DoubleClick(sender As Object, e As EventArgs) Handles dg_tipo_caso.DoubleClick
        If Me.dg_tipo_caso.SelectedRows.Count > 0 Then
            Me.txt_3.Text = CStr(dg_tipo_caso.Item("Caso de Atencion", dg_tipo_caso.SelectedRows(0).Index).Value)
            varf3 = txt_3.Text
            Me.Close()
        End If
    End Sub
    Private Sub dg_tipo_caso_SelectionChanged(sender As Object, e As EventArgs) Handles dg_tipo_caso.SelectionChanged
        If Me.dg_tipo_caso.SelectedRows.Count > 0 Then
            Me.txt_3.Text = CStr(dg_tipo_caso.Item("Caso de Atencion", dg_tipo_caso.SelectedRows(0).Index).Value)
            varf3 = txt_3.Text
        End If
    End Sub
End Class