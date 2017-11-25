Namespace SOT

    Public Class TB_datos_cliente
        'TB_DATOS_CLIENTE EN SQL SERVER
        Private _tipo_persona As String
        Public Property tipo_persona() As String
            Get
                Return _tipo_persona
            End Get

            Set(ByVal value As String)
                _tipo_persona = value
            End Set
        End Property

        Private _segmento_negocio As String
        Public Property segmento_negocio() As String
            Get
                Return _segmento_negocio
            End Get

            Set(ByVal value As String)
                _segmento_negocio = value
            End Set
        End Property

        Private _codigo As String
        Public Property codigo() As String
            Get
                Return _codigo
            End Get

            Set(ByVal value As String)
                _codigo = value
            End Set
        End Property

        Private _tipo_cliente As String
        Public Property tipo_cliente() As String
            Get
                Return _tipo_cliente
            End Get

            Set(ByVal value As String)
                _tipo_cliente = value
            End Set
        End Property

        Private _sector_negocio As String
        Public Property sector_negocio() As String
            Get
                Return _sector_negocio
            End Get

            Set(ByVal value As String)
                _sector_negocio = value
            End Set
        End Property

        Private _documento_tipo As String
        Public Property documento_tipo() As String
            Get
                Return _documento_tipo
            End Get

            Set(ByVal value As String)
                _documento_tipo = value
            End Set
        End Property

        Private _documento As String
        Public Property documento() As String
            Get
                Return _documento
            End Get

            Set(ByVal value As String)
                _documento = value
            End Set
        End Property

        Private _subsector_negocio As String
        Public Property subsector_negocio() As String
            Get
                Return _subsector_negocio
            End Get

            Set(ByVal value As String)
                _subsector_negocio = value
            End Set
        End Property

        Private _razon_social As String
        Public Property razon_social() As String
            Get
                Return _razon_social
            End Get

            Set(ByVal value As String)
                _razon_social = value
            End Set
        End Property

        Private _tipo_empresa As String
        Public Property tipo_empresa() As String
            Get
                Return _tipo_empresa
            End Get

            Set(ByVal value As String)
                _tipo_empresa = value
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

        Private _grupo_economico As String
        Public Property grupo_economico() As String
            Get
                Return _grupo_economico
            End Get

            Set(ByVal value As String)
                _grupo_economico = value
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

        Private _categoria As String
        Public Property categoria() As String
            Get
                Return _categoria
            End Get

            Set(ByVal value As String)
                _categoria = value
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

        Private _ejecutivo_datos As String
        Public Property ejecutivo_datos() As String
            Get
                Return _ejecutivo_datos
            End Get

            Set(ByVal value As String)
                _ejecutivo_datos = value
            End Set
        End Property

        Private _ciudad As String
        Public Property ciudad() As String
            Get
                Return _ciudad
            End Get

            Set(ByVal value As String)
                _ciudad = value
            End Set
        End Property

        Private _pais As String
        Public Property pais() As String
            Get
                Return _pais
            End Get

            Set(ByVal value As String)
                _pais = value
            End Set
        End Property

        Private _integrador As String
        Public Property integrador() As String
            Get
                Return _integrador
            End Get

            Set(ByVal value As String)
                _integrador = value
            End Set
        End Property

        Private _email As String
        Public Property email() As String
            Get
                Return _email
            End Get

            Set(ByVal value As String)
                _email = value
            End Set
        End Property

        Private _adm_proyecto As String
        Public Property adm_proyecto() As String
            Get
                Return _adm_proyecto
            End Get

            Set(ByVal value As String)
                _adm_proyecto = value
            End Set
        End Property

        Private _tipo_act As String
        Public Property tipo_act() As String
            Get
                Return _tipo_act
            End Get

            Set(ByVal value As String)
                _tipo_act = value
            End Set
        End Property

        Private _dt_fecha As DateTime
        Public Property dt_fecha() As DateTime
            Get
                Return _dt_fecha
            End Get

            Set(ByVal value As DateTime)
                _dt_fecha = value
            End Set
        End Property

    End Class

End Namespace