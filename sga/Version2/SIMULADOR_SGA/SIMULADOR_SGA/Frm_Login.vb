Public Class Frm_Login

    Private Sub btn_ingresar_Click(sender As Object, e As EventArgs) Handles btn_ingresar.Click
        Dim usuario As String
        Dim contraseña As String



        If txt_usuario.Text <> "" And txt_contraseña.Text <> "" Then
            'Diferente de vacio
            'Capturando los valores de sesion (Actual)


            usuario = txt_usuario.Text
            contraseña = txt_contraseña.Text
            Me.Visible() = False
            FRM_INIT.Show()
        Else
            MessageBox.Show("Ingrese los datos Completos")
        End If
        'MessageBox.Show("Thank you " + usuario + " from " + contraseña)
    End Sub

    Private Sub Frm_Login_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        txt_contraseña.PasswordChar = "•"c

    End Sub
End Class