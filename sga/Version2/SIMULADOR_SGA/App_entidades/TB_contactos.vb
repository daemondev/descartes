Namespace SOT
    Public Class TB_contactos
        'TB_CONTACTOS
        Private _codigo As String
        Public Property codigo() As String
            Get
                Return _codigo
            End Get

            Set(ByVal value As String)
                _codigo = value
            End Set
        End Property

        Private _tipo_contacto As String
        Public Property tipo_contacto() As String
            Get
                Return _tipo_contacto
            End Get

            Set(ByVal value As String)
                _tipo_contacto = value
            End Set
        End Property

        Private _contacto As String
        Public Property contacto() As String
            Get
                Return _contacto
            End Get

            Set(ByVal value As String)
                _contacto = value
            End Set
        End Property

        Private _cargo As String
        Public Property cargo() As String
            Get
                Return _cargo
            End Get

            Set(ByVal value As String)
                _cargo = value
            End Set
        End Property

        Private _cargo_especifico As String
        Public Property cargo_especifico() As String
            Get
                Return _cargo_especifico
            End Get

            Set(ByVal value As String)
                _cargo_especifico = value
            End Set
        End Property


        Private _n_doc As String
        Public Property n_doc() As String
            Get
                Return _n_doc
            End Get

            Set(ByVal value As String)
                _n_doc = value
            End Set
        End Property



        Private _n_servicio As String
        Public Property n_servicio() As String
            Get
                Return _n_servicio
            End Get

            Set(ByVal value As String)
                _n_servicio = value
            End Set
        End Property
    End Class
End Namespace

