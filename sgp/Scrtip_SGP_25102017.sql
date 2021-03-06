USE [BD_DESCARTE_AT_18102017]
GO
/****** Object:  Table [dbo].[TB_CARGA_AGENTES]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_CARGA_AGENTES](
	[in_CargaID] [int] IDENTITY(1,1) NOT NULL,
	[in_CapaID] [int] NULL,
	[in_UsuRegistroID] [int] NULL,
	[dt_FechRegistro] [datetime] NULL,
	[in_CantAgentes] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[in_CargaID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_CAMPANIA]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_CAMPANIA](
	[in_CampaniaID] [int] IDENTITY(1,1) NOT NULL,
	[vc_Campania] [varchar](50) NOT NULL,
	[in_SedeID] [int] NULL,
	[dt_FecRegistro] [datetime] NULL,
	[in_Estado] [int] NULL,
	[in_UsuRegistro] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[in_CampaniaID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TB_CAMPANIA] ON
INSERT [dbo].[TB_CAMPANIA] ([in_CampaniaID], [vc_Campania], [in_SedeID], [dt_FecRegistro], [in_Estado], [in_UsuRegistro]) VALUES (17, N'AT MOVIL', 3, CAST(0x0000A62E012C82F2 AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[TB_CAMPANIA] OFF
/****** Object:  UserDefinedFunction [dbo].[cambio]    Script Date: 10/25/2017 12:36:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[cambio](@hora CHAR(8))
RETURNS int
AS
BEGIN
	declare @result int = cast(SUBSTRING(@hora,1,2) as float)*3600+cast(SUBSTRING(@hora,4,2) as float)*60+cast(SUBSTRING(@hora,7,2) as float);
	RETURN @result;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[dividirCadena]    Script Date: 10/25/2017 12:36:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[dividirCadena] 
( 
    @string NVARCHAR(MAX), 
    @delimiter CHAR(1) 
) 
RETURNS @output TABLE(columna NVARCHAR(MAX) 
) 
BEGIN 
    DECLARE @start INT, @end INT 
    SELECT @start = 1, @end = CHARINDEX(@delimiter, @string) 
    WHILE @start < LEN(@string) + 1 BEGIN 
        IF @end = 0  
            SET @end = LEN(@string) + 1
       
        INSERT INTO @output (columna)  
        VALUES(SUBSTRING(@string, @start, @end - @start)) 
        SET @start = @end + 1 
        SET @end = CHARINDEX(@delimiter, @string, @start)        
    END 
    RETURN 
END
GO
/****** Object:  UserDefinedFunction [dbo].[devuelveHora]    Script Date: 10/25/2017 12:36:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[devuelveHora]
(
	@result int
)
RETURNS char(8)
AS
BEGIN

	 
	--DECLARE @lahora char(2)=IF((@result/3600)<10,'0'+CAST(@result/3600 AS CHAR),CAST(@result/3600 AS CHAR))    
	--DECLARE @minuto char(2)= IF((@result%3600)/60<10,'0'+CAST((@result%3600)/60 AS CHAR),CAST((@result%3600)/60 AS CHAR))
	--DECLARE @segundo char(2)=IF((@result%3600)%60<10,'0'+CAST((@result%3600)%60 AS CHAR),CAST((@result%3600)%60 AS CHAR))
	
	RETURN (SELECT LEFT((SELECT CONVERT(varchar, DATEADD(MS,@result* 1000, 0), 114)),8))
END;

--DECLARE @HORAS_DEBE INT
--SET @HORAS_DEBE=54282


--SELECT LEFT((SELECT CONVERT(varchar, DATEADD(MS,@HORAS_DEBE* 1000, 0), 114)),8) 

--SELECT 
--	CASE(LEN(CONVERT(NVARCHAR,(SUM(DATEDIFF(SECOND, '00:00:00', @HORAS_DEBE)) / 3600))))
--		WHEN '1' THEN '0' + CONVERT(NVARCHAR,(SUM(DATEDIFF(SECOND, '00:00:00', @HORAS_DEBE)) / 3600))
--		ELSE CONVERT(NVARCHAR,(SUM(DATEDIFF(SECOND, '00:00:00', @HORAS_DEBE)) / 3600))
--	END + ':' +
--	CASE(LEN(CONVERT(NVARCHAR,((SUM(DATEDIFF(SECOND, '00:00:00', @HORAS_DEBE)) % 3600) % (3600)) / 60)))
--		WHEN '1' THEN '0' + CONVERT(NVARCHAR,((SUM(DATEDIFF(SECOND, '00:00:00', @HORAS_DEBE)) % 3600) % (3600)) / 60)
--		ELSE CONVERT(NVARCHAR,((SUM(DATEDIFF(SECOND, '00:00:00', @HORAS_DEBE)) % 3600) % (3600)) / 60) END
--	 + ':' +
--	CASE(LEN(CONVERT(NVARCHAR,((SUM(DATEDIFF(SECOND, '00:00:00', @HORAS_DEBE)) % 3600) % (3600)) % 60)))
--		WHEN '1' THEN '0' + CONVERT(NVARCHAR,((SUM(DATEDIFF(SECOND, '00:00:00', @HORAS_DEBE)) % 3600) % (3600)) % 60)
--		ELSE CONVERT(NVARCHAR,((SUM(DATEDIFF(SECOND, '00:00:00', @HORAS_DEBE)) % 3600) % (3600)) % 60) END
GO
/****** Object:  Table [dbo].[TBL_OPCIONES_NIVEL]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_OPCIONES_NIVEL](
	[id_opcion_nivel] [int] IDENTITY(1,1) NOT NULL,
	[in_nivel] [int] NOT NULL,
	[vc_descripcion] [varchar](500) NULL,
	[in_orden] [int] NULL,
	[in_estado] [int] NULL,
 CONSTRAINT [PK_TBL_OPCIONES_NIVEL] PRIMARY KEY CLUSTERED 
(
	[id_opcion_nivel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TBL_OPCIONES_NIVEL] ON
INSERT [dbo].[TBL_OPCIONES_NIVEL] ([id_opcion_nivel], [in_nivel], [vc_descripcion], [in_orden], [in_estado]) VALUES (1, 128, N'OPCION 1', 1, 1)
INSERT [dbo].[TBL_OPCIONES_NIVEL] ([id_opcion_nivel], [in_nivel], [vc_descripcion], [in_orden], [in_estado]) VALUES (2, 128, N'OPCION 2', 1, 1)
SET IDENTITY_INSERT [dbo].[TBL_OPCIONES_NIVEL] OFF
/****** Object:  Table [dbo].[TBL_NIVEL_CONTENIDO]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_NIVEL_CONTENIDO](
	[in_idcontenido] [int] IDENTITY(1,1) NOT NULL,
	[in_idnivel] [int] NOT NULL,
	[vc_contenido] [nvarchar](max) NOT NULL,
	[vc_color] [nvarchar](50) NOT NULL,
	[in_subrayado] [int] NOT NULL,
	[in_estado] [int] NOT NULL,
 CONSTRAINT [PK_TBL_NIVEL_CONTENIDO] PRIMARY KEY CLUSTERED 
(
	[in_idcontenido] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TBL_NIVEL_CONTENIDO] ON
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (1, 1135, N'Titulo de colores', N'#F90404', 1, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (4, 1135, N'Rojo
Azul
Negro', N'#000000', 2, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (5, 1135, N'Solucion 1', N'#043BF9', 2, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (6, 1145, N'QUE NIVE ES?
WEWESD', N'#F90404', 1, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (7, 1145, N'SU 1', N'#043BF9', 2, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (8, 1145, N'SU 2', N'#000000', 2, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (9, 1148, N'SI', N'#F90404', 2, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (10, 1148, N'NO
TAL VEZ', N'#043BF9', 2, 1)
SET IDENTITY_INSERT [dbo].[TBL_NIVEL_CONTENIDO] OFF
/****** Object:  Table [dbo].[TBL_NIVEL]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_NIVEL](
	[id_nivel] [int] IDENTITY(1,1) NOT NULL,
	[in_cate] [int] NOT NULL,
	[vc_titulo] [nvarchar](200) NOT NULL,
	[vc_descripcion] [nvarchar](1000) NULL,
	[vc_url_img] [nvarchar](300) NOT NULL,
	[in_rpta] [int] NULL,
	[in_tipo_rpta] [int] NULL,
	[in_dpndncia_idnivel] [int] NOT NULL,
	[in_link] [int] NULL,
	[vc_alerta] [nvarchar](1000) NULL,
	[in_orden] [int] NULL,
	[in_estado] [int] NOT NULL,
	[in_visible] [int] NOT NULL,
	[vc_color_alerta] [nvarchar](50) NULL,
	[dt_fec_registro] [datetime] NULL,
 CONSTRAINT [PK_TBL_NIVEL] PRIMARY KEY CLUSTERED 
(
	[id_nivel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TBL_NIVEL] ON
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1, 4, N'Manual Prepago - AT', N'Manual Prepago - AT', N'C:\fakepath\inicio.JPG', 2, 1, 0, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76B0091F85E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (2, 1, N'Cliente no puede acceder a internet', N'Cliente no puede acceder a internet', N'C:\fakepath\CLIENTES.png', 2, 1, 1, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A76B0092CFE9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (3, 1, N'Cliente no puede realizar llamadas', N'-', N'C:\fakepath\app_d_img.png', 6, 1, 1, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A76B0092DB0D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (4, 5, N'No puede realizar llamadas', N'Descarte 1', N'C:\fakepath\Informacion.JPG', 2, 1, 1, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A76B0092E59A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (5, 2, N'No accede a Internet', N'', N'', 4, 1, 2, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A76B009465DB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (6, 2, N'Tiene lentitud en la navegación', N'', N'', 4, 1, 2, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A76B0094700A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (7, 2, N'Cliente indica tiene problemas en 4G', N'', N'', 4, 1, 2, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A76B009476AC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (8, 2, N'No accede a Redes Sociales (Facebook, Twitter)', N'', N'', 4, 1, 2, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A76B00947D09 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (9, 2, N'No accede a Whatsapp', N'', N'', 4, 1, 2, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A76B009482D2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (10, 3, N'consultar al cliente', N'- ', N'C:\fakepath\Chrysanthemum.jpg', 2, 1, 4, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A76D00A2B55F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (11, 2, N'Si', N'', N'', 2, 1, 4, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A76D00A2C16D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (12, 2, N'No', N'', N'', 2, 1, 4, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A76D00A2C7B3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (13, 2, N'consultar al cliente', N'-', N'', 2, 1, 4, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A76D00A4256C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (14, 2, N'consultar al clientee', N'', N'', 4, 1, 4, 0, N'', 1, 1, 2, N'red', CAST(0x0000A76D00A44B7C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (15, 2, N'consultar al cli3ente', N'', N'', 1, 1, 4, 0, N'', 1, 1, 2, N'red', CAST(0x0000A76D00A45582 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (16, 4, N'Consultar al cliente', N'-', N'C:\fakepath\PConsultaralcliente.JPG', 2, 1, 4, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A76D00A53D89 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (17, 2, N'SI', N'Locución 1
Locución 2
Locución 3
Locución 4', N'', 1, 1, 4, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00A5915E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (18, 1, N'No', N'Descarte 2', N'', 5, 1, 4, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00A5A131 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (19, 4, N'consultar al cliente', N'-', N'C:\fakepath\6.JPG', 2, 1, 18, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A76D00AB6628 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (20, 3, N'SI', N'Descarte 1 - Sistemas', N'', 4, 1, 19, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00ABC384 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (21, 1, N'Si', N'Descarte 1 - Estado de Línea', N'', 4, 1, 18, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00ABD979 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (22, 5, N'No', N'Descarte 3', N'', 5, 1, 18, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00ABEF69 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (23, 6, N'consultar al cliente', N'-', N'C:\fakepath\9.JPG', 2, 1, 22, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00AC2FBF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (24, 7, N'Si', N'Descarte 1 Interiores', N'', 4, 1, 22, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00AC3E4E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (25, 5, N'No', N'Descartes Básicos', N'', 5, 1, 22, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00AC5188 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (26, 6, N'Descarte 1 ', N'Estado Línea', N'C:\fakepath\12.JPG', 2, 1, 25, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00BD0835 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (27, 5, N'Si', N'Descarte 2', N'', 4, 1, 25, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00BD4DA2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (28, 5, N'No', N'Speech', N'', 4, 1, 25, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00BD5747 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (29, 5, N'Ver imagen', N'', N'', 2, 1, 25, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00BD639B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (30, 6, N'(Ver imagen)', N'', N'C:\fakepath\Imagen12.JPG', 2, 1, 25, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00BF3A76 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (31, 5, N'Si', N'Descarte 2', N'', 4, 1, 25, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00BF4F1D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (32, 5, N'No', N'Speech y Tipificar', N'', 5, 1, 25, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00BF6A14 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (33, 6, N'Paso 1', N'', N'C:\fakepath\SNActivo.JPG', 6, 1, 32, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00CBA3F6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (34, 6, N'Paso 2', N'', N'C:\fakepath\ASActivo1.JPG', 6, 1, 32, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00CBAEB5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (35, 6, N'Paso 3', N'-', N'C:\fakepath\ATVozPreSalDBPNoActivo.JPG', 6, 1, 32, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00CBBA8A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (36, 6, N'Finalizar', N'', N'', 3, 1, 32, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00CC1594 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (37, 7, N'Clic Aquí', N'-', N'', 4, 1, 35, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00CCF58D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (38, 8, N'Finalizar', N'', N'', 3, 1, 37, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00CD258D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (39, 6, N'DBPNoActivo', N'-', N'C:\fakepath\LNoActivo.JPG', 2, 1, 32, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00CF604E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (40, 6, N'Finalizar', N'', N'', 3, 1, 32, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00CF6FB6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (41, 6, N'Descarte 2', N'', N'C:\fakepath\15.JPG', 2, 1, 31, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00D10AAC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (42, 6, N'No', N'Speech - Tipifica', N'', 5, 1, 31, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00D12D4F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (43, 6, N'Si', N'Descarte 3', N'', 4, 1, 31, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00D13ED2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (44, 6, N'(Ver imagen)', N'-', N'C:\fakepath\desbloqueado.JPG', 2, 1, 31, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00D153CE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (45, 6, N'(Ver imagen)', N'', N'C:\fakepath\desbloqueado.JPG', 2, 1, 31, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00D2240C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (46, 6, N'Si', N'Descarte 3', N'', 4, 1, 31, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00D233F2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (47, 6, N'No', N'Speech - Tipificar', N'', 5, 1, 31, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00D23F29 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (48, 6, N'(Ver imagen)', N'', N'C:\fakepath\Imagen12.JPG', 2, 1, 25, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00F1DEBA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (49, 16, N'Descarte 1', N'-', N'C:\fakepath\DBD1.PNG', 2, 1, 25, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00F7E44A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (50, 6, N'(Ver imagen)', N'', N'C:\fakepath\Imagen12.JPG', 2, 1, 25, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00F80108 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (51, 7, N'Si', N'Descarte 2', N'', 4, 1, 25, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00F813CC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (52, 7, N'No', N'Speech/Tipifica', N'', 5, 1, 25, 0, N'', 1, 1, 2, N'green', CAST(0x0000A76D00F81BD6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (53, 6, N'No', N'Speech y Tipifica', N'C:\fakepath\LNoActivo.JPG', 5, 1, 25, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00F8AE92 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (54, 1, N'Tipifica', N'-', N'C:\fakepath\LNoActivo.JPG', 2, 1, 53, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00F91F80 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (55, 7, N'Finalizar', N'', N'', 3, 1, 53, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00F939C9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (56, 16, N'Descarte 2', N'-', N'C:\fakepath\DBD2.PNG', 2, 1, 51, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00F9DB03 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (57, 8, N'(Ver imagen)', N'', N'C:\fakepath\desbloqueado.JPG', 2, 1, 51, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00F9F583 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (58, 8, N'Si', N'Descarte 3', N'', 4, 1, 51, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FA00DC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (59, 8, N'No', N'Speech y Tipifica', N'', 5, 1, 51, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FA11D4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (60, 1, N'Tipificar', N'-', N'C:\fakepath\DescBDes2No.PNG', 2, 1, 59, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FA2998 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (61, 9, N'Finalizar', N'', N'', 3, 1, 59, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FA320F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (62, 16, N'Descarte 3', N'-', N'C:\fakepath\DBD3.PNG', 2, 1, 58, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FB4063 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (63, 9, N'(Ver imagen)', N'', N'C:\fakepath\HLR.JPG', 2, 1, 58, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FB5B99 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (64, 9, N'Si', N'Descarte 4', N'', 4, 1, 58, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FB6777 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (65, 4, N'No', N'¿Línea adicional?', N'C:\fakepath\LAdicional.PNG', 5, 1, 58, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FC0C4C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (66, 16, N'Descarte 4', N'-', N'C:\fakepath\DBD4.PNG', 2, 1, 64, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FD0767 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (67, 12, N'(Ver imagen)', N'-', N'C:\fakepath\IMSIPINHLR.JPG', 2, 1, 64, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FD1C74 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (68, 11, N'Si', N'Descarte 5', N'', 4, 1, 64, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FD2ECF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (69, 10, N'No', N'¿Línea Adicional?', N'', 5, 1, 64, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FD4CAD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (70, 16, N'Descarte 5', N'-', N'C:\fakepath\DBD5.PNG', 2, 1, 68, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FE325C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (71, 12, N'(Ver imagen)', N'', N'C:\fakepath\AUC.JPG', 2, 1, 68, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FE5314 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (72, 12, N'Si', N'Descarte 6', N'', 4, 1, 68, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FE6B78 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (73, 12, N'No', N'Brindar Speech', N'', 5, 1, 68, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FE8886 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (74, 16, N'Descarte 6', N'-', N'C:\fakepath\DBD6.PNG', 2, 1, 72, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FEF21C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (75, 13, N'(Ver imagen)', N'-', N'C:\fakepath\MSCVLR.JPG', 2, 1, 72, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FF132A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (76, 16, N'Si', N'Descarte 11', N'', 4, 1, 72, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FF3DE0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (77, 1, N'No', N'Descarte 7', N'', 5, 1, 72, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D00FF5866 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (78, 16, N'Descarte 7', N'-', N'C:\fakepath\DBD7.PNG', 2, 1, 77, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D0104C761 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (79, 14, N'(Ver imagen)', N'', N'C:\fakepath\MSCVLR.JPG', 2, 1, 77, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D01075E01 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (80, 16, N'Si', N'Descarte 11', N'', 4, 1, 77, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D01076C4F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (81, 1, N'No', N'Descarte 8', N'', 5, 1, 77, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D010787C3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (82, 17, N'Descarte 8', N'-', N'C:\fakepath\DBD8.PNG', 2, 1, 81, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D0107D744 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (83, 15, N'(Ver imagen)', N'', N'C:\fakepath\EstadoEquipo.PNG', 2, 1, 81, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D01084505 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (84, 15, N'Si', N'Descarte 9', N'', 4, 1, 81, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D010866F9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (85, 15, N'No', N'Speech y Tipficar', N'', 5, 1, 81, 0, N'', 1, 1, 1, N'green', CAST(0x0000A76D010876C5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (86, 4, N'Línea Adicional', N'-', N'C:\fakepath\LAdicional.PNG', 2, 1, 65, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100AACD65 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (87, 4, N'Si', N'Hacer lo siguiente', N'', 4, 1, 86, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77100AAE178 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (88, 4, N'No', N'Ver Tipificación', N'', 5, 1, 86, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77100AAF4CF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (89, 4, N'Hacer lo siguiente', N'', N'C:\fakepath\LAdicionalNINTEX.PNG', 2, 1, 87, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100ACB631 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (90, 4, N'Ver Tipificación', N'', N'C:\fakepath\NoNintex.PNG', 2, 1, 88, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100AD41F2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (91, 5, N'Si', N'Hacer lo siguiente', N'', 4, 1, 65, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100AE262A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (92, 5, N'No', N'Ver Tipificación NINTEX', N'', 5, 1, 65, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100AE47A5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (93, 7, N'Ver Tipificación', N'-', N'C:\fakepath\TipiNINTEX.PNG', 2, 1, 92, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100AED482 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (94, 8, N'Si', N'Brindar Speech', N'', 4, 1, 92, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100AEE665 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (95, 8, N'No', N'Realizar Nintex', N'', 5, 1, 92, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100AEEECE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (96, 6, N'Hacer lo siguiente', N'', N'C:\fakepath\LAdicionalNINTEX.PNG', 2, 1, 91, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100AF0893 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (97, 7, N'Si', N'Descarte 4', N'', 4, 1, 91, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100AF1873 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (98, 7, N'No', N'Brindar Speech', N'', 5, 1, 91, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100AF201B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (99, 7, N'Realizar Nintex', N'Realizar Nintex', N'C:\fakepath\SNonintex.PNG', 2, 1, 95, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100BDAE42 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (100, 7, N'Finalizar Atención', N'', N'', 3, 1, 95, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100BDC8B1 AS DateTime))
GO
print 'Processed 100 total records'
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (101, 8, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 94, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100BE170F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (102, 7, N'Si', N'Generar Caso', N'', 4, 1, 94, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100BE294B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (103, 7, N'No', N'Generar Reclamo', N'', 5, 1, 94, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100BE338F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (104, 8, N'Generar Caso', N'Generar Caso', N'C:\fakepath\Caso.PNG', 2, 1, 102, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100C0237A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (105, 8, N'Finalizar', N'', N'', 3, 1, 102, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100C0397D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (106, 8, N'Generar Reclamo', N'Generar Reclamo', N'C:\fakepath\ReclamoB.PNG', 2, 1, 103, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100C05E52 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (107, 8, N'Finalizar', N'', N'', 3, 1, 103, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100C066E4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (108, 9, N'¿Línea Adicional?', N'', N'C:\fakepath\LAdicional.PNG', 2, 1, 69, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100C7808A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (109, 9, N'Si', N'Hacer lo siguiente', N'', 4, 1, 69, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100C79874 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (110, 9, N'No', N'Ver Tipificación NINTEX', N'', 5, 1, 69, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100C7BB27 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (111, 10, N'NINTEX', N'-', N'C:\fakepath\TipiNINTEX.PNG', 2, 1, 110, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100C7F4C5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (112, 10, N'Si', N'Brindar Speech', N'', 4, 1, 110, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100C8163B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (113, 10, N'No', N'Realizar NINTEX', N'', 5, 1, 110, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100C82665 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (114, 10, N'Realizar lo siguiente', N'', N'C:\fakepath\noNINTEXpinPUK.PNG', 2, 1, 109, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100C89038 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (115, 10, N'Si', N'Descarte 5', N'', 4, 1, 109, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100C8AEE2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (116, 10, N'No', N'Brindar Speech', N'', 5, 1, 109, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100C8DAC2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (117, 11, N'NINTEX', N'', N'C:\fakepath\SNonintex.PNG', 2, 1, 113, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100CAE8E5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (118, 11, N'Finalizar', N'', N'', 3, 1, 113, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100CAF58D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (119, 11, N'Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 112, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100CB0F85 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (120, 11, N'Si', N'Generar Caso', N'', 4, 1, 112, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100CB24B8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (121, 11, N'No', N'Generar Reclamo', N'', 5, 1, 112, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100CB359F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (122, 12, N'Caso', N'', N'C:\fakepath\CPP.PNG', 2, 1, 120, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100CCB95D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (123, 12, N'Fin', N'', N'', 3, 1, 120, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100CCC465 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (124, 12, N'Reclamo', N'', N'C:\fakepath\RPP.PNG', 2, 1, 121, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100CD3646 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (125, 12, N'fin', N'', N'', 3, 1, 121, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77100CD40AE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (126, 3, N'Descarte 1 - Estado de línea', N'', N'C:\fakepath\DSLD1.PNG', 2, 1, 21, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B09EB6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (127, 3, N'Si', N'Descarte 2 - Perfil HLR', N'', 4, 1, 21, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B0C172 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (128, 3, N'No', N'Speech y Tipificar', N'C:\fakepath\SLdesc1No.PNG', 5, 1, 21, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77200B0D16A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (129, 3, N'No', N'Speech y Tipificar', N'', 5, 1, 21, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B10C1F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (130, 1, N'Speech y Tipificar', N'Copiar y pegar texto.', N'C:\fakepath\SLdesc1No.PNG', 2, 1, 129, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B13249 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (131, 4, N'Fin', N'', N'', 3, 1, 129, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B13B35 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (132, 4, N'Descarte 2 - Perfil HLR', N'', N'C:\fakepath\DSLD2.PNG', 2, 1, 127, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B1AEC3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (133, 4, N'Si', N'Descarte 3 - AUC', N'', 4, 1, 127, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B1D57E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (134, 5, N'No', N'¿Línea Adicional?', N'', 5, 1, 127, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B1E26C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (135, 6, N'¿Línea Adicional?', N'', N'C:\fakepath\LíneaA.PNG', 2, 1, 134, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B302CB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (136, 6, N'Si', N'Hacer lo siguiente', N'', 4, 1, 134, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B31BCA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (137, 6, N'No', N'Ver Tipificación NINTEX', N'', 5, 1, 134, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B3336A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (138, 7, N'Ver Tipificación NINTEX', N'', N'C:\fakepath\TipiNINTEX.PNG', 2, 1, 137, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B3D500 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (139, 7, N'Si', N'Brindar Speech', N'', 4, 1, 137, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B3F98B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (140, 7, N'No', N'Realizar NINTEX', N'', 5, 1, 137, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B42CF2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (141, 8, N'Realizar NINTEX', N'-', N'C:\fakepath\SLdesc2NoAcc1Nodesc1No.PNG', 2, 1, 140, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B4B6F8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (142, 8, N'Fin', N'', N'', 3, 1, 140, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B4C22A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (143, 8, N'Brindar Speech', N'-', N'C:\fakepath\SLdesc2NoAcc1Nodesc1SiAcc1.PNG', 2, 1, 139, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B50A0B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (144, 8, N'Si', N'Generar Caso', N'', 4, 1, 139, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B5176A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (145, 8, N'No', N'Generar Reclamo', N'', 5, 1, 139, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B52641 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (146, 9, N'Generar Caso', N'', N'C:\fakepath\SLdesc2NoAcc1Nodesc1SiAcc1Caso.PNG', 2, 1, 144, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B56CC1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (147, 9, N'Fin', N'', N'', 3, 1, 144, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B57699 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (148, 9, N'Generar Reclamo', N'', N'C:\fakepath\SLdesc2NoAcc1Nodesc1SiAcc1Reclamo.PNG', 2, 1, 145, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B587A7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (149, 9, N'Fin', N'', N'', 3, 1, 145, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B592CF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (150, 7, N'Hacer', N'', N'C:\fakepath\SLdesc2NoAcc2.PNG', 2, 1, 136, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B69A00 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (151, 7, N'Si', N'Descarte 3 - AUC', N'', 4, 1, 136, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B6BA86 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (152, 8, N'No', N'Brindar Speech y Tipificar', N'', 5, 1, 136, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B6CF1F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (153, 8, N'Speech y Tipificar', N'-', N'C:\fakepath\SLdesc2NoAcc2No.PNG', 2, 1, 152, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B755B4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (154, 8, N'Si', N'Generar Caso', N'', 4, 1, 152, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77200B764BC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (155, 8, N'No', N'Generar Reclamo', N'', 5, 1, 152, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77200B7786E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (156, 8, N'Fin', N'', N'', 3, 1, 152, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200B807D9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (157, 5, N'Descarte 3 - AUC', N'', N'C:\fakepath\DSLD3.PNG', 2, 1, 133, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200BC564D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (158, 5, N'Si', N'Descarte 4 - IMSI / HLR', N'', 4, 1, 133, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200BC9CF9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (159, 5, N'No', N'¿Línea Adicional?', N'', 5, 1, 133, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77200BCB393 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (160, 6, N'¿Línea Adicional?', N'', N'C:\fakepath\LíneaA.PNG', 2, 1, 159, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200BCCAB9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (161, 6, N'Si', N'Hacer lo siguiente', N'', 4, 1, 159, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200BD033F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (162, 6, N'No', N'Ver Tipificación NINTEX', N'', 5, 1, 159, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77200BD1CB5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (163, 5, N'No', N'Brindar Speech', N'', 5, 1, 133, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200BE2DD3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (164, 6, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 163, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200BF1B5C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (165, 6, N'Si', N'Generar Caso', N'', 4, 1, 163, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200BF246D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (166, 6, N'No', N'Generar Reclamo', N'', 5, 1, 163, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200BF31FC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (167, 7, N'Generar Caso', N'', N'C:\fakepath\SLdesc3NoCaso.PNG', 2, 1, 165, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200BF4CED AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (168, 7, N'Fin', N'', N'', 3, 1, 165, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200BF5656 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (169, 7, N'Generar Reclamo', N'', N'C:\fakepath\SLdesc3NoReclamo.PNG', 2, 1, 166, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200BF6F4F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (170, 7, N'fin', N'', N'', 3, 1, 166, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200BF778F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (171, 6, N'Descarte 4 - IMSI / HLR', N'', N'C:\fakepath\DSLD4.PNG', 2, 1, 158, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200C05F0C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (172, 6, N'Si', N'Descarte 5 - ICCID Físico', N'', 4, 1, 158, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200C09CB4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (173, 6, N'No', N'¿Línea Adicional?', N'', 5, 1, 158, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200C0B7B7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (174, 7, N'¿Línea Adicional?', N'', N'C:\fakepath\LíneaA.PNG', 2, 1, 173, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200C0C946 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (175, 7, N'Si', N'Hacer lo siguiente', N'', 4, 1, 173, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200C0DBE4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (176, 7, N'No', N'Ver Tipificación NINTEX', N'', 5, 1, 173, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200C0FEA0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (177, 8, N'Ver Tipificación NINTEX', N'', N'C:\fakepath\TipiNINTEX.PNG', 2, 1, 176, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200C988FF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (178, 8, N'Si', N'Brindar Speech', N'', 4, 1, 176, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200C999C4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (179, 8, N'No', N'Realizar NINTEX', N'', 5, 1, 176, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200C9A85B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (180, 9, N'Realizar NINTEX', N'', N'C:\fakepath\NINTEX.PNG', 2, 1, 179, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CA88B8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (181, 9, N'Fin', N'', N'', 3, 1, 179, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CA93B2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (182, 9, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 178, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77200CB0B2D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (183, 9, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 178, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CB3643 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (184, 9, N'Si', N'Generar Caso', N'', 4, 1, 178, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CB4099 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (185, 10, N'No', N'Generar Reclamo', N'', 5, 1, 178, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CB4B18 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (186, 10, N'Caso', N'', N'C:\fakepath\SLdes4NoAcc1NoDesc1SiCaso.PNG', 2, 1, 184, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CB8D41 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (187, 10, N'Fin', N'', N'', 3, 1, 184, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CB94F4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (188, 11, N'Reclamo', N'', N'C:\fakepath\SLdes4NoAcc1NoDesc1SiReclamo.PNG', 2, 1, 185, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CBA55B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (189, 11, N'Fin', N'', N'', 3, 1, 185, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CBAD9B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (190, 8, N'Hacer lo siguiente', N'', N'C:\fakepath\SLdes4NoAcc2.PNG', 2, 1, 175, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CBF1A2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (191, 8, N'Si', N'Descarte 5 ICCID Físico', N'', 4, 1, 175, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CC10B9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (192, 8, N'No', N'brindar speech', N'', 5, 1, 175, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CC2912 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (193, 9, N'brindar speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 192, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CC3CA3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (194, 9, N'Si', N'Generar Caso', N'', 4, 1, 192, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CC4882 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (195, 9, N'No', N'Generar Reclamo', N'', 5, 1, 192, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CC5298 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (196, 10, N'Caso', N'', N'C:\fakepath\SLdes4NoAcc2NoCaso.PNG', 2, 1, 194, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CC6D50 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (197, 10, N'Fin', N'', N'', 3, 1, 194, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CC77D8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (198, 10, N'Reclamo', N'', N'C:\fakepath\SLdes4NoAcc2NoReclamo.PNG', 2, 1, 195, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CC8855 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (199, 10, N'Fin', N'', N'', 3, 1, 195, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CC8ED7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (200, 7, N'Descarte 5 - ICCID Físico', N'', N'C:\fakepath\DSLD5.PNG', 2, 1, 172, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CE1DD7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (201, 8, N'Si', N'Validar Servicio', N'', 4, 1, 172, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CE3995 AS DateTime))
GO
print 'Processed 200 total records'
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (202, 7, N'No', N'Brindar Speech y Tipificar', N'', 5, 1, 172, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CE4364 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (203, 8, N'Speech', N'', N'C:\fakepath\SLdes5No.PNG', 2, 1, 202, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CE8E81 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (204, 8, N'Fin', N'', N'', 3, 1, 202, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200CE95F5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (205, 10, N'Validar Servicio', N'-', N'C:\fakepath\SLDes5si.PNG', 2, 1, 201, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D19748 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (206, 10, N'Si', N'Informar y Tipificar', N'', 4, 1, 205, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D1D03D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (207, 10, N'No', N'Descarte 6 - IMEI', N'', 5, 1, 205, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D1E268 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (208, 11, N'Informar y Tipificar', N'', N'C:\fakepath\SLDes5SiAcc1Si.PNG', 2, 1, 206, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77200D2F4BC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (209, 11, N'Fin', N'', N'', 3, 1, 206, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77200D3004E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (210, 9, N'Si', N'Informar y Tipificar', N'', 4, 1, 201, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D38B81 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (211, 10, N'No', N'Descarte 6 - IMEI', N'', 4, 1, 201, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D399F0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (212, 10, N'Informar y Tipificar', N'', N'C:\fakepath\SLDes5SiAcc1Si.PNG', 2, 1, 210, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77200D3A9E3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (213, 10, N'Fin', N'', N'', 3, 1, 210, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77200D3B1E2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (214, 10, N'Informar y Tipificar', N'', N'C:\fakepath\SLDes5SiAcc1Si.PNG', 2, 1, 210, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D44064 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (215, 10, N'Fin', N'', N'', 3, 1, 210, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D447B8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (216, 11, N'Descarte 6 - IMEI', N'', N'C:\fakepath\DSLD6.PNG', 2, 1, 211, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D50BCB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (217, 11, N'Si', N'Descarte 7 - Celdas AT', N'', 4, 1, 211, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D51C20 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (218, 11, N'No', N'brindar Speech y Tipificar', N'', 5, 1, 211, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D53406 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (219, 12, N'brindar Speech y Tipificar', N'', N'C:\fakepath\SLdes6No.PNG', 2, 1, 218, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D56C27 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (220, 12, N'Fin', N'', N'', 3, 1, 218, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D57342 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (221, 12, N'Descarte 7 - Celdas AT', N'', N'C:\fakepath\DSLD7.PNG', 2, 1, 217, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D58111 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (222, 13, N'Si', N'Brindar Speech y TIpificar', N'', 4, 1, 217, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D5A345 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (223, 12, N'No', N'Descarte 8 - MSC y VLR', N'', 5, 1, 217, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D5C42B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (224, 14, N'Brindar Speech y TIpificar', N'', N'C:\fakepath\SLdes7Si.PNG', 2, 1, 222, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D5EA2F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (225, 14, N'Fin', N'', N'', 3, 1, 222, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77200D5F287 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (226, 13, N'Descarte 8 - MSC y VLR', N'', N'C:\fakepath\SLD8.PNG', 2, 1, 223, 0, N'', 1, 1, 1, N'green', CAST(0x0000A774009E1F34 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (227, 13, N'Si', N'Descarte 9 - Mensaje Error', N'', 4, 1, 223, 0, N'', 1, 1, 1, N'green', CAST(0x0000A774009E433B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (228, 15, N'No', N'Acción 1', N'', 5, 1, 223, 0, N'', 1, 1, 1, N'green', CAST(0x0000A774009E5C1A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (229, 15, N'Acción 1', N'-', N'C:\fakepath\SLdes8NoAcc1.PNG', 2, 1, 228, 0, N'', 1, 1, 1, N'green', CAST(0x0000A774009F01D7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (230, 14, N'Si', N'Acción 2', N'', 4, 1, 228, 0, N'', 1, 1, 1, N'green', CAST(0x0000A774009F19BE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (231, 14, N'No', N'Consultar al cliente', N'', 5, 1, 228, 0, N'', 1, 1, 1, N'green', CAST(0x0000A774009F3577 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (232, 15, N'Acción 2', N'-', N'C:\fakepath\SLdes8NoAcc2.PNG', 2, 1, 230, 0, N'', 1, 1, 1, N'green', CAST(0x0000A774009F56CF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (233, 15, N'Si', N'Speech y Tipificar', N'', 4, 1, 230, 0, N'', 1, 1, 1, N'green', CAST(0x0000A774009F6457 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (234, 15, N'No', N'Acción 3', N'', 5, 1, 230, 0, N'', 1, 1, 1, N'green', CAST(0x0000A774009F8461 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (235, 16, N'Acción 3', N'-', N'C:\fakepath\SLdes8NoAcc3.PNG', 2, 1, 234, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A20633 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (236, 16, N'Si', N'Acción 4', N'', 4, 1, 234, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A21747 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (237, 16, N'No', N'Regresar al Inicio', N'', 5, 1, 234, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A22FB6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (238, 16, N'Acción 4', N'-', N'C:\fakepath\SLdes8NoAcc4.PNG', 2, 1, 236, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A244C2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (239, 17, N'Si', N'Speech y Tipificar', N'', 4, 1, 236, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A26281 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (240, 17, N'No', N'Speech y Tipificar', N'', 5, 1, 236, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A26A91 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (241, 15, N'Consultar al cliente', N'', N'C:\fakepath\SLdes8NoAcc1NoAcc1.PNG', 2, 1, 231, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A2BDF5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (242, 18, N'Si', N'Speech y Tipificar', N'C:\fakepath\SLdes8NoAcc1NoAcc1S.PNG', 4, 1, 231, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A2D897 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (243, 15, N'No', N'Speech y Tipificar', N'', 5, 1, 231, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A2DEE6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (244, 18, N'Speech y Tipificar', N'-', N'C:\fakepath\SLdes8NoAcc1NoAcc1S.PNG', 2, 1, 242, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A303BB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (245, 16, N'Fin', N'', N'', 3, 1, 242, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A30C95 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (246, 18, N'Speech y Tipificar', N'-', N'C:\fakepath\SLdes8NoAcc1NoAcc1N.PNG', 2, 1, 243, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A317FB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (247, 16, N'Fin', N'', N'', 3, 1, 243, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A31E84 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (248, 16, N'Acción 2', N'', N'C:\fakepath\SLdes8NoAcc2.PNG', 2, 1, 228, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77400A3BC2A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (249, 18, N'Speech y Tipificar', N'-', N'C:\fakepath\SLdes8NoAcc2S.PNG', 2, 1, 233, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A42AD5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (250, 16, N'Fin', N'', N'', 3, 1, 233, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A433ED AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (251, 18, N'Speech y Tipificar', N'', N'C:\fakepath\SLdesc8NoAcc4Si.PNG', 2, 1, 239, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A4996A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (252, 18, N'Fin', N'', N'', 3, 1, 239, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A4A0C2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (253, 18, N'Speech y Tipificar', N'', N'C:\fakepath\SLdesc8NoAcc4No.PNG', 2, 1, 240, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A4AF28 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (254, 18, N'Fin', N'', N'', 3, 1, 240, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A4B65E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (255, 17, N'Inicio', N'', N'', 3, 1, 237, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400A4C601 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (256, 17, N'Acción 1', N'', N'', 6, 1, 237, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400A6541E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (257, 17, N'Acción 2', N'', N'', 6, 1, 237, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400A6598B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (258, 17, N'Acción 3', N'', N'', 6, 1, 237, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400A66C6C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (259, 17, N'Acción 4', N'', N'', 6, 1, 237, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400A672B1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (260, 18, N'Si', N'', N'', 4, 1, 256, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A67BDA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (261, 18, N'No', N'', N'', 5, 1, 256, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A6829A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (262, 18, N'Acción 1	', N'', N'C:\fakepath\SLdes8NoAcc1.PNG', 2, 1, 256, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A6B6FF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (263, 14, N'Descarte 9 - Mensaje Error', N'', N'C:\fakepath\SLD9.PNG', 2, 1, 227, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A87986 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (264, 14, N'Si', N'Acción 1', N'', 4, 1, 227, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A8A4D1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (265, 14, N'No', N'Descarte 10 - Validar Sercivio', N'', 5, 1, 227, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400A8C4ED AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (266, 15, N'Acción 1', N'', N'C:\fakepath\SLdes8NoAcc1.PNG', 2, 1, 264, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400ADE8DD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (267, 15, N'Si', N'Acción 2', N'', 4, 1, 264, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400ADF7D5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (268, 15, N'No', N'Consultar al cliente', N'', 5, 1, 264, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400AE09E2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (269, 16, N'Acción 2', N'', N'C:\fakepath\SLdes8NoAcc2.PNG', 2, 1, 267, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400AE180A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (270, 16, N'Si', N'Speech y Tipificar', N'', 4, 1, 267, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400AE39DD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (271, 16, N'No', N'Acción 3', N'', 5, 1, 267, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400AE47A3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (272, 17, N'Acción 3', N'', N'C:\fakepath\SLdes8NoAcc3.PNG', 2, 1, 271, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400AE5C58 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (273, 17, N'Si', N'Acción 4', N'', 4, 1, 271, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400AE6E48 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (274, 17, N'No', N'Regresar al inicio', N'', 5, 1, 271, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400AE7BFF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (275, 18, N'Acción 4', N'', N'C:\fakepath\SLdes8NoAcc4.PNG', 2, 1, 273, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400AEB565 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (276, 18, N'Si', N'Speech y Tipificar', N'', 4, 1, 273, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400AED3D4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (277, 18, N'No', N'Speech y Tipificar', N'', 5, 1, 273, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400AEDED5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (278, 16, N'Consultar al cliente', N'', N'C:\fakepath\SLdes8NoAcc1NoAcc1.PNG', 2, 1, 268, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B01BED AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (279, 16, N'Si', N'Speech y Tipificar', N'', 4, 1, 268, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B02D84 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (280, 16, N'No', N'Speech y Tipificar', N'', 5, 1, 268, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B037A6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (281, 6, N'Speech y Tipificar', N'-', N'C:\fakepath\SLDesc9SiAcc1NoAcc1Si.PNG', 2, 1, 279, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B0426C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (282, 17, N'Fin', N'', N'', 3, 1, 279, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B0499C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (283, 6, N'Speech y Tipificar', N'-', N'C:\fakepath\SLDes9SiAcc1NoAcc1No.PNG', 2, 1, 280, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B05454 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (284, 6, N'Speech y Tipificar', N'-', N'C:\fakepath\SLDes9SiAcc2Si.PNG', 2, 1, 270, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B06BE9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (285, 17, N'Fin', N'', N'', 3, 1, 270, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B072E3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (286, 6, N'Speech y Tipificar', N'-', N'C:\fakepath\SLDes9SiAcc4Si.PNG', 2, 1, 276, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B0A5D7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (287, 19, N'Fin', N'', N'', 3, 1, 276, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B0ACB6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (288, 6, N'Speech y Tipificar', N'-', N'C:\fakepath\SLDesc9SiAcc4No.PNG', 2, 1, 277, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B0B81C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (289, 19, N'Fin', N'', N'', 3, 1, 277, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B0BF00 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (290, 17, N'Fin', N'', N'', 3, 1, 280, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B16D5A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (291, 15, N'Descarte 10 - Validar Sercivio', N'', N'C:\fakepath\SLD10.PNG', 2, 1, 265, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B28F12 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (292, 15, N'Si', N'Speech y Tipificar', N'', 4, 1, 265, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B2A5FA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (293, 15, N'No', N'Regresar al Inicio', N'', 5, 1, 265, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B2B42E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (294, 16, N'Speech y Tipificar', N'', N'C:\fakepath\SLdes10.PNG', 2, 1, 292, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B2D211 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (295, 16, N'Fin', N'', N'', 3, 1, 292, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B2D9C4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (296, 5, N'No puede recibir llamadas', N'Descarte 1', N'', 2, 1, 1, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B35546 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (297, 6, N'No puede acceder a Internet', N'Descarte 1', N'', 2, 1, 1, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400B36C88 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (298, 2, N'Locución 1', N'', N'', 2, 1, 17, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400BC89C5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (299, 2, N'Locución 2', N'', N'', 2, 1, 17, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400BC8FB2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (300, 2, N'Locución 3', N'', N'', 2, 1, 17, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400BC97A3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (301, 7, N'Descarte 1 Interiores', N'-', N'C:\fakepath\DCD1.PNG', 2, 1, 24, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400BED2DF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (302, 8, N'Interiores', N'Speech Indoor y  Tipificar', N'', 4, 1, 24, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400BEE7AA AS DateTime))
GO
print 'Processed 300 total records'
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (303, 10, N'Exteriores', N'Descarte 2 Exteriores', N'', 4, 1, 24, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400BEF9E2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (304, 5, N'Acción 1', N'-', N'C:\fakepath\Acc1.PNG', 6, 1, 302, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400BF7271 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (305, 5, N'Acción 2', N'-', N'C:\fakepath\DCDes1Acc2.PNG', 6, 1, 302, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400BF82DE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (306, 5, N'Acción 3', N'-', N'C:\fakepath\DCDes1Acc3.PNG', 6, 1, 302, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400BF8776 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (307, 6, N'Acción 4', N'-', N'C:\fakepath\DCDes1Acc4.PNG', 2, 1, 302, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400BFEFF4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (308, 6, N'(Ver imagen)', N'', N'C:\fakepath\CeldasLite.PNG', 2, 1, 307, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400C0FD89 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (309, 5, N'(Ver imagen)', N'', N'C:\fakepath\CeldasLite.PNG', 2, 1, 302, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400C1FA70 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (310, 5, N'Acción 2', N'-', N'C:\fakepath\Acc2.PNG', 6, 1, 302, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400C26535 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (311, 5, N'Acción 3', N'-', N'C:\fakepath\Acc3.PNG', 6, 1, 302, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400C2AA6B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (312, 5, N'Acción 4', N'', N'C:\fakepath\DCDes1Acc4.PNG', 6, 1, 302, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400C2CABC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (313, 5, N'Acción 4', N'', N'C:\fakepath\CeldasLite.PNG', 6, 1, 302, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400C39F0A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (314, 8, N'Interiores', N'-', N'C:\fakepath\DCDes1SiAcc1.PNG', 2, 1, 302, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400C4665D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (315, 5, N'Tipificar', N'Tipificar', N'', 4, 1, 302, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400C4745D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (316, 6, N'Tipificar', N'', N'C:\fakepath\Acc2.PNG', 2, 1, 315, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400C47FFF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (317, 6, N'Registrar', N'Registrar', N'', 4, 1, 315, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400C49AE7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (318, 7, N'Registrar', N'', N'C:\fakepath\Acc3.PNG', 2, 1, 317, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400C4AC4F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (319, 7, N'(Ver imagen)', N'', N'C:\fakepath\CeldasLite.PNG', 2, 1, 317, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400C4C099 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (320, 7, N'Fin', N'', N'', 3, 1, 317, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400C4C831 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (321, 10, N'Exteriores', N'-', N'C:\fakepath\DCD2.PNG', 2, 1, 303, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400C81B07 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (322, 8, N'Si', N'Descarte 3 - CeldasAT', N'', 4, 1, 303, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400C8306E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (323, 8, N'No', N'Speech y Tipificar', N'', 5, 1, 303, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400C83FF5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (324, 9, N'Registrar', N'', N'', 4, 1, 302, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400CA5423 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (325, 10, N'Registrar', N'', N'C:\fakepath\DCDes1SiAcc2.PNG', 2, 1, 324, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400CA7157 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (326, 10, N'Fin', N'', N'', 3, 1, 324, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77400CA7857 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (327, 10, N'(Ver imagen)', N'', N'C:\fakepath\CeldasLite.PNG', 2, 1, 324, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400CAAB5A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (328, 10, N'Fin', N'', N'', 3, 1, 324, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400CAC75B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (329, 9, N'Speech y Tipificar', N'', N'C:\fakepath\DCDes2No.PNG', 2, 1, 323, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400CB2495 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (330, 9, N'Fin', N'', N'', 3, 1, 323, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400CB2B19 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (331, 9, N'CeldasAT', N'', N'C:\fakepath\DCD3.PNG', 2, 1, 322, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400CCB88D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (332, 9, N'Si', N'Speech y Tipificar', N'', 4, 1, 322, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400CCE3BE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (333, 10, N'No', N'Solicitar Equipo ', N'', 5, 1, 322, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400CCFF29 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (334, 10, N'Speech y Tipificar', N'', N'C:\fakepath\DCDes3Si.PNG', 2, 1, 332, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400CD0B42 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (335, 10, N'Fin', N'', N'', 3, 1, 332, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400CD1170 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (336, 11, N'Solicitar Equipo', N'', N'C:\fakepath\DCDes3NoAcc1.PNG', 2, 1, 333, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400CDC199 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (337, 11, N'Si', N'Validar servicio', N'', 4, 1, 333, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400CDE0A3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (338, 11, N'No', N'Consultar', N'', 5, 1, 333, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400CDFF11 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (339, 13, N'Validar servicio', N'-', N'C:\fakepath\DCDes3NoAcc2.PNG', 2, 1, 337, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D14200 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (340, 12, N'Si', N'Consultar', N'', 4, 1, 337, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D15893 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (341, 12, N'No', N'Speech y Tipificar', N'', 5, 1, 337, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D16A1F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (342, 13, N'Speech y Tipificar', N'-', N'C:\fakepath\DCDes3NoAcc2Nomodif.PNG', 2, 1, 341, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D2138E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (343, 13, N'Fin', N'', N'', 3, 1, 341, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D21AA4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (344, 12, N'Consultar', N'', N'C:\fakepath\DCDes3NoAcc3.PNG', 2, 1, 338, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D35750 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (345, 12, N'Si', N'Speech y Tipificar', N'', 4, 1, 338, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D375D1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (346, 12, N'No', N'Speech y Tipificar', N'', 5, 1, 338, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D37E1A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (347, 13, N'Consultar', N'', N'C:\fakepath\DCDes3NoAcc3.PNG', 2, 1, 340, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D392EC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (348, 13, N'Si', N'Speech y Tipificar', N'', 4, 1, 340, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D399FA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (349, 13, N'No', N'Speech y Tipificar', N'', 5, 1, 340, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D3A02A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (350, 14, N'Speech y Tipificar', N'', N'C:\fakepath\DCDes3NoAcc3Si.PNG', 2, 1, 348, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D3B2FD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (351, 14, N'Fin', N'', N'', 3, 1, 348, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D3BA60 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (352, 14, N'Speech y Tipificar', N'', N'C:\fakepath\DCDes3NoAcc3No.PNG', 2, 1, 349, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D3C4B5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (353, 14, N'Fin', N'', N'', 3, 1, 349, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D3CB85 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (354, 13, N'Speech y Tipificar', N'', N'C:\fakepath\DCDes3NoAcc3Si.PNG', 2, 1, 345, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D3FD78 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (355, 13, N'Fin', N'', N'', 3, 1, 345, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D40367 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (356, 13, N'Speech y Tipificar', N'', N'C:\fakepath\DCDes3NoAcc3No.PNG', 2, 1, 346, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D40DD2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (357, 13, N'Fin', N'', N'', 3, 1, 346, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77400D41860 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (358, 2, N'Locución 1', N'Descarte 1', N'', 4, 1, 17, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775009F0874 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (359, 2, N'Locución 2', N'Descarte 1', N'', 4, 1, 17, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775009F4E5F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (360, 2, N'Locuciones', N'', N'C:\fakepath\DCD1.PNG', 2, 1, 17, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500A795B0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (361, 5, N'Si', N'Locución', N'', 4, 1, 16, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500A8C675 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (362, 1, N'SI', N'Locución', N'', 4, 1, 4, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500A8EA36 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (363, 8, N'Locución 1 ', N'Descarte 1', N'C:\fakepath\Locuciones.PNG', 1, 1, 362, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500A97FBB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (364, 8, N'Locución 2 ', N'Descarte 1', N'', 1, 1, 362, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500AC5B3F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (365, 7, N' ', N' ', N'C:\fakepath\Locuciones.PNG', 2, 1, 362, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500AC7433 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (366, 7, N'Locución 3', N'Descarte 1', N'', 4, 1, 362, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500AF212F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (367, 7, N'Locución 4', N'Descarte 1', N'', 5, 1, 362, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500AF347C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (368, 7, N'Locución 4', N'Descarte 1', N'', 5, 1, 362, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500AF3F22 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (369, 7, N'Locución 5', N'Descarte 1', N'', 4, 1, 362, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500AFE653 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (370, 7, N'Locución 6', N'Descarte 1', N'', 5, 1, 362, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500B09E68 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (371, 7, N'Locución 7', N'Descarte 1', N'', 4, 1, 362, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500B0AB6E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (372, 7, N' ', N'', N'C:\fakepath\Locuciones.PNG', 2, 1, 362, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500B0B8DF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (373, 7, N'Locución 3', N'', N'', 1, 1, 362, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500B122D3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (374, 7, N'Locución 4', N'', N'', 1, 1, 362, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500B129E5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (375, 6, N'Locución 1', N'Descarte 1', N'C:\fakepath\Locuciones.PNG', 4, 1, 362, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77500B36076 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (376, 7, N'Locución 2 ', N'Descarte 1 
', N'C:\fakepath\Locuciones.PNG', 1, 1, 362, 0, N' ', 1, 1, 2, N'green', CAST(0x0000A77500B36ED7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (377, 7, N' ', N'', N'C:\fakepath\Locuciones.PNG', 2, 1, 362, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500B39EA0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (378, 9, N'Locución 3', N'', N'C:\fakepath\Locuciones.PNG', 1, 1, 376, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500B3AB0B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (379, 7, N'Locución 3', N'Descarte 1', N'C:\fakepath\Locuciones.PNG', 1, 1, 362, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500B3C0AF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (380, 7, N' ', N'', N'C:\fakepath\Locuciones.PNG', 2, 1, 362, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77500B3CE6F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (381, 8, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 98, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500BC66E4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (382, 8, N'Si', N'Generar Caso', N'', 4, 1, 98, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500BC7787 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (383, 8, N'No', N'Generar Reclamo', N'', 5, 1, 98, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500BC8612 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (384, 9, N'Generar Caso', N'', N'C:\fakepath\DBDes3NoAcc2NoCaso.PNG', 2, 1, 382, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500BE0BA3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (385, 9, N'Fin', N'', N'', 3, 1, 382, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500BE1264 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (386, 9, N'Generar Reclamo', N'', N'C:\fakepath\DBDes3NoAcc2NoReclamo.PNG', 2, 1, 383, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500BE1EDC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (387, 9, N'Fin', N'', N'', 3, 1, 383, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500BE2558 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (388, 11, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 116, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C05322 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (389, 11, N'Si', N'Generar Caso', N'', 4, 1, 116, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C05F8C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (390, 11, N'No', N'Generar Reclamo', N'', 5, 1, 116, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C06E20 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (391, 12, N'Generar Caso', N'', N'C:\fakepath\DBDes4NoAcc1NoDes1SiCaso.PNG', 2, 1, 389, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C0813E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (392, 12, N'Fin', N'', N'', 3, 1, 389, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C087A7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (393, 12, N'Generar Reclamo', N'', N'C:\fakepath\DBDes4NoAcc1NoDes1SiReclamo.PNG', 2, 1, 390, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C0963E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (394, 12, N'Fin', N'', N'', 3, 1, 390, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C09D89 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (395, 13, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 73, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C15D34 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (396, 13, N'Si', N'Generar Caso', N'', 4, 1, 73, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C16910 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (397, 13, N'No', N'Generar Reclamo', N'', 5, 1, 73, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C1734A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (398, 14, N'Generar Caso', N'', N'C:\fakepath\DBDes5NoCaso.PNG', 2, 1, 396, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C181D2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (399, 14, N'Fin', N'', N'', 3, 1, 396, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C18A33 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (400, 14, N'Generar Reclamo', N'', N'C:\fakepath\DBDes5NoReclamo.PNG', 2, 1, 397, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C19874 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (401, 14, N'Fin', N'', N'', 3, 1, 397, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C1A0A7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (402, 16, N'Descarte 11', N'-', N'C:\fakepath\DBD11.PNG', 2, 1, 76, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C24EA9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (403, 14, N'Si', N'Validar el servicio', N'', 4, 1, 76, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C27BCD AS DateTime))
GO
print 'Processed 400 total records'
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (404, 21, N'No', N'Solicitar lo siguiente', N'', 5, 1, 76, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C28DD9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (405, 16, N'Validar el servicio', N'-', N'C:\fakepath\DBD11NoAcc1.PNG', 2, 1, 403, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C2AFCD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (406, 15, N'Si', N'Tipificar', N'', 4, 1, 403, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C31D8E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (407, 15, N'No', N'Speech y Tipificar', N'', 5, 1, 403, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C32E96 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (408, 21, N'Tipificar', N'-', N'C:\fakepath\DBDes11SiAcc1Si.PNG', 2, 1, 406, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C34020 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (409, 16, N'Fin', N'', N'', 3, 1, 406, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C34AD5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (410, 21, N'Speech y Tipificar', N'-', N'C:\fakepath\DBDes11SiAcc1No.PNG', 2, 1, 407, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C35820 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (411, 16, N'Fin', N'', N'', 3, 1, 407, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77500C35F7E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (412, 17, N'Descarte 11', N'', N'C:\fakepath\DBD11.PNG', 2, 1, 80, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77500FDEDE1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (413, 17, N'Si', N'Validar Servicio', N'', 4, 1, 80, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77500FE003E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (414, 20, N'No', N'Solicitar lo siguiente', N'', 5, 1, 80, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77500FE2D8E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (415, 18, N'Validar Servicio', N'', N'C:\fakepath\DBDes11Si.PNG', 2, 1, 413, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77500FE4F33 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (416, 18, N'Si', N'Tipificar', N'', 4, 1, 413, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77500FE6F48 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (417, 18, N'No', N'Speech y Tipificar', N'', 5, 1, 413, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77500FE79C4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (418, 19, N'Tipificar', N'', N'C:\fakepath\DBDes11SiAcc1Si.PNG', 2, 1, 416, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77500FE868D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (419, 19, N'Fin', N'', N'', 3, 1, 416, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77500FE8E36 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (420, 19, N'Speech y Tipificar', N'', N'C:\fakepath\DBDes11SiAcc1No.PNG', 2, 1, 417, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77500FEA0FD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (421, 19, N'fin', N'', N'', 3, 1, 417, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77500FEA991 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (422, 20, N'Solicitar lo siguiente', N'-', N'C:\fakepath\LíneaA.PNG', 2, 1, 414, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77500FF32EC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (423, 18, N'Si', N'Realizar lo siguiente', N'', 4, 1, 414, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A7750101B2C0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (424, 18, N'No', N'Ver Tipificación NINTEX', N'', 5, 1, 414, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A7750101C28F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (425, 19, N'Realizar lo siguiente', N'', N'C:\fakepath\NintexLíneaActiva.PNG', 2, 1, 423, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A7750101D4A9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (426, 19, N'Si', N'Validar Servicio', N'', 4, 1, 423, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A7750102B282 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (427, 19, N'No', N'Brindar Speech', N'', 5, 1, 423, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77501042772 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (428, 20, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 427, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010436F7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (429, 20, N'Si', N'Generar Caso', N'', 4, 1, 427, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77501043FB6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (430, 20, N'No', N'Generar Reclamo', N'', 5, 1, 427, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77501044B04 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (431, 19, N'Ver Tipificación NINTEX', N'', N'C:\fakepath\TipiNINTEX.PNG', 2, 1, 424, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010585AF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (432, 19, N'Si', N'Brindar Speech', N'', 4, 1, 424, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010596FB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (433, 19, N'No', N'Realizar NINTEX', N'', 5, 1, 424, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A7750105A62E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (434, 1, N'Realizar NINTEX', N'-', N'C:\fakepath\NINTEX.PNG', 2, 1, 433, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7750105E876 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (435, 20, N'Fin', N'', N'', 3, 1, 433, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A7750105EEC6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (436, 20, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 432, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A7750105FAD4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (437, 20, N'Si', N'Generar Caso', N'', 4, 1, 432, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010605AD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (438, 20, N'No', N'Generar Reclamo', N'', 5, 1, 432, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77501060FF8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (439, 21, N'Generar Caso', N'-', N'C:\fakepath\DBDes11NoAcc1NoDes1SiCaso.PNG', 2, 1, 437, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010624FB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (440, 21, N'Fin', N'', N'', 3, 1, 437, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77501062B39 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (441, 21, N'Generar Reclamo', N'-', N'C:\fakepath\DBDes11NoAcc2NoReclamo.PNG', 2, 1, 438, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010637D5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (442, 21, N'Fin', N'', N'', 3, 1, 438, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77501063F61 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (443, 20, N'Validar Servicio', N'', N'C:\fakepath\DBDes11NoAcc2Si.PNG', 2, 1, 426, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010D0FD5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (444, 20, N'Si', N'Tipificar', N'', 4, 1, 426, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010D2A4A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (445, 20, N'No', N'Speech y Tipificar', N'', 5, 1, 426, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010D3C5A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (446, 21, N'Tipificar', N'', N'C:\fakepath\DBDes11NoAcc2SiDes1Si.PNG', 2, 1, 444, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010D5254 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (447, 21, N'Fin', N'', N'', 3, 1, 444, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010D58D2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (448, 21, N'Speech y Tipificar	', N'', N'C:\fakepath\DBDes11NoAcc2SiDes1No.PNG', 2, 1, 445, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010D6967 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (449, 21, N'Fin', N'', N'', 3, 1, 445, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010D6FC2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (450, 21, N'Generar Caso', N'', N'C:\fakepath\DBDes11NoAcc2NoCaso.PNG', 2, 1, 429, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010D8CD5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (451, 21, N'Fin', N'', N'', 3, 1, 429, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010D934E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (452, 21, N'Generar Reclamo', N'', N'C:\fakepath\DBDes11NoAcc2NoReclamo.PNG', 2, 1, 430, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010D9EC2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (453, 21, N'Fin', N'', N'', 3, 1, 430, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A775010DA565 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (454, 22, N'Solicitar lo siguiente', N'', N'C:\fakepath\DBDes11NoAcc1.PNG', 2, 1, 404, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77501103539 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (455, 22, N'Si', N'Hacer lo siguiente', N'', 4, 1, 404, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750110543C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (456, 22, N'No', N'Ver Tipificación NINTEX', N'', 5, 1, 404, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77501106772 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (457, 23, N'Ver Tipificación NINTEX', N'', N'C:\fakepath\TipiNINTEX.PNG', 2, 1, 456, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77501107970 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (458, 23, N'Si', N'Brindar Speech', N'', 4, 1, 456, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750110879D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (459, 23, N'No', N'Realizar NINTEX', N'', 5, 1, 456, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77501109497 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (460, 24, N'Realizar NINTEX', N'', N'C:\fakepath\NINTEX.PNG', 2, 1, 459, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750110A5E5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (461, 24, N'fin', N'', N'', 3, 1, 459, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750110ADD1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (462, 24, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 458, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750110BF6D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (463, 24, N'Si', N'Generar Caso', N'', 4, 1, 458, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750110CA8D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (464, 24, N'No', N'Generar Reclamo', N'', 5, 1, 458, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750110D744 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (465, 25, N'Generar Caso', N'', N'C:\fakepath\DBDes11NoAcc1NoDes1SiCaso.PNG', 2, 1, 463, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750110E507 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (466, 25, N'Fin', N'', N'', 3, 1, 463, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750110ECA1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (467, 25, N'Generar Reclamo', N'', N'C:\fakepath\DBDes11NoAcc1NoDes1SiReclamo.PNG', 2, 1, 464, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750110F7AF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (468, 25, N'Fin', N'', N'', 3, 1, 464, 0, N'', 1, 1, 1, N'green', CAST(0x0000A775011101D1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (469, 23, N'Hacer lo siguiente', N'', N'C:\fakepath\DBDes11NoAcc2.PNG', 2, 1, 455, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77501112481 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (470, 23, N'Si', N'Validar Servicio', N'', 4, 1, 455, 0, N'', 1, 1, 1, N'green', CAST(0x0000A775011136F2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (471, 23, N'No', N'Brindar Speech', N'', 5, 1, 455, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750111431B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (472, 24, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 471, 0, N'', 1, 1, 1, N'green', CAST(0x0000A775011159BB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (473, 24, N'Si', N'Generar Caso', N'', 4, 1, 471, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77501116413 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (474, 24, N'No', N'Generar Reclamo', N'', 5, 1, 471, 0, N'', 1, 1, 2, N'green', CAST(0x0000A77501116F27 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (475, 24, N'Si', N'Generar Caso', N'', 4, 1, 471, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750111AF14 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (476, 24, N'No', N'Generar Reclamo', N'', 5, 1, 471, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750111B7F0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (477, 25, N'Generar Caso', N'', N'C:\fakepath\DBDes11NoAcc2NoCaso.PNG', 2, 1, 475, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750111C47A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (478, 25, N'Fin', N'', N'', 3, 1, 475, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750111CD86 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (479, 25, N'Generar Reclamo', N'', N'C:\fakepath\DBDes11NoAcc2NoReclamo.PNG', 2, 1, 476, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750111DB03 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (480, 25, N'Fin', N'', N'', 3, 1, 476, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750111E3EE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (481, 24, N'Validar Servicio', N'', N'C:\fakepath\DBDes11NoAcc2Si.PNG', 2, 1, 470, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750111FDA0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (482, 24, N'Si', N'Tipificar', N'', 4, 1, 470, 0, N'', 1, 1, 1, N'green', CAST(0x0000A775011206DA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (483, 24, N'No', N'Speech y Tipificar', N'', 5, 1, 470, 0, N'', 1, 1, 1, N'green', CAST(0x0000A775011217B2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (484, 25, N'Tipificar', N'', N'C:\fakepath\DBDes11NoAcc2SiDes1Si.PNG', 2, 1, 482, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77501122EC7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (485, 25, N'Fin', N'', N'', 3, 1, 482, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750112368A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (486, 25, N'Speech y Tipificar', N'', N'C:\fakepath\DBDes11NoAcc2SiDes1No.PNG', 2, 1, 483, 0, N'', 1, 1, 1, N'green', CAST(0x0000A775011242BF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (487, 25, N'Fin', N'', N'', 3, 1, 483, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77501124997 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (488, 16, N'Speech y Tipficar', N'', N'C:\fakepath\DBDes8No.PNG', 2, 1, 85, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77501138328 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (489, 16, N'Fin', N'', N'', 3, 1, 85, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77501138A6D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (490, 16, N'Descarte 9', N'', N'C:\fakepath\DBD9.PNG', 2, 1, 84, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77501139C8D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (491, 17, N'Si', N'Descarte 10', N'', 4, 1, 84, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750113C5B8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (492, 16, N'No', N'Speech y Tipificar', N'', 5, 1, 84, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750113D404 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (493, 17, N'Speech y Tipificar', N'', N'C:\fakepath\DBDes9No.PNG', 2, 1, 492, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750113E6D4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (494, 17, N'Fin', N'', N'', 3, 1, 492, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750113EEC3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (495, 18, N'Descarte 10', N'', N'C:\fakepath\DBD10.PNG', 2, 1, 491, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77501143B63 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (496, 18, N'Si', N'Descarte 11', N'', 4, 1, 491, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77501144E03 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (497, 18, N'No', N'Speech y Tipificar', N'', 5, 1, 491, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77501145B02 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (498, 19, N'Speech y Tipificar', N'', N'C:\fakepath\DBDes10No.PNG', 2, 1, 497, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750114B12A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (499, 19, N'Fin', N'', N'', 3, 1, 497, 0, N'', 1, 1, 1, N'green', CAST(0x0000A7750114B7BF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (500, 19, N'Descarte 11', N'', N'C:\fakepath\DBD11.PNG', 2, 1, 496, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600932D18 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (501, 19, N'Si', N'Validar Servicio', N'', 4, 1, 496, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600934DC5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (502, 19, N'No', N'Solicitar lo Siguiente', N'', 5, 1, 496, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600935AD7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (503, 20, N'Validar Servicio', N'', N'C:\fakepath\DBDes11Si.PNG', 2, 1, 501, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776009375E7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (504, 20, N'Si', N'Tipificar', N'', 4, 1, 501, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760093820C AS DateTime))
GO
print 'Processed 500 total records'
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (505, 20, N'No', N'Speech y Tipificar', N'', 5, 1, 501, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776009391AA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (506, 21, N'Tipificar', N'', N'C:\fakepath\DBDes11SiAcc1Si.PNG', 2, 1, 504, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760093A795 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (507, 21, N'Fin', N'', N'', 3, 1, 504, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760093AEB5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (508, 21, N'Speech y Tipificar', N'', N'C:\fakepath\DBDes11SiAcc1No.PNG', 2, 1, 505, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760093BB81 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (509, 21, N'Fin', N'', N'', 3, 1, 505, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760093C273 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (510, 20, N'Solicitar lo Siguiente', N'', N'C:\fakepath\LíneaA.PNG', 2, 1, 502, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760093FDDC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (511, 20, N'Si', N'Realizar lo siguiente', N'', 4, 1, 502, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600941429 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (512, 20, N'No', N'Verificar Tipificación NINTEX', N'', 5, 1, 502, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600942AC9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (513, 21, N'Verificar Tipificación NINTEX', N'', N'C:\fakepath\TipiNINTEX.PNG', 2, 1, 512, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600943BD6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (514, 21, N'Si', N'Brindar Speech', N'', 4, 1, 512, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600944E0F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (515, 21, N'No', N'Realizar Nintex', N'', 5, 1, 512, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600945E70 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (516, 22, N'Realizar Nintex', N'', N'C:\fakepath\NINTEX.PNG', 2, 1, 515, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600946FA6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (517, 22, N'Fin', N'', N'', 3, 1, 515, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760094765F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (518, 22, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 514, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760094812C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (519, 22, N'Si', N'Generar Caso', N'', 4, 1, 514, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600948EF4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (520, 22, N'No', N'Generar Reclamo', N'', 5, 1, 514, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760094997D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (521, 23, N'Generar Caso', N'', N'C:\fakepath\DBDes11NoAcc1NoDes1SiCaso.PNG', 2, 1, 519, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760094D546 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (522, 23, N'Fin', N'', N'', 3, 1, 519, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760094DC23 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (523, 23, N'Generar Reclamo', N'', N'C:\fakepath\DBDes11NoAcc1NoDes1SiReclamo.PNG', 2, 1, 520, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600950398 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (524, 23, N'Fin', N'', N'', 3, 1, 520, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600950B8D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (525, 21, N'Realizar lo siguiente', N'', N'C:\fakepath\DBDes11NoAcc2.PNG', 2, 1, 511, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600953B1F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (526, 21, N'Si', N'Validar Servicio', N'', 4, 1, 511, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776009556F2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (527, 21, N'No', N'Brindar Speech', N'', 5, 1, 511, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600956166 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (528, 22, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 527, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600956C95 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (529, 22, N'Si', N'Generar Caso', N'', 4, 1, 527, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776009579E5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (530, 22, N'No', N'Generar Reclamo', N'', 5, 1, 527, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776009582D4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (531, 23, N'Generar Caso', N'', N'C:\fakepath\DBDes11NoAcc2NoCaso.PNG', 2, 1, 529, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760095A0EE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (532, 23, N'Fin', N'', N'', 3, 1, 529, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760095A6EB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (533, 23, N'Generar Reclamo', N'', N'C:\fakepath\DBDes11NoAcc2NoReclamo.PNG', 2, 1, 530, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760095BB85 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (534, 23, N'Fin', N'', N'', 3, 1, 530, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760095C42B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (535, 22, N'Validar Servicio', N'', N'C:\fakepath\DBDes11NoAcc2Si.PNG', 2, 1, 526, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776009608CB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (536, 22, N'Si', N'Tipificar', N'', 4, 1, 526, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600961E84 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (537, 22, N'No', N'Speech y Tipificar', N'', 5, 1, 526, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600962E76 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (538, 23, N'Tipificar', N'', N'C:\fakepath\DBDes11SiAcc1Si.PNG', 2, 1, 536, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760096F11A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (539, 23, N'Fin', N'', N'', 3, 1, 536, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760096F7BF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (540, 23, N'Speech y Tipificar	', N'', N'C:\fakepath\DBDes11SiAcc1No.PNG', 2, 1, 537, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776009704B0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (541, 23, N'Fin', N'', N'', 3, 1, 537, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77600970AF3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (542, 1, N'Descarte 1', N'-', N'C:\fakepath\D1SL.PNG', 2, 1, 296, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77600ED3C03 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (543, 7, N'Si', N'Acción 1', N'', 4, 1, 542, 0, N'', 1, 1, 2, N'noselected', CAST(0x0000A77600ED534E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (544, 6, N'Si', N'Acción 1', N'', 4, 1, 296, 0, N'', 1, 1, 2, N'noselected', CAST(0x0000A77600ED640E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (545, 6, N'No', N'Descarte 2', N'', 5, 1, 296, 0, N'', 1, 1, 2, N'noselected', CAST(0x0000A77600ED6D1D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (546, 6, N'(Ver imagen)', N'-', N'C:\fakepath\D1.PNG', 2, 1, 296, 0, N'', 1, 1, 2, N'noselected', CAST(0x0000A77601155F8C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (547, 6, N'(Ver imagen)', N'', N'', 2, 1, 296, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77601170267 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (548, 6, N'Si', N'Acción 1', N'', 4, 1, 296, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77601171268 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (549, 6, N'No', N'Descarte 2', N'', 5, 1, 296, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77601171AB1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (550, 2, N'Locución 2', N'Descarte 1', N'', 5, 1, 362, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760117C673 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (551, 2, N'Locución 3', N'Descarte 1', N'', 4, 1, 362, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760117E9F4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (552, 2, N'Locución 4', N'Descarte 1', N'', 5, 1, 362, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760117F465 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (553, 2, N'Locución 5', N'Descarte 1', N'', 4, 1, 362, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760117FED0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (554, 2, N'Locución 6', N'Descarte 1', N'', 5, 1, 362, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77601180A36 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (555, 2, N'Locución 7', N'Descarte 1', N'', 4, 1, 362, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77601181322 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (556, 7, N'Si', N'Locuciones', N'', 4, 1, 4, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77601185951 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (557, 7, N'Locución', N'', N'C:\fakepath\Locuciones.PNG', 2, 1, 556, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011874BF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (558, 36, N'Locución 1', N'Locución 1 - Descarte 1', N'', 5, 1, 556, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011896EB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (559, 30, N'Locución 2', N'Locución 2 - Descarte 1', N'', 5, 1, 556, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760118A36C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (560, 26, N'Locución 3', N'Locución 3 - Descarte 1', N'', 5, 1, 556, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760118ADBC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (561, 22, N'Locución 4', N'Locución 4 - Descarte 1', N'', 5, 1, 556, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A7760118B73B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (562, 18, N'Locución 5', N'Locución 5 - Descarte 1', N'', 4, 1, 556, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77601190B40 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (563, 14, N'Locución 6', N'Locución 6 - Descarte 1', N'', 4, 1, 556, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77601192448 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (564, 10, N'Locución 7', N'Locución 7 - Descarte 1', N'', 4, 1, 556, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77601192E8D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (565, 11, N'Locución 7 - Descarte 1', N'', N'C:\fakepath\Loc7D1.PNG', 2, 1, 564, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011C3A82 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (566, 11, N'Si', N'Descarte 2', N'', 4, 1, 564, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011C5FC6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (567, 11, N'No', N'Speech y Tipificar', N'', 5, 1, 564, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011C6B20 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (568, 12, N'Descarte 2', N'', N'C:\fakepath\Loc7D2.PNG', 2, 1, 566, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011C93FE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (569, 12, N'Si', N'Descarte 3', N'', 4, 1, 566, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011CAC48 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (570, 12, N'No', N'Speech y Tipificar', N'', 5, 1, 566, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011CB5F5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (571, 12, N'Speech y Tipificar', N'', N'C:\fakepath\Loc7Des1No.PNG', 2, 1, 567, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011CCB1B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (572, 12, N'Fin', N'', N'', 3, 1, 567, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011CD187 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (573, 13, N'Speech y Tipificar', N'', N'C:\fakepath\Loc7Des2No.PNG', 2, 1, 570, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011CDCD6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (574, 13, N'Fin', N'', N'', 3, 1, 570, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011CE39F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (575, 13, N'Descarte 3', N'', N'C:\fakepath\Loc7D3.PNG', 2, 1, 569, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011CEEA5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (576, 13, N'Si', N'Speech y TIpificar', N'', 4, 1, 569, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011D01EC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (577, 13, N'No', N'Speech y TIpificar', N'', 5, 1, 569, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011D098A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (578, 14, N'Speech y TIpificar', N'', N'C:\fakepath\Loc7Des3No.PNG', 2, 1, 577, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011D1961 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (579, 14, N'Fin', N'', N'', 3, 1, 577, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011D2437 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (580, 14, N'Speech y TIpificar', N'', N'C:\fakepath\Loc7Des3Si.PNG', 2, 1, 576, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011D2E4F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (581, 14, N'Fin', N'', N'', 3, 1, 576, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A776011D34EE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (582, 15, N'Locución 6 - Descarte 1', N'', N'C:\fakepath\Loc6D1.PNG', 2, 1, 563, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A7780099C051 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (583, 15, N'Si', N'Descarte 2', N'', 4, 1, 563, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009A8B29 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (584, 15, N'No', N'Speech y Tipificar', N'', 5, 1, 563, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009A95D5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (585, 16, N'Speech y Tipificar', N'', N'C:\fakepath\Loc6Des1No.PNG', 2, 1, 584, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009AA5B6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (586, 16, N'Fin', N'', N'', 3, 1, 584, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009AB05F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (587, 16, N'Descarte 2', N'', N'C:\fakepath\Loc6D2.PNG', 2, 1, 583, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009ABC45 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (588, 16, N'Si', N'Descarte 3', N'', 4, 1, 583, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009ACD3A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (589, 16, N'No', N'Speech y Tipificar', N'', 5, 1, 583, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009ADA8F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (590, 17, N'Speech y Tipificar', N'', N'C:\fakepath\Loc6Des2No.PNG', 2, 1, 589, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009AE64A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (591, 17, N'Fin', N'', N'', 3, 1, 589, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009AEEDF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (592, 17, N'Descarte 3', N'', N'C:\fakepath\Loc6D3.PNG', 2, 1, 588, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009AFAFC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (593, 17, N'Si', N'Speech y TIpificar', N'', 4, 1, 588, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009B0903 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (594, 17, N'No', N'Speech y TIpificar', N'', 5, 1, 588, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009B107E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (595, 18, N'Speech y TIpificar', N'', N'C:\fakepath\Loc6Des3Si.PNG', 2, 1, 593, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009B1892 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (596, 18, N'Fin', N'', N'', 3, 1, 593, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009B22DB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (597, 18, N'Speech y TIpificar', N'', N'C:\fakepath\Loc6Des3No.PNG', 2, 1, 594, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009B2B27 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (598, 18, N'Fin', N'', N'', 3, 1, 594, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009B317E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (599, 19, N'Locución 5 - Descarte 1', N'', N'C:\fakepath\Loc5D1.PNG', 2, 1, 562, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009B72BE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (600, 19, N'Si', N'Descarte 2', N'', 4, 1, 562, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009B7D40 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (601, 19, N'No', N'Speech y Tipificar', N'', 5, 1, 562, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009B91FC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (602, 20, N'Speech y Tipificar', N'', N'C:\fakepath\Loc5Des1No.PNG', 2, 1, 601, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009B9C18 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (603, 20, N'Fin', N'', N'', 3, 1, 601, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009BA337 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (604, 20, N'Descarte 2', N'', N'C:\fakepath\Loc5D2.PNG', 2, 1, 600, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009BAF1F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (605, 20, N'Si', N'Descarte 3', N'', 4, 1, 600, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009BBA55 AS DateTime))
GO
print 'Processed 600 total records'
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (606, 20, N'No', N'Speech y Tipificar', N'', 5, 1, 600, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009BC375 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (607, 21, N'Speech y Tipificar', N'', N'C:\fakepath\Loc5Des2No.PNG', 2, 1, 606, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009BCCDE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (608, 21, N'Fin', N'', N'', 3, 1, 606, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009BD39C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (609, 21, N'Descarte 3', N'', N'C:\fakepath\Loc5D3.PNG', 2, 1, 605, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009BE63D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (610, 21, N'Si', N'Speech y Tipificar', N'', 4, 1, 605, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009BEC7E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (611, 21, N'No', N'Speech y Tipificar', N'', 5, 1, 605, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009BF384 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (612, 22, N'Speech y Tipificar', N'', N'C:\fakepath\Loc5Des3Si.PNG', 2, 1, 610, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009BFB4D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (613, 22, N'Fin', N'', N'', 3, 1, 610, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009C0119 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (614, 22, N'Speech y Tipificar', N'', N'C:\fakepath\Loc5Des3No.PNG', 2, 1, 611, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009C0B9D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (615, 22, N'Fin', N'', N'', 3, 1, 611, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009C11BA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (616, 23, N'Locución 4 - Descarte 1', N'', N'C:\fakepath\Loc4D1.PNG', 2, 1, 561, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009C6DBB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (617, 23, N'Si', N'Descarte 2', N'', 4, 1, 561, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009C77F1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (618, 23, N'No', N'Speech y Tipificar', N'', 5, 1, 561, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009C87CD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (619, 24, N'Speech y Tipificar', N'', N'C:\fakepath\Loc4Des1No.PNG', 2, 1, 618, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009C915A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (620, 24, N'Fin', N'', N'', 3, 1, 618, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009CA311 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (621, 24, N'Descarte 2', N'', N'C:\fakepath\Loc4D2.PNG', 2, 1, 617, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009CB747 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (622, 24, N'Si', N'Descarte 3', N'', 4, 1, 617, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009CC0A1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (623, 24, N'No', N'Speech y Tipificar', N'', 5, 1, 617, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009CC713 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (624, 25, N'Speech y Tipificar', N'', N'C:\fakepath\Loc4Des2No.PNG', 2, 1, 623, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009CD0DB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (625, 25, N'Fin', N'', N'', 3, 1, 623, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009CD711 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (626, 25, N'Descarte 3', N'', N'C:\fakepath\Loc4D3.PNG', 2, 1, 622, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009D1AED AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (627, 25, N'Si', N'Speech y Tipificar', N'', 4, 1, 622, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009D2A2C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (628, 25, N'No', N'Speech y Tipificar', N'', 5, 1, 622, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009D310D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (629, 26, N'Speech y Tipificar', N'', N'C:\fakepath\Loc4Des3Si.PNG', 2, 1, 627, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009D3BE4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (630, 26, N'Fin', N'', N'', 3, 1, 627, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009D426D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (631, 26, N'Speech y Tipificar', N'', N'C:\fakepath\Loc4Des3No.PNG', 2, 1, 628, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009D4AF5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (632, 26, N'Fin', N'', N'', 3, 1, 628, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778009D518C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (633, 27, N'Locución 3 - Descarte 1', N'', N'C:\fakepath\Loc3D1.PNG', 2, 1, 560, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009D9717 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (634, 27, N'Si', N'Descarte 2', N'', 4, 1, 560, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009D9F71 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (635, 27, N'No', N'Speech y Tipificar', N'', 5, 1, 560, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009DB059 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (636, 28, N'Speech y Tipificar', N'', N'C:\fakepath\Loc3Des1No.PNG', 2, 1, 635, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009DB92D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (637, 28, N'Fin', N'', N'', 3, 1, 635, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009DBFDF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (638, 28, N'Descarte 2', N'', N'C:\fakepath\Loc3D2.PNG', 2, 1, 634, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009DC9FF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (639, 28, N'Si', N'Descarte 3', N'', 4, 1, 634, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009DD1F6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (640, 28, N'No', N'Speech y Tipificar', N'', 5, 1, 634, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009DD947 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (641, 29, N'Speech y Tipificar', N'', N'C:\fakepath\Loc3Des2No.PNG', 2, 1, 640, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009DDFD4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (642, 29, N'Fin', N'', N'', 3, 1, 640, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009DE58D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (643, 29, N'Descarte 3', N'', N'C:\fakepath\Loc3D3.PNG', 2, 1, 639, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009DF5AE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (644, 29, N'Si', N'Speech y Tipificar', N'', 4, 1, 639, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009E00CD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (645, 29, N'No', N'Speech y Tipificar', N'', 5, 1, 639, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009E1130 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (646, 30, N'Speech y Tipificar', N'', N'C:\fakepath\Loc3Des3Si.PNG', 2, 1, 644, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009E24BA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (647, 30, N'Fin', N'', N'', 3, 1, 644, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009E2B45 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (648, 30, N'Speech y Tipificar', N'', N'C:\fakepath\Loc3Des3No.PNG', 2, 1, 645, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009E3447 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (649, 30, N'Fin', N'', N'', 3, 1, 645, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009E3BA3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (650, 31, N'Locución 2 - Descarte 1', N'', N'C:\fakepath\Loc2D1.PNG', 2, 1, 559, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009EAC0F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (651, 31, N'(Ver imagen)', N'', N'', 2, 1, 559, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009EBAA8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (652, 31, N'Si', N'Solicitar lo siguiente', N'', 4, 1, 559, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009EDBDC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (653, 31, N'No', N'Descarte 2', N'', 5, 1, 559, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009EE492 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (654, 32, N'Solicitar lo siguiente', N'', N'C:\fakepath\Loc2Des1SiAcc1.PNG', 2, 1, 652, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009F05C6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (655, 32, N'Si', N'Validar el servicio', N'', 4, 1, 652, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009F1BFA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (656, 32, N'No', N'Speech y Tipificar', N'', 5, 1, 652, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009F2A4B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (657, 33, N'Speech y Tipificar', N'', N'C:\fakepath\Loc2Des1SiAcc1No.PNG', 2, 1, 656, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009F42CD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (658, 33, N'Fin', N'', N'', 3, 1, 656, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009F50F2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (659, 33, N'Validar el servicio', N'', N'C:\fakepath\Loc2Des1SiAcc2.PNG', 2, 1, 655, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009F69BB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (660, 33, N'Si', N'Tipificar', N'', 4, 1, 655, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009F7BF2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (661, 33, N'No', N'Speech y Tipificar', N'', 5, 1, 655, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009F8A11 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (662, 34, N'Tipificar', N'', N'C:\fakepath\Loc2Des1SiAcc2Si.PNG', 2, 1, 660, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009F96AE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (663, 34, N'Fin', N'', N'', 3, 1, 660, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009F9F90 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (664, 34, N'Speech y Tipificar', N'', N'C:\fakepath\Loc2Des1SiAcc2No.PNG', 2, 1, 661, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009FA9E4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (665, 34, N'Fin', N'', N'', 3, 1, 661, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009FB2A4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (666, 32, N'Descarte 2', N'', N'C:\fakepath\Loc2D2.PNG', 2, 1, 653, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A778009FC528 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (667, 32, N'Si', N'Descarte 3', N'', 4, 1, 653, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77800A03A20 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (668, 32, N'No', N'Speech y Tipificar', N'', 5, 1, 653, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77800A045E1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (669, 33, N'Speech y Tipificar', N'', N'C:\fakepath\Loc2Des2No.PNG', 2, 1, 668, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A086B2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (670, 33, N'Fin', N'', N'', 3, 1, 668, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A09EEC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (671, 33, N'Descarte 3', N'', N'C:\fakepath\Loc2D3.PNG', 2, 1, 667, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A0AAA4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (672, 33, N'Si', N'Solicitar lo Siguiente', N'', 4, 1, 667, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A0C860 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (673, 33, N'No', N'Speech y Tipificar', N'', 5, 1, 667, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A0D1B9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (674, 34, N'Speech y Tipificar', N'', N'C:\fakepath\Loc2Des3No.PNG', 2, 1, 673, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A0EC29 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (675, 34, N'Fin', N'', N'', 3, 1, 673, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A0F353 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (676, 34, N'Solicitar lo Siguiente', N'', N'C:\fakepath\Loc2Des3SiAcc1.PNG', 2, 1, 672, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A144C8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (677, 34, N'Si', N'Validar el Servicio', N'', 4, 1, 672, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A15E71 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (678, 34, N'No', N'Speech y Tipificar', N'', 5, 1, 672, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A1679C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (679, 35, N'Speech y Tipificar', N'', N'C:\fakepath\Loc2Des3SiAcc1No.PNG', 2, 1, 678, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A1721F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (680, 35, N'Fin', N'', N'', 3, 1, 678, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A1795D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (681, 35, N'Validar el Servicio', N'', N'C:\fakepath\Loc2Des1SiAcc2.PNG', 2, 1, 677, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A1C7AC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (682, 35, N'Si', N'Tipificar', N'', 4, 1, 677, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A1D8E5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (683, 35, N'No', N'Speech y Tipificar', N'', 5, 1, 677, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A1E2F6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (684, 36, N'Tipificar', N'', N'C:\fakepath\Loc2Des3SiAcc2Si.PNG', 2, 1, 682, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A1F3AD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (685, 36, N'Fin', N'', N'', 3, 1, 682, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A1F9C3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (686, 36, N'Speech y Tipificar', N'', N'C:\fakepath\Loc2Des3SiAcc2No.PNG', 2, 1, 683, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A21320 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (687, 36, N'Fin', N'', N'', 3, 1, 683, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A219D0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (688, 32, N'(Ver imagen)', N'', N'', 2, 1, 653, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A39BED AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (689, 32, N'Si', N'Descarte 3', N'', 4, 1, 653, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A3A959 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (690, 32, N'No', N'Speech y Tipificar', N'', 5, 1, 653, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A3C459 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (691, 34, N'Speech y Tipificar', N'-', N'C:\fakepath\Loc2Des2No.PNG', 2, 1, 690, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A3D26B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (692, 33, N'Fin', N'', N'', 3, 1, 690, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A3DA70 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (693, 33, N'Descarte 3', N'', N'C:\fakepath\Loc2D3.PNG', 2, 1, 689, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A3E82C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (694, 33, N'Si', N'Solicitar lo siguiente', N'', 4, 1, 689, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A40090 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (695, 33, N'No', N'Speech y Tipificar', N'', 5, 1, 689, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A41BFF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (696, 34, N'Speech y Tipificar', N'', N'C:\fakepath\Loc2Des3No.PNG', 2, 1, 695, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A43138 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (697, 34, N'Fin', N'', N'', 3, 1, 695, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A43812 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (698, 34, N'Solicitar lo siguiente', N'', N'C:\fakepath\Loc2Des3SiAcc1.PNG', 2, 1, 694, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A46E3D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (699, 34, N'Si', N'Validar servicio', N'', 4, 1, 694, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A47BD5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (700, 34, N'No', N'Speech y Tipificar', N'', 5, 1, 694, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A48D7C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (701, 35, N'Speech y Tipificar', N'', N'C:\fakepath\Loc2Des3SiAcc1No.PNG', 2, 1, 700, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A49DF9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (702, 35, N'Fin', N'', N'', 3, 1, 700, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A4A588 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (703, 35, N'Validar servicio', N'', N'C:\fakepath\Loc2Des1SiAcc2.PNG', 2, 1, 699, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A4B43B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (704, 35, N'Si', N'Tipificar', N'', 4, 1, 699, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A4D6C2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (705, 35, N'No', N'Speech y Tipificar', N'', 5, 1, 699, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A4DCD8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (706, 36, N'Tipificar', N'', N'C:\fakepath\Loc2Des3SiAcc2Si.PNG', 2, 1, 704, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A4F1D0 AS DateTime))
GO
print 'Processed 700 total records'
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (707, 36, N'Fin', N'', N'', 3, 1, 704, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A4F79E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (708, 36, N'Speech y Tipificar', N'', N'C:\fakepath\Loc2Des3SiAcc2No.PNG', 2, 1, 705, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A5063B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (709, 36, N'Fin', N'', N'', 3, 1, 705, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A50BFD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (710, 37, N'Locución 1 - Descarte 1', N'', N'C:\fakepath\DBD1.PNG', 2, 1, 558, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A615EA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (711, 37, N'(Ver imagen)', N'', N'', 2, 1, 558, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A65547 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (712, 37, N'Si', N'Descarte 2', N'', 4, 1, 558, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A6D134 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (713, 37, N'No', N'Speech y Tipificar', N'', 5, 1, 558, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A6DB90 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (714, 38, N'Periodo de Gracia', N'Periodo de Gracia', N'C:\fakepath\Loc1Des1NoPG.PNG', 5, 1, 713, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A777A5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (715, 38, N'Reciclado', N'Reciclado', N'C:\fakepath\Loc1Des1NoRec.PNG', 5, 1, 713, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A7B4B4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (716, 38, N'Preactivo', N'Preactivo', N'C:\fakepath\Loc1Des1NoPre.PNG', 4, 1, 713, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A7C83D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (717, 1, N'Periodo de Gracia', N'-', N'C:\fakepath\Loc1Des1NoPG.PNG', 2, 1, 714, 0, N'Brindar el siguiente speech:"Para mayor detalle de su línea debe acercarse a cualquiera de nuestros Centros de Atención al Cliente, donde  nuestros asesores especializados gustosamente lo atenderán”.[ATVozPreSalLoc1Des1No] Estado de la línea Preactivo', 1, 1, 1, N'yellow', CAST(0x0000A77800A8F797 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (718, 39, N'Fin', N'', N'', 3, 1, 714, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A8FDDD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (719, 2, N'Reciclado', N'-', N'C:\fakepath\Loc1Des1NoRec.PNG', 2, 1, 715, 0, N'', 1, 1, 1, N'green', CAST(0x0000A77800A90BB5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (720, 39, N'Fin', N'', N'', 3, 1, 715, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A9126C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (721, 39, N'Preactivo', N'', N'C:\fakepath\Loc1Des1NoPre.PNG', 2, 1, 716, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A91C24 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (722, 39, N'Fin', N'', N'', 3, 1, 716, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A93C9B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (723, 38, N'Descarte 2', N'', N'C:\fakepath\DBD2.PNG', 2, 1, 712, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A973F0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (724, 38, N'Si', N'Descarte 3', N'', 4, 1, 712, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A97EAE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (725, 38, N'No', N'Speech y Tipificar', N'', 5, 1, 712, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A98C6C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (726, 39, N'Speech y Tipificar	', N'', N'C:\fakepath\Loc1Des2No.PNG', 2, 1, 725, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A99B57 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (727, 39, N'Fin', N'', N'', 3, 1, 725, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800A9A3FE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (728, 39, N'Descarte 3', N'', N'C:\fakepath\D3.PNG', 2, 1, 724, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AA6087 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (729, 39, N'Si', N'Descarte 4', N'', 4, 1, 724, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AA7721 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (730, 39, N'No', N'Realizar lo Siguiente', N'', 5, 1, 724, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AA86A5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (731, 40, N'Realizar lo Siguiente', N'', N'C:\fakepath\Loc1Des3Acc1.PNG', 2, 1, 730, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AAB834 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (732, 40, N'Consultar lo Siguiente', N'Consultar lo Siguiente', N'', 4, 1, 730, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AAD28B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (733, 41, N'Consultar lo Siguiente', N'', N'C:\fakepath\Loc1Des3Acc2.PNG', 2, 1, 732, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AB126D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (734, 41, N'Si', N'Indicar comando', N'', 4, 1, 732, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AB31AA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (735, 41, N'No', N'Ver tipificación NINTEX', N'', 5, 1, 732, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AB446E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (736, 42, N'Indicar comando', N'', N'C:\fakepath\Loc1Des3Acc3.PNG', 2, 1, 734, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AB5A3C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (737, 42, N'Si', N'Descarte 4', N'', 4, 1, 734, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AB79DB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (738, 42, N'No', N'Brindar Speech', N'', 5, 1, 734, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AB8C62 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (739, 42, N'Ver tipificación NINTEX', N'', N'C:\fakepath\TipiNINTEX.PNG', 2, 1, 735, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AB9F5B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (740, 42, N'Si', N'Brindar Speech', N'', 4, 1, 735, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800ABBEE7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (741, 42, N'No', N'Realizar NINTEX', N'', 5, 1, 735, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800ABC9C0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (742, 43, N'Realizar NINTEX', N'', N'C:\fakepath\NINTEX.PNG', 2, 1, 741, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800ABD9E3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (743, 43, N'Fin', N'', N'', 3, 1, 741, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800ABE0B8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (744, 43, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 740, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800ABEC9B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (745, 43, N'Si', N'Generar Caso', N'', 4, 1, 740, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800ABF71D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (746, 43, N'No', N'Generar Reclamo', N'', 5, 1, 740, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AC010D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (747, 44, N'Generar Caso', N'', N'C:\fakepath\Loc1Des3Acc2NoDes1SiCaso.PNG', 2, 1, 745, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AC1DA2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (748, 44, N'Fin', N'', N'', 3, 1, 745, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AC257F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (749, 44, N'Generar Reclamo', N'', N'C:\fakepath\Loc1Des3Acc2NoDes1SiReclamo.PNG', 2, 1, 746, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AE6A2D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (750, 44, N'Fin', N'', N'', 3, 1, 746, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AE706E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (751, 43, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 738, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AEA872 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (752, 43, N'Si', N'Generar Caso', N'', 4, 1, 738, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AEB3D6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (753, 43, N'No', N'Generar Reclamo', N'', 5, 1, 738, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AEBC16 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (754, 44, N'Generar Caso', N'', N'C:\fakepath\Loc1Des3Acc3NoCaso.PNG', 2, 1, 752, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AEFD44 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (755, 44, N'Fin', N'', N'', 3, 1, 752, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AF03AC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (756, 44, N'Generar Reclamo', N'', N'C:\fakepath\Loc1Des3Acc3NoReclamo.PNG', 2, 1, 753, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AF18EC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (757, 44, N'Fin', N'', N'', 3, 1, 753, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800AF2030 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (758, 40, N'Descarte 4', N'', N'C:\fakepath\D4.PNG', 2, 1, 729, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D03044 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (759, 40, N'Si', N'Solicitar lo siguiente', N'', 4, 1, 729, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D05CF5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (760, 40, N'No', N'Solicitar lo siguiente', N'', 5, 1, 729, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D066D1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (761, 41, N'Solicitar lo siguiente', N'', N'C:\fakepath\Loc1Des4NoAcc1.PNG', 2, 1, 759, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D09491 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (762, 41, N'Si', N'Validar Servicio', N'', 4, 1, 759, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D0A88E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (763, 41, N'No', N'Speech y Tipifica', N'', 5, 1, 759, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D0B394 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (764, 42, N'Speech y Tipifica', N'', N'C:\fakepath\Loc1Des4SiAcc1.PNG', 2, 1, 763, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D0E258 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (765, 42, N'Fin', N'', N'', 3, 1, 763, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D0E8F1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (766, 1, N'Validar Servicio', N'-', N'C:\fakepath\Loc1Des4SiAcc2.PNG', 2, 1, 762, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D103B2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (767, 42, N'Si', N'Tipifica', N'', 4, 1, 762, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D11B16 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (768, 42, N'No', N'Speech y Tipifica', N'', 5, 1, 762, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D122A2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (769, 1, N'Tipifica', N'-', N'C:\fakepath\Loc1Des4SiAcc2Sii.PNG', 2, 1, 767, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D1398E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (770, 43, N'Fin', N'', N'', 3, 1, 767, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D149A3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (771, 1, N'Speech y Tipifica', N'-', N'C:\fakepath\Loc1Des4SiAcc2No.PNG', 2, 1, 768, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D15D43 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (772, 43, N'Fin', N'', N'', 3, 1, 768, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D1640F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (773, 41, N'Solicitar lo siguiente', N'', N'C:\fakepath\Loc1Des4NoAcc1.PNG', 2, 1, 760, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D1993C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (774, 41, N'Si', N'Realizar lo siguiente', N'', 4, 1, 760, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D1AE60 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (775, 41, N'No', N'Ver Tipificación NINTEX', N'', 5, 1, 760, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D1BECC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (776, 42, N'Ver Tipificación NINTEX', N'', N'C:\fakepath\TipiNINTEX.PNG', 2, 1, 775, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D1CEB8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (777, 42, N'Si', N'Brindar Speech', N'', 4, 1, 775, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D1EDEF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (778, 42, N'No', N'Realizar NINTEX', N'', 5, 1, 775, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D1F684 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (779, 43, N'Realizar NINTEX', N'', N'C:\fakepath\NINTEX.PNG', 2, 1, 778, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D201B3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (780, 43, N'Fin', N'', N'', 3, 1, 778, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D2087E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (781, 43, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 777, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D213D1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (782, 43, N'Si', N'Generar Caso', N'', 4, 1, 777, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D21D67 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (783, 43, N'No', N'Generar Reclamo', N'', 5, 1, 777, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D227AF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (784, 44, N'Generar Caso', N'', N'C:\fakepath\Loc1Des4NoAcc2NoCaso.PNG', 2, 1, 782, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D24F91 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (785, 44, N'Fin', N'', N'', 3, 1, 782, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D256F1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (786, 44, N'Generar Reclamo', N'', N'C:\fakepath\Loc1Des4NoAcc2NoReclamo.PNG', 2, 1, 783, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D26D95 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (787, 44, N'Fiin', N'', N'', 3, 1, 783, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D274C1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (788, 42, N'Realizar lo siguiente', N'', N'C:\fakepath\Loc1Des4NoAcc2.PNG', 2, 1, 774, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D2DB3D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (789, 44, N'Si', N'Solicitar lo siguiente', N'', 4, 1, 774, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D2F5A3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (790, 42, N'No', N'Brindar speech', N'', 5, 1, 774, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D2FF96 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (791, 43, N'Brindar speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 790, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D3166C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (792, 43, N'Si', N'Generar Caso', N'', 4, 1, 790, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D322F3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (793, 43, N'No', N'Generar Reclamo', N'', 5, 1, 790, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D33190 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (794, 44, N'Generar Caso', N'', N'C:\fakepath\DBDes11NoAcc2NoCaso.PNG', 2, 1, 792, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D34694 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (795, 44, N'Fin', N'', N'', 3, 1, 792, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D34DFF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (796, 44, N'Generar Reclamo', N'', N'C:\fakepath\DBDes11NoAcc2NoReclamo.PNG', 2, 1, 793, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D35EB6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (797, 44, N'Fin', N'', N'', 3, 1, 793, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77800D3676C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (798, 43, N'Descarte 4', N'', N'C:\fakepath\D4.PNG', 2, 1, 737, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77801227E11 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (799, 43, N'Si', N'Solicitar lo siguiente', N'', 4, 1, 737, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778012298C4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (800, 43, N'No', N'Solicitar lo siguiente', N'', 5, 1, 737, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77801229F2B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (801, 44, N'Solicitar lo siguiente', N'', N'C:\fakepath\Loc1Des4NoAcc1.PNG', 2, 1, 799, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A7780122B8A2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (802, 44, N'Si', N'Validar Servicio', N'', 4, 1, 799, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A7780122CCFD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (803, 44, N'No', N'Speech y Tipificar', N'', 5, 1, 799, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A7780122D7C7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (804, 45, N'Speech y Tipificar', N'', N'C:\fakepath\Loc1Des4SiAcc1No.PNG', 2, 1, 803, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77801230A3C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (805, 45, N'Fin', N'', N'', 3, 1, 803, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778012312BD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (806, 46, N'Validar Servicio', N'-', N'C:\fakepath\LlamadaPrueba.PNG', 2, 1, 802, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77801232F9E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (807, 45, N'Si', N'Tipificar', N'', 4, 1, 802, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77801233F47 AS DateTime))
GO
print 'Processed 800 total records'
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (808, 45, N'No', N'Speech y Tipificar', N'', 5, 1, 802, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A778012347F9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (809, 46, N'Tipificar', N'', N'C:\fakepath\LlamadaPrueba.PNG', 2, 1, 807, 0, N'', 1, 1, 2, N'noselected', CAST(0x0000A7780125553E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (810, 44, N'Solicitar lo siguiente', N'', N'C:\fakepath\Loc1Des4SiAcc1.PNG', 2, 1, 800, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A6CA07 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (811, 44, N'Si', N'Realizar lo siguiente', N'', 4, 1, 800, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A6E155 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (812, 44, N'No', N'Ver Tipificación NINTEX', N'', 5, 1, 800, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A6F13C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (813, 45, N'Ver Tipificación NINTEX', N'', N'C:\fakepath\TipiNINTEX.PNG', 2, 1, 812, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A71BAE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (814, 45, N'Si', N'Brindar Speech', N'', 4, 1, 812, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A72C7E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (815, 45, N'No', N'Realizar NINTEX', N'', 5, 1, 812, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A736E8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (816, 46, N'Realizar NINTEX', N'', N'C:\fakepath\NINTEX.PNG', 2, 1, 815, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A74416 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (817, 46, N'Fin', N'', N'', 3, 1, 815, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A74C90 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (818, 46, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 814, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A75982 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (819, 46, N'Si', N'Generar Caso', N'', 4, 1, 814, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A765D7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (820, 46, N'No', N'Generar Reclamo', N'', 5, 1, 814, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A76F72 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (821, 47, N'Generar Caso', N'', N'C:\fakepath\Loc1Des4NoAcc1NoDes1SiCaso.PNG', 2, 1, 819, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A7BC39 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (822, 47, N'Fin', N'', N'', 3, 1, 819, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A7C2D1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (823, 47, N'Generar Reclamo', N'', N'C:\fakepath\Loc1Des4NoAcc1NoDes1SiReclamo.PNG', 2, 1, 820, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A7D5F6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (824, 47, N'Fin', N'', N'', 3, 1, 820, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A7DD08 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (825, 45, N'Realizar lo siguiente', N'', N'C:\fakepath\Loc1Des4NoAcc2.PNG', 2, 1, 811, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A7F382 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (826, 45, N'Si', N'Solicitar lo siguiente', N'', 4, 1, 811, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A85C2E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (827, 45, N'No', N'Brindar Speech', N'', 5, 1, 811, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A88269 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (828, 46, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 827, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A89117 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (829, 46, N'Si', N'Generar Caso', N'', 4, 1, 827, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A8A023 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (830, 46, N'No', N'Generar Reclamo', N'', 5, 1, 827, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A8AA2E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (831, 47, N'Generar Caso', N'', N'C:\fakepath\Loc1Des4NoAcc2NoCaso.PNG', 2, 1, 829, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A8C491 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (832, 47, N'Fin', N'', N'', 3, 1, 829, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A8CC93 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (833, 47, N'Generar Reclamo', N'', N'C:\fakepath\Loc1Des4NoAcc2NoReclamo.PNG', 2, 1, 830, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A8DDE3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (834, 47, N'Fin', N'', N'', 3, 1, 830, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A8E50D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (835, 46, N'Solicitar lo siguiente', N'', N'C:\fakepath\Loc1Des4SiAcc1.PNG', 2, 1, 826, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A904EA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (836, 46, N'Si', N'Validar Servicio', N'', 4, 1, 826, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A91DB9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (837, 46, N'No', N'Speech y Tipificar', N'', 5, 1, 826, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A92C27 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (838, 47, N'Speech y Tipificar', N'', N'C:\fakepath\Loc1Des4SiAcc1No.PNG', 2, 1, 837, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A943AE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (839, 47, N'Fin', N'', N'', 3, 1, 837, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A94966 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (840, 47, N'Validar Servicio', N'', N'C:\fakepath\Loc1Des4SiAcc2.PNG', 2, 1, 836, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A9A237 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (841, 47, N'Si', N'Speech y Tipifica', N'', 4, 1, 836, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A9C0F2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (842, 47, N'No', N'Speech y Tipifica', N'', 5, 1, 836, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A9E529 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (843, 48, N'Speech y Tipifica', N'', N'C:\fakepath\Loc1Des4SiAcc2Sii.PNG', 2, 1, 841, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A9EF12 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (844, 48, N'Fin', N'', N'', 3, 1, 841, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900A9F63E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (845, 48, N'Speech y Tipifica', N'', N'C:\fakepath\Loc1Des4SiAcc2No.PNG', 2, 1, 842, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AA001D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (846, 48, N'Fin', N'', N'', 3, 1, 842, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AA08BF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (847, 1, N'Descarte 2', N'-', N'C:\fakepath\D2SL.PNG', 2, 1, 549, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AA8777 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (848, 7, N'Si', N'Consultar al Cliente', N'', 4, 1, 549, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AA9CE1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (849, 7, N'No', N'Descarte 3', N'', 5, 1, 549, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AAA971 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (850, 1, N'Descarte 3', N'-', N'C:\fakepath\D3SL.PNG', 2, 1, 849, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AAB3C8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (851, 8, N'(Ver imagen)', N'', N'', 2, 1, 849, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AAC945 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (852, 8, N'Si', N'Descarte 4', N'', 4, 1, 849, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AAD1D7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (853, 8, N'No', N'Consultar al cliente', N'', 5, 1, 849, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AADCA5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (854, 1, N'Descarte 4', N'-', N'C:\fakepath\D4SL.PNG', 2, 1, 852, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AAE529 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (855, 9, N'Si', N'Speech y Tipifica', N'', 4, 1, 852, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AB0324 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (856, 9, N'No', N'Descarte 5', N'', 5, 1, 852, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AB0BD2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (857, 1, N'Descarte 5', N'-', N'C:\fakepath\D5SL.PNG', 2, 1, 856, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AB153E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (858, 10, N'Si', N'Speech y Tipifica', N'', 4, 1, 856, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AB247F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (859, 10, N'No', N'Descarte 6', N'', 5, 1, 856, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AB2DEA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (860, 1, N'Descarte 6', N'-', N'C:\fakepath\D6SL.PNG', 2, 1, 859, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AB394A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (861, 12, N'Si', N'Speech y Tipifica', N'', 4, 1, 859, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AB551F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (862, 12, N'No', N'Descarte 7', N'', 5, 1, 859, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AB5B8B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (863, 1, N'Descarte 7', N'-', N'C:\fakepath\D7SL.PNG', 2, 1, 862, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AB8470 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (864, 11, N'Si', N'Desc. sin Locución - Descarte 1', N'', 4, 1, 862, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AB9884 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (865, 13, N'No', N'Descarte 8', N'', 5, 1, 862, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900AB9FFB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (866, 1, N'Descarte 8', N'-', N'C:\fakepath\D8SL.PNG', 2, 1, 865, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900ABAA57 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (867, 1, N'Si', N'Locuciones', N'', 4, 1, 865, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900ABDEED AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (868, 14, N'No', N'Descarte 1', N'', 5, 1, 865, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900ABE87A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (869, 13, N'Speech y Tipifica', N'', N'C:\fakepath\SLDes6Si.PNG', 2, 1, 861, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900B314F5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (870, 13, N'Fin', N'', N'', 3, 1, 861, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900B31B19 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (871, 10, N'Speech y Tipifica', N'-', N'C:\fakepath\SLDes5Sii.PNG', 2, 1, 858, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900B32F1B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (872, 11, N'Fin', N'', N'', 3, 1, 858, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900B33583 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (873, 10, N'Speech y Tipifica', N'', N'C:\fakepath\SLDes4Si.PNG', 2, 1, 855, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900B343F0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (874, 10, N'Fin', N'', N'', 3, 1, 855, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900B349F0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (875, 7, N'Acción 1', N'', N'C:\fakepath\SLDes1SiAcc1.PNG', 2, 1, 548, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900B694D5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (876, 7, N'(Ver imagen)', N'', N'', 2, 1, 548, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900B6A113 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (877, 7, N'Si', N'Descarte 2', N'', 4, 1, 548, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900B6AC4C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (878, 7, N'No', N'Speech y Tipifica', N'', 5, 1, 548, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900B6B877 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (879, 8, N'Speech y Tipifica', N'', N'C:\fakepath\SLDes1SiAcc1No.PNG', 2, 1, 878, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900B6CEFA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (880, 8, N'Fin', N'', N'', 3, 1, 878, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900B6D874 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (881, 1, N'Descarte 2', N'-', N'C:\fakepath\RegresarDescarte.PNG', 2, 1, 877, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900B838A3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (882, 8, N'Consultar al Cliente', N'', N'C:\fakepath\SLDes2SiAcc1.PNG', 2, 1, 848, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900C7ACE8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (883, 8, N'Si', N'Marca y modelo de Equipo', N'', 4, 1, 848, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900C7D4E6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (884, 8, N'No', N'Speech y Tipifica', N'', 5, 1, 848, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900C7E144 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (885, 9, N'Speech y Tipifica', N'', N'C:\fakepath\SLDes2SiAcc1No.PNG', 2, 1, 884, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900C81177 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (886, 9, N'Fin', N'', N'', 3, 1, 884, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900C817A9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (887, 9, N'Marca y modelo de Equipo', N'', N'C:\fakepath\SLDes2SiAcc2.PNG', 2, 1, 883, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900C82C8A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (888, 9, N'Si', N'Realizar configuraciones', N'', 4, 1, 883, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900C84946 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (889, 9, N'No', N'Speech y tipifica', N'', 5, 1, 883, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900C855D1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (890, 10, N'Speech y tipifica', N'', N'C:\fakepath\speechequipos.PNG', 2, 1, 889, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CACCD9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (891, 10, N'Fin', N'', N'', 3, 1, 889, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CAD2E5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (892, 10, N'Realizar configuraciones', N'-', N'C:\fakepath\SOE.PNG', 2, 1, 888, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CC425C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (893, 10, N'HTC', N'HTC', N'C:\fakepath\SLDes2SiAcc2SiAcc1HTC.PNG', 5, 1, 888, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CC6344 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (894, 10, N'Iphone', N'Iphone', N'C:\fakepath\SLDes2SiAcc2SiAcc1iphone.PNG', 5, 1, 888, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CC833A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (895, 10, N'LG', N'LG', N'C:\fakepath\SLDes2SiAcc2SiAcc1LG.PNG', 5, 1, 888, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CC94E4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (896, 10, N'Nokia', N'Nokia	', N'C:\fakepath\SLDes2SiAcc2SiAcc1Nokia.PNG', 5, 1, 888, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CCA101 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (897, 10, N'Samsung', N'Samsung', N'C:\fakepath\SLDes2SiAcc2SiAcc1Sansung.PNG', 5, 1, 888, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CCAEDE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (898, 11, N'HTC', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc1HTC.PNG', 2, 1, 893, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CDC797 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (899, 11, N'Iphone', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc1iphone.PNG', 2, 1, 894, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CDD174 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (900, 11, N'LG', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc1LG.PNG', 2, 1, 895, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CDDA6B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (901, 11, N'Nokia', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc1Nokia.PNG', 2, 1, 896, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CDE5C1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (902, 11, N'Samsung', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc1Sansung.PNG', 2, 1, 897, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CDEFD7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (903, 13, N'Consultar lo siguiente', N'Consultar lo siguiente', N'', 4, 1, 896, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CF9C0B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (904, 12, N'Consultar lo siguiente', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc2.PNG', 2, 1, 903, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CFC313 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (905, 12, N'Si', N'Speech y Tipifica', N'', 4, 1, 903, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CFD303 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (906, 12, N'No', N'Speech y Tipifica', N'', 5, 1, 903, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CFD980 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (907, 13, N'Speech y Tipifica', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc2Si.PNG', 2, 1, 905, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CFF6F1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (908, 13, N'Fin', N'', N'', 3, 1, 905, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900CFFD98 AS DateTime))
GO
print 'Processed 900 total records'
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (909, 13, N'Speech y Tipifica', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc2No.PNG', 2, 1, 906, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D02890 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (910, 13, N'Fin', N'', N'', 3, 1, 906, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D02F08 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (911, 11, N'Consultar lo siguiente', N'Consultar lo siguiente', N'', 5, 1, 897, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D15B3F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (912, 12, N'Consultar lo siguiente', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc2.PNG', 2, 1, 911, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D171C2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (913, 12, N'Si', N'Speech y Tipifica', N'', 4, 1, 911, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D17C36 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (914, 12, N'No', N'Speech y Tipifica', N'', 5, 1, 911, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D188DB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (915, 13, N'Speech y Tipifica', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc2Si.PNG', 2, 1, 913, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D19892 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (916, 13, N'Fin', N'', N'', 3, 1, 913, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D19F18 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (917, 13, N'Speech y Tipifica', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc2No.PNG', 2, 1, 914, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D1A9F5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (918, 13, N'Fin', N'', N'', 3, 1, 914, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D1B41B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (919, 11, N'Consultar lo siguiente', N'Consultar lo siguiente', N'', 4, 1, 893, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D1DC51 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (920, 12, N'Consultar lo siguiente', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc2.PNG', 2, 1, 919, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D1E5DA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (921, 12, N'Si', N'Speech y Tipifica', N'', 4, 1, 919, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D1F529 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (922, 12, N'No', N'Speech y Tipifica', N'', 5, 1, 919, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D1FF8E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (923, 13, N'Speech y Tipifica', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc2Si.PNG', 2, 1, 921, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D208EF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (924, 13, N'Fin', N'', N'', 3, 1, 921, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D216E4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (925, 13, N'Speech y Tipifica', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc2No.PNG', 2, 1, 922, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D222AB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (926, 13, N'Fin', N'', N'', 3, 1, 922, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D2296D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (927, 11, N'Consultar lo siguiente', N'Consultar lo siguiente', N'', 5, 1, 894, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D237E4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (928, 12, N'Consultar lo siguiente', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc2.PNG', 2, 1, 927, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D24421 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (929, 12, N'Si', N'Speech y Tipifica', N'', 4, 1, 927, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D25443 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (930, 12, N'No', N'Speech y Tipifica', N'', 5, 1, 927, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D25B19 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (931, 13, N'Speech y Tipifica', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc2Si.PNG', 2, 1, 929, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D264F8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (932, 13, N'Fin', N'', N'', 3, 1, 929, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D26D25 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (933, 13, N'Speech y Tipifica', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc2No.PNG', 2, 1, 930, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D2777F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (934, 13, N'Fin', N'', N'', 3, 1, 930, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D28272 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (935, 11, N'Consultar lo siguiente', N'Consultar lo siguiente', N'', 5, 1, 895, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D28F88 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (936, 12, N'Consultar lo siguiente', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc2.PNG', 2, 1, 935, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D29B1D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (937, 12, N'Si', N'Speech y Tipifica', N'', 4, 1, 935, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D2A889 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (938, 12, N'No', N'Speech y Tipifica', N'', 5, 1, 935, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D2AECB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (939, 13, N'Speech y Tipifica', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc2Si.PNG', 2, 1, 937, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D2B918 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (940, 13, N'Fin', N'', N'', 3, 1, 937, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D2BF16 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (941, 13, N'Speech y Tipifica', N'', N'C:\fakepath\SLDes2SiAcc2SiAcc2No.PNG', 2, 1, 938, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D2CFFD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (942, 13, N'Fin', N'', N'', 3, 1, 938, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77900D2D609 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (943, 9, N'Consultar al cliente', N'', N'C:\fakepath\PreRecDes3NoAcc1.PNG', 2, 1, 853, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B0097CC02 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (944, 9, N'Si', N'Realizar NINTEX', N'', 4, 1, 853, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B00981257 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (945, 9, N'No', N'Ver Tipificación Nintex', N'', 5, 1, 853, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B00982304 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (946, 10, N'Ver Tipificación Nintex', N'', N'C:\fakepath\PreRecDes3NoAcc1NoDes1.PNG', 2, 1, 945, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B00983E03 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (947, 10, N'Si', N'Brindar Speech', N'', 4, 1, 945, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B00984BB7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (948, 10, N'No', N'Realizar Nintex', N'', 5, 1, 945, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B00985986 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (949, 11, N'Realizar Nintex', N'', N'C:\fakepath\PreRecDes3NoAcc1NoDes1No.PNG', 2, 1, 948, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B00986B1E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (950, 11, N'Fin', N'', N'', 3, 1, 948, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B009874E3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (951, 11, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 947, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B0098CC75 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (952, 11, N'Si', N'Generar Caso', N'', 4, 1, 947, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B0098D59E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (953, 12, N'No', N'Generar Reclamo', N'', 5, 1, 947, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B0098E4A0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (954, 13, N'Generar Reclamo', N'', N'C:\fakepath\PreRecDes3NoAcc1NoDes1SiReclamo.PNG', 2, 1, 953, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B00994D6F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (955, 13, N'Fin', N'', N'', 3, 1, 953, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B009953D2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (956, 12, N'Generar Caso', N'', N'C:\fakepath\PreRecDes3NoAcc1NoDes1SiCaso.PNG', 2, 1, 952, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B0099B183 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (957, 12, N'Fin', N'', N'', 3, 1, 952, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B0099B9B7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (958, 10, N'Realizar NINTEX', N'', N'C:\fakepath\PreRecDes3NoAcc2.PNG', 2, 1, 944, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B0099EFAD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (959, 1, N'Si', N'', N'', 4, 1, 944, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B009A104F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (960, 10, N'No', N'Brindar Speech', N'', 5, 1, 944, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B009A1E29 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (961, 11, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 960, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B009A2F50 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (962, 11, N'Si', N'Generar Caso', N'', 4, 1, 960, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B009A3A0A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (963, 11, N'No', N'Generar Reclamo', N'', 5, 1, 960, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B009A43A8 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (964, 12, N'Generar Caso', N'', N'C:\fakepath\PreRecDes3NoAcc2NoCaso.PNG', 2, 1, 962, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B009A5378 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (965, 12, N'Fin', N'', N'', 3, 1, 962, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B009A5AE0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (966, 12, N'Generar Reclamo', N'', N'C:\fakepath\PreRecDes3NoAcc2NoReclamo.PNG', 2, 1, 963, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B009A651D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (967, 12, N'Fin', N'', N'', 3, 1, 963, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B009A6B73 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (968, 11, N'Descarte 2', N'', N'C:\fakepath\regresaD2.PNG', 2, 1, 959, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77B009B4C15 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (969, 12, N'Desc. sin Locución - Descarte 1', N'', N'C:\fakepath\PreRecPSLD1.PNG', 2, 1, 864, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009C4998 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (970, 12, N'Si', N'Descarte 2', N'', 4, 1, 864, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77B009C5DFC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (971, 12, N'No', N'Speech y Tipifica', N'', 5, 1, 864, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77B009C6B5C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (972, 13, N'Speech y Tipifica', N'', N'C:\fakepath\PreRecPSLDes1No.PNG', 2, 1, 971, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009CA38F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (973, 13, N'Fin', N'', N'', 3, 1, 971, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009CAA38 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (974, 13, N'Descarte 2', N'', N'C:\fakepath\PreRecPSLD2.PNG', 2, 1, 970, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009CB47C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (975, 13, N'Si', N'Descarte 3', N'', 4, 1, 970, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009CC8A6 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (976, 13, N'No', N'Solicitar lo Siguiente', N'', 5, 1, 970, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009CD3FE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (977, 14, N'Descarte 3', N'', N'C:\fakepath\PreRecPSLD3.PNG', 2, 1, 975, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009CDD2C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (978, 14, N'Si', N'Descarte 4', N'', 4, 1, 975, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009CEDA7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (979, 14, N'No', N'Brindar Speech', N'', 5, 1, 975, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009D0015 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (980, 15, N'Descarte 4', N'', N'C:\fakepath\PreRecPSLD4.PNG', 2, 1, 978, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009D0ABA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (981, 15, N'Si', N'Descarte 5', N'', 4, 1, 978, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009D264E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (982, 15, N'No', N'Solicitar lo siguiente', N'', 5, 1, 978, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009D35E7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (983, 12, N'(Ver imagen)', N'', N'', 2, 1, 864, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009EC60F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (984, 12, N'Si', N'Descarte 2', N'', 4, 1, 864, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009EDAA3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (985, 12, N'No', N'Speech y Tipifica', N'', 5, 1, 864, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009EE823 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (986, 13, N'Descarte 2', N'', N'C:\fakepath\PreRecPSLD2.PNG', 2, 1, 984, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009EF020 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (987, 13, N'(Ver imagen)', N'', N'', 2, 1, 984, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009EF708 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (988, 13, N'Si', N'Descarte 3', N'', 4, 1, 984, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009F0738 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (989, 13, N'No', N'Solicitar lo Siguiente', N'', 5, 1, 984, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009F1A8E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (990, 14, N'Descarte 3', N'', N'C:\fakepath\PreRecPSLD3.PNG', 2, 1, 988, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009F242C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (991, 14, N'(Ver imagen)', N'', N'', 2, 1, 988, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009F2C00 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (992, 14, N'Si', N'Descarte 4', N'', 4, 1, 988, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009F3960 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (993, 14, N'No', N'Brindar Speech', N'', 5, 1, 988, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009F4891 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (994, 15, N'Descarte 4', N'', N'C:\fakepath\PreRecPSLD4.PNG', 2, 1, 992, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009F5786 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (995, 15, N'(Ver imagen)', N'', N'', 2, 1, 992, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009F5E3B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (996, 15, N'Si', N'Descarte 5', N'', 4, 1, 992, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009F6775 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (997, 15, N'No', N'Solicitar lo Siguiente', N'', 5, 1, 992, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009F7A13 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (998, 16, N'Descarte 5', N'', N'C:\fakepath\PreRecPSLD5.PNG', 2, 1, 996, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009F8465 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (999, 16, N'(Ver imagen)', N'', N'', 2, 1, 996, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009F9B09 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1000, 17, N'Si', N'Validar Servicio', N'', 4, 1, 996, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009FA3A4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1001, 16, N'No', N'Speech y Tipificar', N'', 5, 1, 996, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B009FB7D5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1002, 17, N'Descarte 6', N'', N'C:\fakepath\PreRecPSLD6.PNG', 2, 1, 1000, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77B009FBFC7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1003, 17, N'(Ver imagen)', N'', N'', 2, 1, 1000, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77B009FC66C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1004, 18, N'Validar Servicio', N'', N'C:\fakepath\PreRecPSLDes5SiAcc1.PNG', 2, 1, 1000, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77B00A02E91 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1005, 18, N'Validar Servicio', N'', N'C:\fakepath\PreRecPSLDes5SiAcc1.PNG', 2, 1, 1000, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A07329 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1006, 18, N'Si', N'Speech y Tipificar', N'', 4, 1, 1000, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A0891E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1007, 18, N'No', N'Descarte 6', N'', 5, 1, 1000, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A091AB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1008, 19, N'Descarte 6', N'', N'C:\fakepath\PreRecPSLD6.PNG', 2, 1, 1007, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A0A671 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1009, 19, N'(Ver imagen)', N'', N'', 2, 1, 1007, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A0B21D AS DateTime))
GO
print 'Processed 1000 total records'
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1010, 19, N'Si', N'Descarte 7', N'', 4, 1, 1007, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A0BE7D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1011, 19, N'No', N'Speech y Tipificar', N'', 5, 1, 1007, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A0D12E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1012, 20, N'Descarte 7', N'-', N'C:\fakepath\PrepRecPSLD7.PNG', 2, 1, 1010, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A0DA55 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1013, 20, N'(Ver imagen)', N'', N'', 2, 1, 1010, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A0E654 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1014, 21, N'Si', N'Brindar Speech', N'', 4, 1, 1010, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A0EFA1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1015, 20, N'No', N'Descarte 8', N'', 5, 1, 1010, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A2FCDA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1016, 21, N'Descarte 8', N'', N'C:\fakepath\PreRecPSLD8.PNG', 2, 1, 1015, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A3064B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1017, 21, N'(Ver imagen)', N'', N'', 2, 1, 1015, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A31295 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1018, 21, N'Si', N'Descarte 9', N'', 4, 1, 1015, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A3218C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1019, 21, N'No', N'Solicitar lo siguiente', N'', 5, 1, 1015, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A32EE1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1020, 22, N'Descarte 9', N'', N'C:\fakepath\PreRecPSLD9.PNG', 2, 1, 1018, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A34242 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1021, 22, N'Si', N'Solicitar lo siguiente', N'', 4, 1, 1018, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A3534D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1022, 22, N'No', N'Descarte 10', N'', 5, 1, 1018, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A35BFD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1023, 23, N'Descarte 10', N'', N'C:\fakepath\PreRecPSLD10.PNG', 2, 1, 1022, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A363E2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1024, 23, N'Si', N'Tipificar', N'', 4, 1, 1022, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A38A37 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1025, 23, N'No', N'Regresar al inicio', N'', 5, 1, 1022, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A394A9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1026, 24, N'Tipificar', N'', N'C:\fakepath\PreRecPSLDes10Si.PNG', 2, 1, 1024, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A44B3C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1027, 24, N'Fin', N'', N'', 3, 1, 1024, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A4553D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1028, 22, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 1014, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A4784F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1029, 22, N'Si', N'Generar Caso', N'', 4, 1, 1014, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A48940 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1030, 22, N'No', N'Generar Reclamo', N'', 5, 1, 1014, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A49692 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1031, 23, N'Generar Caso', N'', N'C:\fakepath\PreRecPSLDes7NoCaso.PNG', 2, 1, 1029, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A4B0BF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1032, 23, N'Fin', N'', N'', 3, 1, 1029, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A4B99B AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1033, 23, N'Generar Reclamo', N'', N'C:\fakepath\PreRecPSLDes7NoReclamo.PNG', 2, 1, 1030, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A4C6F7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1034, 23, N'Fin', N'', N'', 3, 1, 1030, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A4CD9E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1035, 19, N'Speech y Tipificar', N'', N'C:\fakepath\PreRecPSLDes5SiAcc1Si.PNG', 2, 1, 1006, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A514A9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1036, 19, N'Fin', N'', N'', 3, 1, 1006, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A51D0C AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1037, 13, N'Speech y Tipifica', N'', N'C:\fakepath\PreRecPSLDes1No.PNG', 2, 1, 985, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A75DFD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1038, 13, N'Fin', N'', N'', 3, 1, 985, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A76A01 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1039, 15, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 993, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A7F71D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1040, 15, N'Si', N'Generar Caso', N'', 4, 1, 993, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A80389 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1041, 15, N'No', N'Generar Reclamo', N'', 5, 1, 993, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A80D8F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1042, 16, N'Generar Caso', N'', N'C:\fakepath\PreRecPSLDes3NoCaso.PNG', 2, 1, 1040, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A82CBF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1043, 16, N'Fin', N'', N'', 3, 1, 1040, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A83393 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1044, 16, N'Generar Reclamo', N'', N'C:\fakepath\PreRecPSLDes3NoReclamo.PNG', 2, 1, 1041, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A84087 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1045, 16, N'Fin', N'', N'', 3, 1, 1041, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A846AE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1046, 17, N'Speech y Tipificar', N'', N'C:\fakepath\PreRecPSLDes5No.PNG', 2, 1, 1001, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A86D00 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1047, 17, N'Fin', N'', N'', 3, 1, 1001, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00A87325 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1048, 14, N'Solicitar lo Siguiente', N'', N'C:\fakepath\PreRecPSLDes2NoAcc1.PNG', 2, 1, 989, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AA59E7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1049, 14, N'Si', N'Hacer lo Siguiente', N'', 4, 1, 989, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AA713A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1050, 14, N'No', N'Ver Tipificación NINTEX', N'', 5, 1, 989, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AA843D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1051, 15, N'Ver Tipificación NINTEX', N'', N'C:\fakepath\PreRecPSLDes2NoAcc1NoDes1.PNG', 2, 1, 1050, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AAA7A3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1052, 15, N'Si', N'Brindar Speech', N'', 4, 1, 1050, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AAB809 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1053, 15, N'No', N'Realizar NINTEX', N'', 5, 1, 1050, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AAC25E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1054, 16, N'Realizar NINTEX', N'', N'C:\fakepath\NINTEX.PNG', 2, 1, 1053, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AADBE0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1055, 16, N'Fin', N'', N'', 3, 1, 1053, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AAE2BA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1056, 16, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 1052, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AAEDA3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1057, 16, N'Si', N'Generar Caso', N'', 4, 1, 1052, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AAFC30 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1058, 16, N'No', N'Generar Reclamo', N'', 5, 1, 1052, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AB0477 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1059, 15, N'Generar Caso', N'-', N'C:\fakepath\PreRecPSLDes2NoAcc1NoDes1SiCaso.PNG', 2, 1, 1057, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AB4891 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1060, 17, N'Fin', N'', N'', 3, 1, 1057, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AB4F6D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1061, 15, N'Generar Reclamo', N'-', N'C:\fakepath\PreRecPSLDes2NoAcc1NoDes1SiReclamo.PNG', 2, 1, 1058, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AB5A11 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1062, 17, N'Fin', N'', N'', 3, 1, 1058, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AB5FCE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1063, 15, N'Hacer lo Siguiente', N'', N'C:\fakepath\PreRecPSLDes2NoAcc2.PNG', 2, 1, 1049, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AC0DB7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1064, 16, N'Si', N'', N'', 4, 1, 1049, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AC1B82 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1065, 15, N'No', N'Brindar Speech', N'', 5, 1, 1049, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AC257A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1066, 16, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 1065, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AC32C4 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1067, 16, N'Si', N'Generar Caso', N'', 4, 1, 1065, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AC3ED7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1068, 16, N'No', N'Generar Reclamo', N'', 5, 1, 1065, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AC46BC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1069, 17, N'Generar Reclamo', N'', N'C:\fakepath\PreRecPSLDes2NoAcc2Reclamo.PNG', 2, 1, 1068, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00ACBF20 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1070, 17, N'Fin', N'', N'', 3, 1, 1068, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00ACF615 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1071, 20, N'Generar Caso', N'-', N'C:\fakepath\PreRecPSLDes2NoAcc2NoCaaso.PNG', 2, 1, 1067, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AE0357 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1072, 17, N'Fin', N'', N'', 3, 1, 1067, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77B00AE0A35 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1073, 20, N'Speech y Tipificar', N'', N'C:\fakepath\PreRecPSLDes6No.PNG', 2, 1, 1011, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77C00BA7401 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1074, 20, N'Fin', N'', N'', 3, 1, 1011, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77C00BA7A09 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1075, 16, N'Descarte 3', N'', N'C:\fakepath\Desc2Si.PNG', 2, 1, 1064, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00BE8CB1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1076, 16, N'Solicitar lo Siguiente', N'', N'C:\fakepath\PreRecPSLDes4NoAcc1.PNG', 2, 1, 997, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00BF4CD1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1077, 16, N'Si', N'Realizar lo siguiente', N'', 4, 1, 997, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00BF5B27 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1078, 16, N'No', N'Ver Tipificación NINTEX', N'', 5, 1, 997, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00BF7FDF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1079, 17, N'Ver Tipificación NINTEX', N'', N'C:\fakepath\TipiNINTEX.PNG', 2, 1, 1078, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00BF9923 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1080, 17, N'Si', N'Brindar Speech', N'', 4, 1, 1078, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00BFA801 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1081, 17, N'No', N'Realizar NINTEX', N'', 5, 1, 1078, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00BFB3FA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1082, 18, N'Realizar NINTEX', N'', N'C:\fakepath\NINTEX.PNG', 2, 1, 1081, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00BFC0F1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1083, 18, N'Fin', N'', N'', 3, 1, 1081, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00BFCA0E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1084, 18, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 1080, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00BFD61D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1085, 18, N'Si', N'Generar Caso', N'', 4, 1, 1080, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00BFDE36 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1086, 18, N'No', N'Generar Reclamo', N'', 5, 1, 1080, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00BFE87A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1087, 18, N'Generar Caso', N'-', N'C:\fakepath\PreRecPSLDes4NoAcc1NoDes1SiCaso.PNG', 2, 1, 1085, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00C01062 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1088, 19, N'Fin', N'', N'', 3, 1, 1085, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00C01ABE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1089, 18, N'Generar Reclamo', N'-', N'C:\fakepath\PreRecPSLDes4NoAcc1NoDes1SiReclamo.PNG', 2, 1, 1086, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00C029C5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1090, 19, N'Fin', N'', N'', 3, 1, 1086, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00C02FD2 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1091, 17, N'Realizar lo siguiente', N'', N'C:\fakepath\SLdes4NoAcc2.PNG', 2, 1, 1077, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00C089AC AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1092, 19, N'Si', N'', N'', 4, 1, 1077, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00C09C48 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1093, 17, N'No', N'Brindar Speech', N'', 5, 1, 1077, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00C0A748 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1094, 18, N'Brindar Speech', N'', N'C:\fakepath\PreRecPSLDes4NoAcc2.PNG', 2, 1, 1093, 0, N'', 1, 1, 2, N'yellow', CAST(0x0000A77C00C1D12A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1095, 18, N'Brindar Speech', N'', N'C:\fakepath\SpeechCR.PNG', 2, 1, 1093, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00C1F57E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1096, 18, N'Si', N'Generar Caso', N'', 4, 1, 1093, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00C1FEFB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1097, 18, N'No', N'Generar Reclamo', N'', 5, 1, 1093, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00C2080E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1098, 19, N'Generar Caso', N'', N'C:\fakepath\PreRecPSLDes4NoAcc2NoCaso.PNG', 2, 1, 1096, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00C22A3F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1099, 19, N'Fin', N'', N'', 3, 1, 1096, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00C230D3 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1100, 19, N'Generar Reclamo', N'', N'C:\fakepath\PreRecPSLDes4NoAcc2NoReclamo.PNG', 2, 1, 1097, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00C23C9F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1101, 19, N'Fin', N'', N'', 3, 1, 1097, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00C242F0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1102, 20, N'Descarte 5', N'', N'C:\fakepath\MISMOImsi.PNG', 2, 1, 1092, 0, N'', 1, 1, 1, N'yellow', CAST(0x0000A77C00C343E9 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1103, 22, N'Solicitar lo siguiente', N'', N'C:\fakepath\PreRecPSLDes8NoAcc1.PNG', 2, 1, 1019, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A4E69F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1104, 22, N'Si', N'Realizar lo siguiente', N'', 4, 1, 1019, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A4FCF5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1105, 22, N'No', N'Consultar lo siguiente', N'', 5, 1, 1019, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A50D40 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1106, 23, N'Consultar lo siguiente', N'', N'C:\fakepath\PreRecPSLDes8NoAcc1No.PNG', 2, 1, 1105, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A527EB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1107, 23, N'Si', N'Derivar a un CAC', N'', 4, 1, 1105, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A53924 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1108, 23, N'No', N'Derivar a Centro particular', N'', 5, 1, 1105, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A5491E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1109, 24, N'Derivar a un CAC', N'', N'C:\fakepath\PreRecPSLDes8NoAcc1NoAcc1Si.PNG', 2, 1, 1107, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A55C57 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1110, 24, N'Fin', N'', N'', 3, 1, 1107, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A5624A AS DateTime))
GO
print 'Processed 1100 total records'
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1111, 24, N'Derivar a Centro particular', N'', N'C:\fakepath\PreRecPSLDes8NoAcc1NoAcc1No.PNG', 2, 1, 1108, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A56C50 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1112, 24, N'Fin', N'', N'', 3, 1, 1108, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A572FA AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1113, 23, N'Realizar lo siguiente', N'', N'C:\fakepath\PreRecPSLDes8NoAcc2.PNG', 2, 1, 1104, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A59D92 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1114, 23, N'Si', N'Brindar Speech y Tipificar', N'', 4, 1, 1104, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A5CAEB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1115, 23, N'No', N'Validar servicio', N'', 5, 1, 1104, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A5D9FE AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1116, 24, N'Brindar Speech y Tipificar', N'', N'C:\fakepath\PreRecPSLDes8NoAcc2Si.PNG', 2, 1, 1114, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A5EB5F AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1117, 24, N'Fin', N'', N'', 3, 1, 1114, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A5F10E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1118, 24, N'Validar servicio', N'', N'C:\fakepath\PreRecPSLDes8NoAcc3.PNG', 2, 1, 1115, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A61367 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1119, 24, N'Si', N'Consultar lo siguiente', N'', 4, 1, 1115, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A6621E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1120, 24, N'No', N'Regresar al inicio', N'', 5, 1, 1115, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A67323 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1121, 25, N'Regresar al inicio', N'', N'C:\fakepath\INICIO.PNG', 2, 1, 1120, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A6EAE5 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1122, 25, N'Consultar lo siguiente', N'', N'C:\fakepath\PreRecPSLDes8NoAcc4.PNG', 2, 1, 1119, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A6FEDB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1123, 25, N'Si', N'Derivar a un CAC', N'', 4, 1, 1119, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A70F81 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1124, 25, N'No', N'Derivar a un centro particular', N'', 5, 1, 1119, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A72287 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1125, 26, N'Derivar a un CAC', N'', N'C:\fakepath\PreRecPSLDes8NoAcc1NoAcc1Si.PNG', 2, 1, 1123, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A736BF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1126, 26, N'Fin', N'', N'', 3, 1, 1123, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A73CC1 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1127, 26, N'Derivar a un centro particular', N'', N'C:\fakepath\PreRecPSLDes8NoAcc1NoAcc1No.PNG', 2, 1, 1124, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A748D0 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1128, 26, N'Fin', N'', N'', 3, 1, 1124, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A77E00A74E39 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1129, 1, N'PRUEBA GHIAN', N'', N'C:\fakepath\tucson.jpg', 2, 1, 0, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A8110105AC13 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1130, 1, N'Colores', N'Colores 01', N'C:\fakepath\colores.png', 2, 1, 1129, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A811010AD641 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1131, 1, N'Marca', N'Marca 01', N'C:\fakepath\Marcas.jpg', 2, 1, 1129, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A811010BDEAB AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1132, 1, N'Rojo', N'Color Rojo', N'C:\fakepath\Rojo.png', 2, 1, 1130, 0, N'Selecciones SI=Confirmar,NO=No confirmar', 1, 1, 1, N'yellow', CAST(0x0000A81101157FC7 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1133, 2, N'SI', N'', N'', 4, 1, 1130, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A8110116CD89 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1134, 2, N'NO', N'', N'', 5, 1, 1130, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A8110116EA45 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1135, 2, N'Contenido', N'Descripcion', N'', 8, 1, 1130, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A81200AF03DD AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1136, 2, N'Toyota', N'Toyota descrip', N'C:\fakepath\Toyota.jpg', 2, 1, 1131, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A8120120E2FF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1137, 2, N'Si', N'Si', N'', 4, 1, 1131, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A8120120F508 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1138, 2, N'No', N'No', N'', 5, 1, 1131, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A81201210307 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1139, 1, N'MATRIZ DBS', N'GK', N'C:\fakepath\Xeno_Goku.jpg', 2, 1, 0, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A81700C0BC92 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1140, 2, N'GOHAN', N'', N'C:\fakepath\Gohan_Buu_Artwork.png', 2, 1, 1139, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A81700C1D73D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1141, 2, N'GOTEN', N'', N'C:\fakepath\descarga.jpg', 2, 1, 1139, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A81700C22D1A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1142, 3, N'SI', N'GOHAN SU', N'C:\fakepath\G.jpg', 4, 1, 1140, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A81700C336DF AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1143, 3, N'NO', N'', N'', 5, 1, 1140, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A81700C38D84 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1144, 3, N'SUPE 2', N'', N'C:\fakepath\G.jpg', 2, 1, 1140, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A81700C3B183 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1145, 3, N'DESCRIPCION', N'', N'', 8, 1, 1140, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A81700C3EF88 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1146, 4, N's4', N'', N'C:\fakepath\s4.jpg', 2, 1, 1142, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A81700C5E43D AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1147, 4, N'TAL VEZ', N'-', N'', 7, 1, 1142, 1129001131, N'', 1, 1, 1, N'noselected', CAST(0x0000A81700C6049E AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1148, 1, N'DES-GHIAN', N'-', N'', 8, 1, 1142, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A81700C67227 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1149, 4, N'PRUEBA', N'', N'', 6, 1, 1142, 0, N'', 1, 1, 2, N'noselected', CAST(0x0000A81700C86C47 AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1150, 1, N'GOK', N'-', N'C:\fakepath\Xeno_Goku.jpg', 3, 1, 1149, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A81700C9279A AS DateTime))
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro]) VALUES (1151, 5, N'OTRO', N'', N'', 1, 1, 1147, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A81700CB0DED AS DateTime))
SET IDENTITY_INSERT [dbo].[TBL_NIVEL] OFF
/****** Object:  Table [dbo].[TBL_GESTION]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_GESTION](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[in_usuario] [int] NOT NULL,
	[in_cliente] [int] NOT NULL,
	[vc_tipificacion] [nvarchar](max) NOT NULL,
	[vc_duracion] [nvarchar](50) NOT NULL,
	[dt_fec_registro] [datetime] NOT NULL,
	[vc_resultado] [nvarchar](300) NOT NULL,
	[vc_observacion] [nvarchar](max) NULL,
	[in_sede] [int] NULL,
	[in_campannia] [int] NULL,
	[dt_fec_visita] [nvarchar](50) NULL,
	[hr_visita] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_DETALLE_CAMP_NIVEL]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_DETALLE_CAMP_NIVEL](
	[cod] [int] IDENTITY(1,1) NOT NULL,
	[in_campannia] [int] NOT NULL,
	[in_nivel] [int] NOT NULL,
	[in_estado] [int] NOT NULL,
	[in_usuario_reg] [int] NULL,
 CONSTRAINT [PK_TBL_DETALLE_CAMP_NIVEL] PRIMARY KEY CLUSTERED 
(
	[cod] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TBL_DETALLE_CAMP_NIVEL] ON
INSERT [dbo].[TBL_DETALLE_CAMP_NIVEL] ([cod], [in_campannia], [in_nivel], [in_estado], [in_usuario_reg]) VALUES (1, 17, 1, 1, 1)
INSERT [dbo].[TBL_DETALLE_CAMP_NIVEL] ([cod], [in_campannia], [in_nivel], [in_estado], [in_usuario_reg]) VALUES (2, 17, 1129, 1, 1)
INSERT [dbo].[TBL_DETALLE_CAMP_NIVEL] ([cod], [in_campannia], [in_nivel], [in_estado], [in_usuario_reg]) VALUES (3, 17, 1139, 1, 1)
SET IDENTITY_INSERT [dbo].[TBL_DETALLE_CAMP_NIVEL] OFF
/****** Object:  Table [dbo].[TBL_CLIENTE]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CLIENTE](
	[id_cliente] [int] IDENTITY(1,1) NOT NULL,
	[vc_nombre] [nvarchar](300) NOT NULL,
	[vc_codigo] [nvarchar](50) NOT NULL,
	[vc_apellidos] [nvarchar](50) NULL,
	[in_archivo] [int] NOT NULL,
	[in_estado] [int] NOT NULL,
	[dt_fecRegistro] [datetime] NULL,
	[in_visible] [int] NULL,
 CONSTRAINT [PK_TBL_CLIENTE] PRIMARY KEY CLUSTERED 
(
	[id_cliente] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_ARCHIVOCARGA]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_ARCHIVOCARGA](
	[id_archivo] [int] IDENTITY(1,1) NOT NULL,
	[vc_archivo] [nvarchar](50) NOT NULL,
	[in_usuario] [int] NOT NULL,
	[in_cantfilas] [int] NOT NULL,
	[dt_fecha_carga] [datetime] NOT NULL,
 CONSTRAINT [PK_TBL_ARCHIVOCARGA] PRIMARY KEY CLUSTERED 
(
	[id_archivo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_USUARIO_1]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_USUARIO_1](
	[in_UsuarioID] [int] IDENTITY(1,1) NOT NULL,
	[vc_DNI] [varchar](10) NULL,
	[vc_Nombre] [varchar](30) NOT NULL,
	[vc_ApePaterno] [varchar](50) NOT NULL,
	[vc_ApeMaterno] [varchar](50) NULL,
	[vc_Usuario] [varchar](20) NOT NULL,
	[vc_Clave] [varchar](20) NOT NULL,
	[in_PerfilID] [int] NOT NULL,
	[in_SedeID] [int] NOT NULL,
	[in_CampaniaID] [int] NULL,
	[dt_FecRegistro] [datetime] NULL,
	[in_UsuRegistroID] [int] NULL,
	[in_Estado] [int] NULL,
	[vc_Correo] [varchar](100) NULL,
	[vc_ClaveCorreo] [varchar](100) NULL,
	[EstadoConexion] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[in_UsuarioID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TB_USUARIO_1] ON
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (1, N'66432234', N'ADMIN', N'ADM', N'ADM', N'ADM', N'123', 1, 4, 11, CAST(0x0000A62500F7177F AS DateTime), NULL, 1, N'servicedeskln@mdycontactcenter.com', N'Sv201dk5', 1)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (133, N'123', N'123', N'123', N'123', N'ASESOR', N'123', 2, 1, 20, CAST(0x0000A75B00D3275C AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (134, N'1', N'11', N'11', N'11', N'ASESOR', N'1', 2, 1, 15, CAST(0x0000A63700BD5726 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (135, N'22', N'JUAN', N'ALVARADO', N'ALVRADO', N'J22', N'22', 2, 1, 15, CAST(0x0000A6390101E293 AS DateTime), NULL, 0, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (136, N'444', N'SUPER', N'SUPER', N'SUPER', N'SUPER', N'444', 3, 1, 19, CAST(0x0000A63700BEEC1D AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (137, N'789', N'SUPERVISORVISTA', N'SUPERVISORVISTA', N'SUPERVISORVISTA', N'SUPERVISTA', N'789', 8, 1, 19, CAST(0x0000A63700DCB03A AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (138, N'46655497', N'EDUARDO', N'ROMERO', N'ESPADA', N'EROMERO', N'46655497', 1, 1, 19, CAST(0x0000A63700DFBD82 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (139, N'76060971', N'MICHAEL', N'HERNANDO', N'SOTO', N'T76060971', N'76060971', 2, 1, 15, CAST(0x0000A63B014F929A AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (140, N'74281511', N'CARLA', N'SALAZAR', N'GARCIA', N'CSALAZAR', N'74281511', 2, 1, 19, CAST(0x0000A65F0141DE7C AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (141, N'73013675', N'JORDY ALEJANDRO', N'BERROSPI ', N'LOPEZ ', N'E325285', N'73013675', 2, 1, 15, CAST(0x0000A66300C74298 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (142, N'47175295', N' JORDAZ BRYAN', N'GIRON ', N'BARCENA', N'E322629', N'47175295', 2, 1, 15, CAST(0x0000A66300CA9E1A AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (143, N'73068016', N' JORDAN KERTH', N'COTRINA ', N'CORONEL', N'E327387', N'73068016', 2, 1, 15, CAST(0x0000A66300CAFE81 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (144, N'70282762', N' TAYSON JULIO', N'SOLIER ', N'MIGUEL', N'E329184', N'70282762', 2, 1, 15, CAST(0x0000A66300CB370C AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (145, N'47069297', N' ANDY GIANCARLO', N'OBREGON ', N'CABANILLAS', N'E335668', N'47069297', 2, 1, 15, CAST(0x0000A66300CB6E1E AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (146, N'70551618', N' JOEL ALDO', N'QUIÑONES ', N'SHUNA', N'E331830', N'70551618', 2, 1, 15, CAST(0x0000A66300CB9A2B AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (147, N'74646159', N' YULIANA YUDIT', N'GALINDO ', N'VALLE', N'E332635', N'74646159', 2, 1, 15, CAST(0x0000A66300CBC901 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (148, N'45942917', N' CARLOS JUNIOR', N'HAYA ', N'CHINCHAY', N'E333238', N'45942917', 2, 1, 15, CAST(0x0000A66300CBF6BA AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (149, N'70975790', N' ERNESTO FRANK', N'CAMPOS ', N'HUMANI ', N'E333479', N'70975790', 2, 1, 15, CAST(0x0000A66300CC3CBE AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (150, N'73949444', N' YELINA THALIA ', N'DE LA CRUZ ', N' BENIGNO', N'E323397', N'73949444', 2, 1, 15, CAST(0x0000A66300CD2BA4 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (151, N'71371944', N' KEVIN ALEXANDER', N'GLASINOVICH ', N'GUARNIZ', N'E821424', N'71371944', 2, 1, 15, CAST(0x0000A66600E261A0 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (152, N'46911580', N'JHONATAN RAY ', N'ALCALDE ', N'MONCADA', N'E340953', N'46911580', 2, 1, 15, CAST(0x0000A69200F0A83A AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (153, N'71260634', N' JORGE LUIS', N'PRIETO ', N'RAMOS', N'E343155', N'71260634', 2, 1, 15, CAST(0x0000A69200F0C9AC AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (154, N'61042419', N'JOSE ANDRES', N'MARTINEZ ', N'ROJAS ', N'E343149', N'61042419', 2, 1, 15, CAST(0x0000A69200F0EB9A AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (155, N'47725094', N' EDWIN LEANDRO', N'TARAZONA ', N'OBISPO', N'E342840', N'47725094', 2, 1, 15, CAST(0x0000A69200F10EFA AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (156, N'75925744', N'DANNY', N'YGUAVIL ', N'TAIPE ', N'E343160', N'75925744', 2, 1, 15, CAST(0x0000A69200F12F18 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (157, N'77044642', N'JHONATAN', N'GARCIA ', N'SABOYA ', N'E343145', N'77044642', 2, 1, 15, CAST(0x0000A69200F14CDC AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (158, N'71661411', N' YEMSTON', N'MORAN ', N'REYES', N'E343152', N'71661411', 2, 1, 15, CAST(0x0000A69200F1690C AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (159, N'75456362', N' FERNANDO GABRIEL', N'CASAS ', N'GONZALES', N'E343139', N'75456362', 2, 1, 15, CAST(0x0000A69200F181D6 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (160, N'75844293', N' JHON JULIAN', N'GUITIERREZ ', N'PERALTA', N'E343146', N'75844293', 2, 1, 15, CAST(0x0000A69200F1A4D8 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (161, N'73934585', N' HECTOR', N'PEÑALVA ', N'TORRES', N'E343154', N'73934585', 2, 1, 15, CAST(0x0000A69200F1CFAE AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (162, N'75204631', N' PABLO ALFONSO', N'FASABI ', N'TUANAMA', N'E343144', N'75204631', 2, 1, 15, CAST(0x0000A69200F1EDF4 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (163, N'48711972', N' STHEPHANY LISSET', N'MILLA ', N'VILLANUEVA', N'E343150', N'48711972', 2, 1, 15, CAST(0x0000A69200F20C31 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (164, N'70692341', N' ERICK ENRIQUE', N'VARILLAS ', N'PEREZ', N'E342970', N'70692341', 2, 1, 15, CAST(0x0000A69200F23AE6 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (165, N'71617470', N' YHON GUTTEMBENG', N'CISNEROS ', N'TACUCHI', N'E342980', N'71617470', 2, 1, 15, CAST(0x0000A69200F256FF AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (166, N'41194901', N'MARY CAROLA', N'GOMEZ ', N'EPIFANIA ', N'E342990', N'41194901', 2, 1, 15, CAST(0x0000A69200F27407 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (167, N'48864114', N'ANTONY MAYCOL', N'ORE ', N'BOZA ', N'E342592', N'48864114', 2, 1, 15, CAST(0x0000A69200F29012 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (168, N'48456766', N'CHRISTOFER CERENEO', N'CARRASCO ', N'VILLANUEVA ', N'E342586', N'48456766', 2, 1, 15, CAST(0x0000A69200F2A9C1 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (169, N'77097032', N'DANIEL ANGEL   ', N'ARROYO ', N'CONCHA ', N'E342819', N'77097032', 2, 1, 15, CAST(0x0000A69200F2C894 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (170, N'72512674', N' AYRTON DAYNER   ', N'PASTOR ', N'CULLI', N'E342833', N'72512674', 2, 1, 15, CAST(0x0000A69200F2E965 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (171, N'70985909', N' JOSE IVAN   ', N'ACOSTA ', N'FIGUEROA', N'E342817', N'70985909', 2, 1, 15, CAST(0x0000A69200F307AF AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (172, N'70817826', N'AXEL ANTONIO   ', N'SIU ', N'LUZQUIÑOS ', N'E342839', N'70817826', 2, 1, 15, CAST(0x0000A69200F343BD AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (173, N'40605277', N'RICARDO    ', N'ARIAS ', N'LAZON ', N'E342818', N'40605277', 2, 1, 15, CAST(0x0000A69200F35DA0 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (174, N'73050077', N' MAYRON IRVIN   ', N'ENRIQUEZ ', N'AGUIRRE', N'E342822', N'73050077', 2, 1, 15, CAST(0x0000A69200F3874F AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (175, N'48787854', N' STEFFEN BOB JEREMY', N'NUÑEZ ', N'RODAS', N'E329753', N'48787854', 2, 1, 15, CAST(0x0000A69200F3A3E6 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (176, N'48639346', N' LIZ ESTEFANI', N'CONDORI ', N'CAMPOS', N'E327917', N'48639346', 2, 1, 15, CAST(0x0000A69200F40856 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (177, N'70584662', N'EDINSON WILFREDO ', N'GOMEZ ', N'CASTILLO ', N'E327020', N'70584662', 2, 1, 15, CAST(0x0000A69200F44419 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (178, N'47188548', N'PAULO CESAR', N'NEGRI ', N'RUIZ ', N'E327029', N'47188548', 2, 1, 15, CAST(0x0000A69200F47B37 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (179, N'72853179', N'LEISON ERIC ', N'MONTESINOS ', N'HIJAR ', N'E327024', N'72853179', 2, 1, 15, CAST(0x0000A69200F49427 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (180, N'44023069', N' ROMULO', N'REYES ', N'BOITANO', N'E326802', N'44023069', 2, 1, 15, CAST(0x0000A69200F4B0A6 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (181, N'44989286', N'GABRIEL EDUARDO', N'RAMOS ', N'YACHI ', N'E325935', N'44989286', 2, 1, 15, CAST(0x0000A69200F4D123 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (182, N'44443265', N'MARCELA ', N'SOBRADO ', N'LOAYZA ', N'E324615', N'44443265', 2, 1, 15, CAST(0x0000A69200F4F3ED AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (183, N'10282994', N'LUZ PATRICIA', N'MESTA', N'PEREZ ', N'E323432', N'10282994', 2, 1, 15, CAST(0x0000A69200F51217 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (184, N'44886896', N' CHRISTHIAN DENISSE', N'CESPEDES ', N'ZAFRA', N'E323427', N'44886896', 2, 1, 15, CAST(0x0000A69200F52F44 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (185, N'41029611', N' ALBERTO ALONSO', N'CAPUÑAY ', N'NUÑEZ', N'E323502', N'41029611', 2, 1, 15, CAST(0x0000A69200F548A5 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (186, N'70883724', N' VICTOR CARLOS DANIEL SANTOS', N'NAVARRETE ', N'LECCA', N'E323503', N'70883724', 2, 1, 15, CAST(0x0000A69200F56798 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (187, N'77607894', N' DIEGO', N'SANCHEZ ', N'RIVERA', N'E315216', N'77607894', 2, 1, 15, CAST(0x0000A69200F5C1E2 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (188, N'6011973', N'MARCOS ALEJANDRO ', N'CAMPOMANES ', N'VILLARREAL ', N'E319904', N'6011973', 2, 1, 15, CAST(0x0000A69200F5DBB2 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (189, N'47445367', N' MANUEL ALBERTO ', N'MELENDEZ ', N'HUAMAN', N'E319916', N'47445367', 2, 1, 15, CAST(0x0000A69200F645C3 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (190, N'47470873', N'SONNY LUTHER', N'MEDINA ', N'IZAGUIRRE ', N'E313666', N'47470873', 2, 1, 15, CAST(0x0000A69200F685AD AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (191, N'44116863', N' GUILLERMO JOSE', N'GANOZA ', N'MORALES', N'E829264', N'44116863', 2, 1, 15, CAST(0x0000A69200F69F9E AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (192, N'47101469', N'MARGOT', N'CERCEDO', N'CORDOVA', N'E330682', N'47101469', 8, 1, 15, CAST(0x0000A697013EC2F4 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (193, N'72565082', N'MARY ANN', N'JAIME', N'SOLIS', N'E829265', N'72565082', 8, 1, 15, CAST(0x0000A6970140BF13 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (194, N'70327329', N'JORGE', N'CHAVEZ', N'MORENO', N'E318457', N'70327329', 8, 1, 15, CAST(0x0000A6970140A24D AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (195, N'44986640', N'VICTOR', N'AMAYA', N'SANTIVAÑEZ', N'E333543', N'44986640', 8, 1, 15, CAST(0x0000A69701407BFD AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (196, N'46736545', N'ERICK', N'CRUZ', N'MUÑOZ', N'E319974', N'46736545', 8, 1, 15, CAST(0x0000A6970140B016 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (197, N'46250471', N'ISIS NISA', N'SIQUERO', N'LOYOLA', N'E325070', N'46250471', 8, 1, 15, CAST(0x0000A6970140CBC8 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (198, N'74450412', N'FIORELLA', N'QUISPE', N'ARENAS', N'E820849', N'74450412', 8, 1, 15, CAST(0x0000A69B015EDB16 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (199, N'42483292', N'DIANA ', N'HUAYTALLA ', N'DE LA CRUZ', N'E804807', N'42483292', 8, 1, 15, CAST(0x0000A69E00E8EA5F AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO_1] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (200, N'124', N'SDAS', N' SADASD', N'SASDAS', N'ASDS', N'124', 2, 1, 19, CAST(0x0000A7540139C83D AS DateTime), NULL, 1, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[TB_USUARIO_1] OFF
/****** Object:  Table [dbo].[TB_USUARIO]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_USUARIO](
	[in_UsuarioID] [int] IDENTITY(1,1) NOT NULL,
	[vc_DNI] [varchar](10) NULL,
	[vc_Nombre] [varchar](30) NOT NULL,
	[vc_ApePaterno] [varchar](50) NOT NULL,
	[vc_ApeMaterno] [varchar](50) NULL,
	[vc_Usuario] [varchar](20) NOT NULL,
	[vc_Clave] [varchar](20) NOT NULL,
	[in_PerfilID] [int] NOT NULL,
	[in_SedeID] [int] NOT NULL,
	[in_CampaniaID] [int] NULL,
	[dt_FecRegistro] [datetime] NULL,
	[in_UsuRegistroID] [int] NULL,
	[in_Estado] [int] NULL,
	[vc_Correo] [varchar](100) NULL,
	[vc_ClaveCorreo] [varchar](100) NULL,
	[EstadoConexion] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[in_UsuarioID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TB_USUARIO] ON
INSERT [dbo].[TB_USUARIO] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (1, N'12345678', N'GEANNCARLO', N'VILELA', N'CAÑOLA', N'admin', N'123456', 1, 3, 17, CAST(0x0000A76B00928E19 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (2, N'123456', N'PRUEBA', N'PRUEBA', N'PRUEBA', N'asesor', N'123456', 2, 3, 17, CAST(0x0000A76B00933062 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (3, N'45590980', N'ANA CRIS', N'SANTOS', N'CATRO', N'ASANTOS', N'45590980', 2, 3, 17, CAST(0x0000A77900BA9FB9 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (4, N'41919016', N'DANIEL', N'OCHOA', N'CRUZ', N'DOCHOA', N'41919016', 2, 3, 17, CAST(0x0000A77900BA375F AS DateTime), NULL, 1, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[TB_USUARIO] OFF
/****** Object:  Table [dbo].[TB_SEDE]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SEDE](
	[in_SedeID] [int] IDENTITY(1,1) NOT NULL,
	[vc_Sede] [varchar](50) NOT NULL,
	[in_Estado] [int] NOT NULL,
	[in_UsuRegistro] [int] NULL,
	[dt_FechRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[in_SedeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TB_SEDE] ON
INSERT [dbo].[TB_SEDE] ([in_SedeID], [vc_Sede], [in_Estado], [in_UsuRegistro], [dt_FechRegistro]) VALUES (1, N'LINCE', 2, 1, CAST(0x0000A62400000000 AS DateTime))
INSERT [dbo].[TB_SEDE] ([in_SedeID], [vc_Sede], [in_Estado], [in_UsuRegistro], [dt_FechRegistro]) VALUES (2, N'MAGDALENA', 2, 1, CAST(0x0000A62400000000 AS DateTime))
INSERT [dbo].[TB_SEDE] ([in_SedeID], [vc_Sede], [in_Estado], [in_UsuRegistro], [dt_FechRegistro]) VALUES (3, N'COLONIAL', 1, 1, CAST(0x0000A62400000000 AS DateTime))
INSERT [dbo].[TB_SEDE] ([in_SedeID], [vc_Sede], [in_Estado], [in_UsuRegistro], [dt_FechRegistro]) VALUES (4, N'TODAS', 2, 1, CAST(0x0000A62900000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[TB_SEDE] OFF
/****** Object:  Table [dbo].[TB_PERFIL_MENU]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_PERFIL_MENU](
	[in_PerfilMenu] [int] IDENTITY(1,1) NOT NULL,
	[in_PerfilID] [int] NULL,
	[in_MenuID] [int] NULL,
	[in_Estado] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[in_PerfilMenu] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TB_PERFIL_MENU] ON
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (1, 1, 1, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (4, 1, 4, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (5, 1, 5, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (6, 1, 6, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (7, 1, 7, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (8, 1, 9, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (10, 1, 11, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (12, 2, 2, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (15, 2, 5, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (16, 2, 6, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (20, 2, 7, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (21, 2, 9, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (22, 2, 10, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (23, 2, 11, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (24, 3, 1, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (25, 3, 3, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (26, 3, 11, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (27, 3, 12, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (28, 4, 1, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (29, 4, 2, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (30, 4, 8, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (31, 4, 9, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (32, 4, 11, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (33, 5, 1, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (34, 5, 2, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (35, 5, 9, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (36, 5, 11, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (37, 6, 1, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (38, 6, 2, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (39, 6, 9, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (40, 6, 11, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (41, 1, 13, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (42, 2, 13, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (43, 1, 14, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (44, 1, 15, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (45, 1, 8, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (46, 1, 16, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (48, 2, 17, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (49, 1, 18, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (50, 1, 5, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (51, 1, 19, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (52, 1, 20, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (53, 1, 3, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (54, 3, 20, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (55, 3, 16, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (56, 3, 18, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (57, 3, 8, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (58, 8, 1, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (59, 8, 2, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (60, 8, 3, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (61, 8, 8, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (62, 8, 18, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (63, 8, 20, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (64, 8, 19, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (65, 8, 17, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (66, 1, 21, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (69, 2, 23, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (70, 1, 17, 1)
INSERT [dbo].[TB_PERFIL_MENU] ([in_PerfilMenu], [in_PerfilID], [in_MenuID], [in_Estado]) VALUES (71, 1, 2, 1)
SET IDENTITY_INSERT [dbo].[TB_PERFIL_MENU] OFF
/****** Object:  Table [dbo].[TB_PERFIL]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_PERFIL](
	[in_PerfilID] [int] IDENTITY(1,1) NOT NULL,
	[vc_Perfil] [varchar](20) NULL,
	[in_Estado] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[in_PerfilID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TB_PERFIL] ON
INSERT [dbo].[TB_PERFIL] ([in_PerfilID], [vc_Perfil], [in_Estado]) VALUES (1, N'Administrador', 1)
INSERT [dbo].[TB_PERFIL] ([in_PerfilID], [vc_Perfil], [in_Estado]) VALUES (2, N'Asesor', 1)
INSERT [dbo].[TB_PERFIL] ([in_PerfilID], [vc_Perfil], [in_Estado]) VALUES (3, N'Supervisor', 1)
INSERT [dbo].[TB_PERFIL] ([in_PerfilID], [vc_Perfil], [in_Estado]) VALUES (4, N'Cliente', 2)
INSERT [dbo].[TB_PERFIL] ([in_PerfilID], [vc_Perfil], [in_Estado]) VALUES (5, N'otro', 2)
INSERT [dbo].[TB_PERFIL] ([in_PerfilID], [vc_Perfil], [in_Estado]) VALUES (8, N'SupervisorVista', 1)
SET IDENTITY_INSERT [dbo].[TB_PERFIL] OFF
/****** Object:  Table [dbo].[TB_MENU]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_MENU](
	[in_MenuID] [int] IDENTITY(1,1) NOT NULL,
	[vc_NomMenu] [varchar](100) NULL,
	[vc_Url] [varchar](100) NULL,
	[in_PadreID] [int] NULL,
	[in_Orden] [int] NULL,
	[in_Estado] [int] NULL,
	[vc_Imagen] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[in_MenuID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TB_MENU] ON
INSERT [dbo].[TB_MENU] ([in_MenuID], [vc_NomMenu], [vc_Url], [in_PadreID], [in_Orden], [in_Estado], [vc_Imagen]) VALUES (1, N'Administración', N'#', 0, 1, 1, N'fa fa-cog fa-fw')
INSERT [dbo].[TB_MENU] ([in_MenuID], [vc_NomMenu], [vc_Url], [in_PadreID], [in_Orden], [in_Estado], [vc_Imagen]) VALUES (2, N'Gestión', N'#', 0, 2, 1, N'fa fa-archive')
INSERT [dbo].[TB_MENU] ([in_MenuID], [vc_NomMenu], [vc_Url], [in_PadreID], [in_Orden], [in_Estado], [vc_Imagen]) VALUES (3, N'Reportes', N'#', 0, 3, 1, N'fa fa-bar-chart-o')
INSERT [dbo].[TB_MENU] ([in_MenuID], [vc_NomMenu], [vc_Url], [in_PadreID], [in_Orden], [in_Estado], [vc_Imagen]) VALUES (8, N'Mant. Clientes', N'Frm_CargaAgentes.aspx', 1, 2, 1, N'fa fa-upload')
INSERT [dbo].[TB_MENU] ([in_MenuID], [vc_NomMenu], [vc_Url], [in_PadreID], [in_Orden], [in_Estado], [vc_Imagen]) VALUES (16, N'Mant. Matrices', N'Frm_MantNivel.aspx', 1, 9, 1, N'fa fa-clock-o')
INSERT [dbo].[TB_MENU] ([in_MenuID], [vc_NomMenu], [vc_Url], [in_PadreID], [in_Orden], [in_Estado], [vc_Imagen]) VALUES (17, N'Gestion', N'Frm_Gestion.aspx', 2, 4, 1, NULL)
INSERT [dbo].[TB_MENU] ([in_MenuID], [vc_NomMenu], [vc_Url], [in_PadreID], [in_Orden], [in_Estado], [vc_Imagen]) VALUES (18, N'Mant. Usuarios', N'Frm_Usuarios.aspx', 1, 2, 1, N'fa fa-user')
INSERT [dbo].[TB_MENU] ([in_MenuID], [vc_NomMenu], [vc_Url], [in_PadreID], [in_Orden], [in_Estado], [vc_Imagen]) VALUES (19, N'Mant. Campañas', N'Frm_MantCampanias.aspx', 1, 4, 1, N'fa fa-cubes')
INSERT [dbo].[TB_MENU] ([in_MenuID], [vc_NomMenu], [vc_Url], [in_PadreID], [in_Orden], [in_Estado], [vc_Imagen]) VALUES (20, N'Reporte', N'Frm_Reportes.aspx', 3, 2, 1, N'fa fa-bar-chart-o')
INSERT [dbo].[TB_MENU] ([in_MenuID], [vc_NomMenu], [vc_Url], [in_PadreID], [in_Orden], [in_Estado], [vc_Imagen]) VALUES (21, N'Conectados', N'frm_personasConectadas.aspx', 1, 10, 1, N'fa fa-user')
INSERT [dbo].[TB_MENU] ([in_MenuID], [vc_NomMenu], [vc_Url], [in_PadreID], [in_Orden], [in_Estado], [vc_Imagen]) VALUES (23, N'Enviar Mensaje', N'Frm_mensaje.aspx', 2, 11, 1, NULL)
SET IDENTITY_INSERT [dbo].[TB_MENU] OFF
/****** Object:  StoredProcedure [dbo].[enviarMensaje]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[enviarMensaje] 
	@mensaje ntext,
	@emisor int,
	@receptor int
AS
BEGIN
	insert into BD_GESTION_PROCESOS.dbo.TB_MENSAJES (emisor,receptor,mensaje,FechaHoraMSG,visto) 
			values (@emisor,@receptor,@mensaje,getdate(),1);
END
GO
/****** Object:  Table [dbo].[TB_MENSAJES]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_MENSAJES](
	[in_MensajeID] [int] IDENTITY(1,1) NOT NULL,
	[emisor] [int] NOT NULL,
	[receptor] [int] NOT NULL,
	[mensaje] [ntext] NOT NULL,
	[FechaHoraMSG] [datetime] NOT NULL,
	[visto] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[in_MensajeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_GESTION_1]    Script Date: 10/25/2017 12:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_GESTION_1](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[in_usuario] [int] NOT NULL,
	[proceso] [varchar](50) NOT NULL,
	[vc_tipificacion] [nvarchar](max) NOT NULL,
	[horaInicio] [varchar](8) NOT NULL,
	[vc_duracion] [char](8) NOT NULL,
	[fec_registro] [datetime] NOT NULL,
	[in_sede] [int] NOT NULL,
	[in_campania] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[dameTitulo]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[dameTitulo] 
	@id_nivel int
AS
BEGIN
	select vc_titulo from TBL_NIVEL where id_nivel = @id_nivel;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Reporte]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Reporte] --2,2
@in_Opc int,
@in_CapaID int = 0,
@in_NroPago int = 0,
@in_AgenteID int = 0

as

set dateformat dmy
set language N'Español'

if @in_Opc = 1 goto ReporteAsistencia
if @in_Opc = 2 goto ReportePagos
if @in_Opc = 3 goto ReportePagosValid
goto salir

ReportePagosValid:
select in_Pagado
from TB_DETALLLE_PAGOS
where in_AgenteID = @in_AgenteID and in_NroPago = @in_NroPago

if @@ERROR<>0 goto salir
goto salir

ReporteAsistencia:
declare @asis int = (select COUNT(*) from TB_ASISTENCIA where in_CapaID = @in_CapaID)
if @asis = 0 goto salir
select isnull(c.vc_Abreviatura,'') vc_Abreviatura, isnull(c.vc_Titulo,'') vc_Titulo,ca.vc_Campania,
		ISNULL(CONVERT(varchar(10), c.dt_FechRegistro, 103), '') dt_FechRegistro,
		ISNULL(CONVERT(varchar(10), c.dt_FechInicio, 103), '') dt_FechInicio,
		ISNULL(CONVERT(varchar(10), c.dt_FechFin, 103), '') dt_FechFin,
		isnull((u.vc_ApePaterno + ' ' + u.vc_ApeMaterno + ', ' + u.vc_Nombre), '') vc_Nombres,
		c.in_CantAgentes, c.in_CantDias, c.dc_PagoTotal, c.dc_PagoDia, c.in_CantPartes, 
		case(c.in_Estado) when 1 then 'Pendiente' when 2 then 'Agentes cargados' when 3 then 'En curso'
		else 'Cerrado' end vc_Estado
from TB_CAPACITACION c inner join TB_CAMPANIA ca
	on c.in_CampaniaID = ca.in_CampaniaID inner join TB_USUARIO u
	on c.in_UsuRegistroID = u.in_UsuarioID
where c.in_CapaID = @in_CapaID

declare @colA varchar(max) = ''
declare @sqlA varchar(max)
set @sqlA = '
select
	#cols#
from
(
	select distinct in_NroDia,convert(varchar, dt_FechaAs, 103) dt_FechaAs
	from TB_ASISTENCIA where in_CapaID = ' + convert(varchar,@in_CapaID) + '
) as source pivot
	(
		max(dt_FechaAs)
		for in_NroDia in (#cols#)
	) as pvt
'
select @colA = @colA + '['+CONVERT(varchar, v.in_NroDia)+'],'
from
(
	select distinct in_NroDia from TB_ASISTENCIA where in_CapaID = @in_CapaID
) as v
set @colA = SUBSTRING(@colA,0,LEN(@colA))
set @sqlA = REPLACE(@sqlA, '#cols#', @colA)

declare @col varchar(max) = ''
declare @sql varchar(max)
set @sql = '
select
	distinct in_AgenteID,vc_Usuario,vc_Nombres,
	#cols#
from
(
	select distinct in_AgenteID,vc_Usuario,vc_Nombres,in_NroDia,in_Asistencia
	from TB_DETALLE_ASISTENCIA where in_CapaID = ' + convert(varchar,@in_CapaID) + '
) as source pivot
	(
		max(in_Asistencia)
		for in_NroDia in (#cols#)
	) as pvt
'
select @col = @col + '['+CONVERT(varchar, v.in_NroDia)+'],'
from
(
	select distinct in_NroDia from TB_DETALLE_ASISTENCIA where in_CapaID = @in_CapaID
) as v
set @col = SUBSTRING(@col,0,LEN(@col))
set @sql = REPLACE(@sql, '#cols#', @col)

declare @sqlAsis varchar(max)
set @sqlAsis = '
select
	#cols#
from
(
	select distinct in_NroDia,in_CantAsitentes
	from TB_ASISTENCIA where in_CapaID = ' + convert(varchar,@in_CapaID) + '
) as source pivot
	(
		max(in_CantAsitentes)
		for in_NroDia in (#cols#)
	) as pvt
'
set @sqlAsis = REPLACE(@sqlAsis, '#cols#', @colA)

declare @sqlFalt varchar(max)
set @sqlFalt = '
select
	#cols#
from
(
	select distinct in_NroDia,in_CantFaltantes
	from TB_ASISTENCIA where in_CapaID = ' + convert(varchar,@in_CapaID) + '
) as source pivot
	(
		max(in_CantFaltantes)
		for in_NroDia in (#cols#)
	) as pvt
'
set @sqlFalt = REPLACE(@sqlFalt, '#cols#', @colA)

exec (@sqlA)
exec (@sql)
exec (@sqlAsis)
exec (@sqlFalt)

if @@ERROR<>0 goto salir
goto salir

ReportePagos:
declare @pagos int = (select COUNT(*) from TB_PAGOS where in_CapaID = @in_CapaID)
if @pagos = 0 goto salir
if @pagos > 0 goto Reporte

Reporte:
select  isnull(c.vc_Abreviatura,'') vc_Abreviatura, isnull(c.vc_Titulo,'') vc_Titulo,ca.vc_Campania,
		ISNULL(CONVERT(varchar(10), c.dt_FechRegistro, 103), '') dt_FechRegistro,
		ISNULL(CONVERT(varchar(10), c.dt_FechInicio, 103), '') dt_FechInicio,
		ISNULL(CONVERT(varchar(10), c.dt_FechFin, 103), '') dt_FechFin,
		isnull((u.vc_ApePaterno + ' ' + u.vc_ApeMaterno + ', ' + u.vc_Nombre), '') vc_Nombres,
		c.in_CantAgentes, c.in_CantDias, c.dc_PagoTotal, c.dc_PagoDia, c.in_CantPartes, 
		case(c.in_Estado) when 1 then 'Pendiente' when 2 then 'Agentes cargados' when 3 then 'En curso'
		else 'Cerrado' end vc_Estado
from TB_CAPACITACION c inner join TB_CAMPANIA ca
	on c.in_CampaniaID = ca.in_CampaniaID inner join TB_USUARIO u
	on c.in_UsuRegistroID = u.in_UsuarioID
where c.in_CapaID = @in_CapaID

select cc.in_Orden, cc.in_DiaCorte Corte, cp.dc_Monto Monto,
ISNULL(CONVERT(VARCHAR,p.in_DiaPago,103), '') in_DiaPago
from
(
	select in_Orden, vc_Descripcion, in_DiaCorte
	from TB_CAPA_CIERRE where in_CapaID = @in_CapaID
) cc full outer join
(
	select in_Orden, vc_Descripcion, dc_Monto
	from TB_CAPA_PAGO where in_CapaID = @in_CapaID
) cp on cc.in_Orden = cp.in_Orden
full outer join
(
	select in_NroPago,(dt_FecRegistro + in_DiaPago) in_DiaPago 
	from TB_PAGOS where in_CapaID = @in_CapaID
) p on p.in_NroPago= cp.in_Orden

declare @colDetalle varchar(max) = ''
declare @sqlDetalle varchar(max)
set @sqlDetalle = '
select
	distinct in_AgenteID,cv_Usuario,vc_Nombres,
	#cols#
from
(
	select distinct in_AgenteID,cv_Usuario,vc_Nombres,in_NroPago,dc_Monto
	from TB_DETALLLE_PAGOS where in_CapaID = ' + convert(varchar,@in_CapaID) + '
) as source pivot
	(
		max(dc_Monto)
		for in_NroPago in (#cols#)
	) as pvt
'
select @colDetalle = @colDetalle + '['+CONVERT(varchar, v.in_NroPago)+'],'
from
(
	select distinct in_NroPago from TB_DETALLLE_PAGOS where in_CapaID = @in_CapaID
) as v
set @colDetalle = SUBSTRING(@colDetalle,0,LEN(@colDetalle))
set @sqlDetalle = REPLACE(@sqlDetalle, '#cols#', @colDetalle)

exec (@sqlDetalle)

if @@ERROR<>0 goto salir
goto salir

salir:
  set nocount off
  return
GO
/****** Object:  StoredProcedure [dbo].[usp_mantSede]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_mantSede]
@in_opc int,
@in_SedeID int,
@in_UsuarioID int,
@vc_Sede varchar(50)
as
set dateformat dmy
set language N'Español'

if (@in_Opc = 1) goto ListSedes
if (@in_Opc = 2) goto ListXSede
if (@in_Opc = 3) goto GuardarSede
if (@in_Opc = 4) goto CambiarEstado
if (@in_Opc = 5) goto DeleteSede
if (@in_Opc = 6) goto ListSedesActivas
goto salir

ListSedes:
  select s.in_SedeID, s.vc_Sede, s.in_Estado,
		isnull((u.vc_ApePaterno + ' ' + u.vc_ApeMaterno + ', ' + u.vc_Nombre), '') vc_Nombres,
		isnull(convert(varchar,s.dt_FechRegistro,103),'') dt_FechRegistro
  from TB_SEDE s left join TB_USUARIO u
		on s.in_UsuRegistro = u.in_UsuarioID

if @@ERROR<>0 goto salir
goto salir

ListXSede:
select in_SedeID, vc_Sede, in_Estado, '' vc_Nombres, '' dt_FechRegistro
from TB_SEDE where in_SedeID = @in_SedeID

if @@ERROR<>0 goto salir
goto salir

GuardarSede:
if (@in_SedeID = 0)
  begin
	insert into TB_SEDE (vc_Sede, in_Estado, in_UsuRegistro, dt_FechRegistro)
	values(UPPER(@vc_Sede), 1, @in_UsuarioID, GETDATE())
  end
else
  begin
	update TB_SEDE set vc_Sede = UPPER(@vc_Sede),
						in_UsuRegistro = @in_UsuarioID,
						dt_FechRegistro = GETDATE()
	where in_SedeID = @in_SedeID
  end

if @@ERROR<>0 goto salir
goto salir

CambiarEstado:
declare @est int = (select case(in_Estado) when 1 then 0 else 1 end  from TB_SEDE
						where in_SedeID = @in_SedeID)
update TB_SEDE set in_Estado = @est, dt_FechRegistro = GETDATE(), in_UsuRegistro = @in_UsuarioID
where in_SedeID = @in_SedeID

if @@ERROR<>0 goto salir
goto salir

DeleteSede:
delete from TB_SEDE where in_SedeID = @in_SedeID

if @@ERROR<>0 goto salir
goto salir

ListSedesActivas:
select in_SedeID, vc_Sede, in_Estado, '' vc_Nombres, '' dt_FechRegistro
from TB_SEDE where in_Estado = 1

if @@ERROR<>0 goto salir
goto salir

salir:	
  set nocount off
  return
GO
/****** Object:  StoredProcedure [dbo].[usp_MantPerfil]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_MantPerfil] 
@in_Opc int
as

set dateformat dmy      
set language N'Español'  

if @in_Opc = 1 goto ListPerfil
goto salir

ListPerfil:
select in_PerfilID, vc_Perfil, in_Estado
from TB_PERFIL
where in_Estado = 1 
--and in_PerfilID <> 3

if @@ERROR<>0 goto salir

salir:
  set nocount off
  return
GO
/****** Object:  StoredProcedure [dbo].[usp_MantMenuPerfil]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_MantMenuPerfil]
@opc int,
@in_PerfilID int = 0,
@in_PadreID int = 0,
@in_MenuID int = 0
as
set dateformat dmy
set language N'Español'

if @opc=1 goto Sel_MenuxPerfil
goto Salir

Sel_MenuxPerfil:
select pm.in_PerfilMenu, m.in_MenuID, m.vc_NomMenu, m.vc_Url, m.in_PadreID, m.in_Orden,
		ISNULL(m.vc_Imagen,'') vc_Imagen
from TB_PERFIL_MENU pm inner join TB_MENU m
	on pm.in_MenuID = m.in_MenuID inner join TB_PERFIL p
	on pm.in_PerfilID = p.in_PerfilID
where p.in_PerfilID = @in_PerfilID and m.in_Estado = 1 and p.in_Estado = 1
order by 6,5

if @@ERROR<>0 goto Salir
goto Salir

Salir:
	set nocount off
	return
GO
/****** Object:  StoredProcedure [dbo].[usp_mantContenido_Nivel]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_mantContenido_Nivel] 
@in_opc int=0,
@in_idcontenido int=0,	
@in_idnivel int=0,
@vc_contenido nvarchar(max)='',
@vc_color nvarchar(50)='',
@in_subrayado int=0,
@pagenum int=0,
@pagesize int=0
AS
SET DATEFORMAT dmy
SET LANGUAGE N'Español'

IF (@in_Opc = 1) GOTO REGISTRO
IF (@in_Opc = 2) GOTO LISTA_REGISTRO
IF (@in_Opc = 3) GOTO DATOS_REGISTRO
IF (@in_Opc = 4) GOTO ACTUALIZA_REGISTRO
IF (@in_Opc = 5) GOTO ESTADO_REGISTRO
IF (@in_Opc = 6) GOTO LISTA_CONTENIDOS
GOTO salir

REGISTRO:
	-- COLOR DE LA LETRA
	DECLARE @COLOR NVARCHAR(10)
	IF(@vc_color=1)--ROJO
		 BEGIN
			SET @COLOR='#F90404'
		 END
	ELSE IF(@vc_color=2)-- AZUL
		 BEGIN
			SET @COLOR='#043BF9'
		 END
	ELSE IF(@vc_color=3)-- NEGRO
		 BEGIN
			SET @COLOR='#000000'
		 END
	
	INSERT INTO dbo.TBL_NIVEL_CONTENIDO(in_idnivel,vc_contenido,vc_color,in_subrayado) 
	VALUES(@in_idnivel,@vc_contenido,@COLOR,@in_subrayado)
	
IF @@ERROR<>0 GOTO salir
GOTO salir

LISTA_REGISTRO:
	SELECT 
			ROW_NUMBER() OVER(ORDER BY in_idcontenido) N_REG,
			in_idcontenido,
			vc_contenido,
			vc_color,
			CASE(in_subrayado) WHEN '1' THEN 'Si' ELSE 'No' END vc_subrayado,
			in_estado
			INTO #TB_CONTENIDO 
	FROM dbo.TBL_NIVEL_CONTENIDO
	WHERE in_idnivel=@in_idnivel
	
	DECLARE @pageCount INT    
	SET @pageCount = (SELECT COUNT(*) FROM #TB_CONTENIDO)    
	SET @pageCount=(SELECT CEILING(CAST(@pageCount AS DECIMAL(10,2))/CAST(@pagesize AS DECIMAL(10,2))))    

	SELECT 
			in_idcontenido,
			vc_contenido,
			vc_color,
			vc_subrayado,
			in_estado,
			@pageCount total  
	FROM #TB_CONTENIDO   
	WHERE N_REG >= @pagesize *(@pagenum-1)   
	AND N_REG <= @pagesize * @pagenum    
	DROP TABLE #TB_CONTENIDO   
	
IF @@ERROR<>0 GOTO salir
GOTO salir

DATOS_REGISTRO:
	SELECT 
			in_idcontenido,
			vc_contenido,
			CASE(vc_color) WHEN '#F90404' THEN '1' WHEN '#000000' THEN '3' ELSE '2' END vc_color,
			in_subrayado
	FROM dbo.TBL_NIVEL_CONTENIDO
	WHERE in_idcontenido=@in_idcontenido
IF @@ERROR<>0 GOTO salir
GOTO salir

ACTUALIZA_REGISTRO:
	DECLARE @COLOR_ACT NVARCHAR(10)
	IF(@vc_color=1)--ROJO
		 BEGIN
			SET @COLOR_ACT='#F90404'
		 END
	ELSE IF(@vc_color=2)-- AZUL
		 BEGIN
			SET @COLOR_ACT='#043BF9'
		 END
	ELSE IF(@vc_color=3)-- NEGRO
		 BEGIN
			SET @COLOR_ACT='#000000'
		 END
		 
	UPDATE dbo.TBL_NIVEL_CONTENIDO
			SET vc_contenido=@vc_contenido,
				vc_color=@COLOR_ACT,
				in_subrayado=@in_subrayado
	WHERE in_idcontenido=@in_idcontenido
IF @@ERROR<>0 GOTO salir
GOTO salir

ESTADO_REGISTRO:
	 DECLARE @estado INT  
     SET @estado= (SELECT in_estado FROM TBL_NIVEL_CONTENIDO WHERE in_idcontenido=@in_idcontenido)  
  
	 IF (@estado=1)  
		  BEGIN  
			   UPDATE dbo.TBL_NIVEL_CONTENIDO 
				 SET  in_estado=0  
			   WHERE  in_idcontenido=@in_idcontenido
		  END  
	 ELSE  
		  BEGIN   
			   UPDATE TBL_NIVEL_CONTENIDO
				 SET  in_estado=1  
			   WHERE in_idcontenido=@in_idcontenido 
		  END  	
IF @@ERROR<>0 GOTO salir
GOTO salir

LISTA_CONTENIDOS:
	SELECT 
			in_idcontenido,
			vc_contenido,
			vc_color,
			in_subrayado
	FROM dbo.TBL_NIVEL_CONTENIDO
	WHERE in_idnivel=@in_idnivel
IF @@ERROR<>0 GOTO salir
GOTO salir

SALIR:	
  SET NOCOUNT OFF
  RETURN
GO
/****** Object:  StoredProcedure [dbo].[usp_mantCampania]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

[dbo].[usp_mantCampania] 1,0,1,0,0

*/

