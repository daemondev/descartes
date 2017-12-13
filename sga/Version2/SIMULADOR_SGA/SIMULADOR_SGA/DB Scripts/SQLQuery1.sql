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
--update TB_datos_cliente  set vc_ejecutivo_datos = 'Sin Definir' where vc_documento = 44880188
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
('Cable','PROBLEMAS CON CANALES NACIONALES / TP1',1,0)

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
go
--select * from  tb_departamento_usuario_incidencia
--select * into tb_departamento_usuario_incidencia_bkp from tb_departamento_usuario_incidencia 
--truncate table tb_departamento_usuario_incidencia
--insert into tb_departamento_usuario_incidencia (vc_departamento) values ('CAC TRUJILLO 4 - TRUJILLO'),('CAC TRUJILLO I - TRUJILLO'),('CAC TRUJILLO III - TRUJILLO'),('CLAVE TRUJILLO T-CONEXA - TRUJILLO'),('Centro de Atención Empresarial - CAE Nor'),('ATC TELMEX TV CHICLAYO - CHICLAYO'),('CAC CHICLAYO I - CHICLAYO'),('CAC CHICLAYO II - CHICLAYO'),('CAC CHICLAYO III - CHICLAYO'),('CAC PIURA I - PIURA'),('CAC PIURA II - PIURA'),('CAC PIURA OPEN PLAZA - PIURA'),('CAVE PIURA - PIURA'),('Activaciones Postventa - HFC - LIMA'),('Administración y Soporte a Ventas- LIMA'),('Área atención de Reclamos Corporativos'),('ATC PÁGINAS CLARO - LIMA'),('Atención al Cliente - Reclamos - LIMA'),('ATENCIÓN PREMIUM - LIMA'),('Atención Tecnológica Fija - LIMA'),('Atención Telefónica DTH - LIMA'),('Atención Telefónica HFC - LIMA'),('Back Office Call Center MDY - LIMA'),('Back Office Corporativo MDY - LIMA'),('BO Claro Empresa - LIMA'),('CAC ANGAMOS - LIMA'),('CAC ATOCONGO - LIMA'),('CAC BEGONIAS - LIMA'),('CAC BELLAVISTA - LIMA'),('CAC BRASIL - LIMA'),('CAC CENTRO CÍVICO - LIMA'),('CAC CHINCHA - LIMA'),('CAC CHORRILLOS - LIMA'),('CAC COLABORADORES - LIMA'),('CAC GAMARRA - LIMA'),('CAC JIRÓN DE LA UNIÓN 1 - LIMA'),('CAC Jirón de la Unión 2 - LIMA'),('CAC JOCKEY PLAZA - LIMA'),('CAC LA MOLINA - LIMA'),('CAC LARCO - LIMA'),('CAC LINCE - LIMA'),('CAC MAGDALENA - LIMA'),('CAC MALL DEL SUR- LIMA'),('CAC MEGAPLAZA - LIMA'),('CAC MINKA - LIMA'),('CAC PLAZA NORTE - LIMA'),('CAC PRIMAVERA - LIMA'),('CAC SALAVERRY - LIMA'),('CAC SAN BORJA - LIMA'),('CAC SAN JUAN LURIGANCHO - LIMA'),('CAC SAN MIGUEL - LIMA'),('CAC SANTA ANITA - LIMA'),('CAC SANTA CLARA - LIMA'),('CAC TORRE SAN ISIDRO - LIMA'),('CAC UNICACHI - LIMA'),('CAC VILLA EL SALVADOR - LIMA'),('Call Center-Boga - LIMA'),('CAV CENTRO CÍVICO II - LIMA'),('CAVE MEGA PLAZA - LIMA'),('CAVE STA ANITA- LIMA'),('Centro de Atención y Pagos- LIMA'),('Centro de Gestión ISP - LIMA'),('CNOC - LIMA'),('CNOC Backoffice - LIMA'),('Cobranzas  - LIMA'),('Comercial - LIMA'),('Conmutación - LIMA'),('Créditos - LIMA'),('Facturación - LIMA'),('Fidelización y Mantenimiento de Clientes -'),('Operaciones CDMA/GSM - LIMA'),('Operacione DTH - LIMA'),('Recarga Inalámbrica - LIMA'),('Recupero en Mora HFC - LIMA'),('RED BACKOFFICE CORE VOZ - LIMA'),('Retenciones Corporativo - LIMA'),('Retenciones Masivo- LIMA'),('Otros 1 - LIMA'),('Otros 2 - LIMA'),('Otros 3 - LIMA'),('Otros 4 - LIMA'),('Otros 5 - LIMA'),('Otros 6 - LIMA'),('Otros 7 - LIMA')

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
insert into tipoTrabajo (nombre) values ('WMAX-MANTENIMIENTO CLARO EMPRESAS'),('HFC - RECLAMO MASIVO'),('HFC - BAJA TOTAL DE SERVICIO'),('HFC - BAJA TOTAL CLARO TOTAL'),('HFC - MANTENIMIENTO'),('HFC - RETENCION'),('HFC - MANTENIMIENTO PREVENTIVO'),('INALAMBRICO - PREVENTIVO DTH'),('HFC - MANTENIMIENTO CLARO EMPRESAS'),('DTH - RETENCION'),('HFC - MANTENIMIENTO BABY SITTING'),('HFC - FIDELIZACION'),('HFC - GARANTÍA MANTENIMIENTO'),('HFC - GARANTÍA DE INSTALACIÓN'),('HFC - RECLAMO CLARO EMPRESAS'),('WIMAX - RECLAMO MANTENIMIENTO CLARO EMPRESAS'),('DTH - RECLAMO'),('HFC - MATENIMIENTO CALIDAD'),('MANTENIMIENTO PEXT FO'),('WLL/SIAC - RECLAMOS'),('CORP-MANTO CORRECTIVO PINT'),('HFC ATENCION PREVENTIVA'),('CORP-MANTO PREV PEXT'),('CORP-MANTO PREV PINT'),('MANTENIMIENTO PEXT FO'),('INALÁMBRICO - EQUIPOS DAÑADOS'),('HFC - EQUIPOS DAÑADOS'),('WLL/SIAC - EQUIPOS DAÑADOS'),('CORP MANTO CORRECTIVO PEXT'),('INALÁMBRICO - MANTENIMIENTO DTH'),('INALÁMBRICO - DESINSTALACIÓN DECO ADICIONALDTI')


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
('INT - PROBLEMA DE INTERCONEXIÓN'),
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
('CATV - MALA SEÑAL'),
('CATV - NO VISUALIZA ALGUNOS CANALES'),
('CATV - PANTALLA NEGRA'),
('CATV - PROBLEMAS CON CANALES NACIONALES'),
('CATV - PROBLEMAS CON DECODIFICADOR'),
('CATV - SIN SERVICIO'),
('DTH - SIN SEÑAL'),
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
