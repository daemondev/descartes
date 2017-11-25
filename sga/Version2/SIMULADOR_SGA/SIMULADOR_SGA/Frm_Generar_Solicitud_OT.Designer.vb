<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Frm_Generar_Solicitud_OT
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Frm_Generar_Solicitud_OT))
        Me.CheckBox1 = New System.Windows.Forms.CheckBox()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.TextBox1 = New System.Windows.Forms.TextBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.txt_incidencia_sot = New System.Windows.Forms.TextBox()
        Me.txt_observaciones_sot = New System.Windows.Forms.TextBox()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.TextBox4 = New System.Windows.Forms.TextBox()
        Me.txt_codigo_cliente_sot = New System.Windows.Forms.TextBox()
        Me.txt_nom_cliente_sot = New System.Windows.Forms.TextBox()
        Me.ddl_motivo_sot = New System.Windows.Forms.ComboBox()
        Me.txt_fecha_comp = New System.Windows.Forms.TextBox()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.Label10 = New System.Windows.Forms.Label()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.TextBox10 = New System.Windows.Forms.TextBox()
        Me.TextBox9 = New System.Windows.Forms.TextBox()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.MonthCalendar1 = New System.Windows.Forms.MonthCalendar()
        Me.ddl_tipo_trabajo_sot = New System.Windows.Forms.ComboBox()
        Me.CheckBox2 = New System.Windows.Forms.CheckBox()
        Me.CheckBox3 = New System.Windows.Forms.CheckBox()
        Me.CheckBox4 = New System.Windows.Forms.CheckBox()
        Me.CheckBox5 = New System.Windows.Forms.CheckBox()
        Me.CheckBox6 = New System.Windows.Forms.CheckBox()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.CheckBox10 = New System.Windows.Forms.CheckBox()
        Me.CheckBox9 = New System.Windows.Forms.CheckBox()
        Me.CheckBox8 = New System.Windows.Forms.CheckBox()
        Me.CheckBox7 = New System.Windows.Forms.CheckBox()
        Me.txt_area = New System.Windows.Forms.TextBox()
        Me.txt_direccion_sot = New System.Windows.Forms.TextBox()
        Me.txt_distrito_sot = New System.Windows.Forms.TextBox()
        Me.txt_tipo_servicio_sot = New System.Windows.Forms.TextBox()
        Me.txt_solicitante_sot = New System.Windows.Forms.TextBox()
        Me.txt_num_solicitud_sot = New System.Windows.Forms.TextBox()
        Me.txt_dni_sot = New System.Windows.Forms.TextBox()
        Me.GroupBox1.SuspendLayout()
        Me.Panel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'CheckBox1
        '
        Me.CheckBox1.AutoSize = True
        Me.CheckBox1.Location = New System.Drawing.Point(23, 3)
        Me.CheckBox1.Name = "CheckBox1"
        Me.CheckBox1.Size = New System.Drawing.Size(53, 17)
        Me.CheckBox1.TabIndex = 0
        Me.CheckBox1.Text = "09:00"
        Me.CheckBox1.UseVisualStyleBackColor = True
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(164, 429)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(97, 35)
        Me.Button1.TabIndex = 1
        Me.Button1.Text = "Generar SOT"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 180)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(70, 13)
        Me.Label1.TabIndex = 2
        Me.Label1.Text = "Fecha Comp:"
        '
        'TextBox1
        '
        Me.TextBox1.Location = New System.Drawing.Point(101, 205)
        Me.TextBox1.Name = "TextBox1"
        Me.TextBox1.Size = New System.Drawing.Size(329, 20)
        Me.TextBox1.TabIndex = 3
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(12, 9)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(68, 13)
        Me.Label2.TabIndex = 10
        Me.Label2.Text = "N°Incidencia"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(12, 31)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(39, 13)
        Me.Label3.TabIndex = 11
        Me.Label3.Text = "Cliente"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(12, 56)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(66, 13)
        Me.Label4.TabIndex = 12
        Me.Label4.Text = "Tipo trabajo:"
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(12, 85)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(42, 13)
        Me.Label5.TabIndex = 13
        Me.Label5.Text = "Motivo:"
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(12, 110)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(81, 13)
        Me.Label6.TabIndex = 14
        Me.Label6.Text = "Observaciones:"
        '
        'txt_incidencia_sot
        '
        Me.txt_incidencia_sot.BackColor = System.Drawing.SystemColors.Control
        Me.txt_incidencia_sot.Enabled = False
        Me.txt_incidencia_sot.Location = New System.Drawing.Point(101, 9)
        Me.txt_incidencia_sot.Name = "txt_incidencia_sot"
        Me.txt_incidencia_sot.Size = New System.Drawing.Size(114, 20)
        Me.txt_incidencia_sot.TabIndex = 15
        '
        'txt_observaciones_sot
        '
        Me.txt_observaciones_sot.Location = New System.Drawing.Point(101, 106)
        Me.txt_observaciones_sot.Multiline = True
        Me.txt_observaciones_sot.Name = "txt_observaciones_sot"
        Me.txt_observaciones_sot.Size = New System.Drawing.Size(329, 74)
        Me.txt_observaciones_sot.TabIndex = 16
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(12, 210)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(55, 13)
        Me.Label7.TabIndex = 17
        Me.Label7.Text = "Plano(F9):"
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Location = New System.Drawing.Point(228, 12)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(82, 13)
        Me.Label8.TabIndex = 18
        Me.Label8.Text = "SOT Generado:"
        '
        'TextBox4
        '
        Me.TextBox4.BackColor = System.Drawing.SystemColors.Control
        Me.TextBox4.Location = New System.Drawing.Point(316, 9)
        Me.TextBox4.Name = "TextBox4"
        Me.TextBox4.Size = New System.Drawing.Size(114, 20)
        Me.TextBox4.TabIndex = 19
        '
        'txt_codigo_cliente_sot
        '
        Me.txt_codigo_cliente_sot.BackColor = System.Drawing.SystemColors.Control
        Me.txt_codigo_cliente_sot.Location = New System.Drawing.Point(101, 33)
        Me.txt_codigo_cliente_sot.Name = "txt_codigo_cliente_sot"
        Me.txt_codigo_cliente_sot.Size = New System.Drawing.Size(76, 20)
        Me.txt_codigo_cliente_sot.TabIndex = 20
        '
        'txt_nom_cliente_sot
        '
        Me.txt_nom_cliente_sot.BackColor = System.Drawing.SystemColors.Control
        Me.txt_nom_cliente_sot.Location = New System.Drawing.Point(183, 33)
        Me.txt_nom_cliente_sot.Name = "txt_nom_cliente_sot"
        Me.txt_nom_cliente_sot.Size = New System.Drawing.Size(250, 20)
        Me.txt_nom_cliente_sot.TabIndex = 21
        '
        'ddl_motivo_sot
        '
        Me.ddl_motivo_sot.FormattingEnabled = True
        Me.ddl_motivo_sot.Items.AddRange(New Object() {"TEL - SERIE TELEFONICA NO APERTURADA", "TEL - SERIE TELEFONICA NO REGISTRADA", "TEL - SIN SERVICIO -DA TONO DE OCUPADO", "TEL - SIN SERVICIO -NO DA TONO", "TEL - SOLICITUD DE CARRIER RELATIONS", "INT - CAMBIO DE CABLE WEP KEY", "INT - ENLACE INTERMITENTE", "INT - ENLACE LENTE", "INT - NO LLEGA A DETERMINADAS PAGINAS WEB", "INT - PROBLEMA DE INTERCONEXIÓN", "INT - PROBLEMA WIFI", "INT - PROBLEMAS CON LA SALIDA A INTERNET", "INT - PROBLEMAS DE COBERTURA WIFI", "INT - PROBLEMAS DE CORREO", "INT - ROUTER CON PROBLEMAS", "INT - SIN SERVICIO", "CATV - DECOS DESHABILITADOS", "CATV - IMAGEN CONGELADA", "CATV - IMAGEN LLUVIOSA O PIXELEADA", "CATV - IMAGEN SOBREPUESTA", "CATV - MALA SEÑAL", "CATV - NO VISUALIZA ALGUNOS CANALES", "CATV - PANTALLA NEGRA", "CATV - PROBLEMAS CON CANALES NACIONALES", "CATV - PROBLEMAS CON DECODIFICADOR", "CATV - SIN SERVICIO"})
        Me.ddl_motivo_sot.Location = New System.Drawing.Point(101, 81)
        Me.ddl_motivo_sot.Name = "ddl_motivo_sot"
        Me.ddl_motivo_sot.Size = New System.Drawing.Size(329, 21)
        Me.ddl_motivo_sot.TabIndex = 23
        '
        'txt_fecha_comp
        '
        Me.txt_fecha_comp.Location = New System.Drawing.Point(101, 183)
        Me.txt_fecha_comp.Name = "txt_fecha_comp"
        Me.txt_fecha_comp.Size = New System.Drawing.Size(329, 20)
        Me.txt_fecha_comp.TabIndex = 24
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.Label10)
        Me.GroupBox1.Controls.Add(Me.Label9)
        Me.GroupBox1.Controls.Add(Me.TextBox10)
        Me.GroupBox1.Controls.Add(Me.TextBox9)
        Me.GroupBox1.Location = New System.Drawing.Point(413, 238)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(132, 83)
        Me.GroupBox1.TabIndex = 25
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Leyenda de Horario"
        '
        'Label10
        '
        Me.Label10.AutoSize = True
        Me.Label10.Location = New System.Drawing.Point(47, 51)
        Me.Label10.Name = "Label10"
        Me.Label10.Size = New System.Drawing.Size(76, 13)
        Me.Label10.TabIndex = 29
        Me.Label10.Text = "No disponibles"
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Location = New System.Drawing.Point(47, 25)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(56, 13)
        Me.Label9.TabIndex = 27
        Me.Label9.Text = "Disponible"
        '
        'TextBox10
        '
        Me.TextBox10.BackColor = System.Drawing.Color.Red
        Me.TextBox10.Location = New System.Drawing.Point(6, 48)
        Me.TextBox10.Name = "TextBox10"
        Me.TextBox10.Size = New System.Drawing.Size(35, 20)
        Me.TextBox10.TabIndex = 28
        '
        'TextBox9
        '
        Me.TextBox9.Location = New System.Drawing.Point(6, 22)
        Me.TextBox9.Name = "TextBox9"
        Me.TextBox9.Size = New System.Drawing.Size(35, 20)
        Me.TextBox9.TabIndex = 27
        '
        'Button2
        '
        Me.Button2.Location = New System.Drawing.Point(267, 429)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(97, 35)
        Me.Button2.TabIndex = 26
        Me.Button2.Text = "Cancelar"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'MonthCalendar1
        '
        Me.MonthCalendar1.Location = New System.Drawing.Point(5, 238)
        Me.MonthCalendar1.Name = "MonthCalendar1"
        Me.MonthCalendar1.TabIndex = 27
        '
        'ddl_tipo_trabajo_sot
        '
        Me.ddl_tipo_trabajo_sot.FormattingEnabled = True
        Me.ddl_tipo_trabajo_sot.Items.AddRange(New Object() {"WMAX-MANTENIMIENTO CLARO EMPRESAS", "HFC - RECLAMO MASIVO", "HFC - BAJA TOTAL DE SERVICIO", "HFC - BAJA TOTAL CLARO TOTAL", "HFC - MANTENIMIENTO", "HFC - RETENCION", "HFC - MANTENIMIENTO PREVENTIVO", "HFC - MANTENIMIENTO CLARO EMPRESAS", "CLARO CORP - VISITA DE INSPECCIÓN", "CLARO CORP - MANTENIMIENTO PREVENTIVO", "HFC - MANTENIMIENTO BABY SITTING"})
        Me.ddl_tipo_trabajo_sot.Location = New System.Drawing.Point(101, 55)
        Me.ddl_tipo_trabajo_sot.Name = "ddl_tipo_trabajo_sot"
        Me.ddl_tipo_trabajo_sot.Size = New System.Drawing.Size(329, 21)
        Me.ddl_tipo_trabajo_sot.TabIndex = 29
        '
        'CheckBox2
        '
        Me.CheckBox2.AutoSize = True
        Me.CheckBox2.Location = New System.Drawing.Point(23, 22)
        Me.CheckBox2.Name = "CheckBox2"
        Me.CheckBox2.Size = New System.Drawing.Size(53, 17)
        Me.CheckBox2.TabIndex = 30
        Me.CheckBox2.Text = "10:00"
        Me.CheckBox2.UseVisualStyleBackColor = True
        '
        'CheckBox3
        '
        Me.CheckBox3.AutoSize = True
        Me.CheckBox3.Location = New System.Drawing.Point(23, 42)
        Me.CheckBox3.Name = "CheckBox3"
        Me.CheckBox3.Size = New System.Drawing.Size(53, 17)
        Me.CheckBox3.TabIndex = 31
        Me.CheckBox3.Text = "11:00"
        Me.CheckBox3.UseVisualStyleBackColor = True
        '
        'CheckBox4
        '
        Me.CheckBox4.AutoSize = True
        Me.CheckBox4.Location = New System.Drawing.Point(23, 61)
        Me.CheckBox4.Name = "CheckBox4"
        Me.CheckBox4.Size = New System.Drawing.Size(53, 17)
        Me.CheckBox4.TabIndex = 32
        Me.CheckBox4.Text = "12:00"
        Me.CheckBox4.UseVisualStyleBackColor = True
        '
        'CheckBox5
        '
        Me.CheckBox5.AutoSize = True
        Me.CheckBox5.Location = New System.Drawing.Point(23, 80)
        Me.CheckBox5.Name = "CheckBox5"
        Me.CheckBox5.Size = New System.Drawing.Size(53, 17)
        Me.CheckBox5.TabIndex = 33
        Me.CheckBox5.Text = "13:00"
        Me.CheckBox5.UseVisualStyleBackColor = True
        '
        'CheckBox6
        '
        Me.CheckBox6.AutoSize = True
        Me.CheckBox6.Location = New System.Drawing.Point(23, 98)
        Me.CheckBox6.Name = "CheckBox6"
        Me.CheckBox6.Size = New System.Drawing.Size(53, 17)
        Me.CheckBox6.TabIndex = 34
        Me.CheckBox6.Text = "14:00"
        Me.CheckBox6.UseVisualStyleBackColor = True
        '
        'Panel1
        '
        Me.Panel1.BackColor = System.Drawing.Color.White
        Me.Panel1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.Panel1.Controls.Add(Me.CheckBox10)
        Me.Panel1.Controls.Add(Me.CheckBox9)
        Me.Panel1.Controls.Add(Me.CheckBox8)
        Me.Panel1.Controls.Add(Me.CheckBox7)
        Me.Panel1.Controls.Add(Me.CheckBox3)
        Me.Panel1.Controls.Add(Me.CheckBox6)
        Me.Panel1.Controls.Add(Me.CheckBox1)
        Me.Panel1.Controls.Add(Me.CheckBox5)
        Me.Panel1.Controls.Add(Me.CheckBox2)
        Me.Panel1.Controls.Add(Me.CheckBox4)
        Me.Panel1.Location = New System.Drawing.Point(238, 238)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(169, 185)
        Me.Panel1.TabIndex = 35
        '
        'CheckBox10
        '
        Me.CheckBox10.AutoSize = True
        Me.CheckBox10.Location = New System.Drawing.Point(23, 166)
        Me.CheckBox10.Name = "CheckBox10"
        Me.CheckBox10.Size = New System.Drawing.Size(53, 17)
        Me.CheckBox10.TabIndex = 38
        Me.CheckBox10.Text = "18:00"
        Me.CheckBox10.UseVisualStyleBackColor = True
        '
        'CheckBox9
        '
        Me.CheckBox9.AutoSize = True
        Me.CheckBox9.Location = New System.Drawing.Point(23, 114)
        Me.CheckBox9.Name = "CheckBox9"
        Me.CheckBox9.Size = New System.Drawing.Size(53, 17)
        Me.CheckBox9.TabIndex = 37
        Me.CheckBox9.Text = "15:00"
        Me.CheckBox9.UseVisualStyleBackColor = True
        '
        'CheckBox8
        '
        Me.CheckBox8.AutoSize = True
        Me.CheckBox8.Location = New System.Drawing.Point(23, 132)
        Me.CheckBox8.Name = "CheckBox8"
        Me.CheckBox8.Size = New System.Drawing.Size(53, 17)
        Me.CheckBox8.TabIndex = 36
        Me.CheckBox8.Text = "16:00"
        Me.CheckBox8.UseVisualStyleBackColor = True
        '
        'CheckBox7
        '
        Me.CheckBox7.AutoSize = True
        Me.CheckBox7.Location = New System.Drawing.Point(23, 149)
        Me.CheckBox7.Name = "CheckBox7"
        Me.CheckBox7.Size = New System.Drawing.Size(53, 17)
        Me.CheckBox7.TabIndex = 35
        Me.CheckBox7.Text = "17:00"
        Me.CheckBox7.UseVisualStyleBackColor = True
        '
        'txt_area
        '
        Me.txt_area.Location = New System.Drawing.Point(445, 150)
        Me.txt_area.Name = "txt_area"
        Me.txt_area.Size = New System.Drawing.Size(100, 20)
        Me.txt_area.TabIndex = 36
        Me.txt_area.Text = "CUSTOMER CARE"
        Me.txt_area.Visible = False
        '
        'txt_direccion_sot
        '
        Me.txt_direccion_sot.Location = New System.Drawing.Point(445, 46)
        Me.txt_direccion_sot.Name = "txt_direccion_sot"
        Me.txt_direccion_sot.Size = New System.Drawing.Size(100, 20)
        Me.txt_direccion_sot.TabIndex = 37
        Me.txt_direccion_sot.Visible = False
        '
        'txt_distrito_sot
        '
        Me.txt_distrito_sot.Location = New System.Drawing.Point(445, 72)
        Me.txt_distrito_sot.Name = "txt_distrito_sot"
        Me.txt_distrito_sot.Size = New System.Drawing.Size(100, 20)
        Me.txt_distrito_sot.TabIndex = 38
        Me.txt_distrito_sot.Visible = False
        '
        'txt_tipo_servicio_sot
        '
        Me.txt_tipo_servicio_sot.Location = New System.Drawing.Point(445, 98)
        Me.txt_tipo_servicio_sot.Name = "txt_tipo_servicio_sot"
        Me.txt_tipo_servicio_sot.Size = New System.Drawing.Size(100, 20)
        Me.txt_tipo_servicio_sot.TabIndex = 39
        Me.txt_tipo_servicio_sot.Text = "Acceso Dedicado a Internet"
        Me.txt_tipo_servicio_sot.Visible = False
        '
        'txt_solicitante_sot
        '
        Me.txt_solicitante_sot.Location = New System.Drawing.Point(445, 124)
        Me.txt_solicitante_sot.Name = "txt_solicitante_sot"
        Me.txt_solicitante_sot.Size = New System.Drawing.Size(100, 20)
        Me.txt_solicitante_sot.TabIndex = 40
        Me.txt_solicitante_sot.Visible = False
        '
        'txt_num_solicitud_sot
        '
        Me.txt_num_solicitud_sot.Location = New System.Drawing.Point(445, 22)
        Me.txt_num_solicitud_sot.Name = "txt_num_solicitud_sot"
        Me.txt_num_solicitud_sot.Size = New System.Drawing.Size(100, 20)
        Me.txt_num_solicitud_sot.TabIndex = 41
        Me.txt_num_solicitud_sot.Visible = False
        '
        'txt_dni_sot
        '
        Me.txt_dni_sot.Location = New System.Drawing.Point(445, 176)
        Me.txt_dni_sot.Name = "txt_dni_sot"
        Me.txt_dni_sot.Size = New System.Drawing.Size(100, 20)
        Me.txt_dni_sot.TabIndex = 42
        Me.txt_dni_sot.Visible = False
        '
        'Frm_Generar_Solicitud_OT
        '
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None
        Me.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink
        Me.ClientSize = New System.Drawing.Size(551, 468)
        Me.Controls.Add(Me.txt_dni_sot)
        Me.Controls.Add(Me.txt_num_solicitud_sot)
        Me.Controls.Add(Me.txt_solicitante_sot)
        Me.Controls.Add(Me.txt_tipo_servicio_sot)
        Me.Controls.Add(Me.txt_distrito_sot)
        Me.Controls.Add(Me.txt_direccion_sot)
        Me.Controls.Add(Me.txt_area)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.ddl_tipo_trabajo_sot)
        Me.Controls.Add(Me.MonthCalendar1)
        Me.Controls.Add(Me.Button2)
        Me.Controls.Add(Me.GroupBox1)
        Me.Controls.Add(Me.txt_fecha_comp)
        Me.Controls.Add(Me.ddl_motivo_sot)
        Me.Controls.Add(Me.txt_nom_cliente_sot)
        Me.Controls.Add(Me.txt_codigo_cliente_sot)
        Me.Controls.Add(Me.TextBox4)
        Me.Controls.Add(Me.Label8)
        Me.Controls.Add(Me.Label7)
        Me.Controls.Add(Me.txt_observaciones_sot)
        Me.Controls.Add(Me.txt_incidencia_sot)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.TextBox1)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.Button1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "Frm_Generar_Solicitud_OT"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Generar Solicitud de OT"
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents CheckBox1 As System.Windows.Forms.CheckBox
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents TextBox1 As System.Windows.Forms.TextBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents txt_incidencia_sot As System.Windows.Forms.TextBox
    Friend WithEvents txt_observaciones_sot As System.Windows.Forms.TextBox
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents TextBox4 As System.Windows.Forms.TextBox
    Friend WithEvents txt_codigo_cliente_sot As System.Windows.Forms.TextBox
    Friend WithEvents txt_nom_cliente_sot As System.Windows.Forms.TextBox
    Friend WithEvents ddl_motivo_sot As System.Windows.Forms.ComboBox
    Friend WithEvents txt_fecha_comp As System.Windows.Forms.TextBox
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents Label10 As System.Windows.Forms.Label
    Friend WithEvents Label9 As System.Windows.Forms.Label
    Friend WithEvents TextBox10 As System.Windows.Forms.TextBox
    Friend WithEvents TextBox9 As System.Windows.Forms.TextBox
    Friend WithEvents Button2 As System.Windows.Forms.Button
    Friend WithEvents MonthCalendar1 As System.Windows.Forms.MonthCalendar
    Friend WithEvents ddl_tipo_trabajo_sot As System.Windows.Forms.ComboBox
    Friend WithEvents CheckBox2 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox3 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox4 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox5 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox6 As System.Windows.Forms.CheckBox
    Friend WithEvents Panel1 As System.Windows.Forms.Panel
    Friend WithEvents CheckBox10 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox9 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox8 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox7 As System.Windows.Forms.CheckBox
    Friend WithEvents txt_area As System.Windows.Forms.TextBox
    Friend WithEvents txt_direccion_sot As System.Windows.Forms.TextBox
    Friend WithEvents txt_distrito_sot As System.Windows.Forms.TextBox
    Friend WithEvents txt_tipo_servicio_sot As System.Windows.Forms.TextBox
    Friend WithEvents txt_solicitante_sot As System.Windows.Forms.TextBox
    Friend WithEvents txt_num_solicitud_sot As System.Windows.Forms.TextBox
    Friend WithEvents txt_dni_sot As System.Windows.Forms.TextBox
End Class