CREATE proc [dbo].[usp_mantCampania] 
@in_opc int=0,
@in_CampaniaID int=0,	
@in_SedeID int=0,
@in_UsuarioID int=0,
@vc_Campania varchar(50)=''

as
set dateformat dmy
set language N'Español'

if (@in_Opc = 1) goto ListCampanias
if (@in_Opc = 2) goto ListCampaniaxID
if (@in_Opc = 3) goto GuardarCampania
if (@in_Opc = 4) goto CambiarEstado
if (@in_Opc = 5) goto DeleteCampania
if (@in_Opc = 6) goto ListCampaniasActivas
if (@in_Opc = 7) goto CambiarSede
goto salir

ListCampanias:
  select c.in_CampaniaID, c.vc_Campania, s.vc_Sede,
		isnull(convert(varchar,c.dt_FecRegistro,103),'') dt_FechRegistro, c.in_Estado,
		isnull((u.vc_ApePaterno + ' ' + u.vc_ApeMaterno + ', ' + u.vc_Nombre), '') vc_Nombres		
  from TB_CAMPANIA c left join TB_USUARIO u
		on c.in_UsuRegistro = u.in_UsuarioID inner join TB_SEDE s
		on c.in_SedeID = s.in_SedeID
  where c.in_SedeID = @in_SedeID and c.in_Estado = 1 and s.in_Estado=1



