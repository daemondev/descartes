Namespace SOT
    Public Class TB_usuario

        Private _perfil As Int32
        Public Property perfil() As Int32
            Get
                Return _perfil
            End Get

            Set(ByVal value As Int32)
                _perfil = value
            End Set
        End Property

        Private _nombres As String
        Public Property nombres() As String
            Get
                Return _nombres
            End Get

            Set(ByVal value As String)
                _nombres = value
            End Set
        End Property

        Private _apellidos As String
        Public Property apellidos() As String
            Get
                Return _apellidos
            End Get

            Set(ByVal value As String)
                _apellidos = value
            End Set
        End Property

        Private _usuario As String
        Public Property usuario() As String
            Get
                Return _usuario
            End Get

            Set(ByVal value As String)
                _usuario = value
            End Set
        End Property

        Private _password As String
        Public Property password() As String
            Get
                Return _password
            End Get

            Set(ByVal value As String)
                _password = value
            End Set
        End Property


        Private _estado As Int32
        Public Property estado() As Int32
            Get
                Return _estado
            End Get

            Set(ByVal value As Int32)
                _estado = value
            End Set
        End Property

    End Class
End Namespace

