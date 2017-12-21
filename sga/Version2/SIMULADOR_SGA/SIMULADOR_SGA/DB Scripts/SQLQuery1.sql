/*
delete tb_datos_cliente  where vc_codigo = '01002990'
delete tb_datos_cliente  where vc_documento = '20988151'
update tb_datos_cliente set dt_fecha = GETDATE() -15  where vc_documento = '20988151'

select * from tb_datos_cliente 
insert into tb_datos_cliente (vc_documento,vc_codigo, vc_tipo_persona, vc_documento_tipo, vc_razon_social, vc_abreviado, vc_direccion, vc_distrito, vc_ciudad, vc_segmento_negocio, vc_tipo_empresa, vc_categoria, vc_ejecutivo_datos, dt_fecha) values
('20988151','01002990','Residencial','DNI/LE', 'PARAGUAY MERCADO DAVID','PARAGUAY MERCADO DAVID', 'CENTRO POBLADO VILLA FLAVIA MZ.. LT.. SEC.. .A', 'MAZAMARI | SATIPO | JUNIN', 'JUNIN', 'CLIENTE C','NACIONAL', 'Estandar', 'Sin Definir',GETDATE()-15)

insert into TB_contactos(vc_codigo, vc_tipo_contacto, vc_contacto, vc_cargo, vc_cargo_especifico, tipo_doc, n_doc, n_servicio) values
('01002990','PROPIETARIO', 'DAVID PARAGUAY MERCADO','Propietario', 'Propietario', 'DNI/LE','20988151','1852876')
---*/


if OBJECT_ID('getClientByID') is not null drop procedure getClientByID
go
create procedure getClientByID
@idCliente int
as
SELECT * FROM tb_datos_cliente where vc_codigo=@idCliente
go

if OBJECT_ID('getClientByDOC') is not null drop procedure getClientByDOC
go
create procedure getClientByDOC
@docCliente int
as
SELECT * FROM TB_datos_cliente where vc_documento=@docCliente
go

--alter table TB_datos_cliente add id int primary key identity
--alter table TB_datos_cliente drop column id int identity


---------------------------
if OBJECT_ID('tvSatelital') is not null drop table tvSatelital
go

if OBJECT_ID('tipoContrato') is not null drop table tipoContrato
go
create table tipoContrato(
id int primary key identity,
nombre varchar(80),
descripcion varchar(80)
)
go
insert into tipoContrato(nombre, descripcion) values('Contrato','solo contratos')
go
select * from tipoContrato
go
---------------------------

if OBJECT_ID('tvSatelital') is not null drop table tvSatelital
go
if OBJECT_ID('contratista') is not null drop table contratista
go

create table contratista(
id int primary key identity,
nombre varchar(80),
consultor varchar(80),
instalador varchar(80),
ins datetime default getdate()
)
go
insert into contratista (nombre, consultor, instalador) values('GRUPO SKYNET SAC','','ERICK CALZADA CAHUANA')
go
select * from contratista
go

if OBJECT_ID('tvSatelital') is not null drop table tvSatelital
go

create table tvSatelital(
id int primary key identity,
idCliente int foreign key references TB_datos_cliente(id),
idContratista int foreign key references contratista(id),
idTipoContrato int foreign key references tipoContrato(id),
nroRegistro varchar(15),
estRegistro varchar(15),
fecRegistro datetime default getdate(),
horaRegistro as convert(char(8),fecRegistro, 108),
idUsuario int foreign key references TB_USUARIO(in_UsuarioID),
nroProyecto varchar(20),
solicitud int,

cliPre varchar(15),
contacto varchar(80),
telefono1 varchar(15),
telefono2 varchar(15),
paquete varchar(80),
dirInstPre varchar(15),
dirInstPost varchar(150),
dirFacPre varchar(15),
dirFacPost varchar(150),
observacion varchar(200),

contNroDocumento varchar(15),

facTipoDoc varchar(50),
facSerie varchar(10),
facNumero varchar(10),
motLugarVenta varchar(100),
motTipoCliente varchar(50),
motCompetidor varchar(50),
motTipoFacturacion varchar(100),

recCodigo varchar(20),
recEnSistema bit default 0,
recFecIniVigencia date,
recFecFinVigencia date,
recFecCorteProgramado date,
recNumeroUltimaRecarga int,

ins datetime default getdate()
)
go

