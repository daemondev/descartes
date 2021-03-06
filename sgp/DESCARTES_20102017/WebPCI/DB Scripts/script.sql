USE [master]
GO
/****** Object:  Database [BD_DESCARTE_AT_18102017]    Script Date: 11/15/2017 12:47:44 ******/
CREATE DATABASE [BD_DESCARTE_AT_18102017] ON  PRIMARY 
( NAME = N'BD_DESCARTE_AT_18102017', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\BD_DESCARTE_AT_18102017.mdf' , SIZE = 2304KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BD_DESCARTE_AT_18102017_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\BD_DESCARTE_AT_18102017_log.LDF' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BD_DESCARTE_AT_18102017].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET ANSI_NULLS OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET ANSI_PADDING OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET ARITHABORT OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET  ENABLE_BROKER
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET  READ_WRITE
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET RECOVERY FULL
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET  MULTI_USER
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [BD_DESCARTE_AT_18102017] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'BD_DESCARTE_AT_18102017', N'ON'
GO
USE [BD_DESCARTE_AT_18102017]
GO
/****** Object:  UserDefinedFunction [dbo].[cambio]    Script Date: 11/15/2017 12:47:46 ******/
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
/****** Object:  UserDefinedFunction [dbo].[dividirCadena]    Script Date: 11/15/2017 12:47:46 ******/
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
/****** Object:  UserDefinedFunction [dbo].[devuelveHora]    Script Date: 11/15/2017 12:47:46 ******/
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
/****** Object:  Table [dbo].[TB_CARGA_AGENTES]    Script Date: 11/15/2017 12:47:48 ******/
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
/****** Object:  Table [dbo].[TB_CAMPANIA]    Script Date: 11/15/2017 12:47:48 ******/
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
INSERT [dbo].[TB_CAMPANIA] ([in_CampaniaID], [vc_Campania], [in_SedeID], [dt_FecRegistro], [in_Estado], [in_UsuRegistro]) VALUES (1, N'AT MOVIL', 3, CAST(0x0000A82700E998FF AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[TB_CAMPANIA] OFF
/****** Object:  Table [dbo].[TBL_OPCIONES_NIVEL]    Script Date: 11/15/2017 12:47:48 ******/
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
/****** Object:  Table [dbo].[TBL_NIVEL_CONTENIDO]    Script Date: 11/15/2017 12:47:48 ******/
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
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (1, 7, N'<p style="text-align: center;"><span style="color:#ff0000;"><span style="font-size: 48px;">LE GUSTAN LOS AUTOS?</span></span></p><p style="text-align: center;"><span style="font-size:48px;"><img alt="" style="width: 225px; height: 225px;" src="/Archivos_Carga/interrogacion.jpg" /></span></p>', N'#000000', 1, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (2, 10, N'<p style="text-align: center;"><span style="color:#0000ff;"><span style="font-size: 36px;">LE GUSTAN LOS AUTOS DE COLORES B&Aacute;SICOS?</span></span></p><div style="background:#eeeeee;border:1px solid #cccccc;padding:5px 10px;"><p style="text-align: center;"><span style="color:#0000ff;"><span style="font-size: 36px;"><img alt="" style="width: 300px; height: 225px;" src="/Archivos_Carga/autoazul.jpeg" /><img alt="" style="width: 300px; height: 225px;" src="/Archivos_Carga/autorojo.jpg" /><img alt="" style="width: 300px; height: 188px;" src="/Archivos_Carga/autonegro.jpg" /></span></span></p></div>', N'#000000', 1, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (3, 13, N'<p style="text-align: center;"><span style="font-size:48px;"><span style="color: rgb(0, 128, 0);">QUIERE ELEGIR UN COLOR?</span></span></p><p style="text-align: center;"><span style="font-size:48px;"><span style="color: rgb(0, 128, 0);"><img alt="" style="width: 225px; height: 225px;" src="/Archivos_Carga/interrogacion.jpg" /></span></span></p>', N'#000000', 1, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (4, 18, N'<p style="text-align: center;"><span style="font-size:72px;"><span style="background-color:#ffff00;">FIN!!!</span></span></p><p><img alt="" style="display: block; margin-right: auto; margin-left: auto;" src="/Archivos_Carga/finish.png" /></p>', N'#000000', 1, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (5, 20, N'<p style="text-align: center;"><span class="marker"><span style="font-size:72px;"><span style="background-color:#008000;">FIN DE ENCUESTA</span></span></span></p><p><img alt="" style="display: block; margin-right: auto; margin-left: auto;" src="/Archivos_Carga/finish.png" /></p>', N'#000000', 1, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (6, 17, N'<p style="text-align: center;">FINAL DE LA ENCUESTA</p><p style="text-align: center;"><img alt="" style="width: 286px; height: 214px;" src="/Archivos_Carga/finish.png" /></p>', N'#000000', 1, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (7, 23, N'<p style="text-align: center;"><span style="font-size:72px;"><span style="color: rgb(255, 0, 0);">QU&Eacute; TONO DE COLOR PREFIERE?</span></span></p><ol><li><span style="color:#0000ff;"><span style="font-size: 36px;">COLORES OSCUROS</span></span></li><li><span style="color:#0000ff;"><span style="font-size: 36px;">COLORES CLAROS</span></span></li></ol>', N'#000000', 1, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (8, 26, N'<p style="text-align: center;"><span style="font-family:Comic Sans MS,cursive;"><span style="font-size: 48px;">DESEA COMPRAR UN AUTO AHORA?</span></span></p><p style="text-align: center;"><img alt="" style="width: 225px; height: 225px;" src="/Archivos_Carga/interrogacion.jpg" /></p>', N'#000000', 1, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (9, 27, N'<p><span style="font-family:Comic Sans MS,cursive;"><span style="font-size: 48px;"><span style="background-color:#00ffff;">DESEA COMPRAR UN AUTO AHORA?</span></span></span><span style="background-color:#00ffff;"> </span></p><p><img alt="" style="display: block; margin-right: auto; margin-left: auto;" src="/Archivos_Carga/interrogacion.jpg" /></p>', N'#000000', 1, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (10, 30, N'<p>&nbsp;</p><p style="text-align: center;">FIN</p><p><img alt="" style="width: 286px; height: 214px; display: block; margin-right: auto; margin-left: auto;" src="/Archivos_Carga/finish.png" /></p>', N'#000000', 1, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (11, 34, N'<p><br /><img alt="" style="width: 660px; height: 400px;" src="/Archivos_Carga/dinero.png" /></p><p style="text-align: center;"><span style="font-size:36px;"><span style="background-color:#00ff00;">Compra Concretada</span></span></p>', N'#000000', 1, 1)
INSERT [dbo].[TBL_NIVEL_CONTENIDO] ([in_idcontenido], [in_idnivel], [vc_contenido], [vc_color], [in_subrayado], [in_estado]) VALUES (12, 40, N'<p><br /><img alt="" style="width: 286px; height: 214px;" src="/Archivos_Carga/finish.png" />fin</p>', N'#000000', 1, 1)
SET IDENTITY_INSERT [dbo].[TBL_NIVEL_CONTENIDO] OFF
/****** Object:  Table [dbo].[TBL_NIVEL]    Script Date: 11/15/2017 12:47:48 ******/
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
	[in_jumpId] [int] NULL,
 CONSTRAINT [PK_TBL_NIVEL] PRIMARY KEY CLUSTERED 
(
	[id_nivel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TBL_NIVEL] ON
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (1, 1, N'AUTOS', N'Venta de Autos', N'todoAutos.jpg', 2, 1, 0, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700EA438B AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (2, 1, N'COLOR', N'Selección de Colores', N'colores.jpg', 2, 1, 0, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700EA5DEA AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (3, 1, N'MARCA', N'Marca de Autos', N'marcas.jpg', 2, 1, 0, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700EA7998 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (4, 2, N'ENCUESTA DE AUTOS', N'Encuesta', N'todoAutos.jpg', 2, 1, 1, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700EAE057 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (5, 2, N'SELECCIÓN DE COLOR', N'Selección de Color', N'colores.jpg', 2, 1, 2, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700EBA678 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (6, 2, N'FIJACIÓN DE MARCA', N'Elección de Marca', N'marcas.jpg', 2, 1, 3, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700EBE2DF AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (7, 3, N'LE GUSTAN LOS AUTOS', N'Datos de Autos', N'', 8, 1, 4, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700EC6827 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (8, 3, N'SÍ', N'Sí Gusta de Autos', N'', 4, 1, 4, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700ECFB4C AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (9, 7, N'NO', N'No le gustan los Autos', N'', 5, 1, 4, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700ED19B5 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (10, 4, N'PREGUNTA SOBRE COLORES', N'Gusto sobre Colores', N'', 8, 1, 8, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700ED4F3E AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (11, 4, N'SÍ', N'Autos de color Básico', N'', 4, 1, 8, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700EE3A79 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (12, 6, N'NO', N'No quiere autos de Color', N'', 5, 1, 8, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700EE6891 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (13, 5, N'QUIERE ELEGIR UN COLOR?', N'Quiere escoger color', N'', 8, 1, 11, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700EE927B AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (14, 1, N'SÍ', N'Salto a Colores', N'', 7, 1, 11, 3000006, N'', 1, 1, 2, N'noselected', CAST(0x0000A82700EF03BA AS DateTime), 32)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (15, 5, N'NO', N'Finaliza Encuesta', N'', 5, 1, 11, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700EF205A AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (16, 6, N'FINALIZAR', N'Finalizar Encuesta', N'', 3, 1, 15, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700F049B7 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (17, 6, N'FIN ENCUESTA', N'FIN', N'', 8, 1, 15, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700F062FA AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (18, 7, N'FIN', N'FIN', N'', 8, 1, 12, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700F19412 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (19, 7, N'FIN DE ENCUESTA', N'FIN', N'', 3, 1, 12, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700F1F402 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (20, 8, N'FIN DE ENCUESTA', N'FIN DE ENCUESTA', N'', 8, 1, 9, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700F24589 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (21, 8, N'FIN ENCUESTA', N'FIN ENCUESTA', N'', 3, 1, 9, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700F27696 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (22, 2, N'AUTOSERVICIO', N'Servicio al Cliente', N'autoServicio.jpg', 2, 1, 1, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700F4551B AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (23, 3, N'COLORES OSCUROS', N'Colores Oscuros', N'', 8, 1, 5, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700F4D83E AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (24, 3, N'COLORES CLAROS', N'Colores Claros', N'', 4, 1, 5, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700F59FBC AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (25, 3, N'COLORES OSCUROS', N'Colores Oscuros', N'', 4, 1, 5, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700F5F178 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (26, 4, N'AUTOS CLAROS', N'Autos Claros', N'', 8, 1, 24, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700F653BE AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (27, 4, N'AUTOS OSCUROS', N'Autos Oscuros', N'', 8, 1, 25, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700F67181 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (28, 4, N'SÍ', N'Sí desea comprar', N'', 7, 1, 25, 3000006, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700F755AD AS DateTime), 32)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (29, 4, N'NO', N'FIN ENCUESTA', N'', 5, 1, 25, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700F76E9F AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (30, 5, N'FIN', N'FIN ENCUESTA', N'', 8, 1, 29, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700F789CC AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (31, 5, N'FINAL', N'FINAL', N'', 3, 1, 29, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700F7C249 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (32, 3, N'COMPRAR AUTO', N'Comprar', N'dinero.png', 2, 1, 6, 0, N'', 1, 1, 2, N'noselected', CAST(0x0000A82700FA7363 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (33, 3, N'COMPRAR AUTO', N'Comprar', N'', 4, 1, 6, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700FFAFF2 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (34, 4, N'DATOS DE COMPRA', N'datos', N'', 8, 1, 33, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700FFCC78 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (35, 4, N'CONFIRMAR', N'Confirmar', N'', 3, 1, 33, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82700FFF7AE AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (36, 4, N'CANCELAR', N'Cancelar compra', N'', 3, 1, 33, 0, N'', 1, 1, 2, N'noselected', CAST(0x0000A827010009F2 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (37, 5, N'Sí', N'saltar', N'', 7, 1, 11, 3000006, N'', 1, 1, 1, N'noselected', CAST(0x0000A827010491FF AS DateTime), 33)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (38, 5, N'NO', N'cancelar', N'', 5, 1, 34, 0, N'', 1, 1, 2, N'noselected', CAST(0x0000A82701054ACC AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (39, 4, N'NO', N'cancelar', N'', 5, 1, 33, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82701055FF2 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (40, 5, N'Cancelando COMPRA', N'', N'', 8, 1, 39, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82701057A16 AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (41, 5, N'SALIR', N'salir', N'', 3, 1, 39, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A827010588AB AS DateTime), 0)
INSERT [dbo].[TBL_NIVEL] ([id_nivel], [in_cate], [vc_titulo], [vc_descripcion], [vc_url_img], [in_rpta], [in_tipo_rpta], [in_dpndncia_idnivel], [in_link], [vc_alerta], [in_orden], [in_estado], [in_visible], [vc_color_alerta], [dt_fec_registro], [in_jumpId]) VALUES (42, 3, N'Contenido', N'', N'', 8, 1, 5, 0, N'', 1, 1, 1, N'noselected', CAST(0x0000A82B00E3586C AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[TBL_NIVEL] OFF
/****** Object:  Table [dbo].[TBL_GESTION]    Script Date: 11/15/2017 12:47:48 ******/
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
/****** Object:  Table [dbo].[TBL_DETALLE_CAMP_NIVEL]    Script Date: 11/15/2017 12:47:48 ******/
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
INSERT [dbo].[TBL_DETALLE_CAMP_NIVEL] ([cod], [in_campannia], [in_nivel], [in_estado], [in_usuario_reg]) VALUES (1, 1, 1, 1, 1)
INSERT [dbo].[TBL_DETALLE_CAMP_NIVEL] ([cod], [in_campannia], [in_nivel], [in_estado], [in_usuario_reg]) VALUES (3, 1, 3, 1, 1)
SET IDENTITY_INSERT [dbo].[TBL_DETALLE_CAMP_NIVEL] OFF
/****** Object:  Table [dbo].[TBL_CLIENTE]    Script Date: 11/15/2017 12:47:48 ******/
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
SET IDENTITY_INSERT [dbo].[TBL_CLIENTE] ON
INSERT [dbo].[TBL_CLIENTE] ([id_cliente], [vc_nombre], [vc_codigo], [vc_apellidos], [in_archivo], [in_estado], [dt_fecRegistro], [in_visible]) VALUES (1, N'Juan José', N'98745621', N'Perez Perez', 0, 1, CAST(0x0000A82B00ACD0F3 AS DateTime), 2)
INSERT [dbo].[TBL_CLIENTE] ([id_cliente], [vc_nombre], [vc_codigo], [vc_apellidos], [in_archivo], [in_estado], [dt_fecRegistro], [in_visible]) VALUES (2, N'Juan José', N'98756315', N'Perez Perez', 0, 1, CAST(0x0000A82B00AD2AAF AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[TBL_CLIENTE] OFF
/****** Object:  Table [dbo].[TBL_ARCHIVOCARGA]    Script Date: 11/15/2017 12:47:48 ******/
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
/****** Object:  Table [dbo].[TB_USUARIO_1]    Script Date: 11/15/2017 12:47:48 ******/
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
/****** Object:  Table [dbo].[TB_USUARIO]    Script Date: 11/15/2017 12:47:48 ******/
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
INSERT [dbo].[TB_USUARIO] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (1, N'12345678', N'GEANNCARLO', N'VILELA', N'CAÑOLA', N'ADMIN', N'123456', 1, 3, 1, CAST(0x0000A8280104CD5D AS DateTime), NULL, 1, NULL, NULL, 1)
INSERT [dbo].[TB_USUARIO] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (2, N'87456321', N'USUARIO', N'PATERNO', N'MATERNO', N'ASESOR', N'123456', 2, 3, 1, CAST(0x0000A828013E0F54 AS DateTime), NULL, 1, NULL, NULL, 1)
INSERT [dbo].[TB_USUARIO] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (3, N'45590980', N'ANA CRIS', N'SANTOS', N'CATRO', N'ASANTOS', N'45590980', 2, 3, 1, CAST(0x0000A77900BA9FB9 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (4, N'41919016', N'DANIEL', N'OCHOA', N'CRUZ', N'DOCHOA', N'41919016', 2, 3, 1, CAST(0x0000A82801038534 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (5, N'12345687', N'TESTER', N'PATERNO', N'MATERNO', N'TESTER', N'tester', 2, 3, 1, CAST(0x0000A828014F8336 AS DateTime), NULL, 1, NULL, NULL, 0)
INSERT [dbo].[TB_USUARIO] ([in_UsuarioID], [vc_DNI], [vc_Nombre], [vc_ApePaterno], [vc_ApeMaterno], [vc_Usuario], [vc_Clave], [in_PerfilID], [in_SedeID], [in_CampaniaID], [dt_FecRegistro], [in_UsuRegistroID], [in_Estado], [vc_Correo], [vc_ClaveCorreo], [EstadoConexion]) VALUES (6, N'98745632', N'ET', N'PATERNO', N'MATERNO', N'ET', N'98745632', 1, 3, 1, CAST(0x0000A828013FFCBF AS DateTime), NULL, 1, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[TB_USUARIO] OFF
/****** Object:  Table [dbo].[TB_SEDE]    Script Date: 11/15/2017 12:47:48 ******/
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
/****** Object:  Table [dbo].[TB_PERFIL_MENU]    Script Date: 11/15/2017 12:47:48 ******/
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
/****** Object:  Table [dbo].[TB_PERFIL]    Script Date: 11/15/2017 12:47:48 ******/
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
/****** Object:  Table [dbo].[TB_MENU]    Script Date: 11/15/2017 12:47:48 ******/
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
/****** Object:  StoredProcedure [dbo].[enviarMensaje]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  Table [dbo].[TB_MENSAJES]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  Table [dbo].[TBL_GESTION_1]    Script Date: 11/15/2017 12:47:51 ******/
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
SET IDENTITY_INSERT [dbo].[TBL_GESTION_1] ON
INSERT [dbo].[TBL_GESTION_1] ([ID], [in_usuario], [proceso], [vc_tipificacion], [horaInicio], [vc_duracion], [fec_registro], [in_sede], [in_campania]) VALUES (1, 1, N'cines', N'=>Sub Categoría para salto => desc salto => desc sí salto => desc si => desc continue 1 => desc yes => desc no 1', N'16:35:16', N'00:00:34', CAST(0x0000A82601118784 AS DateTime), 3, 1)
INSERT [dbo].[TBL_GESTION_1] ([ID], [in_usuario], [proceso], [vc_tipificacion], [horaInicio], [vc_duracion], [fec_registro], [in_sede], [in_campania]) VALUES (2, 1, N'cines', N'=>Sub Categoría para salto => desc salto => desc sí salto => desc si => desc continue 1 => desc yes => desc no 1', N'17:00:35', N'00:05:17', CAST(0x0000A8260119C5FD AS DateTime), 3, 1)
INSERT [dbo].[TBL_GESTION_1] ([ID], [in_usuario], [proceso], [vc_tipificacion], [horaInicio], [vc_duracion], [fec_registro], [in_sede], [in_campania]) VALUES (3, 1, N'cines', N'=>Sub Categoría para salto => desc salto => desc sí salto => desc si => desc continue 1 => desc yes => desc no 1', N'17:07:56', N'00:00:36', CAST(0x0000A826011A8BE0 AS DateTime), 3, 1)
INSERT [dbo].[TBL_GESTION_1] ([ID], [in_usuario], [proceso], [vc_tipificacion], [horaInicio], [vc_duracion], [fec_registro], [in_sede], [in_campania]) VALUES (4, 1, N'cines', N'=>Sub Categoría para salto => desc salto => desc sí salto => desc si => desc continue 1 => desc yes => desc no 1', N'17:10:39', N'00:00:32', CAST(0x0000A826011B4386 AS DateTime), 3, 1)
INSERT [dbo].[TBL_GESTION_1] ([ID], [in_usuario], [proceso], [vc_tipificacion], [horaInicio], [vc_duracion], [fec_registro], [in_sede], [in_campania]) VALUES (5, 1, N'cines', N'=>Sub Categoría para salto => desc salto => desc sí salto => desc si => desc continue 1 => desc yes => desc no 1', N'17:12:40', N'00:00:21', CAST(0x0000A826011C048E AS DateTime), 3, 1)
INSERT [dbo].[TBL_GESTION_1] ([ID], [in_usuario], [proceso], [vc_tipificacion], [horaInicio], [vc_duracion], [fec_registro], [in_sede], [in_campania]) VALUES (6, 1, N'cines', N'=>Sub Categoría para salto => desc salto => des no salto => desc si => desc continue 1 => desc yes => desc no 1', N'17:47:05', N'00:05:23', CAST(0x0000A8260126518F AS DateTime), 3, 1)
INSERT [dbo].[TBL_GESTION_1] ([ID], [in_usuario], [proceso], [vc_tipificacion], [horaInicio], [vc_duracion], [fec_registro], [in_sede], [in_campania]) VALUES (7, 1, N'AUTOS', N'=>ENCUESTA DE AUTOS => Encuesta => Sí Gusta de Autos => Autos de color Básico => Comprar => cancelar', N'15:43:50', N'00:08:57', CAST(0x0000A8270105CC27 AS DateTime), 3, 1)
INSERT [dbo].[TBL_GESTION_1] ([ID], [in_usuario], [proceso], [vc_tipificacion], [horaInicio], [vc_duracion], [fec_registro], [in_sede], [in_campania]) VALUES (8, 1, N'COLOR', N'=>SELECCIÓN DE COLOR => Selección de Color => Colores Oscuros => FIN ENCUESTA', N'15:53:15', N'00:00:37', CAST(0x0000A827010600FE AS DateTime), 3, 1)
INSERT [dbo].[TBL_GESTION_1] ([ID], [in_usuario], [proceso], [vc_tipificacion], [horaInicio], [vc_duracion], [fec_registro], [in_sede], [in_campania]) VALUES (9, 1, N'MARCA', N'=>FIJACIÓN DE MARCA => Elección de Marca => Comprar', N'15:53:59', N'00:00:08', CAST(0x0000A82701061429 AS DateTime), 3, 1)
SET IDENTITY_INSERT [dbo].[TBL_GESTION_1] OFF
/****** Object:  StoredProcedure [dbo].[delDeleteContent]    Script Date: 11/15/2017 12:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[delDeleteContent] 
@in_idContenido int
as
delete from TBL_NIVEL_CONTENIDO where in_idcontenido = @in_idContenido
GO
/****** Object:  StoredProcedure [dbo].[dameTitulo]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_Reporte]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_mantSede]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_MantPerfil]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_MantMenuPerfil]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_mantContenido_Nivel]    Script Date: 11/15/2017 12:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--sp_helptext  usp_mantContenido_Nivel
--/*
CREATE PROC [dbo].[usp_mantContenido_Nivel] 
@in_opc int=0,
@in_idcontenido int=0,	
@in_idnivel int=0,
@vc_contenido nvarchar(max)='',
@vc_color nvarchar(50)='',
@in_subrayado int=0,
@pagenum int=0,
@pagesize int=0
AS  --*/

/*
declare
	@in_opc int=0,
	@in_idcontenido int=0,	
	@in_idnivel int=0,
	@vc_contenido nvarchar(max)='',
	@vc_color nvarchar(50)='',
	@in_subrayado int=0,
	@pagenum int=0,
	@pagesize int=0;
	
select @in_opc =6, @in_idnivel= 1135
--*/
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
	
	select @@identity
	
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
	
	select @in_idcontenido
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
	-- select * 
	FROM dbo.TBL_NIVEL_CONTENIDO
	WHERE in_idnivel=@in_idnivel
IF @@ERROR<>0 GOTO salir
GOTO salir

SALIR:	
  SET NOCOUNT OFF
  RETURN
GO
/****** Object:  StoredProcedure [dbo].[usp_mantCampania]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_MantAgentes]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[USP_MANT_NIVEL]    Script Date: 11/15/2017 12:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--sp_helptext USP_MANT_NIVEL
-- sp_helptext USP_MANT_NIVEL
--/*
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
@vc_color_alerta nvarchar(50)='',
@in_jumpId int = 0
AS --*/

/*
declare 
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
	@vc_color_alerta nvarchar(50)='',
	@in_jumpId int = 0

--*/

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
			) as vc_enlase,*/N.vc_color_alerta,N.in_jumpId
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
		/*vc_enlase,*/vc_color_alerta,in_jumpId,
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
					vc_color_alerta,dt_fec_registro,in_jumpId)
			VALUES (
				(@IN_CATE+1),
				@VC_TITULO,
				@vc_descripcion,
				@vc_url_img,
				@in_rpta,
				@in_dpndncia_idnivel,
				@vc_alerta,1,1,1,1,@IN_ID_LINK,@vc_color_alerta,GETDATE(),@in_jumpId)
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
				in_link=@IN_ID_LINK,
				in_jumpId=@in_jumpId
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
				in_link=@IN_ID_LINK,
				in_jumpId=@in_jumpId
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
/****** Object:  StoredProcedure [dbo].[USP_MANT_CLIENTE]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[USP_MAN_OPCIONES_NIVEL]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[USP_INS_TBL_ARCHIVOCARGA]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[finalizaSesion]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_cargarCombos]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[USP_ASIGNAR_CAMP_NIVEL]    Script Date: 11/15/2017 12:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--USP_ASIGNAR_CAMP_NIVEL 2,17,0,0,0,0,0    
    
--/*        
CREATE PROC [dbo].[USP_ASIGNAR_CAMP_NIVEL]    
@indice int =0,    
@in_campannia int=0,    
@in_nivel int=0,    
@cod int=0,    
@in_UsuarioID int=0,    
@pagenum int=0,    
@pagesize int=0    
AS    --*/
/*
declare 
@indice int =0,    
@in_campannia int=0,    
@in_nivel int=0,    
@cod int=0,    
@in_UsuarioID int=0,    
@pagenum int=1,    
@pagesize int=10    
select  @indice = 2, @in_campannia = 17, @in_UsuarioID = 1
--*/    

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
	--select * from TBL_NIVEL      
	--select * from #LISTA_DETALLE 
	--select * FROM TBL_DETALLE_CAMP_NIVEL D        
	DROP TABLE #LISTA_DETALLE      
	--truncate table TBL_NIVEL      
	--truncate table TBL_DETALLE_CAMP_NIVEL 
    
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
/****** Object:  StoredProcedure [dbo].[USP_ARMAR_preview]    Script Date: 11/15/2017 12:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--sp_helptext USP_ARMAR_preview

--   USP_ARMAR_preview 2,164
-- where in_dpndncia_idnivel=128

--/*
CREATE PROC [dbo].[USP_ARMAR_preview]
@indice int=0,
@in_parametro int=0,
@vc_UsuarioID nvarchar(20)='%'
AS  --*/

/*
declare 
@indice int=2,
@in_parametro int=0,
@vc_UsuarioID nvarchar(20)='%' 
--*/


IF @indice = 1 GOTO LST_NIVEL_CABE
if @indice = 2 GOTO LST_NIVEL_SUB
ELSE GOTO SALIR

LST_NIVEL_CABE:	

	SELECT id_nivel,in_cate,vc_titulo,vc_descripcion,vc_url_img,in_rpta,in_dpndncia_idnivel, vc_alerta,in_link,vc_color_alerta, ISNULL(c.vc_contenido,'') as vc_contenido,n.in_jumpId
	FROM TBL_NIVEL n left join TBL_NIVEL_CONTENIDO c on c.in_idnivel = n.id_nivel
	WHERE id_nivel=@in_parametro
	--where id_nivel=3117 	
		and n.in_estado=1 and in_visible=1 	
		--and c.in_estado = 1
	IF @@ERROR <>0 GOTO SALIR
	GOTO SALIR
		
LST_NIVEL_SUB:

	if @in_parametro=0 	begin
		SELECT id_nivel,in_cate,vc_titulo,vc_descripcion,vc_url_img,in_rpta,in_dpndncia_idnivel, vc_alerta,in_link,vc_color_alerta,ISNULL(c.vc_contenido,'') as vc_contenido,n.in_jumpId
			--SELECT * 
		FROM TBL_NIVEL n left join TBL_NIVEL_CONTENIDO c on c.in_idnivel = n.id_nivel
		WHERE in_dpndncia_idnivel=@in_parametro 
			and n.in_estado=1 and in_visible=1
			and id_nivel in  (
				select N.in_nivel from TBL_DETALLE_CAMP_NIVEL N
				where N.in_campannia in (select in_CampaniaID from TB_USUARIO where in_UsuarioID like @vc_UsuarioID)
			)
	end	else begin
		SELECT id_nivel,in_cate,vc_titulo,vc_descripcion,vc_url_img,in_rpta,in_dpndncia_idnivel, vc_alerta,in_link,vc_color_alerta,  ISNULL(c.vc_contenido,'') as vc_contenido,n.in_jumpId
		--select * 
		FROM TBL_NIVEL n left join TBL_NIVEL_CONTENIDO c on c.in_idnivel = n.id_nivel
		WHERE in_dpndncia_idnivel=@in_parametro 
			and n.in_estado=1 and in_visible=1
			--and c.in_estado = 1
	end
	
	IF @@ERROR <>0 GOTO SALIR
	GOTO SALIR

SALIR:
SET NOCOUNT OFF
RETURN
GO
/****** Object:  StoredProcedure [dbo].[traerSubProcesos]    Script Date: 11/15/2017 12:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--/*
CREATE PROCEDURE [dbo].[traerSubProcesos]
	@matrizAnterior int
AS --*/
/*
declare @matrizAnterior int = 2
--*/

BEGIN
	select id_nivel,vc_titulo,vc_descripcion,vc_url_img,in_link,in_jumpId,in_dpndncia_idnivel from TBL_NIVEL where in_dpndncia_idnivel=@matrizAnterior and in_estado = 1; --and in_rpta in (2,7)
	--select * from TBL_NIVEL where in_dpndncia_idnivel=@matrizAnterior and in_rpta in (2,7) and in_estado = 1;
END


--update TBL_NIVEL  set  in_jumpId = 0
--alter table TBL_NIVEL add in_jumpId int default 0
--alter table TBL_NIVEL drop column in_jumpId 
--alter table TBL_NIVEL drop constraint DF__TBL_NIVEL__in_ju__6C190EBB
GO
/****** Object:  StoredProcedure [dbo].[traerProcesos]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[traerMatrices]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[traerAdmins]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[setChangePassword]    Script Date: 11/15/2017 12:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[setChangePassword]
@in_idUsuario int,
@vc_Clave varchar(50)
as --*/
/*
declare 
@in_idUsuario int,
@vc_Clave varchar(50) --*/
update TB_USUARIO set vc_Clave = @vc_Clave where in_UsuarioID = @in_idUsuario;
if (@@ERROR <> 0) begin	
	select 'error' as result
end else begin
	select 'successful' as result
end
GO
/****** Object:  StoredProcedure [dbo].[USP_VERHISTORIAL]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[USP_REPORTES]    Script Date: 11/15/2017 12:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_helptext USP_REPORTES
--/*
CREATE PROC [dbo].[USP_REPORTES] 
@F1 NVARCHAR(20)='',
@F2 NVARCHAR(20)='',
@SEDE NVARCHAR(20)='%',
@CAMPANNIA NVARCHAR(20)='%'
AS --*/
/*
declare 
@F1 NVARCHAR(20)='2017/11/09',
@F2 NVARCHAR(20)='2017/11/09',
@SEDE NVARCHAR(20)='%',
@CAMPANNIA NVARCHAR(20)='%'
--*/

set @F1= CONVERT(varchar,CONVERT(date,@f1),112)
set @F2= CONVERT(varchar,CONVERT(date,@f2),112)

SELECT 
(select vc_Sede from TB_SEDE SS where SS.in_SedeID= (select  UU.in_SedeID from tb_usuario UU where UU.in_UsuarioID=G.in_usuario )) as vc_sede ,
(select vc_Campania from TB_CAMPANIA CC where CC.in_CampaniaID = (select  UU.in_CampaniaID from tb_usuario UU where UU.in_UsuarioID=G.in_usuario )) as vc_campania ,
(select vc_Nombre +' '+ vc_ApePaterno + ' ' +vc_ApeMaterno  from TB_USUARIO where in_UsuarioID=G.in_usuario) as vc_usuario,
(select vc_Usuario  from TB_USUARIO where in_UsuarioID=G.in_usuario) as vc_user,
/*isnull((select vc_nombre from TBL_CLIENTE C where C.id_cliente=G.in_cliente),'NUEVO') as vc_cliente,
(select vc_codigo from TBL_CLIENTE C where C.id_cliente=G.in_cliente)as vc_codCliente,*/
'''' +  G.vc_tipificacion,
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
/****** Object:  StoredProcedure [dbo].[REPORTE_GENERAL]    Script Date: 11/15/2017 12:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--sp_helptext REPORTE_GENERAL

--/*
CREATE PROCEDURE [dbo].[REPORTE_GENERAL] 
@F1 NVARCHAR(20)='',
@F2 NVARCHAR(20)='',
@SEDE NVARCHAR(20)='%',
@CAMPANNIA NVARCHAR(20)='%'
AS --*/
/*
declare 
@F1 NVARCHAR(20)='2017/11/09',
@F2 NVARCHAR(20)='2017/11/09',
@SEDE NVARCHAR(20)='%',
@CAMPANNIA NVARCHAR(20)='%'
--*/


set @F1= CONVERT(varchar,CONVERT(date,@f1),112)
set @F2= CONVERT(varchar,CONVERT(date,@f2),112)

SELECT 

vc_Nombre +' '+ vc_ApePaterno + ' ' +vc_ApeMaterno + ' ('+ u.vc_Usuario+')' as vc_Usuario,G.proceso,
COUNT(*) cantidadProcesos,
dbo.devuelveHora(sum(dbo.cambio(G.vc_duracion))) tiempoTotal,
CONVERT(varchar,fec_registro,103) fechaRegistro
FROM TBL_GESTION_1 G join TB_USUARIO u on u.in_UsuarioID = G.in_usuario where
CONVERT(varchar,fec_registro,112) between @F1 and @F2 
GROUP BY G.proceso,vc_Nombre +' '+ vc_ApePaterno + ' ' +vc_ApeMaterno + ' ('+ u.vc_Usuario+')',CONVERT(varchar,fec_registro,103)
/*
select * from TBL_GESTION_1
select * from TB_USUARIO --*/
GO
/****** Object:  StoredProcedure [dbo].[mensajesNoLeidos]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[USP_GESTION]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarHistorial]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_mostrarChat]    Script Date: 11/15/2017 12:47:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Mant_Usuario]    Script Date: 11/15/2017 12:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--sp_helptext sp_Mant_Usuario
--/*
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
as --*/

/*
declare
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
@in_CampaniaID int=0;

select @in_Opc = 1, @vc_Usuario = 'admin', @vc_Clave = '123456'

--*/
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
--/*
declare @auxPassword varchar(50)
set @auxPassword = @vc_DNI

if(@vc_Clave != '') begin 
	set @auxPassword = @vc_Clave
end  --*/

if (@in_UsuarioID = 0)
  begin
	if not exists (select vc_DNI from TB_USUARIO where vc_DNI = LTRIM(RTRIM(@vc_DNI)))
	  begin
		insert into TB_USUARIO(vc_DNI,vc_Nombre,vc_ApePaterno,vc_ApeMaterno,vc_Usuario,vc_Clave,
								in_PerfilID,in_SedeID,dt_FecRegistro,in_Estado,in_CampaniaID)
		values(UPPER(@vc_DNI),UPPER(@vc_Nombre),UPPER(@vc_ApePaterno),UPPER(@vc_ApeMaterno),UPPER(@vc_Usuario),@auxPassword
								,@in_PerfilID,@in_SedeID,GETDATE(), 1,@in_CampaniaID)
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
								,vc_Clave = @auxPassword								
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
/****** Object:  Default [DF_TBL_NIVEL_CONTENIDO_in_estado]    Script Date: 11/15/2017 12:47:48 ******/
ALTER TABLE [dbo].[TBL_NIVEL_CONTENIDO] ADD  CONSTRAINT [DF_TBL_NIVEL_CONTENIDO_in_estado]  DEFAULT ((1)) FOR [in_estado]
GO
/****** Object:  Default [DF__TBL_NIVEL__in_ju__534D60F1]    Script Date: 11/15/2017 12:47:48 ******/
ALTER TABLE [dbo].[TBL_NIVEL] ADD  DEFAULT ((0)) FOR [in_jumpId]
GO
/****** Object:  Default [DF__TB_USUARI__Estad__5441852A]    Script Date: 11/15/2017 12:47:48 ******/
ALTER TABLE [dbo].[TB_USUARIO_1] ADD  DEFAULT ((0)) FOR [EstadoConexion]
GO
/****** Object:  Default [DF__TB_USUARI__Estad__5535A963]    Script Date: 11/15/2017 12:47:48 ******/
ALTER TABLE [dbo].[TB_USUARIO] ADD  DEFAULT ((0)) FOR [EstadoConexion]
GO
/****** Object:  ForeignKey [FK__TB_MENSAJ__emiso__5629CD9C]    Script Date: 11/15/2017 12:47:51 ******/
ALTER TABLE [dbo].[TB_MENSAJES]  WITH CHECK ADD FOREIGN KEY([emisor])
REFERENCES [dbo].[TB_USUARIO_1] ([in_UsuarioID])
GO
/****** Object:  ForeignKey [FK__TB_MENSAJ__recep__571DF1D5]    Script Date: 11/15/2017 12:47:51 ******/
ALTER TABLE [dbo].[TB_MENSAJES]  WITH CHECK ADD FOREIGN KEY([receptor])
REFERENCES [dbo].[TB_USUARIO_1] ([in_UsuarioID])
GO
/****** Object:  ForeignKey [FK__TBL_GESTI__in_se__5812160E]    Script Date: 11/15/2017 12:47:51 ******/
ALTER TABLE [dbo].[TBL_GESTION_1]  WITH CHECK ADD FOREIGN KEY([in_sede])
REFERENCES [dbo].[TB_SEDE] ([in_SedeID])
GO
/****** Object:  ForeignKey [FK__TBL_GESTI__in_us__59063A47]    Script Date: 11/15/2017 12:47:51 ******/
ALTER TABLE [dbo].[TBL_GESTION_1]  WITH CHECK ADD FOREIGN KEY([in_usuario])
REFERENCES [dbo].[TB_USUARIO_1] ([in_UsuarioID])
GO
/****** Object:  ForeignKey [FK_CAMP_GEST]    Script Date: 11/15/2017 12:47:51 ******/
ALTER TABLE [dbo].[TBL_GESTION_1]  WITH CHECK ADD  CONSTRAINT [FK_CAMP_GEST] FOREIGN KEY([in_campania])
REFERENCES [dbo].[TB_CAMPANIA] ([in_CampaniaID])
GO
ALTER TABLE [dbo].[TBL_GESTION_1] CHECK CONSTRAINT [FK_CAMP_GEST]
GO
