Public Class Frm_Login_SGA

    Private Sub btn_cancelar_Click(sender As Object, e As EventArgs) Handles btn_cancelar.Click
        Me.txt_usuario1.Text = ""
        Me.txt_contraseña1.Text = ""
        Me.Close()

    End Sub

    Private Sub btn_Ingresar1_Click(sender As Object, e As EventArgs) Handles btn_Ingresar1.Click




        If txt_usuario1.Text <> "" And txt_contraseña1.Text <> "" And txt_nombres1.Text <> "" And Me.ddl_conexion.SelectedItem Is "BD_SIMULADOR_SGA" Then
            'Diferente de vacio
            'Capturando los valores de sesion (Actual)

            Modulo1.usuario = txt_usuario1.Text
            Modulo1.contraseña = txt_contraseña1.Text
            Modulo1.nombres_usuario = txt_nombres1.Text
            Me.Visible() = False
            Form1.Show()
        Else
            MessageBox.Show("Ingrese los datos Completos")
        End If
        'MessageBox.Show("Thank you " + usuario + " from " + contraseña)
    End Sub

    Private Sub Frm_Login_SGA_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        If Util.debug Then
            Modulo1.usuario = "TIM\E827566"
            Modulo1.contraseña = "123456"
            Modulo1.nombres_usuario = "@daemonDEV"
            'Me.Visible() = False
            Me.Hide()
            Form1.Show()
        Else
            txt_contraseña1.PasswordChar = "•"c
            Me.MaximizeBox = False  ' boton maximizar
        End If

    End Sub
End Class