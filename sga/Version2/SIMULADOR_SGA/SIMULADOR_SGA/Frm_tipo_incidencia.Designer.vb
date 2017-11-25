<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Frm_tipo_incidencia
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Frm_tipo_incidencia))
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.lb_tipo_incidencia = New System.Windows.Forms.ListBox()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.lb_area_vinculada = New System.Windows.Forms.ListBox()
        Me.TabControl1 = New System.Windows.Forms.TabControl()
        Me.TabPage1 = New System.Windows.Forms.TabPage()
        Me.CheckBox12 = New System.Windows.Forms.CheckBox()
        Me.CheckBox11 = New System.Windows.Forms.CheckBox()
        Me.CheckBox10 = New System.Windows.Forms.CheckBox()
        Me.CheckBox9 = New System.Windows.Forms.CheckBox()
        Me.CheckBox8 = New System.Windows.Forms.CheckBox()
        Me.CheckBox7 = New System.Windows.Forms.CheckBox()
        Me.CheckBox6 = New System.Windows.Forms.CheckBox()
        Me.CheckBox5 = New System.Windows.Forms.CheckBox()
        Me.CheckBox4 = New System.Windows.Forms.CheckBox()
        Me.CheckBox3 = New System.Windows.Forms.CheckBox()
        Me.CheckBox2 = New System.Windows.Forms.CheckBox()
        Me.TextBox2 = New System.Windows.Forms.TextBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.TextBox1 = New System.Windows.Forms.TextBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.CheckBox1 = New System.Windows.Forms.CheckBox()
        Me.TabPage2 = New System.Windows.Forms.TabPage()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.txt_tipo_incidencia5 = New System.Windows.Forms.TextBox()
        Me.txt_tipo_incidencia_2_click = New System.Windows.Forms.TextBox()
        Me.TabControl1.SuspendLayout()
        Me.TabPage1.SuspendLayout()
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(1, 9)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(140, 13)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Áreas Vinculadas al usuario:"
        '
        'Button1
        '
        Me.Button1.DialogResult = System.Windows.Forms.DialogResult.OK
        Me.Button1.Location = New System.Drawing.Point(413, 322)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(75, 33)
        Me.Button1.TabIndex = 2
        Me.Button1.Text = "Seleccionar"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'lb_tipo_incidencia
        '
        Me.lb_tipo_incidencia.Font = New System.Drawing.Font("Microsoft Sans Serif", 11.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lb_tipo_incidencia.FormattingEnabled = True
        Me.lb_tipo_incidencia.ItemHeight = 18
        Me.lb_tipo_incidencia.Items.AddRange(New Object() {"SOLUCION 1ER - NIVEL -Descartes", "ATENCION TECNOLOGICA FIJA -Descartes", "INFORMACIÓN-Información", "SOLICITUD-Cliente", "RECLAMO-Multicarrier", "REPORTE PREVIO-Calidad", "Incidencia-Cliente", "REPORTE PREVIO-AVERIA DE RED", "REPORTE PREVIO-Prepago", "REPORTE PREVIO TP-Telefonia Publica", "REPORTE-Reporte Equipos", "TP-Incidencia", "GESTION INTERNA-Incidencia"})
        Me.lb_tipo_incidencia.Location = New System.Drawing.Point(4, 119)
        Me.lb_tipo_incidencia.Name = "lb_tipo_incidencia"
        Me.lb_tipo_incidencia.Size = New System.Drawing.Size(321, 238)
        Me.lb_tipo_incidencia.TabIndex = 3
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(1, 102)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(100, 13)
        Me.Label4.TabIndex = 6
        Me.Label4.Text = "Tipos de Incidencia"
        '
        'lb_area_vinculada
        '
        Me.lb_area_vinculada.Font = New System.Drawing.Font("Microsoft Sans Serif", 11.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lb_area_vinculada.FormattingEnabled = True
        Me.lb_area_vinculada.ItemHeight = 18
        Me.lb_area_vinculada.Items.AddRange(New Object() {"Atención Telefónica HFC - LIMA"})
        Me.lb_area_vinculada.Location = New System.Drawing.Point(4, 26)
        Me.lb_area_vinculada.Name = "lb_area_vinculada"
        Me.lb_area_vinculada.Size = New System.Drawing.Size(321, 58)
        Me.lb_area_vinculada.TabIndex = 7
        '
        'TabControl1
        '
        Me.TabControl1.Appearance = System.Windows.Forms.TabAppearance.FlatButtons
        Me.TabControl1.Controls.Add(Me.TabPage1)
        Me.TabControl1.Controls.Add(Me.TabPage2)
        Me.TabControl1.Location = New System.Drawing.Point(366, 1)
        Me.TabControl1.Name = "TabControl1"
        Me.TabControl1.SelectedIndex = 0
        Me.TabControl1.Size = New System.Drawing.Size(276, 322)
        Me.TabControl1.TabIndex = 8
        '
        'TabPage1
        '
        Me.TabPage1.Controls.Add(Me.CheckBox12)
        Me.TabPage1.Controls.Add(Me.CheckBox11)
        Me.TabPage1.Controls.Add(Me.CheckBox10)
        Me.TabPage1.Controls.Add(Me.CheckBox9)
        Me.TabPage1.Controls.Add(Me.CheckBox8)
        Me.TabPage1.Controls.Add(Me.CheckBox7)
        Me.TabPage1.Controls.Add(Me.CheckBox6)
        Me.TabPage1.Controls.Add(Me.CheckBox5)
        Me.TabPage1.Controls.Add(Me.CheckBox4)
        Me.TabPage1.Controls.Add(Me.CheckBox3)
        Me.TabPage1.Controls.Add(Me.CheckBox2)
        Me.TabPage1.Controls.Add(Me.TextBox2)
        Me.TabPage1.Controls.Add(Me.Label3)
        Me.TabPage1.Controls.Add(Me.TextBox1)
        Me.TabPage1.Controls.Add(Me.Label2)
        Me.TabPage1.Controls.Add(Me.CheckBox1)
        Me.TabPage1.Location = New System.Drawing.Point(4, 25)
        Me.TabPage1.Name = "TabPage1"
        Me.TabPage1.Padding = New System.Windows.Forms.Padding(3)
        Me.TabPage1.Size = New System.Drawing.Size(268, 293)
        Me.TabPage1.TabIndex = 0
        Me.TabPage1.Text = "Propiedades"
        Me.TabPage1.UseVisualStyleBackColor = True
        '
        'CheckBox12
        '
        Me.CheckBox12.AutoSize = True
        Me.CheckBox12.Location = New System.Drawing.Point(11, 273)
        Me.CheckBox12.Name = "CheckBox12"
        Me.CheckBox12.Size = New System.Drawing.Size(111, 17)
        Me.CheckBox12.TabIndex = 15
        Me.CheckBox12.Text = "Incidencia Interna"
        Me.CheckBox12.UseVisualStyleBackColor = True
        '
        'CheckBox11
        '
        Me.CheckBox11.AutoSize = True
        Me.CheckBox11.Checked = True
        Me.CheckBox11.CheckState = System.Windows.Forms.CheckState.Checked
        Me.CheckBox11.Location = New System.Drawing.Point(11, 91)
        Me.CheckBox11.Name = "CheckBox11"
        Me.CheckBox11.Size = New System.Drawing.Size(98, 17)
        Me.CheckBox11.TabIndex = 14
        Me.CheckBox11.Text = "Elige un cliente"
        Me.CheckBox11.UseVisualStyleBackColor = True
        '
        'CheckBox10
        '
        Me.CheckBox10.AutoSize = True
        Me.CheckBox10.Checked = True
        Me.CheckBox10.CheckState = System.Windows.Forms.CheckState.Checked
        Me.CheckBox10.Location = New System.Drawing.Point(11, 113)
        Me.CheckBox10.Name = "CheckBox10"
        Me.CheckBox10.Size = New System.Drawing.Size(101, 17)
        Me.CheckBox10.TabIndex = 13
        Me.CheckBox10.Text = "Selecc. servicio"
        Me.CheckBox10.UseVisualStyleBackColor = True
        '
        'CheckBox9
        '
        Me.CheckBox9.AutoSize = True
        Me.CheckBox9.Checked = True
        Me.CheckBox9.CheckState = System.Windows.Forms.CheckState.Checked
        Me.CheckBox9.Location = New System.Drawing.Point(11, 134)
        Me.CheckBox9.Name = "CheckBox9"
        Me.CheckBox9.Size = New System.Drawing.Size(103, 17)
        Me.CheckBox9.TabIndex = 12
        Me.CheckBox9.Text = "Elige un servicio"
        Me.CheckBox9.UseVisualStyleBackColor = True
        '
        'CheckBox8
        '
        Me.CheckBox8.AutoSize = True
        Me.CheckBox8.Location = New System.Drawing.Point(11, 156)
        Me.CheckBox8.Name = "CheckBox8"
        Me.CheckBox8.Size = New System.Drawing.Size(68, 17)
        Me.CheckBox8.TabIndex = 11
        Me.CheckBox8.Text = "Co-billing"
        Me.CheckBox8.UseVisualStyleBackColor = True
        '
        'CheckBox7
        '
        Me.CheckBox7.AutoSize = True
        Me.CheckBox7.Location = New System.Drawing.Point(11, 177)
        Me.CheckBox7.Name = "CheckBox7"
        Me.CheckBox7.Size = New System.Drawing.Size(106, 17)
        Me.CheckBox7.TabIndex = 10
        Me.CheckBox7.Text = "Registra facturas"
        Me.CheckBox7.UseVisualStyleBackColor = True
        '
        'CheckBox6
        '
        Me.CheckBox6.AutoSize = True
        Me.CheckBox6.Location = New System.Drawing.Point(11, 198)
        Me.CheckBox6.Name = "CheckBox6"
        Me.CheckBox6.Size = New System.Drawing.Size(109, 17)
        Me.CheckBox6.TabIndex = 9
        Me.CheckBox6.Text = "Registra llamadas"
        Me.CheckBox6.UseVisualStyleBackColor = True
        '
        'CheckBox5
        '
        Me.CheckBox5.AutoSize = True
        Me.CheckBox5.Location = New System.Drawing.Point(11, 218)
        Me.CheckBox5.Name = "CheckBox5"
        Me.CheckBox5.Size = New System.Drawing.Size(103, 17)
        Me.CheckBox5.TabIndex = 8
        Me.CheckBox5.Text = "Baja del servicio"
        Me.CheckBox5.UseVisualStyleBackColor = True
        '
        'CheckBox4
        '
        Me.CheckBox4.AutoSize = True
        Me.CheckBox4.Location = New System.Drawing.Point(11, 256)
        Me.CheckBox4.Name = "CheckBox4"
        Me.CheckBox4.Size = New System.Drawing.Size(68, 17)
        Me.CheckBox4.TabIndex = 7
        Me.CheckBox4.Text = "Procesar"
        Me.CheckBox4.UseVisualStyleBackColor = True
        '
        'CheckBox3
        '
        Me.CheckBox3.AutoSize = True
        Me.CheckBox3.Location = New System.Drawing.Point(11, 236)
        Me.CheckBox3.Name = "CheckBox3"
        Me.CheckBox3.Size = New System.Drawing.Size(100, 17)
        Me.CheckBox3.TabIndex = 6
        Me.CheckBox3.Text = "Alta del servicio"
        Me.CheckBox3.UseVisualStyleBackColor = True
        '
        'CheckBox2
        '
        Me.CheckBox2.AutoSize = True
        Me.CheckBox2.Checked = True
        Me.CheckBox2.CheckState = System.Windows.Forms.CheckState.Checked
        Me.CheckBox2.Location = New System.Drawing.Point(11, 71)
        Me.CheckBox2.Name = "CheckBox2"
        Me.CheckBox2.Size = New System.Drawing.Size(99, 17)
        Me.CheckBox2.TabIndex = 5
        Me.CheckBox2.Text = "Existe el cliente"
        Me.CheckBox2.UseVisualStyleBackColor = True
        '
        'TextBox2
        '
        Me.TextBox2.Location = New System.Drawing.Point(48, 49)
        Me.TextBox2.Name = "TextBox2"
        Me.TextBox2.Size = New System.Drawing.Size(151, 20)
        Me.TextBox2.TabIndex = 4
        Me.TextBox2.Text = "1"
        Me.TextBox2.TextAlign = System.Windows.Forms.HorizontalAlignment.Center
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(3, 52)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(27, 13)
        Me.Label3.TabIndex = 3
        Me.Label3.Text = "Inst:"
        '
        'TextBox1
        '
        Me.TextBox1.Location = New System.Drawing.Point(48, 6)
        Me.TextBox1.Name = "TextBox1"
        Me.TextBox1.Size = New System.Drawing.Size(151, 20)
        Me.TextBox1.TabIndex = 2
        Me.TextBox1.Text = "SOL. 1NVL"
        Me.TextBox1.TextAlign = System.Windows.Forms.HorizontalAlignment.Center
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(3, 12)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(26, 13)
        Me.Label2.TabIndex = 1
        Me.Label2.Text = "Abr:"
        '
        'CheckBox1
        '
        Me.CheckBox1.AutoSize = True
        Me.CheckBox1.Checked = True
        Me.CheckBox1.CheckState = System.Windows.Forms.CheckState.Checked
        Me.CheckBox1.Location = New System.Drawing.Point(66, 32)
        Me.CheckBox1.Name = "CheckBox1"
        Me.CheckBox1.Size = New System.Drawing.Size(79, 17)
        Me.CheckBox1.TabIndex = 0
        Me.CheckBox1.Text = "Tipo activo"
        Me.CheckBox1.UseVisualStyleBackColor = True
        '
        'TabPage2
        '
        Me.TabPage2.Location = New System.Drawing.Point(4, 25)
        Me.TabPage2.Name = "TabPage2"
        Me.TabPage2.Padding = New System.Windows.Forms.Padding(3)
        Me.TabPage2.Size = New System.Drawing.Size(268, 293)
        Me.TabPage2.TabIndex = 1
        Me.TabPage2.Text = "Est. Servicios"
        Me.TabPage2.UseVisualStyleBackColor = True
        '
        'Button2
        '
        Me.Button2.Location = New System.Drawing.Point(519, 322)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(75, 33)
        Me.Button2.TabIndex = 9
        Me.Button2.Text = "Cerrar"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'txt_tipo_incidencia5
        '
        Me.txt_tipo_incidencia5.Location = New System.Drawing.Point(107, 95)
        Me.txt_tipo_incidencia5.Name = "txt_tipo_incidencia5"
        Me.txt_tipo_incidencia5.Size = New System.Drawing.Size(95, 20)
        Me.txt_tipo_incidencia5.TabIndex = 10
        Me.txt_tipo_incidencia5.Visible = False
        '
        'txt_tipo_incidencia_2_click
        '
        Me.txt_tipo_incidencia_2_click.Location = New System.Drawing.Point(208, 94)
        Me.txt_tipo_incidencia_2_click.Name = "txt_tipo_incidencia_2_click"
        Me.txt_tipo_incidencia_2_click.Size = New System.Drawing.Size(101, 20)
        Me.txt_tipo_incidencia_2_click.TabIndex = 11
        Me.txt_tipo_incidencia_2_click.Visible = False
        '
        'Frm_tipo_incidencia
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(651, 366)
        Me.Controls.Add(Me.txt_tipo_incidencia_2_click)
        Me.Controls.Add(Me.txt_tipo_incidencia5)
        Me.Controls.Add(Me.Button2)
        Me.Controls.Add(Me.TabControl1)
        Me.Controls.Add(Me.lb_area_vinculada)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.lb_tipo_incidencia)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.Label1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "Frm_tipo_incidencia"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Tipo de Incidencia"
        Me.TabControl1.ResumeLayout(False)
        Me.TabPage1.ResumeLayout(False)
        Me.TabPage1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents lb_tipo_incidencia As System.Windows.Forms.ListBox
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents lb_area_vinculada As System.Windows.Forms.ListBox
    Friend WithEvents TabControl1 As System.Windows.Forms.TabControl
    Friend WithEvents TabPage1 As System.Windows.Forms.TabPage
    Friend WithEvents TabPage2 As System.Windows.Forms.TabPage
    Friend WithEvents Button2 As System.Windows.Forms.Button
    Friend WithEvents CheckBox12 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox11 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox10 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox9 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox8 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox7 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox6 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox5 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox4 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox3 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox2 As System.Windows.Forms.CheckBox
    Friend WithEvents TextBox2 As System.Windows.Forms.TextBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents TextBox1 As System.Windows.Forms.TextBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents CheckBox1 As System.Windows.Forms.CheckBox
    Friend WithEvents txt_tipo_incidencia5 As System.Windows.Forms.TextBox
    Friend WithEvents txt_tipo_incidencia_2_click As System.Windows.Forms.TextBox
End Class
