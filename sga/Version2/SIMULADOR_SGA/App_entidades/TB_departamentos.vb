Namespace SOT

    Public Class TB_departamentos
        'TABLA tb_departamento__usuarios_incidencia
        Private _vc_departamento As String
        Public Property vc_departamento() As String
            Get
                Return _vc_departamento
            End Get

            Set(ByVal value As String)
                _vc_departamento = value
            End Set
        End Property

    End Class
End Namespace