if @@ERROR<>0 goto salir
goto salir

ListCampaniaxID:
select in_CampaniaID, vc_Campania, '' in_SedeID, '' dt_FechRegistro, 0 in_Estado, '' vc_Nombres

from TB_CAMPANIA where in_CampaniaID = @in_CampaniaID and in_Estado=1 

if @@ERROR<>0 goto salir
goto salir

GuardarCampania:
if (@in_CampaniaID = 0)
  begin
	insert into TB_CAMPANIA(vc_Campania,in_SedeID,dt_FecRegistro,in_Estado,in_UsuRegistro
	)
	values(UPPER(@vc_Campania), @in_SedeID,GETDATE(),1,@in_UsuarioID)
  end
else
  begin
	update TB_CAMPANIA set vc_Campania = UPPER(@vc_Campania),
							in_SedeID = @in_SedeID,
							dt_FecRegistro= GETDATE(),
							in_UsuRegistro = @in_UsuarioID							
	where in_CampaniaID = @in_CampaniaID
  end

if @@ERROR<>0 goto salir
goto salir

CambiarEstado:
declare @est int = (select case(in_Estado) when 1 then 0 else 1 end  from TB_CAMPANIA
						where in_CampaniaID = @in_CampaniaID)
update TB_CAMPANIA set in_Estado = @est, dt_FecRegistro = GETDATE(), in_UsuRegistro = @in_UsuarioID
where in_CampaniaID = @in_CampaniaID

