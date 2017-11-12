--/*
--FIXTURES BOOTSTRAP APP
truncate table [TBL_NIVEL]
truncate table [TBL_NIVEL_CONTENIDO]
TRUNCATE TABLE [TBL_DETALLE_CAMP_NIVEL]

ALTER TABLE [TBL_GESTION_1]  NOCHECK CONSTRAINT FK_CAMP_GEST
ALTER TABLE [TBL_GESTION_1]   DROP CONSTRAINT FK_CAMP_GEST

TRUNCATE TABLE [TB_CAMPANIA]
ALTER TABLE [TBL_GESTION_1]  WITH CHECK ADD constraint FK_CAMP_GEST FOREIGN KEY([in_campania]) REFERENCES [dbo].[TB_CAMPANIA] ([in_CampaniaID])

UPDATE TB_USUARIO  SET in_CampaniaID = 1
--SELECT * FROM  TBL_NIVEL
--SELECT * FROM TBL_NIVEL_CONTENIDO
--SELECT * FROM  [TB_CAMPANIA]
INSERT INTO [TB_CAMPANIA]( vc_Campania, in_SedeID, dt_FecRegistro,in_Estado, in_UsuRegistro) values('AT MOVIL', 3, GETDATE(),1,1);

--*/


--sp_helptext USP_MANT_NIVEL

/*
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
AS --*/

--/* ### BEGIN DEBUG {{
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
@vc_color_alerta nvarchar(50)=''

select
	@INDICE = 1, @pagenum = 1, @pagesize = 4, @in_dpndncia_idnivel = 1152

--*/ --### END DEBUG }}

--SELECT  TOP 10 * FROM TBL_NIVEL
--SELECT  * FROM TBL_NIVEL order by 1 desc
--SELECT  distinct in_rpta FROM TBL_NIVEL order by 1 desc

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

#-------------------------------------------------- BEGIN [sat second proc] - (28-10-2017 - 16:22:04) {{

--sp_helptext sp_Mant_Usuario
--/*
alter proc [dbo].[sp_Mant_Usuario] --2,1,10,0,'','','','', 'Admin','123456'
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

#-------------------------------------------------- END   [sat second proc] - (28-10-2017 - 16:22:04) }}
#-------------------------------------------------- BEGIN [third proc] - (31-10-2017 - 18:07:31) {{

--sp_helptext USP_ARMAR_preview

--   USP_ARMAR_preview 2,164
-- where in_dpndncia_idnivel=128

/*
alter PROC [dbo].[USP_ARMAR_preview]
@indice int=0,
@in_parametro int=0,
@vc_UsuarioID nvarchar(20)='%'
AS  --*/
--/*
declare
@indice int=2,
@in_parametro int=1152,
@vc_UsuarioID nvarchar(20)='%'
--*/


IF @indice = 1 GOTO LST_NIVEL_CABE
if @indice = 2 GOTO LST_NIVEL_SUB
ELSE GOTO SALIR

LST_NIVEL_CABE:

	SELECT id_nivel,in_cate,vc_titulo,vc_descripcion,vc_url_img,in_rpta,in_dpndncia_idnivel, vc_alerta,in_link,vc_color_alerta
	FROM TBL_NIVEL
	WHERE id_nivel=@in_parametro
	--where id_nivel=3117
		and in_estado=1 and in_visible=1
	IF @@ERROR <>0 GOTO SALIR
	GOTO SALIR

LST_NIVEL_SUB:

	if @in_parametro=0 	begin
		SELECT id_nivel,in_cate,vc_titulo,vc_descripcion,vc_url_img,in_rpta,in_dpndncia_idnivel, vc_alerta,in_link,vc_color_alerta
			--SELECT *
		FROM TBL_NIVEL
		WHERE in_dpndncia_idnivel=@in_parametro
			and in_estado=1 and in_visible=1
			and id_nivel in  (
				select N.in_nivel from TBL_DETALLE_CAMP_NIVEL N
				where N.in_campannia in (select in_CampaniaID from TB_USUARIO where in_UsuarioID like @vc_UsuarioID)
			)
	end	else begin
		SELECT id_nivel,in_cate,vc_titulo,vc_descripcion,vc_url_img,in_rpta,in_dpndncia_idnivel, vc_alerta,in_link,vc_color_alerta
		FROM TBL_NIVEL
		WHERE in_dpndncia_idnivel=@in_parametro
			and in_estado=1 and in_visible=1
	end

	IF @@ERROR <>0 GOTO SALIR
	GOTO SALIR

SALIR:
SET NOCOUNT OFF
RETURN

#-------------------------------------------------- END   [third proc] - (31-10-2017 - 18:07:31) }}

--USP_ASIGNAR_CAMP_NIVEL 2,17,0,0,0,0,0

/*
alter PROC [dbo].[USP_ASIGNAR_CAMP_NIVEL]
@indice int =0,
@in_campannia int=0,
@in_nivel int=0,
@cod int=0,
@in_UsuarioID int=0,
@pagenum int=0,
@pagesize int=0
AS    --*/
--/*
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

