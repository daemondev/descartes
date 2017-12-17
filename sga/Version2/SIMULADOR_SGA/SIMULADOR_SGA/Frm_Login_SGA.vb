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
            FRM_INIT.Show()
        Else
            MessageBox.Show("Ingrese los datos Completos")
        End If
        'MessageBox.Show("Thank you " + usuario + " from " + contraseña)
    End Sub
    'Protected Overrides Sub SetVisibleCore(ByVal value As Boolean)
    '    'If Not Me.IsHandleCreated Then
    '    '    Me.CreateHandle()
    '    '    value = False
    '    'End If
    '    'MyBase.SetVisibleCore(value)
    'End Sub


    'Dim t As Timer = New Timer
    't.Interval = 2000
    'AddHandler t.Tick, AddressOf Ticker
    't.Start()
    'Private Sub Ticker(ByVal sender As Object, ByVal e As Object)


    'Dim t As New System.Timers.Timer()
    't.AutoReset = True
    't.Interval = 2000
    'AddHandler t.Elapsed, AddressOf Ticker
    't.Start()

    Dim t As Timer = New Timer
    'Dim t As New System.Timers.Timer()
    Private Sub hidde(ByVal sender As Object, ByVal e As Object)
        'Sub hidde(ByVal sender As Object, ByVal e As System.Timers.ElapsedEventArgs)

        'Me.ShowInTaskbar = False
        'Me.WindowState = System.Windows.Forms.FormWindowState.Minimized
        'Me.CheckForIllegalCrossThreadCalls = False
        Me.Opacity = 0
        Me.Visible = False
        Me.Hide()
        t.Enabled = False
        t.Stop()
        'Frm_Menu.TopMost = True
        Frm_Menu.Show()

    End Sub

    'Public Sub AddItemToList(ByVal Item As Integer)
    '    If Me.InvokeRequired Then
    '        Dim d As New Object(AddressOf hidde)
    '        Me.Invoke(d, New Object() {Item})
    '    Else
    '        '
    '    End If
    'End Sub
    Private progress As New List(Of ProgressBar)
    Private timex As New List(Of Timer)
    Sub timerStart()
        Dim cnt4 As Integer
        For cnt4 = 0 To 100

            progress.Add(New ProgressBar)
            With progress(cnt4)
                .Parent = Me
                .Left = 0
                .Height = 23
                .Width = 50
                .Top = .Height * cnt4 + 50
                .Visible = True
                .Tag = cnt4
                .Text = ""
                .Maximum = 100 'Set Maximum
                .Minimum = 0
                .Name = "progress" & cnt4
                .Location = New Point(17 + (.Width * cnt4), 532)
                Me.Controls.Add(progress(cnt4)) 'Have to add it to your Containers Control Collection
            End With

            timex.Add(New Timer)
            AddHandler timex(cnt4).Tick, AddressOf myTickEvent

            With timex(cnt4)
                .Tag = cnt4
                .Interval = 100
            End With
        Next
        timex(0).Start()
    End Sub
    Private Sub myTickEvent(sender As Object, e As EventArgs)
        Dim instance As Integer = CInt(DirectCast(sender, Timer).Tag) 'Get Index of the Active Timer
        If progress(instance).Value >= progress(instance).Maximum Then
            timex(instance).Stop()
            RemoveHandler timex(instance).Tick, AddressOf myTickEvent
            If instance < progress.Count - 1 Then
                timex(instance + 1).Start()
            End If
        Else
            progress(instance).Value += 1
        End If
    End Sub
    Private Sub Frm_Login_SGA_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        't.AutoReset = True
        t.Interval = 1
        AddHandler t.Tick, AddressOf hidde
        'AddHandler t.Elapsed, AddressOf hidde

        If Util.debug Then
            Modulo1.usuario = "E123456"
            Modulo1.contraseña = "123456"
            Modulo1.nombres_usuario = "@daemonDEV"
            t.Start()
        Else
            txt_contraseña1.PasswordChar = "•"c
            Me.MaximizeBox = False  ' boton maximizar
        End If

    End Sub
End Class