if @@ERROR<>0 goto salir
goto salir

DeleteCampania:
delete from TB_CAMPANIA where in_CampaniaID = @in_CampaniaID

if @@ERROR<>0 goto salir
goto salir

ListCampaniasActivas:
select in_CampaniaID, vc_Campania, '' in_SedeID, '' dt_FechRegistro, 0 in_Estado, '' vc_Nombres
from TB_CAMPANIA where in_Estado = 1

if @@ERROR<>0 goto salir
goto salir

CambiarSede:
update TB_CAMPANIA set in_SedeID = @in_SedeID
where in_CampaniaID = @in_CampaniaID

if @@ERROR<>0 goto salir
goto salir

salir:	
  set nocount off
  return
GO
/****** Object:  StoredProcedure [dbo].[usp_MantAgentes]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_MantAgentes]
@in_Opc int,
@in_CargaID int,
@in_CapaID int,
@in_UsuRegistroID int,
@in_CantAgentes int,
@in_AgenteID int,
@vc_Usuario varchar(10),
@vc_DNI varchar(10),
@vc_Nombre varchar(100),
@vc_ApePaterno varchar(50),
@vc_ApeMaterno varchar(50),
@in_Estado int,
@vc_Observacion varchar(200)
as

set dateformat dmy      
set language N'Español'  

if (@in_Opc = 1) goto RegistroCarga
if (@in_Opc = 2) goto RegistroAgentes
if (@in_Opc = 3) goto ListarAgentes
goto salir

RegistroCarga:
insert into TB_CARGA_AGENTES(in_CapaID,in_UsuRegistroID,dt_FechRegistro,in_CantAgentes)
values (@in_CapaID, @in_UsuRegistroID, GETDATE(), @in_CantAgentes)

update TB_CAPACITACION set in_Estado = 2
where in_CapaID = @in_CapaID

if @@ERROR<>0 goto salir
goto salir

RegistroAgentes:
declare @in_UltCargaID int = (select MAX(in_CargaID) from TB_CARGA_AGENTES)

insert into TB_AGENTES (in_CargaID,in_CapaID,vc_Usuario,vc_DNI,vc_Nombre,vc_ApePaterno,vc_ApeMaterno,in_Estado)
values(@in_UltCargaID, @in_CapaID,@vc_Usuario,@vc_DNI,@vc_Nombre,@vc_ApePaterno,@vc_ApeMaterno,1)

declare @cantAgen int = (select COUNT(*) from TB_AGENTES where in_CapaID = @in_CapaID)
update TB_CAPACITACION set in_CantAgentes = @cantAgen
where in_CapaID = @in_CapaID

if @@ERROR<>0 goto salir
goto salir

ListarAgentes:
select vc_Usuario,vc_DNI,vc_Nombre,vc_ApePaterno,vc_ApeMaterno
from TB_AGENTES
where in_CapaID = @in_CapaID

if @@ERROR<>0 goto salir
goto salir

salir:
  set nocount off
  return
GO
/****** Object:  StoredProcedure [dbo].[USP_MANT_NIVEL]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_MANT_NIVEL]
@INDICE INT =0,
@ID_NIVEL INT =0,
@in_dpndncia_idnivel INT =0,
@IN_CATE INT =0,
@VC_TITULO NVARCHAR(200) ='-',
@vc_descripcion nvarchar(500)='-',
@vc_url_img NVARCHAR(300)='',
@in_rpta int=0,
@in_tipo_rpta int=0,
@vc_alerta nvarchar(1000)='-',
@IN_ESTADO INT =0,
@pagenum int=0,
@pagesize int=0,
@IN_ID_LINK int=0,
@vc_color_alerta nvarchar(50)=''
AS

--SELECT  TOP 10 * FROM TBL_NIVEL

IF @INDICE = 1 GOTO LISTAR_TBL_NIVEL
IF @INDICE = 2 GOTO INS_TBL_NIVEL
IF @INDICE = 3 GOTO UPD_TBL_NIVEL
IF @INDICE = 4 GOTO DEL_TBL_NIVEL
IF @INDICE = 5 GOTO MOD_ESTA_NIVEL
IF @INDICE = 6 GOTO ASIGNAR_LINK_TBL_NIVEL

ELSE GOTO SALIR

ASIGNAR_LINK_TBL_NIVEL:

	UPDATE TBL_NIVEL
	SET in_link=@IN_ID_LINK
	WHERE id_nivel=@ID_NIVEL
		IF @@ERROR <> 0 GOTO SALIR
	goto SALIR

MOD_ESTA_NIVEL:
		UPDATE TBL_NIVEL
		SET in_estado=@IN_ESTADO
		WHERE id_nivel=@ID_NIVEL
		
		--select * from TBL_NIVEL
		update TBL_NIVEL
		set in_estado=@IN_ESTADO
		where in_dpndncia_idnivel=@ID_NIVEL
		
		IF @@ERROR <> 0 GOTO SALIR
	goto SALIR
LISTAR_TBL_NIVEL:
	SELECT   
		ROW_NUMBER() OVER(ORDER BY N.id_nivel) N_REG,
		N.id_nivel,
		N.in_cate,
		N.vc_titulo,
		N.vc_descripcion,
		N.vc_url_img,
		N.in_rpta,
		0 as in_tipo_rpta,
		N.in_dpndncia_idnivel,
		N.vc_alerta,
		1 as in_orden,
		in_estado,	
		N.in_link,
		/*(case 
			when N.in_link=0 then (select 'No enlase')
			else (select  NN.vc_titulo from TBL_NIVEL NN where NN.id_nivel=N.in_link)
			end
			) as vc_enlase,*/N.vc_color_alerta
		INTO #LISTA_USUARIOS  
	 FROM TBL_NIVEL N
		
	 where in_visible= 1 AND in_dpndncia_idnivel=@in_dpndncia_idnivel	
	 order by in_orden asc 
	  
	  DECLARE @pageCount INT    
	  SET @pageCount = (SELECT COUNT(*) FROM #LISTA_USUARIOS)    
	  SET @pageCount=(SELECT CEILING(CAST(@pageCount AS DECIMAL(10,2))/CAST(@pagesize AS DECIMAL(10,2))))    
	  
	   SELECT id_nivel,
		in_cate,
		vc_titulo,
		vc_descripcion,
		vc_url_img,
		in_rpta,0 as in_tipo_rpta,
		in_dpndncia_idnivel,
		vc_alerta,
		in_orden,
		in_estado,in_link ,
		/*vc_enlase,*/vc_color_alerta,
		@pageCount total  
	   FROM #LISTA_USUARIOS   
	  WHERE N_REG > @pagesize *(@pagenum-1)   
	  AND N_REG <= @pagesize * @pagenum    
		 DROP TABLE #LISTA_USUARIOS         

		   
	IF @@ERROR <> 0 GOTO SALIR
	goto SALIR
INS_TBL_NIVEL:
	IF NOT EXISTS (SELECT VC_TITULO FROM TBL_NIVEL WHERE 
					in_estado =1 AND in_visible=1 AND vc_titulo=@VC_TITULO
					AND in_cate=@IN_CATE+1 AND in_dpndncia_idnivel=@in_dpndncia_idnivel)
		BEGIN
			INSERT INTO TBL_NIVEL (
					in_cate,
					vc_titulo,
					vc_descripcion,
					vc_url_img,
					in_rpta,
					in_dpndncia_idnivel,
					vc_alerta,
					in_estado,
					in_visible,
					in_tipo_rpta,
					in_orden,in_link,
					vc_color_alerta,dt_fec_registro)
			VALUES (
				(@IN_CATE+1),
				@VC_TITULO,
				@vc_descripcion,
				@vc_url_img,
				@in_rpta,
				@in_dpndncia_idnivel,
				@vc_alerta,1,1,1,1,@IN_ID_LINK,@vc_color_alerta,GETDATE())			
		END
	IF @@ERROR <> 0 GOTO SALIR
	goto SALIR
UPD_TBL_NIVEL:
		
		/*if (@in_rpta<>5 and @in_rpta<>2)
			begin
				SET @IN_ID_LINK=0
			end
		else
			begin
				set @IN_ID_LINK= (select in_link from TBL_NIVEL where id_nivel=@ID_NIVEL)
			end
		*/

		if ( @vc_url_img<>'')
			begin
					
				UPDATE TBL_NIVEL
				SET in_cate=@IN_CATE+1,
				vc_titulo=@VC_TITULO,
				vc_descripcion=@vc_descripcion,		
				in_rpta=@in_rpta,	
				vc_url_img=@vc_url_img,
				in_dpndncia_idnivel=@in_dpndncia_idnivel,
				vc_alerta=@vc_alerta,
				vc_color_alerta=@vc_color_alerta,
				in_link=@IN_ID_LINK
				WHERE id_nivel=@ID_NIVEL
			end	
		else
			begin
				UPDATE TBL_NIVEL
				SET in_cate=@IN_CATE+1,
				vc_titulo=@VC_TITULO,
				vc_descripcion=@vc_descripcion,		
				in_rpta=@in_rpta,	
				in_dpndncia_idnivel=@in_dpndncia_idnivel,
				vc_alerta=@vc_alerta,
				vc_color_alerta=@vc_color_alerta,
				in_link=@IN_ID_LINK
				WHERE id_nivel=@ID_NIVEL
			end
	
	
	IF @@ERROR <> 0 GOTO SALIR
	goto SALIR
DEL_TBL_NIVEL:
		UPDATE TBL_NIVEL
		SET in_visible=2
		WHERE id_nivel=@ID_NIVEL
	IF @@ERROR <> 0 GOTO SALIR
	goto SALIR
SALIR:
SET NOCOUNT OFF
RETURN
GO
/****** Object:  StoredProcedure [dbo].[USP_MANT_CLIENTE]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- [USP_MANT_CLIENTE] 2,0,'111','%',0,1,10
/*
SELECT * FROM TBL_CLIENTE

delete from TBL_CLIENTE
*/


  CREATE PROC [dbo].[USP_MANT_CLIENTE]
	@INDICE INT=0,
	@IN_ARCHIVO INT=0,
	@VC_NOMBRE NVARCHAR(300) ='',
	@VC_CODIGO NVARCHAR(50)='%',
	@VC_APELLIDOS nvarchar(50)='',
	@ID_CLIENTE INT=0,
	@in_estado int =0,
	@pagenum int=0,
	@pagesize int=0
	AS
	
	IF @INDICE = 1 GOTO INS_CLIENTES
	IF @INDICE = 2 GOTO LIST_CLIENTES
	IF @INDICE = 3 GOTO UPDATE_CLIENTE
	IF @INDICE = 4 GOTO DELETE_CLIENTE
	if @INDICE = 5 GOTO MOD_ESTADO
	

	ELSE GOTO SALIR
	
	MOD_ESTADO:
			UPDATE TBL_CLIENTE
			SET in_estado= @in_estado
			WHERE id_cliente=@ID_CLIENTE
			IF @@ERROR <> 0 GOTO SALIR
			ELSE GOTO SALIR
			
	UPDATE_CLIENTE:
		
			IF NOT EXISTS (SELECT vc_codigo FROM TBL_CLIENTE WHERE vc_codigo=@VC_CODIGO  and id_cliente<>@ID_CLIENTE) 
			begin
			UPDATE TBL_CLIENTE
			SET vc_codigo=@VC_CODIGO,
			vc_nombre=@VC_NOMBRE,
			vc_apellidos=@VC_APELLIDOS 
			WHERE id_cliente=@ID_CLIENTE	
			end
			
			IF @@ERROR <> 0 GOTO SALIR
			ELSE GOTO SALIR
			
	DELETE_CLIENTE:
		
			UPDATE TBL_CLIENTE
			SET in_visible=2
			WHERE id_cliente=@ID_CLIENTE
		
			IF @@ERROR <> 0 GOTO SALIR
			ELSE GOTO SALIR
	
	INS_CLIENTES:
	
	--SELECT * FROM TBL_CLIENTE
		IF NOT EXISTS (SELECT vc_codigo FROM TBL_CLIENTE WHERE vc_codigo=@VC_CODIGO ) 
	
		INSERT INTO TBL_CLIENTE
		(
		vc_nombre,vc_codigo,vc_apellidos,in_archivo,in_estado,dt_fecRegistro,in_visible
		)
		VALUES 
		(
		@VC_NOMBRE,@VC_CODIGO,@VC_APELLIDOS,@IN_ARCHIVO,1,GETDATE(),1
		)
					IF @@ERROR <> 0 GOTO SALIR
			ELSE GOTO SALIR
				
	LIST_CLIENTES:		
		
			SELECT 
			ROW_NUMBER() OVER(ORDER BY C.id_cliente) N_REG,
			C.id_cliente,
			C.vc_nombre,
			C.vc_apellidos,
			C.vc_codigo,
			C.dt_fecRegistro,
			C.in_estado		
			INTO #LISTA_CLIE 
			FROM dbo.TBL_CLIENTE C 		
			where C.in_visible=1 AND 
			vc_codigo LIKE @VC_CODIGO
					  
			DECLARE @pageCount INT    
			SET @pageCount = (SELECT COUNT(*) FROM #LISTA_CLIE)    
			SET @pageCount=(SELECT CEILING(CAST(@pageCount AS DECIMAL(10,2))/CAST(@pagesize AS DECIMAL(10,2))))    
		  
		    SELECT id_cliente,vc_nombre,vc_apellidos,vc_codigo,dt_fecRegistro,in_estado,@pageCount total  
		    FROM #LISTA_CLIE   
			WHERE N_REG >= @pagesize *(@pagenum-1)   
			AND N_REG <= @pagesize * @pagenum    
			DROP TABLE #LISTA_CLIE   
						IF @@ERROR <> 0 GOTO SALIR
			ELSE GOTO SALIR
			
		
	SALIR:
	SET NOCOUNT OFF
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[USP_MAN_OPCIONES_NIVEL]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE TABLE [dbo].[TBL_OPCIONES_NIVEL](
--	[id_opcion_nivel] [int] IDENTITY(1,1) NOT NULL,
--	[in_nivel] [int] not null,
--	[vc_descripcion] [varchar](500) NULL,
--	[in_orden] [int] NULL,
--	[in_estado] [int] NULL
--	)

CREATE PROC [dbo].[USP_MAN_OPCIONES_NIVEL]
@INDICE INT =0,
@IN_NIVEL INT=0,
@ID_OPCION_NIVEL INT=0,
@VC_DESCRIPCIÓN NVARCHAR(500)='',
@IN_ORDEN INT =0,
@IN_ESTADO INT=0
AS

IF @INDICE = 1 GOTO LST_OPCIONES
IF @INDICE = 2 GOTO INS_OPCIONES
IF @INDICE = 3 GOTO UDP_OPCIONES
IF @INDICE = 4 GOTO DELETE_OPCIONES
ELSE GOTO SALIR

LST_OPCIONES:
	 select 
		id_opcion_nivel,
		in_nivel,
		vc_descripcion,
		in_orden,
		in_estado
	 from TBL_OPCIONES_NIVEL
	 where in_nivel=@IN_NIVEL and in_estado= 1 
	
 IF @@ERROR <>0 GOTO SALIR
INS_OPCIONES:

	INSERT INTO TBL_OPCIONES_NIVEL (in_nivel,vc_descripcion,in_orden,in_estado)
	values (@IN_NIVEL,@VC_DESCRIPCIÓN,@IN_ORDEN,@IN_ESTADO)
	
 IF @@ERROR <>0 GOTO SALIR 
UDP_OPCIONES:

	update TBL_OPCIONES_NIVEL
	set vc_descripcion=@VC_DESCRIPCIÓN,
	in_orden=@IN_ORDEN,
	in_estado=@IN_ESTADO
	where id_opcion_nivel=@ID_OPCION_NIVEL
	
 IF @@ERROR <>0 GOTO SALIR 
DELETE_OPCIONES:

	update TBL_OPCIONES_NIVEL
	set in_estado=2
	where id_opcion_nivel=@ID_OPCION_NIVEL
	
 IF @@ERROR <>0 GOTO SALIR
SALIR:
SET NOCOUNT OFF 
RETURN
GO
/****** Object:  StoredProcedure [dbo].[USP_INS_TBL_ARCHIVOCARGA]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[USP_INS_TBL_ARCHIVOCARGA] 
@vc_nombre nvarchar(60)='',
@in_usuario int=0,
@in_cantFilas int=0

as
	INSERT INTO TBL_ARCHIVOCARGA(
				vc_archivo,
				in_usuario,
				in_cantFilas,
				dt_fecha_carga	
				
				)
				values(
				@vc_nombre,
				@in_usuario,
				@in_cantFilas,
				GETDATE()
				)
GO
/****** Object:  StoredProcedure [dbo].[usp_cargarCombos]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_cargarCombos]
@indice int=0,
@in_SedeID int=0
as


if @indice= 1 goto ListarSede
if @indice = 2 goto ListarCamp
else goto Salir


ListarSede:
	select in_SedeID,vc_Sede from TB_SEDE
	where in_Estado=1
if @@ERROR <> 0 goto Salir
else goto Salir

ListarCamp:
	select in_CampaniaID,vc_Campania from TB_CAMPANIA
	where in_SedeID=@in_SedeID and in_Estado=1
if @@ERROR <> 0 goto Salir
else goto Salir

Salir:
set nocount off
return
GO
/****** Object:  StoredProcedure [dbo].[USP_ASIGNAR_CAMP_NIVEL]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
    
USP_ASIGNAR_CAMP_NIVEL 2,17,0,0,0,0,0    
    
*/    
    
CREATE PROC [dbo].[USP_ASIGNAR_CAMP_NIVEL]    
@indice int =0,    
@in_campannia int=0,    
@in_nivel int=0,    
@cod int=0,    
@in_UsuarioID int=0,    
@pagenum int=0,    
@pagesize int=0    
AS    
    
if @indice= 1 goto ListarMatrices    
if @indice= 2 goto ListarMAtricesxCamp    
if @indice= 3 goto InsCampxNivel    
if @indice= 4 goto DelCampxNivel    
else goto Salir    
    
Salir:    
if @@ERROR <> 0     
set nocount off    
return    
    
ListarMatrices:    
SELECT id_nivel,vc_titulo,vc_url_img,in_orden FROM TBL_NIVEL    
WHERE in_dpndncia_idnivel=0 and in_visible=1     
if @@ERROR <> 0 goto Salir    
else goto Salir    
    
ListarMAtricesxCamp:    
	SELECT     
		ROW_NUMBER() OVER(ORDER BY D.cod) N_REG,    
		D.cod,    
		(select vc_titulo from TBL_NIVEL N where N.id_nivel=D.in_nivel) as vc_titulo    
		INTO #LISTA_DETALLE     
	FROM TBL_DETALLE_CAMP_NIVEL D    
	WHERE D.IN_CAMPANNIA=@in_campannia    
  
	DECLARE @pageCount INT        
	SET @pageCount = (SELECT COUNT(*) FROM #LISTA_DETALLE)        
	SET @pageCount=(SELECT CEILING(CAST(@pageCount AS DECIMAL(10,2))/CAST(@pagesize AS DECIMAL(10,2))))        
	  
	 SELECT   
	 cod,    
	 vc_titulo,      
	 @pageCount total      
	 FROM #LISTA_DETALLE       
	 WHERE N_REG > @pagesize *(@pagenum-1)       
	 AND N_REG <= @pagesize * @pagenum        
	  
	DROP TABLE #LISTA_DETALLE      
       
    
if @@ERROR <> 0 goto Salir    
else goto Salir    
    
    
InsCampxNivel:    
    
if (select COUNT(*) from TBL_DETALLE_CAMP_NIVEL where in_campannia=@in_campannia and in_nivel=@in_nivel )=0    
begin    
insert into TBL_DETALLE_CAMP_NIVEL (in_campannia,in_nivel,in_estado,in_usuario_reg)    
values (@in_campannia,@in_nivel,1,@in_UsuarioID)    
end    
    
    
if @@ERROR <> 0 goto Salir    
else goto Salir    
    
DelCampxNivel:    
delete from TBL_DETALLE_CAMP_NIVEL    
where cod=@cod    
    
if @@ERROR <> 0 goto Salir    
else goto Salir    
/*    
CREATE TABLE TBL_DETALLE    
(    
cod INT IDENTITY NOT NULL,    
in_campannia int not null,    
in_nivel int not null,    
in_estado int not null    
)    
GO    
*/
GO
/****** Object:  StoredProcedure [dbo].[USP_ARMAR_preview]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--   USP_ARMAR_preview 2,164
-- where in_dpndncia_idnivel=128


CREATE PROC [dbo].[USP_ARMAR_preview]
@indice int=0,
@in_parametro int=0,
@vc_UsuarioID nvarchar(20)='%'
AS

IF @indice = 1 GOTO LST_NIVEL_CABE
if @indice = 2 GOTO LST_NIVEL_SUB
ELSE GOTO SALIR

LST_NIVEL_CABE:	

	SELECT id_nivel,in_cate,vc_titulo,vc_descripcion,vc_url_img,in_rpta,in_dpndncia_idnivel,
	vc_alerta,in_link,vc_color_alerta FROM TBL_NIVEL
	WHERE id_nivel=@in_parametro
	--where id_nivel=3117 
	
	and in_estado=1 and in_visible=1 	
	IF @@ERROR <>0 GOTO SALIR
	GOTO SALIR
		
LST_NIVEL_SUB:

	if @in_parametro=0 
	begin
	SELECT id_nivel,in_cate,vc_titulo,vc_descripcion,vc_url_img,in_rpta,in_dpndncia_idnivel,
	vc_alerta,in_link,vc_color_alerta FROM TBL_NIVEL
	WHERE in_dpndncia_idnivel=@in_parametro 
	and in_estado=1 and in_visible=1
	and id_nivel in 
	(
	select N.in_nivel from TBL_DETALLE_CAMP_NIVEL N
	where N.in_campannia in (select in_CampaniaID from TB_USUARIO where in_UsuarioID like @vc_UsuarioID)
	)
	end
	else
	begin
	SELECT id_nivel,in_cate,vc_titulo,vc_descripcion,vc_url_img,in_rpta,in_dpndncia_idnivel,
	vc_alerta,in_link,vc_color_alerta FROM TBL_NIVEL
	WHERE in_dpndncia_idnivel=@in_parametro 
	and in_estado=1 and in_visible=1

	end
	
	
	IF @@ERROR <>0 GOTO SALIR
	GOTO SALIR
	
	

SALIR:
SET NOCOUNT OFF
RETURN
GO
/****** Object:  StoredProcedure [dbo].[traerProcesos]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[traerProcesos]
	@matrizAnterior int
AS
BEGIN
	select id_nivel,vc_titulo from TBL_NIVEL where in_dpndncia_idnivel=@matrizAnterior;
END
GO
/****** Object:  StoredProcedure [dbo].[traerMatrices]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[traerMatrices] 

AS
BEGIN
	select id_nivel,vc_titulo from TBL_NIVEL where in_dpndncia_idnivel=0;
END
GO
/****** Object:  StoredProcedure [dbo].[traerAdmins]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[traerAdmins] 
	-- Add the parameters for the stored procedure here
	AS
BEGIN
	select in_UsuarioID,vc_Nombre+' '+vc_ApePaterno+' '+vc_ApeMaterno Nombre from TB_USUARIO WHERE in_PerfilID=1;
END
GO
/****** Object:  StoredProcedure [dbo].[finalizaSesion]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[finalizaSesion] 
	@vc_Usuario varchar(20),
	@vc_Clave varchar(20)
AS
BEGIN
	UPDATE TB_USUARIO set EstadoConexion = 0 where vc_Usuario=@vc_Usuario and vc_Clave=@vc_Clave;
END
GO
/****** Object:  StoredProcedure [dbo].[USP_VERHISTORIAL]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
SELECT * FROM TBL_CLIENTE

SELECT * FROM TBL_GESTION

[USP_VERHISTORIAL] 0,1001,1,1
*/

CREATE PROC [dbo].[USP_VERHISTORIAL]
@INDICE INT=0,
@VC_CODIGO NVARCHAR(30) ='',
@pagenum int=0,
@pagesize int=0
AS

	SELECT 
	ROW_NUMBER() OVER(ORDER BY G.ID) N_REG,
	(SELECT vc_nombre +' '+ vc_apellidos FROM TBL_CLIENTE C WHERE C.id_cliente=G.in_cliente) AS vc_cliente,
	replace((SELECT vc_codigo FROM TBL_CLIENTE C WHERE C.id_cliente=G.in_cliente),' ','') AS vc_cod_Cliente,
	G.vc_resultado,
	CONVERT(varchar,G.dt_fec_registro) as dt_fec_registro,
	G.vc_duracion,
	G.vc_tipificacion,
	G.vc_observacion
	INTO #LISTA_SEGUIMIENTO
	FROM TBL_GESTION G
	WHERE G.in_cliente= (select id_cliente from TBL_CLIENTE where vc_codigo=@VC_CODIGO)
	order by dt_fec_registro desc
	
			  
			DECLARE @pageCount INT    
			SET @pageCount = (SELECT COUNT(*) FROM #LISTA_SEGUIMIENTO)    
			SET @pageCount=(SELECT CEILING(CAST(@pageCount AS DECIMAL(10,2))/CAST(@pagesize AS DECIMAL(10,2))))    
		  
		    SELECT 
		    vc_cliente,vc_cod_Cliente,
		    vc_resultado,dt_fec_registro,vc_duracion,
		    vc_tipificacion,vc_observacion,
		    @pageCount total  
		    FROM #LISTA_SEGUIMIENTO   
			WHERE N_REG >= @pagesize *(@pagenum-1)   
			AND N_REG <= @pagesize * @pagenum    
			DROP TABLE #LISTA_SEGUIMIENTO
GO
/****** Object:  StoredProcedure [dbo].[USP_REPORTES]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_REPORTES] 
@F1 NVARCHAR(20)='',
@F2 NVARCHAR(20)='',
@SEDE NVARCHAR(20)='%',
@CAMPANNIA NVARCHAR(20)='%'
AS

set @F1= CONVERT(varchar,CONVERT(date,@f1),112)
set @F2= CONVERT(varchar,CONVERT(date,@f2),112)

SELECT 
(select vc_Sede from TB_SEDE SS where SS.in_SedeID= (select  UU.in_SedeID from tb_usuario UU where UU.in_UsuarioID=G.in_usuario )) as vc_sede ,
(select vc_Campania from TB_CAMPANIA CC where CC.in_CampaniaID = (select  UU.in_CampaniaID from tb_usuario UU where UU.in_UsuarioID=G.in_usuario )) as vc_campania ,
(select vc_Nombre +' '+ vc_ApePaterno + ' ' +vc_ApeMaterno  from TB_USUARIO where in_UsuarioID=G.in_usuario) as vc_usuario,
(select vc_Usuario  from TB_USUARIO where in_UsuarioID=G.in_usuario) as vc_user,
/*isnull((select vc_nombre from TBL_CLIENTE C where C.id_cliente=G.in_cliente),'NUEVO') as vc_cliente,
(select vc_codigo from TBL_CLIENTE C where C.id_cliente=G.in_cliente)as vc_codCliente,*/
G.vc_tipificacion,
G.proceso,
G.horaInicio,
G.vc_duracion,
G.fec_registro
FROM TBL_GESTION_1 G
where 
CONVERT(varchar,fec_registro,112) between @F1 and @F2 
and -- G.in_usuario = t.in_UsuarioID;
G.in_sede like @SEDE and G.in_campania like @CAMPANNIA
GO
/****** Object:  StoredProcedure [dbo].[USP_GESTION]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GESTION]
@INDICE INT=0,
@VALUE NVARCHAR(100)='',
@IN_USUARIO INT =0,
@PROCESO VARCHAR(50)='',
@VC_TIPIFICACION NVARCHAR(MAX)='',
@HORAINICIO CHAR(8)='',
@VC_DURACION NVARCHAR(50)=''
AS

IF @INDICE= 1 GOTO CONSULTAR_CLIENTE
IF @INDICE= 2 GOTO REGISTRAR_GESTION
GOTO SALIR

REGISTRAR_GESTION:

/*if @IN_CLIENTE=0
	begin
		INSERT INTO TBL_CLIENTE(vc_nombre,vc_codigo,vc_apellidos,in_archivo,in_estado,dt_fecRegistro,in_visible)
		VALUES ('Nuevo',@cod_cliente,'',0,1,GETDATE(),2)
		declare @in_cliente_N int=0
		set @in_cliente_N=(	SELECT CONVERt(int,SCOPE_IDENTITY()))
		set @IN_CLIENTE=@in_cliente_N
		
		INSERT INTO TBL_GESTION
		(in_usuario,
		in_cliente,
		vc_tipificacion,
		vc_duracion,
		dt_fec_registro,
		vc_resultado,
		vc_observacion,
		in_sede,
		in_campannia,
		dt_fec_visita,
		hr_visita
		)
		values
		(
		@IN_USUARIO,
		@IN_CLIENTE,
		@VC_TIPIFICACION,
		@VC_DURACION,
		GETDATE(),
		@VC_RESULTADO,
		@vc_observacion,
		(select in_SedeID from TB_USUARIO where  in_UsuarioID=@IN_USUARIO),
		(select in_CampaniaID from TB_USUARIO where  in_UsuarioID=@IN_USUARIO),
		@dt_fec_visita,
		@hr_visita
		)
	SELECT CONVERt(int,SCOPE_IDENTITY())
	end
else*/
		begin
		INSERT INTO TBL_GESTION_1
		(in_usuario,
		proceso,
		vc_tipificacion,
		horaInicio,
		vc_duracion,
		fec_registro,
		in_sede,
		in_campania
		)
		values
		(
		@IN_USUARIO,
		@PROCESO,
		@VC_TIPIFICACION,
		@HORAINICIO,
		@VC_DURACION,
		GETDATE(),
		(select in_SedeID from TB_USUARIO where  in_UsuarioID=@IN_USUARIO),
		(select in_CampaniaID from TB_USUARIO where  in_UsuarioID=@IN_USUARIO)
		)
	SELECT CONVERt(int,SCOPE_IDENTITY())
		end
	
IF @@ERROR <> 0 GOTO ERROR
GOTO SALIR

CONSULTAR_CLIENTE: 
set @VALUE=REPLACE(@value,' ','')
SELECT id_cliente,vc_nombre,vc_codigo,vc_apellidos,in_estado FROM TBL_CLIENTE 
WHERE vc_codigo=@VALUE 
--WHERE vc_codigo='1001'
IF @@ERROR <> 0 GOTO ERROR
GOTO SALIR

SALIR:
SET NOCOUNT OFF
IF @@ERROR <> 0  GOTO SALIR


ERROR:
SET NOCOUNT OFF
RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[EliminarHistorial]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarHistorial] 
	-- Add the parameters for the stored procedure here
	@emisor int,
	@receptor int
AS
BEGIN
	delete from TB_MENSAJES where (emisor=@emisor and receptor=@receptor) or (emisor=@receptor and receptor=@emisor)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_mostrarChat]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_mostrarChat]
	@Emisor int,
	@Receptor int	
AS
BEGIN
	Select in_MensajeID,emisor,receptor,mensaje,FechaHoraMSG,visto,vc_ApePaterno+' '+vc_ApeMaterno+' '+vc_Nombre nombreEmisor from TB_MENSAJES,TB_USUARIO 
	where emisor = in_UsuarioID and ((emisor=@Emisor and receptor = @Receptor) or (emisor=@Receptor and receptor = @Emisor));

	update TB_MENSAJES set visto = 0 where emisor = @Emisor and receptor = @Receptor;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Mant_Usuario]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_Mant_Usuario] --2,1,10,0,'','','','', 'Admin','123456'
