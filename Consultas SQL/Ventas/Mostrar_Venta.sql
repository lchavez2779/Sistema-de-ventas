USE [SisVentas]
GO
/****** Object:  StoredProcedure [dbo].[Mostrar_Ventas]    Script Date: 03/31/2014 15:30:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[Mostrar_Ventas]
as
SELECT     dbo.Ventas.ID_Venta, dbo.Ventas.ID_Cliente, dbo.Cliente.Apellido, dbo.Cliente.Dni, dbo.Ventas.Fecha_Venta, dbo.Ventas.Tipo_Documento, 
                      dbo.Ventas.Nro_Documento
FROM         dbo.Ventas INNER JOIN
                      dbo.Cliente ON dbo.Ventas.ID_Cliente = dbo.Cliente.ID_Cliente
order by ID_Venta desc