insert into tvSatelital(idCliente,idContratista, idTipoContrato, nroRegistro, estRegistro,idUsuario, nroProyecto, solicitud
		,cliPre, contacto, telefono1, telefono2, paquete,dirInstPre, dirInstPost, dirFacPre, dirFacPost, observacion
		,contNroDocumento, facTipoDoc, facSerie, facNumero, motLugarVenta, motTipoCliente, motCompetidor, motTipoFacturacion
		,recCodigo, recEnSistema, recFecIniVigencia, recFecFinVigencia, recFecCorteProgramado, recNumeroUltimaRecarga) values
		(6,1,1,'0005779215', 'ACTIVO', 1,'0000864657', 2387196
		,'01002990' ,'DAVID PARAGUAY MERCADO','964741357','', 'CLARO TV SAT PLAN B�SICO VN', '0000866109', 'CENTRO POBLADO VILLA FLAVIA MZ. 51 LT. 10 EN EL CERCADO','0000866109', 'CENTRO POBLADO VILLA FLAVIA MZ. 51 LT. 10 EN EL CERCADO',''
		,'DT452454','BOLETA','014', '003134', 'CANALES - AGENTES', 'Cliente Nuevo', '', 'S/. 75.00 Pago de Instalaci�n al Contado'
		,20988151,1,'20170827','20170926','20170927',136761)
go
select * from tvSatelital
go


if OBJECT_ID('getTVSatelitalDataByDOCCliente') is not null drop procedure getTVSatelitalDataByDOCCliente
go
create procedure getTVSatelitalDataByDOCCliente --1
--@idCliente int
@idCliente varchar(15)
as
SELECT top 1 tv.nroRegistro, tv.estRegistro, convert(varchar(10),tv.fecRegistro,103) as [fecRegistro], tv.horaRegistro, u.vc_Usuario as [usuario],tv.nroProyecto, tv.solicitud --TVS
	,co.nombre as [contrata], co.consultor, co.instalador -- CONTRATISTA
	,tv.cliPre, cl.vc_razon_social, cl.vc_documento_tipo, cl.vc_documento, tv.contacto, tv.telefono1, tv.telefono2, tv.paquete, tv.dirInstPre, tv.dirInstPost, tv.dirFacPre, tv.dirFacPost, tv.observacion
	,tc.nombre as [contTipoDoc], tv.contNroDocumento, tv.facTipoDoc, tv.facSerie, tv.facNumero, tv.motLugarVenta, tv.motTipoCliente, tv.motCompetidor, tv.motTipoFacturacion
	,tv.recCodigo, tv.recEnSistema, convert(varchar(10),tv.recFecIniVigencia, 103) as recFecIniVigencia, convert(varchar(10),tv.recFecFinVigencia, 103) as recFecFinVigencia, convert(varchar(10),tv.recFecCorteProgramado, 103) as recFecCorteProgramado, tv.recNumeroUltimaRecarga
	,cl.n_servicio, cl.id
	FROM tvSatelital tv 
	join TB_datos_cliente cl on cl.id = tv.idCliente 
	join contratista co on co.id = tv.idContratista 
	join TB_USUARIO u on u.in_UsuarioID = tv.idUsuario  
	join tipoContrato tc on tc.id = tv.idTipoContrato
--where idCliente=@idCliente
where cl.vc_documento=@idCliente
go
exec getTVSatelitalDataByDOCCliente 44880188
go
--update TB_datos_cliente  set vc_ejecutivo_datos = 'Sin Definir' where vc_documento = 44880188
--select * from TB_datos_cliente 
select * from [TB_servicios_contratados]
go

--###
--alter table [TB_servicios_contratados] add bouquets varchar(200), fecInicio date, fecFin date, fecActivacion date
--alter table [TB_servicios_contratados] drop column bouquets varchar(50)

--update [TB_servicios_contratados] set bouquets = '110, 112, 114, 115, 116, 121, 122, 124, 128, 129, 141, 144' where 
--select * from [TB_servicios_contratados] where vc_numero_servicio =  'SID.1852876'

--update [TB_servicios_contratados] set bouquets = ''
--delete [TB_servicios_contratados] where vc_numero_servicio =  'SID.1852876'
--delete [TB_servicios_contratados] where n_doc =  '20988151'
--insert into   [TB_servicios_contratados] (vc_tipo_servicio, vc_producto)
--sp_help [TB_servicios_contratados]

