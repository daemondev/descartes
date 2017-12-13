<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Frm_contactos_incidencia
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Frm_contactos_incidencia))
        Me.Button1 = New System.Windows.Forms.Button()
        Me.btn_seleccionar_usuario = New System.Windows.Forms.Button()
        Me.lb_contactos_disponibles = New System.Windows.Forms.ListBox()
        Me.ddl_departamento = New System.Windows.Forms.ComboBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.txt_usuario_seleccionado = New System.Windows.Forms.TextBox()
        Me.txt_tipo_incidencia_contactos = New System.Windows.Forms.TextBox()
        Me.txt_departamento_seleccionado = New System.Windows.Forms.TextBox()
        Me.SuspendLayout()
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(198, 297)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(75, 23)
        Me.Button1.TabIndex = 0
        Me.Button1.Text = "Cancelar"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'btn_seleccionar_usuario
        '
        Me.btn_seleccionar_usuario.DialogResult = System.Windows.Forms.DialogResult.OK
        Me.btn_seleccionar_usuario.Location = New System.Drawing.Point(114, 297)
        Me.btn_seleccionar_usuario.Name = "btn_seleccionar_usuario"
        Me.btn_seleccionar_usuario.Size = New System.Drawing.Size(75, 23)
        Me.btn_seleccionar_usuario.TabIndex = 1
        Me.btn_seleccionar_usuario.Text = "Seleccionar"
        Me.btn_seleccionar_usuario.UseVisualStyleBackColor = True
        '
        'lb_contactos_disponibles
        '
        Me.lb_contactos_disponibles.FormattingEnabled = True
        Me.lb_contactos_disponibles.Location = New System.Drawing.Point(3, 88)
        Me.lb_contactos_disponibles.Name = "lb_contactos_disponibles"
        Me.lb_contactos_disponibles.Size = New System.Drawing.Size(270, 173)
        Me.lb_contactos_disponibles.TabIndex = 2
        '
        'ddl_departamento
        '
        Me.ddl_departamento.DropDownHeight = 93
        Me.ddl_departamento.DropDownWidth = 340
        Me.ddl_departamento.FormattingEnabled = True
        Me.ddl_departamento.IntegralHeight = False
        Me.ddl_departamento.Location = New System.Drawing.Point(3, 45)
        Me.ddl_departamento.MaxDropDownItems = 5
        Me.ddl_departamento.Name = "ddl_departamento"
        Me.ddl_departamento.Size = New System.Drawing.Size(270, 21)
        Me.ddl_departamento.TabIndex = 3
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(2, 14)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(204, 13)
        Me.Label1.TabIndex = 4
        Me.Label1.Text = "Seleccionar Departamento-Usuario"
        '
        'txt_usuario_seleccionado
        '
        Me.txt_usuario_seleccionado.Location = New System.Drawing.Point(3, 300)
        Me.txt_usuario_seleccionado.Name = "txt_usuario_seleccionado"
        Me.txt_usuario_seleccionado.Size = New System.Drawing.Size(100, 20)
        Me.txt_usuario_seleccionado.TabIndex = 5
        Me.txt_usuario_seleccionado.Visible = False
        '
        'txt_tipo_incidencia_contactos
        '
        Me.txt_tipo_incidencia_contactos.Location = New System.Drawing.Point(173, 267)
        Me.txt_tipo_incidencia_contactos.Name = "txt_tipo_incidencia_contactos"
        Me.txt_tipo_incidencia_contactos.Size = New System.Drawing.Size(100, 20)
        Me.txt_tipo_incidencia_contactos.TabIndex = 6
        Me.txt_tipo_incidencia_contactos.Visible = False
        '
        'txt_departamento_seleccionado
        '
        Me.txt_departamento_seleccionado.Location = New System.Drawing.Point(3, 274)
        Me.txt_departamento_seleccionado.Name = "txt_departamento_seleccionado"
        Me.txt_departamento_seleccionado.Size = New System.Drawing.Size(100, 20)
        Me.txt_departamento_seleccionado.TabIndex = 7
        Me.txt_departamento_seleccionado.Visible = False
        '
        'Frm_contactos_incidencia
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(289, 327)
        Me.Controls.Add(Me.txt_departamento_seleccionado)
        Me.Controls.Add(Me.txt_tipo_incidencia_contactos)
        Me.Controls.Add(Me.txt_usuario_seleccionado)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.ddl_departamento)
        Me.Controls.Add(Me.lb_contactos_disponibles)
        Me.Controls.Add(Me.btn_seleccionar_usuario)
        Me.Controls.Add(Me.Button1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "Frm_contactos_incidencia"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Incidencias"
        Me.ResumeLayout(False)
        Me.PerformLayout()

End Sub
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents btn_seleccionar_usuario As System.Windows.Forms.Button
    Friend WithEvents lb_contactos_disponibles As System.Windows.Forms.ListBox
    Friend WithEvents ddl_departamento As System.Windows.Forms.ComboBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents txt_usuario_seleccionado As System.Windows.Forms.TextBox
    Friend WithEvents txt_tipo_incidencia_contactos As System.Windows.Forms.TextBox
    Friend WithEvents txt_departamento_seleccionado As System.Windows.Forms.TextBox
End Class
