<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Frm_tipo_caso
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Frm_tipo_caso))
        Me.Label1 = New System.Windows.Forms.Label()
        Me.TabControl1 = New System.Windows.Forms.TabControl()
        Me.TabPage1 = New System.Windows.Forms.TabPage()
        Me.dg_tipo_atencion_tipo_caso = New System.Windows.Forms.DataGridView()
        Me.dg_tipo_caso = New System.Windows.Forms.DataGridView()
        Me.txt_buscar_tipo_caso = New System.Windows.Forms.TextBox()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.Button3 = New System.Windows.Forms.Button()
        Me.btn_buscar_tipo_caso = New System.Windows.Forms.Button()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.Button5 = New System.Windows.Forms.Button()
        Me.txt_numero_servicio_tipo_caso = New System.Windows.Forms.TextBox()
        Me.txt_tipo_incidencia_general = New System.Windows.Forms.TextBox()
        Me.txt_3 = New System.Windows.Forms.TextBox()
        Me.TabControl1.SuspendLayout()
        Me.TabPage1.SuspendLayout()
        CType(Me.dg_tipo_atencion_tipo_caso, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.dg_tipo_caso, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 9)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(32, 13)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Filtro:"
        '
        'TabControl1
        '
        Me.TabControl1.Appearance = System.Windows.Forms.TabAppearance.Buttons
        Me.TabControl1.Controls.Add(Me.TabPage1)
        Me.TabControl1.Location = New System.Drawing.Point(4, 274)
        Me.TabControl1.Name = "TabControl1"
        Me.TabControl1.SelectedIndex = 0
        Me.TabControl1.Size = New System.Drawing.Size(558, 125)
        Me.TabControl1.TabIndex = 2
        '
        'TabPage1
        '
        Me.TabPage1.Controls.Add(Me.dg_tipo_atencion_tipo_caso)
        Me.TabPage1.Location = New System.Drawing.Point(4, 25)
        Me.TabPage1.Name = "TabPage1"
        Me.TabPage1.Padding = New System.Windows.Forms.Padding(3)
        Me.TabPage1.Size = New System.Drawing.Size(550, 96)
        Me.TabPage1.TabIndex = 0
        Me.TabPage1.Text = "Tipo de Atención"
        Me.TabPage1.UseVisualStyleBackColor = True
        '
        'dg_tipo_atencion_tipo_caso
        '
        Me.dg_tipo_atencion_tipo_caso.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dg_tipo_atencion_tipo_caso.GridColor = System.Drawing.Color.White
        Me.dg_tipo_atencion_tipo_caso.Location = New System.Drawing.Point(0, 0)
        Me.dg_tipo_atencion_tipo_caso.Name = "dg_tipo_atencion_tipo_caso"
        Me.dg_tipo_atencion_tipo_caso.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect
        Me.dg_tipo_atencion_tipo_caso.Size = New System.Drawing.Size(547, 90)
        Me.dg_tipo_atencion_tipo_caso.TabIndex = 8
        '
        'dg_tipo_caso
        '
        Me.dg_tipo_caso.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dg_tipo_caso.GridColor = System.Drawing.Color.White
        Me.dg_tipo_caso.Location = New System.Drawing.Point(4, 35)
        Me.dg_tipo_caso.Name = "dg_tipo_caso"
        Me.dg_tipo_caso.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect
        Me.dg_tipo_caso.Size = New System.Drawing.Size(558, 218)
        Me.dg_tipo_caso.TabIndex = 3
        '
        'txt_buscar_tipo_caso
        '
        Me.txt_buscar_tipo_caso.Location = New System.Drawing.Point(50, 6)
        Me.txt_buscar_tipo_caso.Name = "txt_buscar_tipo_caso"
        Me.txt_buscar_tipo_caso.Size = New System.Drawing.Size(179, 20)
        Me.txt_buscar_tipo_caso.TabIndex = 4
        '
        'Button2
        '
        Me.Button2.DialogResult = System.Windows.Forms.DialogResult.OK
        Me.Button2.Location = New System.Drawing.Point(399, 405)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(75, 23)
        Me.Button2.TabIndex = 5
        Me.Button2.Text = "Seleccionar"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'Button3
        '
        Me.Button3.Location = New System.Drawing.Point(480, 405)
        Me.Button3.Name = "Button3"
        Me.Button3.Size = New System.Drawing.Size(75, 23)
        Me.Button3.TabIndex = 6
        Me.Button3.Text = "Salir"
        Me.Button3.UseVisualStyleBackColor = True
        '
        'btn_buscar_tipo_caso
        '
        Me.btn_buscar_tipo_caso.Location = New System.Drawing.Point(246, 6)
        Me.btn_buscar_tipo_caso.Name = "btn_buscar_tipo_caso"
        Me.btn_buscar_tipo_caso.Size = New System.Drawing.Size(75, 23)
        Me.btn_buscar_tipo_caso.TabIndex = 7
        Me.btn_buscar_tipo_caso.Text = "Buscar"
        Me.btn_buscar_tipo_caso.UseVisualStyleBackColor = True
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(434, 3)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(75, 23)
        Me.Button1.TabIndex = 8
        Me.Button1.Text = "Filtrar"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'Button5
        '
        Me.Button5.Location = New System.Drawing.Point(515, 4)
        Me.Button5.Name = "Button5"
        Me.Button5.Size = New System.Drawing.Size(17, 23)
        Me.Button5.TabIndex = 9
        Me.Button5.UseVisualStyleBackColor = True
        '
        'txt_numero_servicio_tipo_caso
        '
        Me.txt_numero_servicio_tipo_caso.Location = New System.Drawing.Point(131, 255)
        Me.txt_numero_servicio_tipo_caso.Name = "txt_numero_servicio_tipo_caso"
        Me.txt_numero_servicio_tipo_caso.Size = New System.Drawing.Size(134, 20)
        Me.txt_numero_servicio_tipo_caso.TabIndex = 10
        Me.txt_numero_servicio_tipo_caso.Visible = False
        '
        'txt_tipo_incidencia_general
        '
        Me.txt_tipo_incidencia_general.Location = New System.Drawing.Point(282, 256)
        Me.txt_tipo_incidencia_general.Name = "txt_tipo_incidencia_general"
        Me.txt_tipo_incidencia_general.Size = New System.Drawing.Size(134, 20)
        Me.txt_tipo_incidencia_general.TabIndex = 11
        Me.txt_tipo_incidencia_general.Visible = False
        '
        'txt_3
        '
        Me.txt_3.Location = New System.Drawing.Point(422, 255)
        Me.txt_3.Name = "txt_3"
        Me.txt_3.Size = New System.Drawing.Size(134, 20)
        Me.txt_3.TabIndex = 12
        Me.txt_3.Visible = False
        '
        'Frm_tipo_caso
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(567, 433)
        Me.Controls.Add(Me.txt_3)
        Me.Controls.Add(Me.txt_tipo_incidencia_general)
        Me.Controls.Add(Me.txt_numero_servicio_tipo_caso)
        Me.Controls.Add(Me.Button5)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.btn_buscar_tipo_caso)
        Me.Controls.Add(Me.Button3)
        Me.Controls.Add(Me.Button2)
        Me.Controls.Add(Me.txt_buscar_tipo_caso)
        Me.Controls.Add(Me.dg_tipo_caso)
        Me.Controls.Add(Me.TabControl1)
        Me.Controls.Add(Me.Label1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "Frm_tipo_caso"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Seleccionar Tipificación"
        Me.TabControl1.ResumeLayout(False)
        Me.TabPage1.ResumeLayout(False)
        CType(Me.dg_tipo_atencion_tipo_caso, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.dg_tipo_caso, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents TabControl1 As System.Windows.Forms.TabControl
    Friend WithEvents TabPage1 As System.Windows.Forms.TabPage
    Friend WithEvents dg_tipo_caso As System.Windows.Forms.DataGridView
    Friend WithEvents txt_buscar_tipo_caso As System.Windows.Forms.TextBox
    Friend WithEvents Button2 As System.Windows.Forms.Button
    Friend WithEvents Button3 As System.Windows.Forms.Button
    Friend WithEvents btn_buscar_tipo_caso As System.Windows.Forms.Button
    Friend WithEvents dg_tipo_atencion_tipo_caso As System.Windows.Forms.DataGridView
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents Button5 As System.Windows.Forms.Button
    Friend WithEvents txt_numero_servicio_tipo_caso As System.Windows.Forms.TextBox
    Friend WithEvents txt_tipo_incidencia_general As System.Windows.Forms.TextBox
    Friend WithEvents txt_3 As System.Windows.Forms.TextBox
End Class