/*

alter table [TB_servicios_contratados] alter column vc_direccion varchar(400)
insert into   [TB_servicios_contratados] (n_doc, vc_codigo, vc_tipo_servicio, vc_producto, vc_servicio, vc_numero_servicio, vc_estado, bouquets, fecInicio, vc_direccion, vc_distrito) values
('20988151','1852876','Cable', 'Claro TV - Sat Plan B�sico VN','Claro TV - Sat Plan B�sico VN','SID.1852876','Activo', '110, 112, 114, 115, 116, 121, 122, 124, 128, 129, 141, 144', '28/12/2010','CENTRO POBLADO VILLA FLAVIA MZ. 51 LT. 10-B EN EL MISMO GRIFO VILLA FLAVIA. ALTURA DEL KIL�METRO 19 DE LA CARRETERA MARGINAL SATIPO MAZAMARI', 'MAZAMARI | SATIPO | JUNIN')
,('20988151','7417399','Cable', 'Claro TV - Sat Plan B�sico SC','Claro TV - Sat Plan B�sico SC','CID.7417399','Suspendido', '', '28/12/2010','CA ANTONIO PORTUGAL 703 702 PISO 1 ALTURA DE LA CARRETERA CENTRAL DONDE SE ENCUENTRAN LOS CENTROS BANCARIOS','SANTA ANITA | LIMA | LIMA')
,('20988151','7150038','', 'Claro TV - Sat Plan B�sico SC','SID.7150038','','Suspendido', '', '28/12/2010','CA ANTONIO PORTUGAL 703 702 PISO 1 ALTURA DE LA CARRETERA CENTRAL DONDE SE ENCUENTRAN LOS CENTROS BANCARIOS','SANTA ANITA | LIMA | LIMA')
,('20988151','','Cable', 'Claro TV - Sat Plan B�sico VN','Claro TV - Sat Plan B�sico VN','SID.1856365','Cancelado', '', '28/12/2010','AV VICTOR ROJAS SN FRENTE AL CENTRO EDUCATIVO SAGRADO CORAZ�N DE JES�S DEL DISTRITO DE VILCABAMBA .... A 2 CUADRAS DE LA PLAZA DE ARMAS DEL DISTRITO DE VILCABAMBA','VILCABAMBA | GRAU | AP')

,('20988151','','Cable', 'Claro TV - Sat Plan Plus','Claro TV - Sat Plan Plus','9237989','Sin Activar', '', '28/12/2010','AV ANDRES AVELINA C�CERES 0 SIN NOMBRE PASAJE LOS POZOS 000 ALL LADO DE LA INSTITUCI�N EDUCATIVA JUAN XXIII AL FRENTE DEL GOBIERNO REGIONAL - 946701958','MOQUEGUA| MARISCAL NI')
,('20988151','','', 'Claro TV - Sat Plan Plus','','SID.5211052','Sin Activar', '', '28/12/2010','-- S/N COOPERATIVA VA BELAUNDE  MZ. H LT. 9-1 PEDRA SANTA CASA 2 PISOS BLANCO CON ROJO REJAS NEGRAS','YANAHURA | AREQUIPA |')



--*/


if OBJECT_ID('getTVSServices') is not null drop procedure getTVSServices
go
create procedure getTVSServices
@idCliente varchar(15)
as
select sc.vc_codigo as [SID], sc.vc_tipo_servicio as [Tipo Servicio], sc.vc_producto as [Producto], sc.vc_numero_servicio as [N�mero Servicio], sc.vc_estado as [Estado], sc.bouquets as [Bouquets], sc.fecInicio as [Fecha inicio], sc.fecFin as [Fecha fin], sc.fecActivacion as [Fecha Activaci�n], sc.vc_motivo as [Motivo], sc.vc_direccion as [Direcci�n]
	from [TB_servicios_contratados] sc  --where sc.n_doc = '44880188'
	--join tb_solicitudes_ot so on sc.vc_numero_servicio = so.vc_n_servicio
where sc.n_doc = @idCliente and sc.vc_estado = 'Activo'

--where sc.vc_numero_servicio = @idCliente
go

exec getTVSServices 20988151
--exec getTVSServices 16482223
go

--select * from tb_solicitudes_ot

