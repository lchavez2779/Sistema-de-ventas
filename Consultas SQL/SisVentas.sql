USE [master]
GO
/****** Object:  Database [SisVentas]    Script Date: 05/07/2015 18:18:41 ******/
CREATE DATABASE [SisVentas]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SisVentas', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\SisVentas.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SisVentas_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\SisVentas_log.ldf' , SIZE = 4672KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SisVentas] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SisVentas].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SisVentas] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SisVentas] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SisVentas] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SisVentas] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SisVentas] SET ARITHABORT OFF 
GO
ALTER DATABASE [SisVentas] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SisVentas] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [SisVentas] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SisVentas] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SisVentas] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SisVentas] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SisVentas] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SisVentas] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SisVentas] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SisVentas] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SisVentas] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SisVentas] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SisVentas] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SisVentas] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SisVentas] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SisVentas] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SisVentas] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SisVentas] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SisVentas] SET RECOVERY FULL 
GO
ALTER DATABASE [SisVentas] SET  MULTI_USER 
GO
ALTER DATABASE [SisVentas] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SisVentas] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SisVentas] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SisVentas] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SisVentas', N'ON'
GO
USE [SisVentas]
GO
/****** Object:  StoredProcedure [dbo].[Aumentar_Stock]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Aumentar_Stock]
@ID_Producto int,
@Cantidad decimal(18,2)
as                /**Incrementa el stock al actual**/
update Producto set Stock=Stock+@Cantidad where ID_Producto=@ID_Producto