@in_Opc int,
@in_NumPagina int = 0,
@in_TamPagina int = 0,
@in_UsuarioID int = 0,
@vc_DNI varchar(20) = '',
@vc_Nombre varchar(50) = '',
@vc_ApePaterno varchar(50) = '',
@vc_ApeMaterno varchar(50) = '',
@vc_Usuario varchar(20) = '',
@vc_Clave varchar(20) = '',
@vc_Correo varchar(100) = '',
@in_PerfilID int = 0,
@in_SedeID int = 0,
@in_CampaniaID int=0
as

set dateformat dmy      
set language N'Español'  

if (@in_Opc = 1) goto UserLogin
if (@in_Opc = 2) goto ListUsuariosPag
if (@in_Opc = 3) goto ListUsuario
if (@in_Opc = 4) goto InsertUsuario
if (@in_Opc = 5) goto CambiarClave
if (@in_Opc = 6) goto CambiarEstado
if (@in_Opc = 7) goto DeleteUsuario
if (@in_Opc = 8) goto ListConectadosPag
if (@in_Opc = 9) goto AdmConectados
goto salir

UserLogin:
  select u.in_UsuarioID, 
  u.vc_DNI,
   u.vc_Nombre, 
   u.vc_ApePaterno,
    u.vc_ApeMaterno, 
    u.vc_Usuario,
		ISNULL(u.vc_Correo,'') vc_Correo,
		 u.vc_Clave,
		u.in_PerfilID, 
		p.vc_Perfil,
		u.in_SedeID,
		(select S.vc_Sede from TB_SEDE S where S.in_SedeID=u.in_sedeID) as vc_Sede
		,CONVERT(varchar(10),u.dt_FecRegistro, 103) dt_FecRegistro,
		u.in_Estado,u.in_CampaniaID,
		ISNULL((select vc_Campania from TB_CAMPANIA CC where CC.in_CampaniaID=u.in_CampaniaID),'')  as vc_Campania
		, 1 as in_TotalRegistros
  from TB_USUARIO u inner join TB_PERFIL p
		on u.in_PerfilID = p.in_PerfilID 
  Where vc_Usuario = @vc_Usuario and vc_Clave = @vc_Clave and u.in_Estado = 1
		and p.in_Estado = 1 
		update TB_USUARIO set EstadoConexion=1 where vc_Usuario=@vc_Usuario and vc_Clave=@vc_Clave;	
  if @@ERROR<>0 goto salir
