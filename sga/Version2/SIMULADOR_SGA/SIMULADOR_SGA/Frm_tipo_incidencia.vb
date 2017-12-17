

Public Class Frm_tipo_incidencia
    Public Sub New()

        ' Llamada necesaria para el diseñador.
        InitializeComponent()
    End Sub

    Public varf2 As String
    Public frm4 As New Frm_Generar_incidencia()
    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
		Me.Close()

    End Sub
    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        'Boton Seleccionar
        Try
            'Asignacion de lo seleccionado en el listbox a la variable lb_tipo_incidencia
            Modulo1.lb_tipo_incidencia = lb_tipo_incidencia.SelectedItem.ToString

            'Asignacion del valor de lb_tipo_incidencia a txt_tipo_incidencia5
            txt_tipo_incidencia5.Text = Modulo1.lb_tipo_incidencia

            varf2 = txt_tipo_incidencia5.Text
            'Frm_Generar_incidencia.txt_tipo_incidencia.Text = Modulo1.lb_tipo_incidencia
            whenClose()
        Catch ex As Exception
            MessageBox.Show("Seleccionar un tipo de Incidencia")
        End Try
        'frmGenerarIncidencia.
        
    End Sub

    Private Sub lb_tipo_incidencia_DoubleClick(sender As Object, e As EventArgs) Handles lb_tipo_incidencia.DoubleClick

        Modulo1.lb_tipo_incidencia = lb_tipo_incidencia.SelectedItem.ToString

        'Asignacion del valor de lb_tipo_incidencia a txt_tipo_incidencia5
        txt_tipo_incidencia5.Text = Modulo1.lb_tipo_incidencia



        varf2 = txt_tipo_incidencia5.Text


        ' Al presionar doble debe pasar al formulario
        'Frm_Generar_incidencia.txt_tipo_incidencia.Text = Modulo1.lb_tipo_incidencia
        whenClose()
        Me.Close()

    End Sub

    Sub whenClose()
        frmGenerarIncidencia.ddl_tipo_servicio.Text = "Cable"
        frmGenerarIncidencia.pnlHideDocRel.Visible = False
        frmGenerarIncidencia.mostrar_clientes_incidencias()

    End Sub


    Private Sub lb_tipo_incidencia_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lb_tipo_incidencia.SelectedIndexChanged
        If "Incidencia-Cliente" = lb_tipo_incidencia.SelectedItem.ToString() Then
            chkExisteCliente.Checked = True
            chkEligeCliente.Checked = True
            chkSeleccionaServicio.Checked = True
            chkRegistraLlamadas.Checked = True
            chkFacturas.Checked = True
            chkProcesar.Checked = True
            chkEligeServicio.Checked = False
            txtAbr.Text = "Inc-CLI"
        Else
            chkExisteCliente.Checked = False
            chkEligeCliente.Checked = False
            chkSeleccionaServicio.Checked = False
            chkRegistraLlamadas.Checked = False
            chkFacturas.Checked = False
            chkProcesar.Checked = False
            chkEligeServicio.Checked = False
            txtAbr.Text = "INF-INF"
        End If


    End Sub

    Private Sub Frm_tipo_incidencia_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        lb_area_vinculada.SelectedIndex = 0
    End Sub

    Private Sub lb_area_vinculada_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lb_area_vinculada.SelectedIndexChanged

    End Sub
End Class