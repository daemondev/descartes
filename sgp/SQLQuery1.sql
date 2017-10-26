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

