use SVenta

alter table Consumidor add EstadoCon bit default 1

--Agregar/Insercion Consumidor

create procedure CConsumidor
@IDC int,
@PNC nvarchar(15),
@SNC nvarchar(15),
@PAC nvarchar(15),
@SAC nvarchar(15),
@DIR nvarchar(70),
@PAI nvarchar(20),
@SALI float,
@SALFI float 
as
declare @idd as int
set @idd=(select Id_Cliente from Consumidor where Id_Cliente=@IDC)
if(@PNC='' or @SNC='' or @PAC='' or @SAC='' or @DIR='' or @PAI='')
begin
  print 'No puede ser null'
end
else
 begin
  if(@IDC=@idd)
  begin
    insert into Consumidor values(@PNC,@SNC,@PAC,@SAC,@DIR,@PAI,@SALI,@SALFI,1,@IDC)
  end
  else
  begin
    print 'Consumidor no registrado'
  end
end


CConsumidor 1,'Carlos','Eduardo','Rodriguez','Torres','Km8 Carretera Norte','Nicaragua',20.00,34.32

select * from Consumidor

--Dar Baja 

create procedure BConsum
@ID int
as
declare @iddept as int
set @iddept=(select Id_Cliente from Consumidor where Id_Cliente=@ID)
if(@iddept=@ID)
begin
  update Consumidor set EstadoCon=0 where Id_Cliente=@ID
end
else
begin
  print 'Consumidor no encontrado'
end

select * from Consumidor


--Modificar Consumidor

create procedure UpdateMun
@ID int,
@PNC nvarchar(15),
@SNC nvarchar(15),
@PAC nvarchar(15),
@SAC nvarchar(15),
@DIR nvarchar(70),
@PAI nvarchar(20),
@SALI float,
@SALFI float 
as
declare @idd as int
set @idd=(select Id_Cliente from Consumidor where Id_Cliente=@ID)
if(@idd=@ID)
begin
  if(@PNC='' or @SNC='' or @PAC='' or @SAC='' or @DIR='' or @PAI='')
  begin
    print 'No puede ser Null'
  end
  else
  begin
    update Consumidor set PNC=@PNC,SNC=@SNC,PAC=@PAC,SAC=@SAC,Direccion=@DIR,Pais=@PAI,SaldoInic=@SALI,
	SaldoAct=@SALFI where Id_Cliente=@ID and EstadoCon=1
  end
end
else
begin
  print 'Municipio no encontrado'
end


--Busqueda Consumidor

create procedure FindConsumById
@ID int
as
declare @idd as int
set @idd=(select Id_Cliente from Consumidor where Id_Cliente=@ID)
if(@ID=@idd)
begin
  select * from Consumidor where Id_Cliente=@ID
end
else
begin
  print 'Consumidor no encontrado'
end

--listar Consumidores

create procedure ListarConsum
as
select * from Consumidor where EstadoCon=1

ListarConsum

--Calculo Predicado
--Ventas x Vendedor

select Ventas.Id_Venta,FechaV, Ventas.Id_Cliente, TotalV , Distribuidor.Id_Vendedor,
PNV,PAV,Oficina,Id_Jefe from Ventas full join Distribuidor 
on Ventas.Id_Venta=Distribuidor.Id_Vendedor

Create view VentasXVendedor as
select Ventas.Id_Venta,FechaV, Ventas.Id_Cliente, TotalV , Distribuidor.Id_Vendedor,
PNV,PAV,Oficina,Id_Jefe from Ventas full join Distribuidor 
on Ventas.Id_Venta=Distribuidor.Id_Vendedor



--Calculo Predicado
--Clientes x Pais


select Id_Cliente,PNC,SNC, PNC,SAC,Pais,Direccion from 
Consumidor 

Create view ClientesxPais as
select Id_Cliente,PNC,PAC,SAC,Pais,Direccion from 
Consumidor 

alter table Articulos add fecha_creacion date not null



--Procedimiento
--Fecha de Vencimiento de Productos

SELECT  fecha_creacion + 2 from Articulos




