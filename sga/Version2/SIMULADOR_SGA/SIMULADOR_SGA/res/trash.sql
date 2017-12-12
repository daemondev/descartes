if OBJECT_ID('getDF') is not null drop procedure getDF
go

create procedure getDF
as
declare @nFormatEnd int = 115
declare @nFormatBegin int = 100
declare @myDate varchar(50) = ''
declare @myFormat varchar(50) = ''
while @nFormatBegin < @nFormatEnd begin
	set @myFormat = 'CONVERT(varchar(50), GETDATE(), ' + CONVERT(varchar(3),@nFormatBegin) +'): ['
	set @myDate = CONVERT(varchar(50), GETDATE(), @nFormatBegin ) + '] - ['+ CONVERT(varchar(50), GETDATE()-1, @nFormatBegin )
	print(@myFormat + @mydate + ']')
	set @nFormatBegin = @nFormatBegin + 1
end
