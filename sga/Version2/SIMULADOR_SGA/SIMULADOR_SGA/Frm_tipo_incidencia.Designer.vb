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
        Me.chkIncidenciaInterna = New System.Windows.Forms.CheckBox()
        Me.chkEligeCliente = New System.Windows.Forms.CheckBox()
        Me.chkSeleccionaServicio = New System.Windows.Forms.CheckBox()
        Me.chkEligeServicio = New System.Windows.Forms.CheckBox()
        Me.chkCoBilling = New System.Windows.Forms.CheckBox()
        Me.chkFacturas = New System.Windows.Forms.CheckBox()
        Me.chkRegistraLlamadas = New System.Windows.Forms.CheckBox()
        Me.chkBajaServicio = New System.Windows.Forms.CheckBox()
        Me.chkProcesar = New System.Windows.Forms.CheckBox()
        Me.chkALtaServicio = New System.Windows.Forms.CheckBox()
        Me.chkExisteCliente = New System.Windows.Forms.CheckBox()
        Me.TextBox2 = New System.Windows.Forms.TextBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.TextBox1 = New System.Windows.Forms.TextBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.CheckBox1 = New System.Windows.Forms.CheckBox()
        Me.TabPage2 = New System.Windows.Forms.TabPage()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.txt_tipo_incidencia5 = New System.Windows.Forms.TextBox()
        Me.txt_tipo_incidencia_2_click = New System.Windows.Forms.TextBox()
        Me.TabPage3 = New System.Windows.Forms.TabPage()
        Me.TabControl1.SuspendLayout()
        Me.TabPage1.SuspendLayout()
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Underline), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(3, 9)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(168, 13)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Áreas Vinculadas al usuario:"
        '
        'Button1
        '
        Me.Button1.DialogResult = System.Windows.Forms.DialogResult.OK
        Me.Button1.FlatStyle = System.Windows.Forms.FlatStyle.Popup
        Me.Button1.Location = New System.Drawing.Point(359, 321)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(75, 33)
        Me.Button1.TabIndex = 2
        Me.Button1.Text = "Seleccionar"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'lb_tipo_incidencia
        '
        Me.lb_tipo_incidencia.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lb_tipo_incidencia.FormattingEnabled = True
        Me.lb_tipo_incidencia.ItemHeight = 15
        Me.lb_tipo_incidencia.Items.AddRange(New Object() {"SOLUCION 1ER - NIVEL -Descartes", "ATENCION TECNOLOGICA FIJA -Descartes", "INFORMACIÓN-Información", "SOLICITUD-Cliente", "RECLAMO-Multicarrier", "REPORTE PREVIO-Calidad", "Incidencia-Cliente", "REPORTE PREVIO-AVERIA DE RED", "REPORTE PREVIO-Prepago", "REPORTE PREVIO TP-Telefonia Publica", "REPORTE-Reporte Equipos", "TP-Incidencia", "GESTION INTERNA-Incidencia"})
        Me.lb_tipo_incidencia.Location = New System.Drawing.Point(6, 119)
        Me.lb_tipo_incidencia.Name = "lb_tipo_incidencia"
        Me.lb_tipo_incidencia.Size = New System.Drawing.Size(321, 229)
        Me.lb_tipo_incidencia.TabIndex = 3
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Underline), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label4.Location = New System.Drawing.Point(3, 102)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(119, 13)
        Me.Label4.TabIndex = 6
        Me.Label4.Text = "Tipos de Incidencia"
        '
        'lb_area_vinculada
        '
        Me.lb_area_vinculada.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lb_area_vinculada.FormattingEnabled = True
        Me.lb_area_vinculada.ItemHeight = 15
        Me.lb_area_vinculada.Items.AddRange(New Object() {"Atención Telefónica HFC - LIMA"})
        Me.lb_area_vinculada.Location = New System.Drawing.Point(6, 26)
        Me.lb_area_vinculada.Name = "lb_area_vinculada"
        Me.lb_area_vinculada.Size = New System.Drawing.Size(321, 49)
        Me.lb_area_vinculada.TabIndex = 7
        '
        'TabControl1
        '
        Me.TabControl1.Appearance = System.Windows.Forms.TabAppearance.Buttons
        Me.TabControl1.Controls.Add(Me.TabPage1)
        Me.TabControl1.Controls.Add(Me.TabPage2)
        Me.TabControl1.Controls.Add(Me.TabPage3)
        Me.TabControl1.ImeMode = System.Windows.Forms.ImeMode.NoControl
        Me.TabControl1.Location = New System.Drawing.Point(333, 1)
        Me.TabControl1.Name = "TabControl1"
        Me.TabControl1.SelectedIndex = 0
        Me.TabControl1.Size = New System.Drawing.Size(211, 288)
        Me.TabControl1.TabIndex = 8
        '
        'TabPage1
        '
        Me.TabPage1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.TabPage1.Controls.Add(Me.chkIncidenciaInterna)
        Me.TabPage1.Controls.Add(Me.chkEligeCliente)
        Me.TabPage1.Controls.Add(Me.chkSeleccionaServicio)
        Me.TabPage1.Controls.Add(Me.chkEligeServicio)
        Me.TabPage1.Controls.Add(Me.chkCoBilling)
        Me.TabPage1.Controls.Add(Me.chkFacturas)
        Me.TabPage1.Controls.Add(Me.chkRegistraLlamadas)
        Me.TabPage1.Controls.Add(Me.chkBajaServicio)
        Me.TabPage1.Controls.Add(Me.chkProcesar)
        Me.TabPage1.Controls.Add(Me.chkALtaServicio)
        Me.TabPage1.Controls.Add(Me.chkExisteCliente)
        Me.TabPage1.Controls.Add(Me.TextBox2)
        Me.TabPage1.Controls.Add(Me.Label3)
        Me.TabPage1.Controls.Add(Me.TextBox1)
        Me.TabPage1.Controls.Add(Me.Label2)
        Me.TabPage1.Controls.Add(Me.CheckBox1)
        Me.TabPage1.Location = New System.Drawing.Point(4, 25)
        Me.TabPage1.Name = "TabPage1"
        Me.TabPage1.Padding = New System.Windows.Forms.Padding(3)
        Me.TabPage1.Size = New System.Drawing.Size(203, 259)
        Me.TabPage1.TabIndex = 0
        Me.TabPage1.Text = "Propiedades"
        Me.TabPage1.UseVisualStyleBackColor = True
        '
        'chkIncidenciaInterna
        '
        Me.chkIncidenciaInterna.Location = New System.Drawing.Point(5, 231)
        Me.chkIncidenciaInterna.Name = "chkIncidenciaInterna"
        Me.chkIncidenciaInterna.RightToLeft = System.Windows.Forms.RightToLeft.Yes
        Me.chkIncidenciaInterna.Size = New System.Drawing.Size(153, 17)
        Me.chkIncidenciaInterna.TabIndex = 15
        Me.chkIncidenciaInterna.Text = "Incidencia Interna"
        Me.chkIncidenciaInterna.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.chkIncidenciaInterna.UseVisualStyleBackColor = True
        '
        'chkEligeCliente
        '
        Me.chkEligeCliente.Checked = True
        Me.chkEligeCliente.CheckState = System.Windows.Forms.CheckState.Checked
        Me.chkEligeCliente.Location = New System.Drawing.Point(5, 87)
        Me.chkEligeCliente.Name = "chkEligeCliente"
        Me.chkEligeCliente.RightToLeft = System.Windows.Forms.RightToLeft.Yes
        Me.chkEligeCliente.Size = New System.Drawing.Size(153, 17)
        Me.chkEligeCliente.TabIndex = 14
        Me.chkEligeCliente.Text = "Elige un cliente"
        Me.chkEligeCliente.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.chkEligeCliente.UseVisualStyleBackColor = True
        '
        'chkSeleccionaServicio
        '
        Me.chkSeleccionaServicio.Checked = True
        Me.chkSeleccionaServicio.CheckState = System.Windows.Forms.CheckState.Checked
        Me.chkSeleccionaServicio.Location = New System.Drawing.Point(5, 103)
        Me.chkSeleccionaServicio.Name = "chkSeleccionaServicio"
        Me.chkSeleccionaServicio.RightToLeft = System.Windows.Forms.RightToLeft.Yes
        Me.chkSeleccionaServicio.Size = New System.Drawing.Size(153, 17)
        Me.chkSeleccionaServicio.TabIndex = 13
        Me.chkSeleccionaServicio.Text = "Selecc. servicio"
        Me.chkSeleccionaServicio.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.chkSeleccionaServicio.UseVisualStyleBackColor = True
        '
        'chkEligeServicio
        '
        Me.chkEligeServicio.Checked = True
        Me.chkEligeServicio.CheckState = System.Windows.Forms.CheckState.Checked
        Me.chkEligeServicio.Location = New System.Drawing.Point(5, 119)
        Me.chkEligeServicio.Name = "chkEligeServicio"
        Me.chkEligeServicio.RightToLeft = System.Windows.Forms.RightToLeft.Yes
        Me.chkEligeServicio.Size = New System.Drawing.Size(153, 17)
        Me.chkEligeServicio.TabIndex = 12
        Me.chkEligeServicio.Text = "Elige un servicio"
        Me.chkEligeServicio.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.chkEligeServicio.UseVisualStyleBackColor = True
        '
        'chkCoBilling
        '
        Me.chkCoBilling.Location = New System.Drawing.Point(5, 135)
        Me.chkCoBilling.Name = "chkCoBilling"
        Me.chkCoBilling.RightToLeft = System.Windows.Forms.RightToLeft.Yes
        Me.chkCoBilling.Size = New System.Drawing.Size(153, 17)
        Me.chkCoBilling.TabIndex = 11
        Me.chkCoBilling.Text = "Co-billing"
        Me.chkCoBilling.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.chkCoBilling.UseVisualStyleBackColor = True
        '
        'chkFacturas
        '
        Me.chkFacturas.Location = New System.Drawing.Point(5, 151)
        Me.chkFacturas.Name = "chkFacturas"
        Me.chkFacturas.RightToLeft = System.Windows.Forms.RightToLeft.Yes
        Me.chkFacturas.Size = New System.Drawing.Size(153, 17)
        Me.chkFacturas.TabIndex = 10
        Me.chkFacturas.Text = "Registra facturas"
        Me.chkFacturas.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.chkFacturas.UseVisualStyleBackColor = True
        '
        'chkRegistraLlamadas
        '
        Me.chkRegistraLlamadas.Location = New System.Drawing.Point(5, 167)
        Me.chkRegistraLlamadas.Name = "chkRegistraLlamadas"
        Me.chkRegistraLlamadas.RightToLeft = System.Windows.Forms.RightToLeft.Yes
        Me.chkRegistraLlamadas.Size = New System.Drawing.Size(153, 17)
        Me.chkRegistraLlamadas.TabIndex = 9
        Me.chkRegistraLlamadas.Text = "Registra llamadas"
        Me.chkRegistraLlamadas.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.chkRegistraLlamadas.UseVisualStyleBackColor = True
        '
        'chkBajaServicio
        '
        Me.chkBajaServicio.Location = New System.Drawing.Point(5, 183)
        Me.chkBajaServicio.Name = "chkBajaServicio"
        Me.chkBajaServicio.RightToLeft = System.Windows.Forms.RightToLeft.Yes
        Me.chkBajaServicio.Size = New System.Drawing.Size(153, 17)
        Me.chkBajaServicio.TabIndex = 8
        Me.chkBajaServicio.Text = "Baja del servicio"
        Me.chkBajaServicio.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.chkBajaServicio.UseVisualStyleBackColor = True
        '
        'chkProcesar
        '
        Me.chkProcesar.Location = New System.Drawing.Point(5, 215)
        Me.chkProcesar.Name = "chkProcesar"
        Me.chkProcesar.RightToLeft = System.Windows.Forms.RightToLeft.Yes
        Me.chkProcesar.Size = New System.Drawing.Size(153, 17)
        Me.chkProcesar.TabIndex = 7
        Me.chkProcesar.Text = "Procesar"
        Me.chkProcesar.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.chkProcesar.UseVisualStyleBackColor = True
        '
        'chkALtaServicio
        '
        Me.chkALtaServicio.Location = New System.Drawing.Point(5, 199)
        Me.chkALtaServicio.Name = "chkALtaServicio"
        Me.chkALtaServicio.RightToLeft = System.Windows.Forms.RightToLeft.Yes
        Me.chkALtaServicio.Size = New System.Drawing.Size(153, 17)
        Me.chkALtaServicio.TabIndex = 6
        Me.chkALtaServicio.Text = "Alta del servicio"
        Me.chkALtaServicio.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.chkALtaServicio.UseVisualStyleBackColor = True
        '
        'chkExisteCliente
        '
        Me.chkExisteCliente.Checked = True
        Me.chkExisteCliente.CheckState = System.Windows.Forms.CheckState.Checked
        Me.chkExisteCliente.Location = New System.Drawing.Point(5, 71)
        Me.chkExisteCliente.Name = "chkExisteCliente"
        Me.chkExisteCliente.RightToLeft = System.Windows.Forms.RightToLeft.Yes
        Me.chkExisteCliente.Size = New System.Drawing.Size(153, 17)
        Me.chkExisteCliente.TabIndex = 5
        Me.chkExisteCliente.Text = "Existe el cliente"
        Me.chkExisteCliente.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.chkExisteCliente.UseVisualStyleBackColor = True
        '
        'TextBox2
        '
        Me.TextBox2.Location = New System.Drawing.Point(50, 49)
        Me.TextBox2.Name = "TextBox2"
        Me.TextBox2.Size = New System.Drawing.Size(151, 20)
        Me.TextBox2.TabIndex = 4
        Me.TextBox2.Text = "1"
        Me.TextBox2.TextAlign = System.Windows.Forms.HorizontalAlignment.Center
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Underline, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.Location = New System.Drawing.Point(5, 52)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(27, 13)
        Me.Label3.TabIndex = 3
        Me.Label3.Text = "Inst:"
        '
        'TextBox1
        '
        Me.TextBox1.Location = New System.Drawing.Point(50, 6)
        Me.TextBox1.Name = "TextBox1"
        Me.TextBox1.Size = New System.Drawing.Size(151, 20)
        Me.TextBox1.TabIndex = 2
        Me.TextBox1.Text = "SOL. 1NVL"
        Me.TextBox1.TextAlign = System.Windows.Forms.HorizontalAlignment.Center
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Underline, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.Location = New System.Drawing.Point(5, 12)
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
        Me.CheckBox1.Location = New System.Drawing.Point(68, 32)
        Me.CheckBox1.Name = "CheckBox1"
        Me.CheckBox1.Size = New System.Drawing.Size(79, 17)
        Me.CheckBox1.TabIndex = 0
        Me.CheckBox1.Text = "Tipo activo"
        Me.CheckBox1.UseVisualStyleBackColor = True
        '
        'TabPage2
        '
        Me.TabPage2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.TabPage2.Location = New System.Drawing.Point(4, 25)
        Me.TabPage2.Name = "TabPage2"
        Me.TabPage2.Padding = New System.Windows.Forms.Padding(3)
        Me.TabPage2.Size = New System.Drawing.Size(203, 259)
        Me.TabPage2.TabIndex = 1
        Me.TabPage2.Text = "Est. Servicios"
        Me.TabPage2.UseVisualStyleBackColor = True
        '
        'Button2
        '
        Me.Button2.FlatStyle = System.Windows.Forms.FlatStyle.Popup
        Me.Button2.Location = New System.Drawing.Point(463, 321)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(75, 33)
        Me.Button2.TabIndex = 9
        Me.Button2.Text = "Cerrar"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'txt_tipo_incidencia5
        '
        Me.txt_tipo_incidencia5.Location = New System.Drawing.Point(126, 95)
        Me.txt_tipo_incidencia5.Name = "txt_tipo_incidencia5"
        Me.txt_tipo_incidencia5.Size = New System.Drawing.Size(95, 20)
        Me.txt_tipo_incidencia5.TabIndex = 10
        Me.txt_tipo_incidencia5.Visible = False
        '
        'txt_tipo_incidencia_2_click
        '
        Me.txt_tipo_incidencia_2_click.Location = New System.Drawing.Point(227, 94)
        Me.txt_tipo_incidencia_2_click.Name = "txt_tipo_incidencia_2_click"
        Me.txt_tipo_incidencia_2_click.Size = New System.Drawing.Size(101, 20)
        Me.txt_tipo_incidencia_2_click.TabIndex = 11
        Me.txt_tipo_incidencia_2_click.Visible = False
        '
        'TabPage3
        '
        Me.TabPage3.Location = New System.Drawing.Point(4, 25)
        Me.TabPage3.Name = "TabPage3"
        Me.TabPage3.Size = New System.Drawing.Size(203, 259)
        Me.TabPage3.TabIndex = 2
        Me.TabPage3.Text = "Servicios"
        Me.TabPage3.UseVisualStyleBackColor = True
        '
        'Frm_tipo_incidencia
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(552, 366)
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
    Friend WithEvents chkIncidenciaInterna As System.Windows.Forms.CheckBox
    Friend WithEvents chkEligeCliente As System.Windows.Forms.CheckBox
    Friend WithEvents chkSeleccionaServicio As System.Windows.Forms.CheckBox
    Friend WithEvents chkEligeServicio As System.Windows.Forms.CheckBox
    Friend WithEvents chkCoBilling As System.Windows.Forms.CheckBox
    Friend WithEvents chkFacturas As System.Windows.Forms.CheckBox
    Friend WithEvents chkRegistraLlamadas As System.Windows.Forms.CheckBox
    Friend WithEvents chkBajaServicio As System.Windows.Forms.CheckBox
    Friend WithEvents chkProcesar As System.Windows.Forms.CheckBox
    Friend WithEvents chkALtaServicio As System.Windows.Forms.CheckBox
    Friend WithEvents chkExisteCliente As System.Windows.Forms.CheckBox
    Friend WithEvents TextBox2 As System.Windows.Forms.TextBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents TextBox1 As System.Windows.Forms.TextBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents CheckBox1 As System.Windows.Forms.CheckBox
    Friend WithEvents txt_tipo_incidencia5 As System.Windows.Forms.TextBox
    Friend WithEvents txt_tipo_incidencia_2_click As System.Windows.Forms.TextBox
    Friend WithEvents TabPage3 As System.Windows.Forms.TabPage
End Class