if OBJECT_ID('equipo') is not null drop table equipo
go
create table equipo(
id int primary key identity,
nombre varchar(80),
descripcion varchar(80),
SOT int,
orden int,
idCliente int foreign key references TB_datos_cliente(id),
--punto varchar(100),
etapa varchar(100),
equipo int, 
codSap varchar(20),
solic bit default 1,
req bit default 0,
nSerie varchar(50),
unitAddress varchar(50),
cantidad decimal(3,2),
ins datetime default getdate()
)
go
insert into equipo (nombre, descripcion, SOT, orden, idCliente, etapa, equipo, codSap, solic, req, nSerie, unitAddress, cantidad) values 
('','AZ-60RS-STM, Antena parab�lica de 60cm, AC',2387196,1,6,'CLIENTE-CPE',7112, '', 1,0, '','',1.00 ),
('','CONECTOR DE COMPRESI�N SLCU-6',2387196,2,6,'CLIENTE INSTALACI�N DE EQUIPOS-MANUAL 1',6414, '', 1,0, '','',2.00 ),
('','CONECTOR DE COMPRESI�N SLCU-6',2387196,3,6,'CLIENTE INSTALACI�N DE EQUIPOS-MANUAL 1',6414, '', 1,0, '','',2.00 ),
('','CABLE COAXIAL NEGRO RG-6 S/MENSAJERO',2387196,4,6,'CLIENTE-INSTALACI�N DE ACOMETIDA',8046, '', 1,0, '','',2.00 )
go
select * from equipo
go

if OBJECT_ID('getTVSEquipo') is not null drop procedure getTVSEquipo
go
create procedure getTVSEquipo
@idCliente varchar(15)
as
select eq.SOT, eq.orden as [Orden], cl.vc_razon_social as [Punto], eq.etapa as [Etapa], eq.equipo as [Equipo], eq.codSap as [Cod Sap], eq.descripcion as [Equipo Descripci�n], eq.solic as [Solic], eq.req as [Req], eq.nSerie as [N.Serie], eq.unitAddress as [Unitaddress], eq.cantidad as [Cantidad]	
	from equipo eq
	join TB_datos_cliente cl on cl.id = eq.idCliente
where eq.idCliente = @idCliente

go

if OBJECT_ID('tipificacion') is not null drop table tipificacion
go
create table tipificacion(
id int primary key identity,
nombre varchar(80),
descripcion varchar(80),
calidad bit default 0,
montoReq bit default 0,
ins datetime default getdate()
)
go
insert into tipificacion(nombre, descripcion,calidad, montoReq) 
select vc_tipo_servicio, vc_caso_atencion,0,0 from [tb_seleccionar_tipificacion_tipo_caso]
go
insert into tipificacion(nombre, descripcion,calidad, montoReq) values
('Cable','ACCESO ACONDICIONADO',1,0),
('Cable','ACTIVACI�N DE SERVICIO SUPLEMENTARIO',0,0),
('Cable','ACTIVACI�N DE VALOR AGREGADO',0,0),
('Cable','ATENCI�N T�CNICA PRIORIZADA',1,0),
('Cable','AVER�A / SIN DESCARTES',1,0),
('Cable','AVER�A / SIN TEL�FONO',1,0),
('Cable','CALIDAD CABLE',1,0),
('Cable','CANALES CODIFICADOS PROBLEMAS CON TARJE',1,0),
('Cable','CONTINGENCIA ADMINISTRATIVA',0,0),
('Cable','CONTINGENCIA T�CNICA',0,0),
('Cable','DA�OS EN PROCESO DE INSTALACI�N / MANTENIMIENTO',0,1),
('Cable','DECOS DESHABILITADOS',1,0),
('Cable','DESBLOQUEO DE CONTROL PARENTAL',1,0),
('Cable','IMAGEN CONGELADA',1,0),
('Cable','IMAGEN LLUVIOSA O PIXELEADA',1,0),
('Cable','IMAGEN SOBREPUESTA',1,0),
('Cable','MALA SE�AL',1,0),
('Cable','MENSAJE SIN CANAL',1,0),
('Cable','MENSAJE SIN SE�AL',1,0),
('Cable','MODIFICACI�N DHCP',0,0),
('Cable','NO VISUALIZA ALGUNOS CANALES',1,0),
('Cable','NO VISUALIZA LOS CANALES DE PROMOCI�N',1,0),
('Cable','OTROS CALIDAD',1,0),
('Cable','PANTALLA NEGRA',1,0),
('Cable','PROBLEMAS DE EQUIPOS',1,0),
('Cable','PROBLEMAS CON ALGUNOS CANALES',1,0),
('Cable','PROBLEMAS CON CANALES NACIONALES / TP1',1,0)

go
select * from tipificacion
go

