<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Frm_Generar_incidencia
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
        Dim DataGridViewCellStyle1 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Frm_Generar_incidencia))
        Me.Button1 = New System.Windows.Forms.Button()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.txt_incidencia = New System.Windows.Forms.TextBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.txt_f_registro = New System.Windows.Forms.TextBox()
        Me.ddl_canal_ingreso = New System.Windows.Forms.ComboBox()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.txt_prioridad = New System.Windows.Forms.TextBox()
        Me.txt_ticket = New System.Windows.Forms.TextBox()
        Me.txt_rep_atc = New System.Windows.Forms.TextBox()
        Me.txt_usuario = New System.Windows.Forms.TextBox()
        Me.Panel2 = New System.Windows.Forms.Panel()
        Me.Button3 = New System.Windows.Forms.Button()
        Me.Button5 = New System.Windows.Forms.Button()
        Me.Button4 = New System.Windows.Forms.Button()
        Me.ddl_tipo_servicio = New System.Windows.Forms.ComboBox()
        Me.txt_f_declarada = New System.Windows.Forms.TextBox()
        Me.txt_tipo_atencion = New System.Windows.Forms.TextBox()
        Me.txt_tipo_caso = New System.Windows.Forms.TextBox()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.txt_estado = New System.Windows.Forms.TextBox()
        Me.txt_tipo_incidencia = New System.Windows.Forms.TextBox()
        Me.Label10 = New System.Windows.Forms.Label()
        Me.Label12 = New System.Windows.Forms.Label()
        Me.Label13 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Panel3 = New System.Windows.Forms.Panel()
        Me.dg_generacion_incidencias = New System.Windows.Forms.DataGridView()
        Me.Tab_control = New System.Windows.Forms.TabControl()
        Me.primer_tab = New System.Windows.Forms.TabPage()
        Me.segundo_tab = New System.Windows.Forms.TabPage()
        Me.CheckBox3 = New System.Windows.Forms.CheckBox()
        Me.CheckBox2 = New System.Windows.Forms.CheckBox()
        Me.CheckBox1 = New System.Windows.Forms.CheckBox()
        Me.btnLauchIncidencia = New System.Windows.Forms.Button()
        Me.txt_asesor_derivacion = New System.Windows.Forms.TextBox()
        Me.txt_derivacion = New System.Windows.Forms.TextBox()
        Me.txt_contacto = New System.Windows.Forms.TextBox()
        Me.txt_cliente = New System.Windows.Forms.TextBox()
        Me.txt_segmento_negocio = New System.Windows.Forms.TextBox()
        Me.txt_contacto_cliente = New System.Windows.Forms.TextBox()
        Me.txt_codigo_cliente = New System.Windows.Forms.TextBox()
        Me.Label15 = New System.Windows.Forms.Label()
        Me.Label14 = New System.Windows.Forms.Label()
        Me.Label11 = New System.Windows.Forms.Label()
        Me.Button6 = New System.Windows.Forms.Button()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.txt_observaciones = New System.Windows.Forms.TextBox()
        Me.tercer_tab = New System.Windows.Forms.TabPage()
        Me.cuarto_tab = New System.Windows.Forms.TabPage()
        Me.quinto_tab = New System.Windows.Forms.TabPage()
        Me.sexto_tab = New System.Windows.Forms.TabPage()
        Me.Panel4 = New System.Windows.Forms.Panel()
        Me.Label16 = New System.Windows.Forms.Label()
        Me.Panel5 = New System.Windows.Forms.Panel()
        Me.txt_codigo5_incidencia = New System.Windows.Forms.TextBox()
        Me.txt_usuario_ingresado = New System.Windows.Forms.TextBox()
        Me.txt_nombre_ingresado = New System.Windows.Forms.TextBox()
        Me.txt_cid_generado = New System.Windows.Forms.TextBox()
        Me.txt_producto_contratado = New System.Windows.Forms.TextBox()
        Me.TabPage1 = New System.Windows.Forms.TabPage()
        Me.CheckBox4 = New System.Windows.Forms.CheckBox()
        Me.Panel1.SuspendLayout()
        Me.Panel2.SuspendLayout()
        Me.Panel3.SuspendLayout()
        CType(Me.dg_generacion_incidencias, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Tab_control.SuspendLayout()
        Me.primer_tab.SuspendLayout()
        Me.segundo_tab.SuspendLayout()
        Me.Panel4.SuspendLayout()
        Me.SuspendLayout()
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(182, 3)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(23, 23)
        Me.Button1.TabIndex = 0
        Me.Button1.Text = "--"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Underline), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(14, 145)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(43, 13)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Ticket"
        '
        'txt_incidencia
        '
        Me.txt_incidencia.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Underline), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txt_incidencia.ForeColor = System.Drawing.Color.Black
        Me.txt_incidencia.Location = New System.Drawing.Point(70, 5)
        Me.txt_incidencia.Name = "txt_incidencia"
        Me.txt_incidencia.Size = New System.Drawing.Size(102, 20)
        Me.txt_incidencia.TabIndex = 2
        Me.txt_incidencia.TextAlign = System.Windows.Forms.HorizontalAlignment.Center
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(3, 177)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(51, 13)
        Me.Label3.TabIndex = 5
        Me.Label3.Text = "Prioridad:"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Underline), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label4.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.Label4.Location = New System.Drawing.Point(3, 109)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(62, 13)
        Me.Label4.TabIndex = 6
        Me.Label4.Text = "Rep. ATC"
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(14, 72)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(43, 13)
        Me.Label5.TabIndex = 7
        Me.Label5.Text = "Usuario"
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(4, 35)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(55, 13)
        Me.Label6.TabIndex = 8
        Me.Label6.Text = "F.Registro"
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Underline), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label7.Location = New System.Drawing.Point(0, 8)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(66, 13)
        Me.Label7.TabIndex = 9
        Me.Label7.Text = "Incidencia"
        '
        'txt_f_registro
        '
        Me.txt_f_registro.Location = New System.Drawing.Point(70, 32)
        Me.txt_f_registro.Name = "txt_f_registro"
        Me.txt_f_registro.Size = New System.Drawing.Size(163, 20)
        Me.txt_f_registro.TabIndex = 12
        '
        'ddl_canal_ingreso
        '
        Me.ddl_canal_ingreso.FormattingEnabled = True
        Me.ddl_canal_ingreso.Items.AddRange(New Object() {"Telefono"})
        Me.ddl_canal_ingreso.Location = New System.Drawing.Point(123, 53)
        Me.ddl_canal_ingreso.Name = "ddl_canal_ingreso"
        Me.ddl_canal_ingreso.Size = New System.Drawing.Size(204, 21)
        Me.ddl_canal_ingreso.TabIndex = 14
        '
        'Panel1
        '
        Me.Panel1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.Panel1.Controls.Add(Me.Button2)
        Me.Panel1.Controls.Add(Me.txt_prioridad)
        Me.Panel1.Controls.Add(Me.txt_ticket)
        Me.Panel1.Controls.Add(Me.txt_rep_atc)
        Me.Panel1.Controls.Add(Me.txt_usuario)
        Me.Panel1.Controls.Add(Me.Label7)
        Me.Panel1.Controls.Add(Me.txt_incidencia)
        Me.Panel1.Controls.Add(Me.Button1)
        Me.Panel1.Controls.Add(Me.txt_f_registro)
        Me.Panel1.Controls.Add(Me.Label6)
        Me.Panel1.Controls.Add(Me.Label5)
        Me.Panel1.Controls.Add(Me.Label4)
        Me.Panel1.Controls.Add(Me.Label3)
        Me.Panel1.Controls.Add(Me.Label1)
        Me.Panel1.Location = New System.Drawing.Point(1, 1)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(241, 200)
        Me.Panel1.TabIndex = 15
        '
        'Button2
        '
        Me.Button2.Location = New System.Drawing.Point(182, 140)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(23, 23)
        Me.Button2.TabIndex = 17
        Me.Button2.Text = "--"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'txt_prioridad
        '
        Me.txt_prioridad.Location = New System.Drawing.Point(62, 177)
        Me.txt_prioridad.Name = "txt_prioridad"
        Me.txt_prioridad.Size = New System.Drawing.Size(71, 20)
        Me.txt_prioridad.TabIndex = 16
        '
        'txt_ticket
        '
        Me.txt_ticket.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Underline), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txt_ticket.ForeColor = System.Drawing.Color.Black
        Me.txt_ticket.Location = New System.Drawing.Point(70, 143)
        Me.txt_ticket.Name = "txt_ticket"
        Me.txt_ticket.Size = New System.Drawing.Size(102, 20)
        Me.txt_ticket.TabIndex = 15
        Me.txt_ticket.TextAlign = System.Windows.Forms.HorizontalAlignment.Center
        '
        'txt_rep_atc
        '
        Me.txt_rep_atc.Location = New System.Drawing.Point(70, 107)
        Me.txt_rep_atc.Name = "txt_rep_atc"
        Me.txt_rep_atc.Size = New System.Drawing.Size(165, 20)
        Me.txt_rep_atc.TabIndex = 14
        '
        'txt_usuario
        '
        Me.txt_usuario.Location = New System.Drawing.Point(70, 69)
        Me.txt_usuario.Name = "txt_usuario"
        Me.txt_usuario.Size = New System.Drawing.Size(164, 20)
        Me.txt_usuario.TabIndex = 13
        '
        'Panel2
        '
        Me.Panel2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.Panel2.Controls.Add(Me.Button3)
        Me.Panel2.Controls.Add(Me.Button5)
        Me.Panel2.Controls.Add(Me.Button4)
        Me.Panel2.Controls.Add(Me.ddl_tipo_servicio)
        Me.Panel2.Controls.Add(Me.txt_f_declarada)
        Me.Panel2.Controls.Add(Me.ddl_canal_ingreso)
        Me.Panel2.Controls.Add(Me.txt_tipo_atencion)
        Me.Panel2.Controls.Add(Me.txt_tipo_caso)
        Me.Panel2.Controls.Add(Me.Label8)
        Me.Panel2.Controls.Add(Me.txt_estado)
        Me.Panel2.Controls.Add(Me.txt_tipo_incidencia)
        Me.Panel2.Controls.Add(Me.Label10)
        Me.Panel2.Controls.Add(Me.Label12)
        Me.Panel2.Controls.Add(Me.Label13)
        Me.Panel2.Location = New System.Drawing.Point(244, 1)
        Me.Panel2.Name = "Panel2"
        Me.Panel2.Size = New System.Drawing.Size(528, 200)
        Me.Panel2.TabIndex = 18
        '
        'Button3
        '
        Me.Button3.FlatStyle = System.Windows.Forms.FlatStyle.Popup
        Me.Button3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Button3.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.Button3.Location = New System.Drawing.Point(6, 26)
        Me.Button3.Name = "Button3"
        Me.Button3.Size = New System.Drawing.Size(107, 22)
        Me.Button3.TabIndex = 22
        Me.Button3.Text = "1. Tipo Incidencia"
        Me.Button3.UseVisualStyleBackColor = True
        '
        'Button5
        '
        Me.Button5.FlatStyle = System.Windows.Forms.FlatStyle.Popup
        Me.Button5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Button5.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.Button5.Location = New System.Drawing.Point(6, 107)
        Me.Button5.Name = "Button5"
        Me.Button5.Size = New System.Drawing.Size(107, 22)
        Me.Button5.TabIndex = 21
        Me.Button5.Text = "3. Tipo de caso"
        Me.Button5.UseVisualStyleBackColor = True
        '
        'Button4
        '
        Me.Button4.FlatStyle = System.Windows.Forms.FlatStyle.Popup
        Me.Button4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Button4.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.Button4.Location = New System.Drawing.Point(6, 79)
        Me.Button4.Name = "Button4"
        Me.Button4.Size = New System.Drawing.Size(107, 22)
        Me.Button4.TabIndex = 20
        Me.Button4.Text = "2. Tipo servicio"
        Me.Button4.UseVisualStyleBackColor = True
        '
        'ddl_tipo_servicio
        '
        Me.ddl_tipo_servicio.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.ddl_tipo_servicio.FormattingEnabled = True
        Me.ddl_tipo_servicio.Items.AddRange(New Object() {"Acceso Dedicado a Internet", "Cable"})
        Me.ddl_tipo_servicio.Location = New System.Drawing.Point(123, 80)
        Me.ddl_tipo_servicio.Name = "ddl_tipo_servicio"
        Me.ddl_tipo_servicio.Size = New System.Drawing.Size(204, 21)
        Me.ddl_tipo_servicio.TabIndex = 19
        '
        'txt_f_declarada
        '
        Me.txt_f_declarada.Location = New System.Drawing.Point(123, 161)
        Me.txt_f_declarada.Name = "txt_f_declarada"
        Me.txt_f_declarada.Size = New System.Drawing.Size(113, 20)
        Me.txt_f_declarada.TabIndex = 16
        '
        'txt_tipo_atencion
        '
        Me.txt_tipo_atencion.Location = New System.Drawing.Point(123, 135)
        Me.txt_tipo_atencion.Name = "txt_tipo_atencion"
        Me.txt_tipo_atencion.Size = New System.Drawing.Size(204, 20)
        Me.txt_tipo_atencion.TabIndex = 15
        '
        'txt_tipo_caso
        '
        Me.txt_tipo_caso.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.txt_tipo_caso.Location = New System.Drawing.Point(123, 109)
        Me.txt_tipo_caso.Name = "txt_tipo_caso"
        Me.txt_tipo_caso.Size = New System.Drawing.Size(302, 20)
        Me.txt_tipo_caso.TabIndex = 14
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label8.Location = New System.Drawing.Point(3, 8)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(46, 13)
        Me.Label8.TabIndex = 9
        Me.Label8.Text = "Estado"
        '
        'txt_estado
        '
        Me.txt_estado.Location = New System.Drawing.Point(123, 6)
        Me.txt_estado.Name = "txt_estado"
        Me.txt_estado.Size = New System.Drawing.Size(203, 20)
        Me.txt_estado.TabIndex = 2
        '
        'txt_tipo_incidencia
        '
        Me.txt_tipo_incidencia.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.txt_tipo_incidencia.Location = New System.Drawing.Point(123, 27)
        Me.txt_tipo_incidencia.Name = "txt_tipo_incidencia"
        Me.txt_tipo_incidencia.Size = New System.Drawing.Size(204, 20)
        Me.txt_tipo_incidencia.TabIndex = 12
        '
        'Label10
        '
        Me.Label10.AutoSize = True
        Me.Label10.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label10.Location = New System.Drawing.Point(3, 57)
        Me.Label10.Name = "Label10"
        Me.Label10.Size = New System.Drawing.Size(85, 13)
        Me.Label10.TabIndex = 7
        Me.Label10.Text = "Canal Ingreso"
        '
        'Label12
        '
        Me.Label12.AutoSize = True
        Me.Label12.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label12.Location = New System.Drawing.Point(3, 158)
        Me.Label12.Name = "Label12"
        Me.Label12.Size = New System.Drawing.Size(78, 13)
        Me.Label12.TabIndex = 5
        Me.Label12.Text = "F. declarada"
        '
        'Label13
        '
        Me.Label13.AutoSize = True
        Me.Label13.Location = New System.Drawing.Point(3, 136)
        Me.Label13.Name = "Label13"
        Me.Label13.Size = New System.Drawing.Size(72, 13)
        Me.Label13.TabIndex = 1
        Me.Label13.Text = "Tipo atencion"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(3, 8)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(90, 13)
        Me.Label2.TabIndex = 9
        Me.Label2.Text = "Incidencia Padre:"
        '
        'Panel3
        '
        Me.Panel3.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.Panel3.Controls.Add(Me.CheckBox4)
        Me.Panel3.Controls.Add(Me.Label2)
        Me.Panel3.Location = New System.Drawing.Point(775, 1)
        Me.Panel3.Name = "Panel3"
        Me.Panel3.Size = New System.Drawing.Size(142, 39)
        Me.Panel3.TabIndex = 18
        '
        'dg_generacion_incidencias
        '
        Me.dg_generacion_incidencias.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dg_generacion_incidencias.Location = New System.Drawing.Point(4, 3)
        Me.dg_generacion_incidencias.Name = "dg_generacion_incidencias"
        DataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]
        Me.dg_generacion_incidencias.RowsDefaultCellStyle = DataGridViewCellStyle1
        Me.dg_generacion_incidencias.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect
        Me.dg_generacion_incidencias.Size = New System.Drawing.Size(1086, 234)
        Me.dg_generacion_incidencias.TabIndex = 3
        '
        'Tab_control
        '
        Me.Tab_control.Appearance = System.Windows.Forms.TabAppearance.Buttons
        Me.Tab_control.Controls.Add(Me.primer_tab)
        Me.Tab_control.Controls.Add(Me.segundo_tab)
        Me.Tab_control.Controls.Add(Me.tercer_tab)
        Me.Tab_control.Controls.Add(Me.cuarto_tab)
        Me.Tab_control.Controls.Add(Me.quinto_tab)
        Me.Tab_control.Controls.Add(Me.sexto_tab)
        Me.Tab_control.Controls.Add(Me.TabPage1)
        Me.Tab_control.ItemSize = New System.Drawing.Size(183, 21)
        Me.Tab_control.Location = New System.Drawing.Point(1, 207)
        Me.Tab_control.Name = "Tab_control"
        Me.Tab_control.SelectedIndex = 0
        Me.Tab_control.Size = New System.Drawing.Size(1308, 278)
        Me.Tab_control.SizeMode = System.Windows.Forms.TabSizeMode.Fixed
        Me.Tab_control.TabIndex = 19
        '
        'primer_tab
        '
        Me.primer_tab.Controls.Add(Me.dg_generacion_incidencias)
        Me.primer_tab.Location = New System.Drawing.Point(4, 25)
        Me.primer_tab.Name = "primer_tab"
        Me.primer_tab.Padding = New System.Windows.Forms.Padding(3)
        Me.primer_tab.Size = New System.Drawing.Size(1300, 249)
        Me.primer_tab.TabIndex = 0
        Me.primer_tab.Text = "Clientes"
        Me.primer_tab.UseVisualStyleBackColor = True
        '
        'segundo_tab
        '
        Me.segundo_tab.Controls.Add(Me.CheckBox3)
        Me.segundo_tab.Controls.Add(Me.CheckBox2)
        Me.segundo_tab.Controls.Add(Me.CheckBox1)
        Me.segundo_tab.Controls.Add(Me.btnLauchIncidencia)
        Me.segundo_tab.Controls.Add(Me.txt_asesor_derivacion)
        Me.segundo_tab.Controls.Add(Me.txt_derivacion)
        Me.segundo_tab.Controls.Add(Me.txt_contacto)
        Me.segundo_tab.Controls.Add(Me.txt_cliente)
        Me.segundo_tab.Controls.Add(Me.txt_segmento_negocio)
        Me.segundo_tab.Controls.Add(Me.txt_contacto_cliente)
        Me.segundo_tab.Controls.Add(Me.txt_codigo_cliente)
        Me.segundo_tab.Controls.Add(Me.Label15)
        Me.segundo_tab.Controls.Add(Me.Label14)
        Me.segundo_tab.Controls.Add(Me.Label11)
        Me.segundo_tab.Controls.Add(Me.Button6)
        Me.segundo_tab.Controls.Add(Me.Label9)
        Me.segundo_tab.Controls.Add(Me.txt_observaciones)
        Me.segundo_tab.Location = New System.Drawing.Point(4, 25)
        Me.segundo_tab.Name = "segundo_tab"
        Me.segundo_tab.Padding = New System.Windows.Forms.Padding(3)
        Me.segundo_tab.Size = New System.Drawing.Size(1300, 249)
        Me.segundo_tab.TabIndex = 1
        Me.segundo_tab.Text = "Contactos / Derivación"
        Me.segundo_tab.UseVisualStyleBackColor = True
        '
        'CheckBox3
        '
        Me.CheckBox3.AutoSize = True
        Me.CheckBox3.Location = New System.Drawing.Point(283, 208)
        Me.CheckBox3.Name = "CheckBox3"
        Me.CheckBox3.Size = New System.Drawing.Size(117, 17)
        Me.CheckBox3.TabIndex = 32
        Me.CheckBox3.Text = "Notificar Incidencia"
        Me.CheckBox3.UseVisualStyleBackColor = True
        '
        'CheckBox2
        '
        Me.CheckBox2.AutoSize = True
        Me.CheckBox2.Location = New System.Drawing.Point(142, 208)
        Me.CheckBox2.Name = "CheckBox2"
        Me.CheckBox2.Size = New System.Drawing.Size(118, 17)
        Me.CheckBox2.TabIndex = 31
        Me.CheckBox2.Text = "Notificar Supervisor"
        Me.CheckBox2.UseVisualStyleBackColor = True
        '
        'CheckBox1
        '
        Me.CheckBox1.AutoSize = True
        Me.CheckBox1.Location = New System.Drawing.Point(22, 208)
        Me.CheckBox1.Name = "CheckBox1"
        Me.CheckBox1.Size = New System.Drawing.Size(65, 17)
        Me.CheckBox1.TabIndex = 30
        Me.CheckBox1.Text = "Notificar"
        Me.CheckBox1.UseVisualStyleBackColor = True
        '
        'btnLauchIncidencia
        '
        Me.btnLauchIncidencia.Location = New System.Drawing.Point(506, 177)
        Me.btnLauchIncidencia.Name = "btnLauchIncidencia"
        Me.btnLauchIncidencia.Size = New System.Drawing.Size(23, 23)
        Me.btnLauchIncidencia.TabIndex = 29
        Me.btnLauchIncidencia.Text = "--"
        Me.btnLauchIncidencia.UseVisualStyleBackColor = True
        '
        'txt_asesor_derivacion
        '
        Me.txt_asesor_derivacion.Location = New System.Drawing.Point(374, 182)
        Me.txt_asesor_derivacion.Name = "txt_asesor_derivacion"
        Me.txt_asesor_derivacion.Size = New System.Drawing.Size(126, 20)
        Me.txt_asesor_derivacion.TabIndex = 28
        '
        'txt_derivacion
        '
        Me.txt_derivacion.Location = New System.Drawing.Point(85, 182)
        Me.txt_derivacion.Name = "txt_derivacion"
        Me.txt_derivacion.Size = New System.Drawing.Size(283, 20)
        Me.txt_derivacion.TabIndex = 27
        '
        'txt_contacto
        '
        Me.txt_contacto.Location = New System.Drawing.Point(196, 30)
        Me.txt_contacto.Name = "txt_contacto"
        Me.txt_contacto.Size = New System.Drawing.Size(304, 20)
        Me.txt_contacto.TabIndex = 26
        '
        'txt_cliente
        '
        Me.txt_cliente.Location = New System.Drawing.Point(196, 8)
        Me.txt_cliente.Name = "txt_cliente"
        Me.txt_cliente.Size = New System.Drawing.Size(304, 20)
        Me.txt_cliente.TabIndex = 25
        '
        'txt_segmento_negocio
        '
        Me.txt_segmento_negocio.Location = New System.Drawing.Point(135, 56)
        Me.txt_segmento_negocio.Name = "txt_segmento_negocio"
        Me.txt_segmento_negocio.Size = New System.Drawing.Size(365, 20)
        Me.txt_segmento_negocio.TabIndex = 24
        '
        'txt_contacto_cliente
        '
        Me.txt_contacto_cliente.Location = New System.Drawing.Point(85, 29)
        Me.txt_contacto_cliente.Name = "txt_contacto_cliente"
        Me.txt_contacto_cliente.Size = New System.Drawing.Size(100, 20)
        Me.txt_contacto_cliente.TabIndex = 23
        '
        'txt_codigo_cliente
        '
        Me.txt_codigo_cliente.Location = New System.Drawing.Point(85, 8)
        Me.txt_codigo_cliente.Name = "txt_codigo_cliente"
        Me.txt_codigo_cliente.Size = New System.Drawing.Size(100, 20)
        Me.txt_codigo_cliente.TabIndex = 22
        '
        'Label15
        '
        Me.Label15.AutoSize = True
        Me.Label15.Location = New System.Drawing.Point(19, 182)
        Me.Label15.Name = "Label15"
        Me.Label15.Size = New System.Drawing.Size(58, 13)
        Me.Label15.TabIndex = 21
        Me.Label15.Text = "Derivación"
        '
        'Label14
        '
        Me.Label14.AutoSize = True
        Me.Label14.Location = New System.Drawing.Point(14, 58)
        Me.Label14.Name = "Label14"
        Me.Label14.Size = New System.Drawing.Size(115, 13)
        Me.Label14.TabIndex = 20
        Me.Label14.Text = "Segmento del Negocio"
        '
        'Label11
        '
        Me.Label11.AutoSize = True
        Me.Label11.Location = New System.Drawing.Point(14, 30)
        Me.Label11.Name = "Label11"
        Me.Label11.Size = New System.Drawing.Size(50, 13)
        Me.Label11.TabIndex = 19
        Me.Label11.Text = "Contacto"
        '
        'Button6
        '
        Me.Button6.Location = New System.Drawing.Point(506, 53)
        Me.Button6.Name = "Button6"
        Me.Button6.Size = New System.Drawing.Size(23, 23)
        Me.Button6.TabIndex = 18
        Me.Button6.Text = "--"
        Me.Button6.UseVisualStyleBackColor = True
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Location = New System.Drawing.Point(15, 8)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(39, 13)
        Me.Label9.TabIndex = 16
        Me.Label9.Text = "Cliente"
        '
        'txt_observaciones
        '
        Me.txt_observaciones.Location = New System.Drawing.Point(17, 81)
        Me.txt_observaciones.Multiline = True
        Me.txt_observaciones.Name = "txt_observaciones"
        Me.txt_observaciones.Size = New System.Drawing.Size(483, 95)
        Me.txt_observaciones.TabIndex = 15
        '
        'tercer_tab
        '
        Me.tercer_tab.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.tercer_tab.Location = New System.Drawing.Point(4, 25)
        Me.tercer_tab.Name = "tercer_tab"
        Me.tercer_tab.Size = New System.Drawing.Size(1300, 249)
        Me.tercer_tab.TabIndex = 2
        Me.tercer_tab.Text = "Documentos relacionados"
        Me.tercer_tab.UseVisualStyleBackColor = True
        '
        'cuarto_tab
        '
        Me.cuarto_tab.Location = New System.Drawing.Point(4, 25)
        Me.cuarto_tab.Name = "cuarto_tab"
        Me.cuarto_tab.Size = New System.Drawing.Size(1300, 249)
        Me.cuarto_tab.TabIndex = 3
        Me.cuarto_tab.Text = "Datos Cancelamiento"
        Me.cuarto_tab.UseVisualStyleBackColor = True
        '
        'quinto_tab
        '
        Me.quinto_tab.Location = New System.Drawing.Point(4, 25)
        Me.quinto_tab.Name = "quinto_tab"
        Me.quinto_tab.Size = New System.Drawing.Size(1300, 249)
        Me.quinto_tab.TabIndex = 4
        Me.quinto_tab.Text = "Voucher Descargo"
        Me.quinto_tab.UseVisualStyleBackColor = True
        '
        'sexto_tab
        '
        Me.sexto_tab.Location = New System.Drawing.Point(4, 25)
        Me.sexto_tab.Name = "sexto_tab"
        Me.sexto_tab.Size = New System.Drawing.Size(1300, 249)
        Me.sexto_tab.TabIndex = 5
        Me.sexto_tab.Text = "CDRs"
        Me.sexto_tab.UseVisualStyleBackColor = True
        '
        'Panel4
        '
        Me.Panel4.Controls.Add(Me.Label16)
        Me.Panel4.Controls.Add(Me.Panel5)
        Me.Panel4.Location = New System.Drawing.Point(950, 209)
        Me.Panel4.Name = "Panel4"
        Me.Panel4.Size = New System.Drawing.Size(143, 16)
        Me.Panel4.TabIndex = 0
        '
        'Label16
        '
        Me.Label16.AutoSize = True
        Me.Label16.ForeColor = System.Drawing.SystemColors.ControlDark
        Me.Label16.Location = New System.Drawing.Point(55, 1)
        Me.Label16.Name = "Label16"
        Me.Label16.Size = New System.Drawing.Size(35, 13)
        Me.Label16.TabIndex = 3
        Me.Label16.Text = "CDRs"
        '
        'Panel5
        '
        Me.Panel5.Location = New System.Drawing.Point(192, 1)
        Me.Panel5.Name = "Panel5"
        Me.Panel5.Size = New System.Drawing.Size(93, 24)
        Me.Panel5.TabIndex = 1
        '
        'txt_codigo5_incidencia
        '
        Me.txt_codigo5_incidencia.Location = New System.Drawing.Point(777, 105)
        Me.txt_codigo5_incidencia.Name = "txt_codigo5_incidencia"
        Me.txt_codigo5_incidencia.Size = New System.Drawing.Size(138, 20)
        Me.txt_codigo5_incidencia.TabIndex = 20
        Me.txt_codigo5_incidencia.Visible = False
        '
        'txt_usuario_ingresado
        '
        Me.txt_usuario_ingresado.Location = New System.Drawing.Point(935, 105)
        Me.txt_usuario_ingresado.Name = "txt_usuario_ingresado"
        Me.txt_usuario_ingresado.Size = New System.Drawing.Size(138, 20)
        Me.txt_usuario_ingresado.TabIndex = 21
        Me.txt_usuario_ingresado.Visible = False
        '
        'txt_nombre_ingresado
        '
        Me.txt_nombre_ingresado.Location = New System.Drawing.Point(935, 144)
        Me.txt_nombre_ingresado.Name = "txt_nombre_ingresado"
        Me.txt_nombre_ingresado.Size = New System.Drawing.Size(138, 20)
        Me.txt_nombre_ingresado.TabIndex = 22
        Me.txt_nombre_ingresado.Visible = False
        '
        'txt_cid_generado
        '
        Me.txt_cid_generado.Location = New System.Drawing.Point(778, 148)
        Me.txt_cid_generado.Name = "txt_cid_generado"
        Me.txt_cid_generado.Size = New System.Drawing.Size(138, 20)
        Me.txt_cid_generado.TabIndex = 23
        Me.txt_cid_generado.Visible = False
        '
        'txt_producto_contratado
        '
        Me.txt_producto_contratado.Location = New System.Drawing.Point(1104, 105)
        Me.txt_producto_contratado.Name = "txt_producto_contratado"
        Me.txt_producto_contratado.Size = New System.Drawing.Size(138, 20)
        Me.txt_producto_contratado.TabIndex = 24
        Me.txt_producto_contratado.Visible = False
        '
        'TabPage1
        '
        Me.TabPage1.Location = New System.Drawing.Point(4, 25)
        Me.TabPage1.Name = "TabPage1"
        Me.TabPage1.Size = New System.Drawing.Size(1300, 249)
        Me.TabPage1.TabIndex = 6
        Me.TabPage1.Text = "Conceptos Reclamados en Formulario"
        Me.TabPage1.UseVisualStyleBackColor = True
        '
        'CheckBox4
        '
        Me.CheckBox4.AutoSize = True
        Me.CheckBox4.Location = New System.Drawing.Point(108, 11)
        Me.CheckBox4.Name = "CheckBox4"
        Me.CheckBox4.Size = New System.Drawing.Size(15, 14)
        Me.CheckBox4.TabIndex = 10
        Me.CheckBox4.UseVisualStyleBackColor = True
        '
        'Frm_Generar_incidencia
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(1321, 491)
        Me.Controls.Add(Me.txt_producto_contratado)
        Me.Controls.Add(Me.txt_cid_generado)
        Me.Controls.Add(Me.txt_nombre_ingresado)
        Me.Controls.Add(Me.txt_usuario_ingresado)
        Me.Controls.Add(Me.txt_codigo5_incidencia)
        Me.Controls.Add(Me.Panel4)
        Me.Controls.Add(Me.Tab_control)
        Me.Controls.Add(Me.Panel3)
        Me.Controls.Add(Me.Panel2)
        Me.Controls.Add(Me.Panel1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "Frm_Generar_incidencia"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Generación de Incidencias"
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.Panel2.ResumeLayout(False)
        Me.Panel2.PerformLayout()
        Me.Panel3.ResumeLayout(False)
        Me.Panel3.PerformLayout()
        CType(Me.dg_generacion_incidencias, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Tab_control.ResumeLayout(False)
        Me.primer_tab.ResumeLayout(False)
        Me.segundo_tab.ResumeLayout(False)
        Me.segundo_tab.PerformLayout()
        Me.Panel4.ResumeLayout(False)
        Me.Panel4.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents txt_incidencia As System.Windows.Forms.TextBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents txt_f_registro As System.Windows.Forms.TextBox
    Friend WithEvents ddl_canal_ingreso As System.Windows.Forms.ComboBox
    Friend WithEvents Panel1 As System.Windows.Forms.Panel
    Friend WithEvents Button2 As System.Windows.Forms.Button
    Friend WithEvents txt_prioridad As System.Windows.Forms.TextBox
    Friend WithEvents txt_ticket As System.Windows.Forms.TextBox
    Friend WithEvents txt_rep_atc As System.Windows.Forms.TextBox
    Friend WithEvents txt_usuario As System.Windows.Forms.TextBox
    Friend WithEvents Panel2 As System.Windows.Forms.Panel
    Friend WithEvents Button5 As System.Windows.Forms.Button
    Friend WithEvents Button4 As System.Windows.Forms.Button
    Friend WithEvents ddl_tipo_servicio As System.Windows.Forms.ComboBox
    Friend WithEvents txt_f_declarada As System.Windows.Forms.TextBox
    Friend WithEvents txt_tipo_atencion As System.Windows.Forms.TextBox
    Friend WithEvents txt_tipo_caso As System.Windows.Forms.TextBox
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents txt_estado As System.Windows.Forms.TextBox
    Friend WithEvents txt_tipo_incidencia As System.Windows.Forms.TextBox
    Friend WithEvents Label10 As System.Windows.Forms.Label
    Friend WithEvents Label12 As System.Windows.Forms.Label
    Friend WithEvents Label13 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Panel3 As System.Windows.Forms.Panel
    Friend WithEvents dg_generacion_incidencias As System.Windows.Forms.DataGridView
    Friend WithEvents Tab_control As System.Windows.Forms.TabControl
    Friend WithEvents primer_tab As System.Windows.Forms.TabPage
    Friend WithEvents segundo_tab As System.Windows.Forms.TabPage
    Friend WithEvents tercer_tab As System.Windows.Forms.TabPage
    Friend WithEvents cuarto_tab As System.Windows.Forms.TabPage
    Friend WithEvents quinto_tab As System.Windows.Forms.TabPage
    Friend WithEvents sexto_tab As System.Windows.Forms.TabPage
    Friend WithEvents Button3 As System.Windows.Forms.Button
    Friend WithEvents txt_contacto As System.Windows.Forms.TextBox
    Friend WithEvents txt_cliente As System.Windows.Forms.TextBox
    Friend WithEvents txt_segmento_negocio As System.Windows.Forms.TextBox
    Friend WithEvents txt_contacto_cliente As System.Windows.Forms.TextBox
    Friend WithEvents txt_codigo_cliente As System.Windows.Forms.TextBox
    Friend WithEvents Label15 As System.Windows.Forms.Label
    Friend WithEvents Label14 As System.Windows.Forms.Label
    Friend WithEvents Label11 As System.Windows.Forms.Label
    Friend WithEvents Button6 As System.Windows.Forms.Button
    Friend WithEvents Label9 As System.Windows.Forms.Label
    Friend WithEvents txt_observaciones As System.Windows.Forms.TextBox
    Friend WithEvents btnLauchIncidencia As System.Windows.Forms.Button
    Friend WithEvents txt_asesor_derivacion As System.Windows.Forms.TextBox
    Friend WithEvents txt_derivacion As System.Windows.Forms.TextBox
    Friend WithEvents CheckBox2 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox1 As System.Windows.Forms.CheckBox
    Friend WithEvents Panel4 As System.Windows.Forms.Panel
    Friend WithEvents Panel5 As System.Windows.Forms.Panel
    Friend WithEvents txt_codigo5_incidencia As System.Windows.Forms.TextBox
    Friend WithEvents Label16 As System.Windows.Forms.Label
    Friend WithEvents txt_usuario_ingresado As System.Windows.Forms.TextBox
    Friend WithEvents txt_nombre_ingresado As System.Windows.Forms.TextBox
    Friend WithEvents txt_cid_generado As System.Windows.Forms.TextBox
    Friend WithEvents txt_producto_contratado As System.Windows.Forms.TextBox
    Friend WithEvents CheckBox3 As System.Windows.Forms.CheckBox
    Friend WithEvents TabPage1 As System.Windows.Forms.TabPage
    Friend WithEvents CheckBox4 As System.Windows.Forms.CheckBox
End Class
