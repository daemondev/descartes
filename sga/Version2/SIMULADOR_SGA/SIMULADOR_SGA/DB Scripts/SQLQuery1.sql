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
		(1,1,1,'0005779215', 'ACTIVO', 1,'0000864657', 2387196
		,'01002990' ,'DAVID PARAGUAY MERCADO','964741357','', 'CLARO TV SAT PLAN BÁSICO VN', '0000866109', 'CENTRO POBLADO VILLA FLAVIA MZ. 51 LT. 10 EN EL CERCADO','0000866109', 'CENTRO POBLADO VILLA FLAVIA MZ. 51 LT. 10 EN EL CERCADO',''
		,'DT452454','BOLETA','014', '003134', 'CANALES - AGENTES', 'Cliente Nuevo', '', 'S/. 75.00 Pago de Instalación al Contado'
		,90988151,1,'20170827','20170926','20170927',136761)
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
--select * from TB_datos_cliente 
select * from [TB_servicios_contratados]
go

--alter table [TB_servicios_contratados] add bouquets varchar(50), fecInicio date, fecFin date, fecActivacion date

if OBJECT_ID('getTVSServices') is not null drop procedure getTVSServices
go
create procedure getTVSServices
@idCliente varchar(15)
as
select sc.vc_codigo as [SID], sc.vc_tipo_servicio as [Tipo Servicio], sc.vc_producto as [Producto], sc.vc_numero_servicio as [Número Servicio], sc.vc_estado as [Estado], sc.bouquets as [Bouquets], sc.fecInicio as [Fecha inicio], sc.fecFin as [Fecha fin], sc.fecActivacion as [Fecha Activación], sc.vc_motivo as [Motivo], sc.vc_direccion as [Dirección]
	from [TB_servicios_contratados] sc  --where sc.n_doc = '44880188'
	--join tb_solicitudes_ot so on sc.vc_numero_servicio = so.vc_n_servicio
where sc.n_doc = @idCliente
--where sc.vc_numero_servicio = @idCliente
go

exec getTVSServices 44880188
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
('','AZ-60RS-STM, Antena parabólica de 60cm, AC',2387196,1,1,'CLIENTE-CPE',7112, '', 1,0, '','',1.00 ),
('','CONECTOR DE COMPRESIÓN SLCU-6',2387196,2,1,'CLIENTE INSTALACIÓN DE EQUIPOS-MANUAL 1',6414, '', 1,0, '','',2.00 ),
('','CONECTOR DE COMPRESIÓN SLCU-6',2387196,3,1,'CLIENTE INSTALACIÓN DE EQUIPOS-MANUAL 1',6414, '', 1,0, '','',2.00 ),
('','CABLE COAXIAL NEGRO RG-6 S/MENSAJERO',2387196,4,1,'CLIENTE-INSTALACIÓN DE ACOMETIDA',8046, '', 1,0, '','',2.00 )
go
select * from equipo
go

if OBJECT_ID('getTVSEquipo') is not null drop procedure getTVSEquipo
go
create procedure getTVSEquipo
@idCliente varchar(15)
as
select eq.SOT, eq.orden as [Orden], cl.vc_razon_social as [Punto], eq.etapa as [Etapa], eq.equipo as [Equipo], eq.codSap as [Cod Sap], eq.descripcion as [Equipo Descripción], eq.solic as [Solic], eq.req as [Req], eq.nSerie as [N.Serie], eq.unitAddress as [Unitaddress], eq.cantidad as [Cantidad]	
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
('Cable','ACTIVACIÓN DE SERVICIO SUPLEMENTARIO',0,0),
('Cable','ACTIVACIÓN DE VALOR AGREGADO',0,0),
('Cable','ATENCIÓN TÉCNICA PRIORIZADA',1,0),
('Cable','AVERÍA / SIN DESCARTES',1,0),
('Cable','AVERÍA / SIN TELÉFONO',1,0),
('Cable','CALIDAD CABLE',1,0),
('Cable','CANALES CODIFICADOS PROBLEMAS CON TARJE',1,0),
('Cable','CONTINGENCIA ADMINISTRATIVA',0,0),
('Cable','CONTINGENCIA TÉCNICA',0,0),
('Cable','DAÑOS EN PROCESO DE INSTALACIÓN / MANTENIMIENTO',0,1),
('Cable','DECOS DESHABILITADOS',1,0),
('Cable','DESBLOQUEO DE CONTROL PARENTAL',1,0),
('Cable','IMAGEN CONGELADA',1,0),
('Cable','IMAGEN LLUVIOSA O PIXELEADA',1,0),
('Cable','IMAGEN SOBREPUESTA',1,0),
('Cable','MALA SEÑAL',1,0),
('Cable','MENSAJE SIN CANAL',1,0),
('Cable','MENSAJE SIN SEÑAL',1,0),
('Cable','MODIFICACIÓN DHCP',0,0),
('Cable','NO VISUALIZA ALGUNOS CANALES',1,0),
('Cable','NO VISUALIZA LOS CANALES DE PROMOCIÓN',1,0),
('Cable','OTROS CALIDAD',1,0),
('Cable','PANTALLA NEGRA',1,0),
('Cable','PROBLEMAS DE EQUIPOS',1,0),
('Cable','PROBLEMAS CON ALGUNOS CANALES',1,0),
('Cable','PROBLEMAS CON CANALES NACIONALES / TP1',1,0),
('Cable','',0,0),
('Cable','',0,0),
('Cable','',0,0),
('Cable','',0,0)

go
select * from tipificacion
go

if OBJECT_ID('getTipificacion') is not null drop procedure getTipificacion
go
create procedure getTipificacion
@tipo varchar(50)
as
select ti.nombre as [Tipo servicio], ti.descripcion as [Caso de atención], ti.calidad as [Calidad], ti.montoReq as [Mont Rec.]
	from tipificacion ti
	
where ti.nombre like '%'+ @tipo +'%'

go

exec getTipificacion 'cable'