if OBJECT_ID('getTipificacion') is not null drop procedure getTipificacion
go
create procedure getTipificacion
@tipo varchar(50)
as
select ti.nombre as [Tipo servicio], ti.descripcion as [Caso de atenci�n], ti.calidad as [Calidad], ti.montoReq as [Mont Rec.]
	from tipificacion ti
	
where ti.nombre like '%'+ @tipo +'%'

go

exec getTipificacion 'cable'
go
--select * from  tb_departamento_usuario_incidencia
--select * into tb_departamento_usuario_incidencia_bkp from tb_departamento_usuario_incidencia 
--truncate table tb_departamento_usuario_incidencia
--insert into tb_departamento_usuario_incidencia (vc_departamento) values ('CAC TRUJILLO 4 - TRUJILLO'),('CAC TRUJILLO I - TRUJILLO'),('CAC TRUJILLO III - TRUJILLO'),('CLAVE TRUJILLO T-CONEXA - TRUJILLO'),('Centro de Atenci�n Empresarial - CAE Nor'),('ATC TELMEX TV CHICLAYO - CHICLAYO'),('CAC CHICLAYO I - CHICLAYO'),('CAC CHICLAYO II - CHICLAYO'),('CAC CHICLAYO III - CHICLAYO'),('CAC PIURA I - PIURA'),('CAC PIURA II - PIURA'),('CAC PIURA OPEN PLAZA - PIURA'),('CAVE PIURA - PIURA'),('Activaciones Postventa - HFC - LIMA'),('Administraci�n y Soporte a Ventas- LIMA'),('�rea atenci�n de Reclamos Corporativos'),('ATC P�GINAS CLARO - LIMA'),('Atenci�n al Cliente - Reclamos - LIMA'),('ATENCI�N PREMIUM - LIMA'),('Atenci�n Tecnol�gica Fija - LIMA'),('Atenci�n Telef�nica DTH - LIMA'),('Atenci�n Telef�nica HFC - LIMA'),('Back Office Call Center MDY - LIMA'),('Back Office Corporativo MDY - LIMA'),('BO Claro Empresa - LIMA'),('CAC ANGAMOS - LIMA'),('CAC ATOCONGO - LIMA'),('CAC BEGONIAS - LIMA'),('CAC BELLAVISTA - LIMA'),('CAC BRASIL - LIMA'),('CAC CENTRO C�VICO - LIMA'),('CAC CHINCHA - LIMA'),('CAC CHORRILLOS - LIMA'),('CAC COLABORADORES - LIMA'),('CAC GAMARRA - LIMA'),('CAC JIR�N DE LA UNI�N 1 - LIMA'),('CAC Jir�n de la Uni�n 2 - LIMA'),('CAC JOCKEY PLAZA - LIMA'),('CAC LA MOLINA - LIMA'),('CAC LARCO - LIMA'),('CAC LINCE - LIMA'),('CAC MAGDALENA - LIMA'),('CAC MALL DEL SUR- LIMA'),('CAC MEGAPLAZA - LIMA'),('CAC MINKA - LIMA'),('CAC PLAZA NORTE - LIMA'),('CAC PRIMAVERA - LIMA'),('CAC SALAVERRY - LIMA'),('CAC SAN BORJA - LIMA'),('CAC SAN JUAN LURIGANCHO - LIMA'),('CAC SAN MIGUEL - LIMA'),('CAC SANTA ANITA - LIMA'),('CAC SANTA CLARA - LIMA'),('CAC TORRE SAN ISIDRO - LIMA'),('CAC UNICACHI - LIMA'),('CAC VILLA EL SALVADOR - LIMA'),('Call Center-Boga - LIMA'),('CAV CENTRO C�VICO II - LIMA'),('CAVE MEGA PLAZA - LIMA'),('CAVE STA ANITA- LIMA'),('Centro de Atenci�n y Pagos- LIMA'),('Centro de Gesti�n ISP - LIMA'),('CNOC - LIMA'),('CNOC Backoffice - LIMA'),('Cobranzas  - LIMA'),('Comercial - LIMA'),('Conmutaci�n - LIMA'),('Cr�ditos - LIMA'),('Facturaci�n - LIMA'),('Fidelizaci�n y Mantenimiento de Clientes -'),('Operaciones CDMA/GSM - LIMA'),('Operacione DTH - LIMA'),('Recarga Inal�mbrica - LIMA'),('Recupero en Mora HFC - LIMA'),('RED BACKOFFICE CORE VOZ - LIMA'),('Retenciones Corporativo - LIMA'),('Retenciones Masivo- LIMA'),('Otros 1 - LIMA'),('Otros 2 - LIMA'),('Otros 3 - LIMA'),('Otros 4 - LIMA'),('Otros 5 - LIMA'),('Otros 6 - LIMA'),('Otros 7 - LIMA')