goto salir

ListUsuariosPag:
  select ROW_NUMBER() over(order by u.in_UsuarioID) nroReg,
		 u.in_UsuarioID,
		  u.vc_DNI,
		   u.vc_Nombre, 
		   u.vc_ApePaterno,
		u.vc_ApeMaterno, 
		u.vc_Usuario,
		 ISNULL(u.vc_Correo,'') vc_Correo, 
		 u.vc_Clave,
		  u.in_PerfilID, 
		  p.vc_Perfil,
		  u.in_SedeID,
		s.vc_Sede,
		 CONVERT(varchar(10), u.dt_FecRegistro, 103) dt_FecRegistro,
		  u.in_Estado,
		  u.in_CampaniaID	,
		ISNULL((select vc_Campania from TB_CAMPANIA CC where CC.in_CampaniaID=u.in_CampaniaID),'')  as vc_Campania
		into #TM_USER
  from TB_USUARIO u inner join TB_PERFIL p
		on u.in_PerfilID = p.in_PerfilID inner join TB_SEDE s
		on u.in_SedeID = s.in_SedeID
  where (u.vc_DNI like @vc_DNI+'%' or u.vc_Nombre like @vc_DNI+'%' or u.vc_ApePaterno like @vc_DNI+'%' or
		u.vc_ApeMaterno like @vc_DNI+'%') 
		--and u.in_PerfilID <> 3
  order by u.vc_ApePaterno
 
  DECLARE @pageCount INT    
  SET @pageCount = (SELECT COUNT(*) FROM #TM_USER)    
  SET @pageCount=(SELECT CEILING(CAST(@pageCount AS DECIMAL(10,2))/CAST(@in_TamPagina AS DECIMAL(10,2)))) 

  SELECT in_UsuarioID,vc_DNI, vc_Nombre,vc_ApePaterno,vc_ApeMaterno,vc_Usuario,vc_Correo,
		vc_Clave,in_PerfilID,vc_Perfil,in_SedeID,
		vc_Sede,dt_FecRegistro,in_Estado,in_CampaniaID,vc_Campania
		, @pageCount TOTAL_PAGE    
  FROM #TM_USER    
  WHERE nroReg > @in_TamPagina *(@in_NumPagina-1)      
  AND nroReg <= @in_TamPagina * @in_NumPagina
  ORDER BY vc_ApePaterno
    
  DROP TABLE #TM_USER    
      
  if @@error<>0 goto salir
  goto salir
  
ListUsuario:
select 
	in_UsuarioID,vc_DNI,vc_Nombre,vc_ApePaterno,vc_ApeMaterno,vc_Usuario, 
	ISNULL(vc_Correo,'') vc_Correo,
	u.vc_Clave,
	in_PerfilID,
	(select PP.vc_Perfil from TB_PERFIL PP where PP.in_PerfilID=U.in_PerfilID ) as vc_Perfil,
	in_SedeID,
	(select SS.vc_Sede from TB_SEDE SS where SS.in_SedeID= U.in_SedeID)  as vc_Sede,
	CONVERT(varchar,u.dt_FecRegistro) as dt_FecRegistro,
	u.in_Estado
	,in_CampaniaID,
	(select vc_Campania from TB_CAMPANIA CC where CC.in_CampaniaID=u.in_CampaniaID)  as vc_Campania,
	0 as in_TotalRegistros
	
from TB_USUARIO U where in_UsuarioID = @in_UsuarioID



if @@error<>0 goto salir
goto salir
  
InsertUsuario:
if (@in_UsuarioID = 0)
  begin
	if not exists (select vc_DNI from TB_USUARIO where vc_DNI = LTRIM(RTRIM(@vc_DNI)))
	  begin
		insert into TB_USUARIO(vc_DNI,vc_Nombre,vc_ApePaterno,vc_ApeMaterno,vc_Usuario,vc_Clave,
								in_PerfilID,in_SedeID,dt_FecRegistro,in_Estado,in_CampaniaID)
		values(UPPER(@vc_DNI),UPPER(@vc_Nombre),UPPER(@vc_ApePaterno),UPPER(@vc_ApeMaterno),UPPER(@vc_Usuario),
					@vc_DNI, @in_PerfilID,@in_SedeID,GETDATE(), 1,@in_CampaniaID)
	  end
  end
else
  begin
	if not exists (select vc_DNI from TB_USUARIO where vc_DNI = LTRIM(RTRIM(@vc_DNI))
					and in_UsuarioID <> @in_UsuarioID)
	  begin
		update TB_USUARIO set vc_DNI = UPPER(@vc_DNI),
								vc_Nombre = UPPER(@vc_Nombre),
								vc_ApePaterno = UPPER(@vc_ApePaterno),
								vc_ApeMaterno = UPPER(@vc_ApeMaterno),
								vc_Usuario = UPPER(LTRIM(RTRIM(@vc_Usuario))),
								in_PerfilID =  @in_PerfilID,
								in_SedeID = @in_SedeID,
								dt_FecRegistro = GETDATE()	,
								in_CampaniaID=@in_CampaniaID							
		where in_UsuarioID = @in_UsuarioID
	  end
  end
  
if @@ERROR<>0 goto salir
goto salir

CambiarClave:
if (@vc_Clave = '')
  begin
	declare @pass varchar(10) = (select vc_DNI from TB_USUARIO where in_UsuarioID = @in_UsuarioID)
	update TB_USUARIO set vc_Clave = @pass where in_UsuarioID = @in_UsuarioID
  end
else
  begin
	update TB_USUARIO set vc_Clave = @vc_Clave where in_UsuarioID = @in_UsuarioID
  end

if @@ERROR<>0 goto salir
goto salir

CambiarEstado:
  declare @est int = (select case(in_Estado) when 1 then 0 else 1 end  from TB_USUARIO
						where in_UsuarioID = @in_UsuarioID)
  update TB_USUARIO set in_Estado = @est, dt_FecRegistro = GETDATE()
  where in_UsuarioID = @in_UsuarioID

if @@ERROR<>0 goto salir
goto salir

DeleteUsuario:
delete from TB_USUARIO where in_UsuarioID = @in_UsuarioID

if @@ERROR<>0 goto salir
goto salir

ListConectadosPag:
  select ROW_NUMBER() over(order by u.EstadoConexion desc,u.vc_ApePaterno) nroReg,
			u.in_UsuarioID,
		   u.vc_Nombre, 
		   u.vc_ApePaterno,
		u.vc_ApeMaterno, 
		u.vc_Usuario,
		  p.vc_Perfil,
		  u.EstadoConexion,
		  (select count(*) from TB_MENSAJES where emisor = u.in_UsuarioID and visto = 1) msgs
		into #TM_USER1
  from TB_USUARIO u inner join TB_PERFIL p
		on u.in_PerfilID = p.in_PerfilID 
  where (u.vc_DNI like @vc_DNI+'%' or u.vc_Nombre like @vc_DNI+'%' or u.vc_ApePaterno like @vc_DNI+'%' or
		u.vc_ApeMaterno like @vc_DNI+'%') and u.in_PerfilID in (2)
		--and u.in_PerfilID <> 3
  order by u.EstadoConexion desc,u.vc_ApePaterno
 
  DECLARE @pageCount1 INT    
  SET @pageCount1 = (SELECT COUNT(*) FROM #TM_USER1)    
  SET @pageCount1=(SELECT CEILING(CAST(@pageCount1 AS DECIMAL(10,2))/CAST(@in_TamPagina AS DECIMAL(10,2)))) 

  SELECT in_UsuarioID,vc_Nombre,vc_ApePaterno,vc_ApeMaterno,vc_Usuario,
		vc_Perfil,EstadoConexion,msgs
		, @pageCount1 TOTAL_PAGE    
  FROM #TM_USER1    
  WHERE nroReg > @in_TamPagina *(@in_NumPagina-1)      
  AND nroReg <= @in_TamPagina * @in_NumPagina
  ORDER BY EstadoConexion desc, vc_ApePaterno
    
  DROP TABLE #TM_USER1    
      
  if @@error<>0 goto salir
  goto salir

AdmConectados:
select ROW_NUMBER() over(order by u.EstadoConexion desc,u.vc_ApePaterno) nroReg,
			u.in_UsuarioID,
		   u.vc_Nombre, 
		   u.vc_ApePaterno,
		u.vc_ApeMaterno, 
		u.vc_Usuario,
		  p.vc_Perfil,
		  u.EstadoConexion,
		  (select count(*) from TB_MENSAJES where emisor = u.in_UsuarioID and visto = 1) msgs
		into #TM_USER2
  from TB_USUARIO u inner join TB_PERFIL p
		on u.in_PerfilID = p.in_PerfilID 
  where (u.vc_DNI like @vc_DNI+'%' or u.vc_Nombre like @vc_DNI+'%' or u.vc_ApePaterno like @vc_DNI+'%' or
		u.vc_ApeMaterno like @vc_DNI+'%') and u.in_PerfilID in (1)
		--and u.in_PerfilID <> 3
  order by u.EstadoConexion desc,u.vc_ApePaterno
 
  DECLARE @pageCount2 INT    
  SET @pageCount2 = (SELECT COUNT(*) FROM #TM_USER2)    
  SET @pageCount2=(SELECT CEILING(CAST(@pageCount2 AS DECIMAL(10,2))/CAST(@in_TamPagina AS DECIMAL(10,2)))) 

  SELECT in_UsuarioID,vc_Nombre,vc_ApePaterno,vc_ApeMaterno,vc_Usuario,
		vc_Perfil,EstadoConexion,msgs
		, @pageCount2 TOTAL_PAGE    
  FROM #TM_USER2    
  WHERE nroReg > @in_TamPagina *(@in_NumPagina-1)      
  AND nroReg <= @in_TamPagina * @in_NumPagina
  ORDER BY EstadoConexion desc, vc_ApePaterno
    
  DROP TABLE #TM_USER2    
      
  if @@error<>0 goto salir
  goto salir
salir:	
  set nocount off
  return
GO
/****** Object:  StoredProcedure [dbo].[REPORTE_GENERAL]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[REPORTE_GENERAL] 

@F1 NVARCHAR(20)='',
@F2 NVARCHAR(20)='',
@SEDE NVARCHAR(20)='%',
@CAMPANNIA NVARCHAR(20)='%'
AS

set @F1= CONVERT(varchar,CONVERT(date,@f1),112)
set @F2= CONVERT(varchar,CONVERT(date,@f2),112)

SELECT 

G.proceso,
COUNT(*) cantidadProcesos,
BD_GESTION_PROCESOS.dbo.devuelveHora(sum(BD_GESTION_PROCESOS.dbo.cambio(G.vc_duracion))) tiempoTotal,
CONVERT(varchar,fec_registro,103) fechaRegistro
FROM TBL_GESTION_1 G where
CONVERT(varchar,fec_registro,112) between @F1 and @F2 
GROUP BY G.proceso,CONVERT(varchar,fec_registro,103)
GO
/****** Object:  StoredProcedure [dbo].[mensajesNoLeidos]    Script Date: 10/25/2017 12:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[mensajesNoLeidos] 
	-- Add the parameters for the stored procedure here
	@usuarioID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	select count(*) msgsNoLeidos,in_PerfilID from TB_MENSAJES,TB_USUARIO 
		where receptor = @usuarioID and in_UsuarioID=receptor and visto =1 group by in_PerfilID;
END
GO
/****** Object:  Default [DF__TB_USUARI__Estad__5165187F]    Script Date: 10/25/2017 12:36:13 ******/
ALTER TABLE [dbo].[TB_USUARIO] ADD  DEFAULT ((0)) FOR [EstadoConexion]
GO
/****** Object:  Default [DF__TB_USUARI__Estad__45F365D3]    Script Date: 10/25/2017 12:36:13 ******/
ALTER TABLE [dbo].[TB_USUARIO_1] ADD  DEFAULT ((0)) FOR [EstadoConexion]
GO
/****** Object:  Default [DF_TBL_NIVEL_CONTENIDO_in_estado]    Script Date: 10/25/2017 12:36:13 ******/
ALTER TABLE [dbo].[TBL_NIVEL_CONTENIDO] ADD  CONSTRAINT [DF_TBL_NIVEL_CONTENIDO_in_estado]  DEFAULT ((1)) FOR [in_estado]
GO
/****** Object:  ForeignKey [FK__TB_MENSAJ__emiso__46E78A0C]    Script Date: 10/25/2017 12:36:13 ******/
ALTER TABLE [dbo].[TB_MENSAJES]  WITH CHECK ADD FOREIGN KEY([emisor])
REFERENCES [dbo].[TB_USUARIO_1] ([in_UsuarioID])
GO
/****** Object:  ForeignKey [FK__TB_MENSAJ__recep__47DBAE45]    Script Date: 10/25/2017 12:36:13 ******/
ALTER TABLE [dbo].[TB_MENSAJES]  WITH CHECK ADD FOREIGN KEY([receptor])
REFERENCES [dbo].[TB_USUARIO_1] ([in_UsuarioID])
GO
/****** Object:  ForeignKey [FK__TBL_GESTI__in_ca__49C3F6B7]    Script Date: 10/25/2017 12:36:13 ******/
ALTER TABLE [dbo].[TBL_GESTION_1]  WITH CHECK ADD FOREIGN KEY([in_campania])
REFERENCES [dbo].[TB_CAMPANIA] ([in_CampaniaID])
GO
/****** Object:  ForeignKey [FK__TBL_GESTI__in_se__4AB81AF0]    Script Date: 10/25/2017 12:36:13 ******/
ALTER TABLE [dbo].[TBL_GESTION_1]  WITH CHECK ADD FOREIGN KEY([in_sede])
REFERENCES [dbo].[TB_SEDE] ([in_SedeID])
GO
/****** Object:  ForeignKey [FK__TBL_GESTI__in_us__4BAC3F29]    Script Date: 10/25/2017 12:36:13 ******/
ALTER TABLE [dbo].[TBL_GESTION_1]  WITH CHECK ADD FOREIGN KEY([in_usuario])
REFERENCES [dbo].[TB_USUARIO_1] ([in_UsuarioID])
GO