GO
/****** Object:  StoredProcedure [dbo].[Backup_base]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Backup_base]
as
Backup database [SisVentas]
To disk = N'C:\SisVentas\Backup\SisVentas.bak'
With description=N'Respaldo del Sistema de ventas',
NoFormat,
Init,
Name=N'SisVentas',
Skip,
Norewind,
Nounload,
Stats=10,
Checksum
GO
/****** Object:  StoredProcedure [dbo].[Disminuir_Stock]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Disminuir_Stock]
@ID_Producto int,
@Cantidad decimal(18,2)
as
update Producto set Stock=Stock-@Cantidad where ID_Producto=@ID_Producto

GO
/****** Object:  StoredProcedure [dbo].[Editar_Categoria]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Editar_Categoria]
@ID_Categoria integer,
@Nombre_Categoria varchar(50)
as
update Categoria set Nombre_Categoria=@Nombre_Categoria where ID_Categoria=@ID_Categoria

GO
/****** Object:  StoredProcedure [dbo].[Editar_Cliente]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Editar_Cliente]
@ID_Cliente integer,
@Nombre varchar(50),
@Apellido varchar(50),
@Direccion varchar(100),
@Telefono varchar(10),
@Dni varchar(8)
as
Update Cliente set Nombre=@Nombre,Apellido=@Apellido,Direccion=@Direccion,Telefono=@Telefono,Dni=@Dni where ID_Cliente=@ID_Cliente

GO
/****** Object:  StoredProcedure [dbo].[Editar_Detalle_Venta]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc  [dbo].[Editar_Detalle_Venta]
@ID_Detalle int,
@ID_Venta int,
@ID_Producto int,
@Cantidad decimal(18,2),
@Precio_unitario decimal(18,2)
as
update Detalle_venta set ID_Venta=@ID_Venta,ID_Producto=@ID_Producto,Cantidad=@Cantidad,
Precio_unitario=@Precio_unitario where ID_Detalle=@ID_Detalle

GO
/****** Object:  StoredProcedure [dbo].[Editar_Producto]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Editar_Producto]
@ID_Producto int,
@ID_Categoria int,
@Nombre varchar(50),
@Descripcion varchar(255),
@Stock decimal(18,2),
@Precio_compra decimal(18,2),
@Precio_venta decimal(18,2),
@Fecha_vencimiento date,
@Imagen image
as 
update Producto set ID_Categoria=@ID_Categoria,Nombre=@Nombre,Descripcion=@Descripcion,
Stock=@Stock,Precio_compra=@Precio_compra,Precio_venta=@Precio_venta,
Fecha_vencimiento=@Fecha_vencimiento,Imagen=@Imagen 
where ID_Producto=@ID_Producto

GO
/****** Object:  StoredProcedure [dbo].[Editar_Venta]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Editar_Venta]
@ID_Venta int,
@ID_Cliente int,
@Fecha_venta date,
@Tipo_Documento varchar(50),
@Nro_Documento varchar(50)
as 
update Ventas set ID_Cliente=@ID_Cliente,Fecha_Venta=@Fecha_venta,Tipo_Documento=@Tipo_Documento,
Nro_Documento=@Nro_Documento where ID_Venta=@ID_Venta

GO
/****** Object:  StoredProcedure [dbo].[Eliminar_Categoria]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Eliminar_Categoria]
@ID_Categoria integer
as
Delete from Categoria where ID_Categoria=@ID_Categoria

GO
/****** Object:  StoredProcedure [dbo].[Eliminar_Cliente]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Eliminar_Cliente]
@ID_Cliente integer
as
Delete from Cliente where ID_Cliente=@ID_Cliente

GO
/****** Object:  StoredProcedure [dbo].[Eliminar_Detalle_Venta]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Eliminar_Detalle_Venta]
@ID_Detalle int
as
Delete from Detalle_venta where ID_Detalle=@ID_Detalle

GO
/****** Object:  StoredProcedure [dbo].[Eliminar_Producto]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Eliminar_Producto]
@ID_Producto int
as
delete from Producto where ID_Producto=@ID_Producto

GO
/****** Object:  StoredProcedure [dbo].[Eliminar_Venta]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Eliminar_Venta]
@ID_Venta int
as
delete from Ventas where ID_Venta=@ID_Venta

GO
/****** Object:  StoredProcedure [dbo].[Generar_Comprobante]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Generar_Comprobante]
@ID_Venta int
as
SELECT     dbo.Ventas.ID_Venta, dbo.Cliente.Nombre, dbo.Cliente.Apellido, dbo.Cliente.Dni, dbo.Ventas.Fecha_Venta, dbo.Ventas.Tipo_Documento, dbo.Ventas.Nro_Documento, 
                      dbo.Producto.Nombre AS Descripcion, dbo.Detalle_venta.Cantidad, dbo.Detalle_venta.Precio_unitario, 
                      dbo.Detalle_venta.Cantidad * dbo.Detalle_venta.Precio_unitario AS Total_parcial
FROM         dbo.Ventas INNER JOIN
                      dbo.Detalle_venta ON dbo.Ventas.ID_Venta = dbo.Detalle_venta.ID_Venta INNER JOIN
                      dbo.Producto ON dbo.Detalle_venta.ID_Producto = dbo.Producto.ID_Producto INNER JOIN
                      dbo.Cliente ON dbo.Ventas.ID_Cliente = dbo.Cliente.ID_Cliente
                      WHERE Ventas.ID_Venta=@ID_Venta 

GO
/****** Object:  StoredProcedure [dbo].[Insertar_Categoria]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Insertar_Categoria]
@Nombre_Categoria varchar(50)
as 
insert into Categoria(Nombre_Categoria) values(@Nombre_Categoria)

GO
/****** Object:  StoredProcedure [dbo].[Insertar_Cliente]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Insertar_Cliente]
@Nombre varchar(50),
@Apellido varchar(50),
@Direccion varchar(50),
@Telefono varchar(10),
@Dni varchar(8)
as
insert into Cliente (Nombre,Apellido,Direccion,Telefono,Dni) values (@Nombre,@Apellido,@Direccion,@Telefono,@Dni)

GO
/****** Object:  StoredProcedure [dbo].[Insertar_Detalle_Venta]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Insertar_Detalle_Venta]
@ID_Venta int,
@ID_Producto int,
@Cantidad decimal(18,2),
@Precio_unitario decimal(18,2)
as
insert into Detalle_venta(ID_Venta,ID_Producto,Cantidad,Precio_unitario)
values(@ID_Venta,@ID_Producto,@Cantidad,@Precio_unitario)

GO
/****** Object:  StoredProcedure [dbo].[Insertar_Producto]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Insertar_Producto]
@ID_Categoria int,
@Nombre varchar(50),
@Descripcion varchar(255),
@Stock decimal(18,2),
@Precio_Compra decimal(18,2),
@Precio_Venta decimal(18,2),
@Fecha_vencimiento date,
@Imagen image
as
insert into Producto(ID_Categoria,Nombre,Descripcion,Stock,Precio_compra,Precio_venta,
Fecha_vencimiento,Imagen) values(@ID_Categoria,@Nombre,@Descripcion,@Stock,@Precio_Compra,
@Precio_Venta,@Fecha_vencimiento,@Imagen)

GO
/****** Object:  StoredProcedure [dbo].[Insertar_Venta]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Insertar_Venta]
@ID_Cliente int,
@Fecha_venta date,
@Tipo_Documento varchar(50),
@Nro_Documento varchar(50)
As
insert into Ventas(ID_Cliente,Fecha_Venta,Tipo_Documento,Nro_Documento)
values (@ID_Cliente,@Fecha_venta,@Tipo_Documento,@Nro_Documento)

GO
/****** Object:  StoredProcedure [dbo].[Mostrar_Categoria]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Mostrar_Categoria]
as
Select *from Categoria order by ID_Categoria desc 

GO
/****** Object:  StoredProcedure [dbo].[Mostrar_Cliente]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Mostrar_Cliente]
as
Select *from Cliente order by ID_Cliente desc

GO
/****** Object:  StoredProcedure [dbo].[Mostrar_Detalle_Venta]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Mostrar_Detalle_Venta]
as
SELECT     dbo.Detalle_venta.ID_Detalle, dbo.Detalle_venta.ID_Venta, dbo.Detalle_venta.ID_Producto, dbo.Producto.Nombre, dbo.Detalle_venta.Cantidad, 
                      dbo.Detalle_venta.Precio_unitario
FROM         dbo.Detalle_venta INNER JOIN
                      dbo.Producto ON dbo.Detalle_venta.ID_Producto = dbo.Producto.ID_Producto
                       order by ID_Detalle desc
GO
/****** Object:  StoredProcedure [dbo].[Mostrar_producto]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Mostrar_producto]
as
select Producto.ID_Producto,Producto.ID_Categoria,Categoria.Nombre_Categoria,
Producto.Nombre,Producto.Descripcion,Producto.Stock,Producto.Precio_compra,Producto.Precio_venta,
Producto.Fecha_vencimiento,Producto.Imagen
from Producto inner join Categoria on Producto.ID_Categoria=Categoria.ID_Categoria
order by Producto.ID_Categoria desc
GO
/****** Object:  StoredProcedure [dbo].[Mostrar_Ventas]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Mostrar_Ventas]
as
SELECT     dbo.Ventas.ID_Venta, dbo.Ventas.ID_Cliente, dbo.Cliente.Apellido, dbo.Cliente.Dni, dbo.Ventas.Fecha_Venta, dbo.Ventas.Tipo_Documento, 
                      dbo.Ventas.Nro_Documento
FROM         dbo.Ventas INNER JOIN
                      dbo.Cliente ON dbo.Ventas.ID_Cliente = dbo.Cliente.ID_Cliente
order by ID_Venta desc
GO
/****** Object:  StoredProcedure [dbo].[Validar_usuarios]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Validar_usuarios]
@Login varchar(50),
@Password varchar(50)
as 
select *from Usuarios
where Login=@Login and Password=@Password and Acesso='1'

GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 05/07/2015 18:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categoria](
	[ID_Categoria] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_Categoria] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[ID_Categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 05/07/2015 18:18:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente](
	[ID_Cliente] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NOT NULL,
	[Direccion] [varchar](100) NOT NULL,
	[Telefono] [varchar](10) NOT NULL,
	[Dni] [varchar](8) NOT NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[ID_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Detalle_venta]    Script Date: 05/07/2015 18:18:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle_venta](
	[ID_Detalle] [int] IDENTITY(1,1) NOT NULL,
	[ID_Venta] [int] NOT NULL,
	[ID_Producto] [int] NOT NULL,
	[Cantidad] [decimal](18, 2) NOT NULL,
	[Precio_unitario] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Detalle_venta] PRIMARY KEY CLUSTERED 
(
	[ID_Detalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Producto]    Script Date: 05/07/2015 18:18:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Producto](
	[ID_Producto] [int] IDENTITY(1,1) NOT NULL,
	[ID_Categoria] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](255) NOT NULL,
	[Stock] [decimal](18, 2) NOT NULL,
	[Precio_compra] [decimal](18, 2) NOT NULL,
	[Precio_venta] [decimal](18, 2) NOT NULL,
	[Fecha_vencimiento] [date] NOT NULL,
	[Imagen] [image] NULL,
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[ID_Producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 05/07/2015 18:18:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuarios](
	[ID_Usuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NOT NULL,
	[Dni] [varchar](8) NOT NULL,
	[Direccion] [varchar](100) NOT NULL,
	[Telefono] [varchar](10) NOT NULL,
	[Login] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Acesso] [varchar](1) NOT NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[ID_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ventas]    Script Date: 05/07/2015 18:18:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ventas](
	[ID_Venta] [int] IDENTITY(1,1) NOT NULL,
	[ID_Cliente] [int] NOT NULL,
	[Fecha_Venta] [date] NOT NULL,
	[Tipo_Documento] [varchar](50) NOT NULL,
	[Nro_Documento] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Ventas] PRIMARY KEY CLUSTERED 
(
	[ID_Venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[Generar_reporte]    Script Date: 05/07/2015 18:18:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Generar_reporte]
AS
SELECT     dbo.Ventas.ID_Venta, dbo.Cliente.Nombre, dbo.Cliente.Apellido, dbo.Cliente.Dni, dbo.Ventas.Fecha_Venta, dbo.Ventas.Tipo_Documento, dbo.Ventas.Nro_Documento, 
                      dbo.Producto.Nombre AS Descripcion, dbo.Detalle_venta.Cantidad, dbo.Detalle_venta.Precio_unitario, 
                      dbo.Detalle_venta.Cantidad * dbo.Detalle_venta.Precio_unitario AS Total_parcial
FROM         dbo.Ventas INNER JOIN
                      dbo.Detalle_venta ON dbo.Ventas.ID_Venta = dbo.Detalle_venta.ID_Venta INNER JOIN
                      dbo.Producto ON dbo.Detalle_venta.ID_Producto = dbo.Producto.ID_Producto INNER JOIN
                      dbo.Cliente ON dbo.Ventas.ID_Cliente = dbo.Cliente.ID_Cliente

GO
/****** Object:  View [dbo].[Vista Cliente-Ventas]    Script Date: 05/07/2015 18:18:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Vista Cliente-Ventas]
AS
SELECT     dbo.Ventas.ID_Venta, dbo.Ventas.ID_Cliente, dbo.Cliente.Apellido, dbo.Cliente.Dni, dbo.Ventas.Fecha_Venta, dbo.Ventas.Tipo_Documento, 
                      dbo.Ventas.Nro_Documento
FROM         dbo.Ventas INNER JOIN
                      dbo.Cliente ON dbo.Ventas.ID_Cliente = dbo.Cliente.ID_Cliente

GO
/****** Object:  View [dbo].[Vista Detalle_Venta]    Script Date: 05/07/2015 18:18:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Vista Detalle_Venta]
AS
SELECT     dbo.Detalle_venta.ID_Detalle, dbo.Detalle_venta.ID_Venta, dbo.Detalle_venta.ID_Producto, dbo.Producto.Nombre, dbo.Detalle_venta.Cantidad, 
                      dbo.Detalle_venta.Precio_unitario
FROM         dbo.Detalle_venta INNER JOIN
                      dbo.Producto ON dbo.Detalle_venta.ID_Producto = dbo.Producto.ID_Producto

GO
ALTER TABLE [dbo].[Detalle_venta]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_venta_Producto] FOREIGN KEY([ID_Producto])
REFERENCES [dbo].[Producto] ([ID_Producto])
GO
ALTER TABLE [dbo].[Detalle_venta] CHECK CONSTRAINT [FK_Detalle_venta_Producto]
GO
ALTER TABLE [dbo].[Detalle_venta]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_venta_Ventas] FOREIGN KEY([ID_Venta])
REFERENCES [dbo].[Ventas] ([ID_Venta])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Detalle_venta] CHECK CONSTRAINT [FK_Detalle_venta_Ventas]
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD  CONSTRAINT [FK_Producto_Categoria] FOREIGN KEY([ID_Categoria])
REFERENCES [dbo].[Categoria] ([ID_Categoria])
GO
ALTER TABLE [dbo].[Producto] CHECK CONSTRAINT [FK_Producto_Categoria]
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Ventas_Cliente] FOREIGN KEY([ID_Cliente])
REFERENCES [dbo].[Cliente] ([ID_Cliente])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ventas] CHECK CONSTRAINT [FK_Ventas_Cliente]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[48] 4[2] 2[25] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Ventas"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 137
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Detalle_venta"
            Begin Extent = 
               Top = 6
               Left = 274
               Bottom = 157
               Right = 472
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Producto"
            Begin Extent = 
               Top = 6
               Left = 510
               Bottom = 198
               Right = 708
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cliente"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 296
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Generar_reporte'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Generar_reporte'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Generar_reporte'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[39] 4[23] 2[21] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Ventas"
            Begin Extent = 
               Top = 0
               Left = 401
               Bottom = 119
               Right = 599
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Cliente"
            Begin Extent = 
               Top = 14
               Left = 38
               Bottom = 133
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vista Cliente-Ventas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vista Cliente-Ventas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Detalle_venta"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 152
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Producto"
            Begin Extent = 
               Top = 6
               Left = 274
               Bottom = 133
               Right = 472
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vista Detalle_Venta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vista Detalle_Venta'
GO
USE [master]
GO
ALTER DATABASE [SisVentas] SET  READ_WRITE 
GO
