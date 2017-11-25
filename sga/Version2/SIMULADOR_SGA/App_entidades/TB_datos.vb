Namespace SOT
    Public Class TB_datos
        'TB_DATOS EN SQL SERVER

        Private _codigo As String
        Public Property codigo() As String
            Get
                Return _codigo
            End Get

            Set(ByVal value As String)
                _codigo = value
            End Set
        End Property

        Private _nombre As String
        Public Property nombre() As String
            Get
                Return _nombre
            End Get

            Set(ByVal value As String)
                _nombre = value
            End Set
        End Property

        Private _estado As String
        Public Property estado() As String
            Get
                Return _estado
            End Get

            Set(ByVal value As String)
                _estado = value
            End Set
        End Property

        Private _direccion As String
        Public Property direccion() As String
            Get
                Return _direccion
            End Get

            Set(ByVal value As String)
                _direccion = value
            End Set
        End Property


        Private _tipo_doc As String
        Public Property tipo_doc() As String
            Get
                Return _tipo_doc
            End Get

            Set(ByVal value As String)
                _tipo_doc = value
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

        Private _abreviado As String
        Public Property abreviado() As String
            Get
                Return _abreviado
            End Get

            Set(ByVal value As String)
                _abreviado = value
            End Set
        End Property

        Private _distrito As String
        Public Property distrito() As String
            Get
                Return _distrito
            End Get

            Set(ByVal value As String)
                _distrito = value
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