if OBJECT_ID('getContactsAvailable') is not null drop procedure getContactsAvailable
go
create procedure getContactsAvailable
--@idCliente varchar(15)
as
Select * from tb_usuarios_disponibles 
go
exec getContactsAvailable
go
--insert into tb_usuarios_disponibles (vc_usuario, vc_tipo_incidencia, vc_departamento) values('Luis Ponce', 'Incidencia-Cliente', 'Operacione DTH - LIMA')
select * from tb_generar_incidencia
select * from tb_incidencias_clientes_servicios
select * from tb_incidencias_lista_general
select * from tb_incidencias_reclamos
go
if OBJECT_ID('incidencias') is not null drop table incidencias
go
create table incidencias (
id int primary key identity(10000001,1) ,
idUsuario int foreign key references TB_USUARIO(in_UsuarioID),
rptATC varchar(20),
ticket int,
prioridad int,
ins datetime default getdate()
)
go
if OBJECT_ID('getCurrentIncidenceByID') is not null drop procedure getCurrentIncidenceByID
go
create procedure getCurrentIncidenceByID
@id int
as
Select * from incidencias where id = @id
go
exec getCurrentIncidenceByID 1
go

if OBJECT_ID('insIncidence') is not null drop procedure insIncidence
go
create procedure insIncidence
@idUsuario int, @rptATC varchar(20), @ticket int, @prioridad int
as
insert into incidencias (idUsuario, rptATC, ticket, prioridad) values (@idUsuario, @rptATC, @ticket, @prioridad)
go
--exec insIncidence 1
go

if OBJECT_ID('insAndGetIncidence') is not null drop procedure insAndGetIncidence
go
create procedure insAndGetIncidence
@idUsuario int = 0 --, @rptATC varchar(20), @prioridad int
as
declare @currentID int, @lastTicketID int, @ticket int = 1
select @lastTicketID = MAX(ticket) from incidencias 
if @lastTicketID is not null begin
	set @ticket = @lastTicketID + 1
end
print @idUsuario
if @idUsuario = 0 begin
	set @idUsuario = 1
end

print @idUsuario

--insert into incidencias (idUsuario, rptATC, ticket, prioridad) values (@idUsuario, @rptATC, @ticket, @prioridad)
insert into incidencias (idUsuario, ticket) values (@idUsuario,  @ticket)
set @currentID = @@IDENTITY
select i.*, u.vc_Nombres + ' ' + u.vc_Apellidos as [usuario] from incidencias i join TB_USUARIO u on u.in_UsuarioID = i.idUsuario where id = @currentID
go
--exec insIncidence 1
go

--insert into incidencias (idUsuario, ticket) values (1,  5)

--exec insAndGetIncidence 0

--truncate table incidencias  
--select * from incidencias 
--select * from tb_generar_incidencia
--update tb_generar_incidencia set vc_estadp = '1 - Generado'

if OBJECT_ID('tipoTrabajo') is not null drop table tipoTrabajo
go
create table tipoTrabajo(
id int primary key identity,
nombre varchar(100),
descripcion varchar(100) default '',
estado bit default 1,
ins datetime default getdate()
)
go
insert into tipoTrabajo (nombre) values ('WMAX-MANTENIMIENTO CLARO EMPRESAS'),('HFC - RECLAMO MASIVO'),('HFC - BAJA TOTAL DE SERVICIO'),('HFC - BAJA TOTAL CLARO TOTAL'),('HFC - MANTENIMIENTO'),('HFC - RETENCION'),('HFC - MANTENIMIENTO PREVENTIVO'),('INALAMBRICO - PREVENTIVO DTH'),('HFC - MANTENIMIENTO CLARO EMPRESAS'),('DTH - RETENCION'),('HFC - MANTENIMIENTO BABY SITTING'),('HFC - FIDELIZACION'),('HFC - GARANT�A MANTENIMIENTO'),('HFC - GARANT�A DE INSTALACI�N'),('HFC - RECLAMO CLARO EMPRESAS'),('WIMAX - RECLAMO MANTENIMIENTO CLARO EMPRESAS'),('DTH - RECLAMO'),('HFC - MATENIMIENTO CALIDAD'),('MANTENIMIENTO PEXT FO'),('WLL/SIAC - RECLAMOS'),('CORP-MANTO CORRECTIVO PINT'),('HFC ATENCION PREVENTIVA'),('CORP-MANTO PREV PEXT'),('CORP-MANTO PREV PINT'),('MANTENIMIENTO PEXT FO'),('INAL�MBRICO - EQUIPOS DA�ADOS'),('HFC - EQUIPOS DA�ADOS'),('WLL/SIAC - EQUIPOS DA�ADOS'),('CORP MANTO CORRECTIVO PEXT'),('INAL�MBRICO - MANTENIMIENTO DTH'),('INAL�MBRICO - DESINSTALACI�N DECO ADICIONALDTI')


