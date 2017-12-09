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

ins datetime default getdate()
)
go

insert into tvSatelital(idCliente,idContratista, idTipoContrato, nroRegistro, estRegistro,idUsuario, nroProyecto, solicitud) values
(1,1,1,'0005779215', 'ACTIVO', 1,'0000864657', 2387196)
go
select * from tvSatelital
go


if OBJECT_ID('getTVSatelitalDataByDOCCliente') is not null drop procedure getTVSatelitalDataByDOCCliente
go
create procedure getTVSatelitalDataByDOCCliente --1
@idCliente int
as
SELECT * 
	FROM tvSatelital tv 
	join TB_datos_cliente cl on cl.id = tv.idCliente 
	join contratista co on co.id = tv.idContratista 
	join TB_USUARIO u on u.in_UsuarioID = tv.idUsuario  
	join tipoContrato tc on tc.id = tv.idTipoContrato
where idCliente=@idCliente
go
exec getTVSatelitalDataByDOCCliente 1
