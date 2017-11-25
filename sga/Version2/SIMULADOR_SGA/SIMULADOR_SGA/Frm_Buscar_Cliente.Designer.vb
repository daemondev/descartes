<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Frm_Buscar_Cliente
    Inherits System.Windows.Forms.Form

    'Form reemplaza a Dispose para limpiar la lista de componentes.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Requerido por el Diseñador de Windows Forms
    Private components As System.ComponentModel.IContainer

    'NOTA: el Diseñador de Windows Forms necesita el siguiente procedimiento
    'Se puede modificar usando el Diseñador de Windows Forms.  
    'No lo modifique con el editor de código.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.txt_nombre = New System.Windows.Forms.TextBox()
        Me.ddl_estado = New System.Windows.Forms.ComboBox()
        Me.dg_buscar_cliente = New System.Windows.Forms.DataGridView()
        Me.txt_5 = New System.Windows.Forms.TextBox()
        CType(Me.dg_buscar_cliente, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(414, 24)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(75, 23)
        Me.Button1.TabIndex = 0
        Me.Button1.Text = "Buscar"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(7, 26)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(44, 13)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Nombre"
        '
        'txt_nombre
        '
        Me.txt_nombre.Location = New System.Drawing.Point(57, 24)
        Me.txt_nombre.Name = "txt_nombre"
        Me.txt_nombre.Size = New System.Drawing.Size(224, 20)
        Me.txt_nombre.TabIndex = 2
        '
        'ddl_estado
        '
        Me.ddl_estado.FormattingEnabled = True
        Me.ddl_estado.Items.AddRange(New Object() {"Activo"})
        Me.ddl_estado.Location = New System.Drawing.Point(287, 23)
        Me.ddl_estado.Name = "ddl_estado"
        Me.ddl_estado.Size = New System.Drawing.Size(121, 21)
        Me.ddl_estado.TabIndex = 4
        '
        'dg_buscar_cliente
        '
        Me.dg_buscar_cliente.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dg_buscar_cliente.Location = New System.Drawing.Point(12, 50)
        Me.dg_buscar_cliente.Name = "dg_buscar_cliente"
        Me.dg_buscar_cliente.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect
        Me.dg_buscar_cliente.Size = New System.Drawing.Size(477, 308)
        Me.dg_buscar_cliente.TabIndex = 5
        '
        'txt_5
        '
        Me.txt_5.Location = New System.Drawing.Point(158, 1)
        Me.txt_5.Name = "txt_5"
        Me.txt_5.Size = New System.Drawing.Size(123, 20)
        Me.txt_5.TabIndex = 6
        '
        'Frm_Buscar_Cliente
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(507, 370)
        Me.Controls.Add(Me.txt_5)
        Me.Controls.Add(Me.dg_buscar_cliente)
        Me.Controls.Add(Me.ddl_estado)
        Me.Controls.Add(Me.txt_nombre)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.Button1)
        Me.Name = "Frm_Buscar_Cliente"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Buscar"
        CType(Me.dg_buscar_cliente, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents txt_nombre As System.Windows.Forms.TextBox
    Friend WithEvents ddl_estado As System.Windows.Forms.ComboBox
    Friend WithEvents dg_buscar_cliente As System.Windows.Forms.DataGridView
    Friend WithEvents txt_5 As System.Windows.Forms.TextBox
End Class