go 
select * from tipoTrabajo 
go

if OBJECT_ID('getWorkType') is not null drop procedure getWorkType
go
create procedure getWorkType
as
select 0 as [id],'' as [nombre] union
select id, nombre from tipoTrabajo
go
exec getWorkType
go


if OBJECT_ID('motivo') is not null drop table motivo
go
create table motivo(
id int primary key identity,
nombre varchar(100),
descripcion varchar(100) default '',
estado bit default 1,
ins datetime default getdate()
)
go
insert into motivo(nombre) values 
('TEL - SERIE TELEFONICA NO APERTURADA'),
('TEL - SERIE TELEFONICA NO REGISTRADA'),
('TEL - SIN SERVICIO -DA TONO DE OCUPADO'),
('TEL - SIN SERVICIO -NO DA TONO'),
('TEL - SOLICITUD DE CARRIER RELATIONS'),
('INT - CAMBIO DE CABLE WEP KEY'),
('INT - ENLACE INTERMITENTE'),
('INT - ENLACE LENTE'),
('INT - NO LLEGA A DETERMINADAS PAGINAS WEB'),
('INT - PROBLEMA DE INTERCONEXI�N'),
('INT - PROBLEMA WIFI'),
('INT - PROBLEMAS CON LA SALIDA A INTERNET'),
('INT - PROBLEMAS DE COBERTURA WIFI'),
('INT - PROBLEMAS DE CORREO'),
('INT - ROUTER CON PROBLEMAS'),
('INT - SIN SERVICIO'),
('CATV - DECOS DESHABILITADOS'),
('CATV - IMAGEN CONGELADA'),
('CATV - IMAGEN LLUVIOSA O PIXELEADA'),
('CATV - IMAGEN SOBREPUESTA'),
('CATV - MALA SE�AL'),
('CATV - NO VISUALIZA ALGUNOS CANALES'),
('CATV - PANTALLA NEGRA'),
('CATV - PROBLEMAS CON CANALES NACIONALES'),
('CATV - PROBLEMAS CON DECODIFICADOR'),
('CATV - SIN SERVICIO'),
('DTH - SIN SE�AL'),
('')
go

if OBJECT_ID('getMotivo') is not null drop procedure getMotivo
go
create procedure getMotivo
as
select 0 as [id],'' as [nombre] union
select id, nombre from motivo
go
exec getMotivo
go

/*
--sp_helptext Usp_select_servicios_contratados_transacciones_por_n_doc
alter procedure [dbo].[Usp_select_servicios_contratados_transacciones_por_n_doc]
@n_doc varchar(100),
@cid varchar(100)
as
begin
select vc_codtrs as 'Codtrs',vc_sid as 'SID',vc_solicitud as 'Solicitud',vc_tipo as 'Tipo',vc_estado as 'Estado',vc_estado_facturacion as 'Estado Facturacion',vc_proyecto as 'Proyecto',vc_ftransaccion as 'F.Transaccion',vc_descripcion as 'Descripcion',
vc_faprobacion as 'F.Aprobacion',vc_aprobadopor as 'Aprobado por',vc_estSID AS 'Est SID',vc_numpto as 'Numpto',
vc_idadd as 'idadd',vc_tipo_det as 'Tipo Det' from  tb_servicios_contratados_transacciones
where vc_n_doc=@n_doc and vc_cid=@cid
END

select * from tb_servicios_contratados_transacciones where vc_n_doc = '20988151' and estado = 'Activo'
delete tb_servicios_contratados_transacciones where vc_n_doc = '20988151' and estado = 'Activo'

--alter table tb_servicios_contratados_transacciones add estado varchar(15) default 'Activo'
--alter table tb_servicios_contratados_transacciones add ins datetime default getdate()
insert into tb_servicios_contratados_transacciones (vc_codtrs, vc_sid, vc_solicitud, vc_tipo, vc_estado,vc_estado_facturacion,vc_proyecto, vc_ftransaccion, vc_descripcion
,vc_faprobacion, vc_aprobadopor, vc_estSID, vc_numpto
,vc_idadd, vc_tipo_det,vc_n_doc) values 
('17231292','1852876','2387196','Activacion', 'Ejecutado', 'Transferido a Billing y Adm. Contratos','0000864657','28/12/2010','COMODATO (S/.)','28/12/2010','E801807','','0001'         ,'','','20988151'),
('17231293','1852876','2387196','Activacion', 'Ejecutado', 'Transferido a Billing y Adm. Contratos','0000864657','28/12/2010','COMODATO (S/.)','28/12/2010','E801807','','0002'         ,'','','20988151'),
('17231294','1852876','2387196','Activacion', 'Ejecutado', 'Transferido a Billing y Adm. Contratos','0000864657','28/12/2010','COMODATO (S/.)','28/12/2010','E801807','','0003'         ,'','','20988151'),
('17231295','1852876','2387196','Activacion', 'Ejecutado', 'Transferido a Billing y Adm. Contratos','0000864657','28/12/2010','COMODATO (S/.)','28/12/2010','E801807','','0004'         ,'','','20988151'),
('17231296','1852876','2387196','Activacion', 'Ejecutado', 'Transferido a Billing y Adm. Contratos','0000864657','28/12/2010','COMODATO (S/.)','28/12/2010','E801807','','0005'         ,'','','20988151'),
('17231297','1852876','2387196','Activacion', 'Ejecutado', 'Transferido a Billing y Adm. Contratos','0000864657','28/12/2010','COMODATO (S/.)','28/12/2010','E801807','','0006'         ,'','','20988151'),
('17231298','1852876','2387196','Activacion', 'Ejecutado', 'Transferido a Billing y Adm. Contratos','0000864657','28/12/2010','COMODATO (S/.)','28/12/2010','E801807','','0007'         ,'','','20988151'),
('17231299','1852876','2387196','Activacion', 'Ejecutado', 'Transferido a Billing y Adm. Contratos','0000864657','28/12/2010','COMODATO (S/.)','28/12/2010','E801807','','0008'         ,'','','20988151'),
('17231300','1852876','2387196','Activacion', 'Ejecutado', 'Transferido a Billing y Adm. Contratos','0000864657','28/12/2010','COMODATO (S/.)','28/12/2010','E801807','','0009'         ,'','','20988151'),
('17231301','1852876','2387196','Activacion', 'Ejecutado', 'Transferido a Billing y Adm. Contratos','0000864657','28/12/2010','COMODATO (S/.)','28/12/2010','E801807','','0010'         ,'','','20988151'),
('17231302','1852876','2387196','Activacion', 'Ejecutado', 'Transferido a Billing y Adm. Contratos','0000864657','28/12/2010','COMODATO (S/.)','28/12/2010','E801807','','0011'         ,'','','20988151'),
('17231303','1852876','2387196','Activacion', 'Ejecutado', 'Transferido a Billing y Adm. Contratos','0000864657','28/12/2010','COMODATO (S/.)','28/12/2010','E801807','','0012'         ,'','','20988151'),
('17231304','1852876','2387196','Activacion', 'Ejecutado', 'Transferido a Billing y Adm. Contratos','0000864657','28/12/2010','COMODATO (S/.)','28/12/2010','E801807','','0013'         ,'','','20988151'),

('23710547','1852876','3550484','Suspension', 'Ejecutado', 'Transferido a Billing','','19/04/2011','Claro TV - Sat Plan B�sico VN','19/04/2011','ADMINJOB','',''         ,'','','20988151'),
('23710549','1852876','3550484','Suspension', 'Ejecutado', 'Transferido a Billing','','19/04/2011','Claro TV - Sat Plan B�sico VN','19/04/2011','ADMINJOB','',''         ,'','','20988151'),
('23710543','1852876','3550484','Suspension', 'Ejecutado', 'Transferido a Billing','','19/04/2011','Claro TV - Sat Plan B�sico VN','19/04/2011','ADMINJOB','',''         ,'','','20988151'),
('23710545','1852876','3550484','Suspension', 'Ejecutado', 'Transferido a Billing','','19/04/2011','Claro TV - Sat Plan B�sico VN','19/04/2011','ADMINJOB','',''         ,'','','20988151'),

*/
