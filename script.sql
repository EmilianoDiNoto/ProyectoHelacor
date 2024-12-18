USE [master]
GO
/****** Object:  Database [GridoTechAdvance]    Script Date: 21/10/2024 21:02:42 ******/
CREATE DATABASE [GridoTechAdvance]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GridoTechAdvance', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\GridoTechAdvance.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GridoTechAdvance_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\GridoTechAdvance_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [GridoTechAdvance] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GridoTechAdvance].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GridoTechAdvance] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET ARITHABORT OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GridoTechAdvance] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GridoTechAdvance] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GridoTechAdvance] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GridoTechAdvance] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET RECOVERY FULL 
GO
ALTER DATABASE [GridoTechAdvance] SET  MULTI_USER 
GO
ALTER DATABASE [GridoTechAdvance] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GridoTechAdvance] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GridoTechAdvance] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GridoTechAdvance] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GridoTechAdvance] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GridoTechAdvance] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [GridoTechAdvance] SET QUERY_STORE = ON
GO
ALTER DATABASE [GridoTechAdvance] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [GridoTechAdvance]
GO
/****** Object:  Table [dbo].[Material]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Material](
	[idMaterial] [int] IDENTITY(1,1) NOT NULL,
	[NombreMaterial] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idMaterial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Almacen]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Almacen](
	[idMaterial] [int] NOT NULL,
	[Stock] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idMaterial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_AlmacenStock]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create view [dbo].[V_AlmacenStock]
 as
 select M.NombreMaterial MATERIAL, A.Stock STOCK 
 from Almacen A
 INNER JOIN Material M 
 ON A.idMaterial= M.idMaterial
GO
/****** Object:  Table [dbo].[Base]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Base](
	[idBase] [int] IDENTITY(1,1) NOT NULL,
	[NombreBase] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idBase] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Produccion]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produccion](
	[idProduccion] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[Turno] [varchar](50) NOT NULL,
	[Responsable] [varchar](50) NOT NULL,
	[idBase] [int] NULL,
	[CantidadProducida] [int] NULL,
	[Etapa] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[idProduccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_Produccion]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_Produccion]
as
select p.Fecha Fecha, p.Turno Turno, p.Responsable Responsable, b.NombreBase Base, p.CantidadProducida Cocinado, p.Etapa Etapa
 from Produccion P
 inner join Base B on p.idBase=b.idBase
GO
/****** Object:  Table [dbo].[Etapa]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Etapa](
	[idEtapa] [int] IDENTITY(1,1) NOT NULL,
	[NombreEtapa] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idEtapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Insumos]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Insumos](
	[Id_Insumo] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nchar](10) NULL,
	[Descripción] [nchar](10) NULL,
	[Unidad_Medida] [nchar](10) NULL,
 CONSTRAINT [PK_Insumos] PRIMARY KEY CLUSTERED 
(
	[Id_Insumo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Materia_Prima]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Materia_Prima](
	[Id_MateriaPrima] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NULL,
	[Descripción] [nvarchar](100) NULL,
	[Unidad_Medida] [nvarchar](100) NULL,
	[Cantidad_Disponible] [nvarchar](100) NULL,
 CONSTRAINT [PK_Materia_Prima] PRIMARY KEY CLUSTERED 
(
	[Id_MateriaPrima] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Materiales_Retenidos]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Materiales_Retenidos](
	[Id_Retencion] [int] IDENTITY(1,1) NOT NULL,
	[Id_MateriaPrima] [int] NULL,
	[Id_Insumo] [int] NULL,
	[Fecha_Retencion] [nchar](10) NULL,
	[Causa_Retencion] [nchar](10) NULL,
	[Estado_Retencion] [nchar](10) NULL,
	[Fecha_Liberacion] [nchar](10) NULL,
 CONSTRAINT [PK_Materiales_Retenidos] PRIMARY KEY CLUSTERED 
(
	[Id_Retencion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movimientos]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movimientos](
	[Id_Movimiento] [int] IDENTITY(1,1) NOT NULL,
	[Id_MateriaPrima] [int] NULL,
	[Id_Insumo] [int] NULL,
	[Fecha_Movimiento] [nchar](10) NULL,
	[Cantidad] [nchar](10) NULL,
	[Tipo_Movimiento] [nchar](10) NULL,
 CONSTRAINT [PK_Movimientos] PRIMARY KEY CLUSTERED 
(
	[Id_Movimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[Id_Pedido] [int] IDENTITY(1,1) NOT NULL,
	[Id_Proveedor] [nchar](10) NULL,
	[Fecha_Pedido] [nchar](10) NULL,
	[Fecha_Entrega] [nchar](10) NULL,
	[Estado] [nchar](10) NULL,
 CONSTRAINT [PK_Pedidos] PRIMARY KEY CLUSTERED 
(
	[Id_Pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores](
	[Id_Proveedor] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nchar](10) NULL,
	[Contacto] [nchar](10) NULL,
 CONSTRAINT [PK_Proveedores] PRIMARY KEY CLUSTERED 
(
	[Id_Proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recetas]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recetas](
	[RecetaID] [int] IDENTITY(1,1) NOT NULL,
	[idBase] [int] NULL,
	[idMaterial] [int] NULL,
	[Cantidad] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RecetaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Responsable]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Responsable](
	[idResponsable] [int] IDENTITY(1,1) NOT NULL,
	[NombreResponsable] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idResponsable] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stock]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stock](
	[Id_Stock] [int] IDENTITY(1,1) NOT NULL,
	[Id_MateriaPrima] [int] NOT NULL,
	[Id_Insumo] [int] NULL,
	[Fecha] [nchar](10) NULL,
	[Tipo_Movimiento] [nchar](10) NULL,
	[Cantidad] [nchar](10) NULL,
	[Stock_Inicial] [nchar](10) NULL,
	[Stock_Final] [nchar](10) NULL,
 CONSTRAINT [PK_Stock] PRIMARY KEY CLUSTERED 
(
	[Id_Stock] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Turno]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Turno](
	[idTurno] [int] IDENTITY(1,1) NOT NULL,
	[NombreTurno] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idTurno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Produccion] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Almacen]  WITH CHECK ADD FOREIGN KEY([idMaterial])
REFERENCES [dbo].[Material] ([idMaterial])
GO
ALTER TABLE [dbo].[Produccion]  WITH CHECK ADD FOREIGN KEY([idBase])
REFERENCES [dbo].[Base] ([idBase])
GO
ALTER TABLE [dbo].[Recetas]  WITH CHECK ADD FOREIGN KEY([idBase])
REFERENCES [dbo].[Base] ([idBase])
GO
ALTER TABLE [dbo].[Recetas]  WITH CHECK ADD FOREIGN KEY([idMaterial])
REFERENCES [dbo].[Material] ([idMaterial])
GO
/****** Object:  StoredProcedure [dbo].[SP_AlmacenAlta]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create procedure [dbo].[SP_AlmacenAlta]
 @idMaterial int,
@Stock decimal
as
begin

insert into [dbo].[Almacen]
values (@idMaterial,@Stock)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_AlmacenDev]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AlmacenDev]
@idMaterial int,
@DevMaterial decimal
as
begin
--descontar del Stock
update	Almacen
set Stock = Stock - @DevMaterial
where idMaterial = @idMaterial
end
GO
/****** Object:  StoredProcedure [dbo].[SP_AlmacenGetAll]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_AlmacenGetAll]
as
begin
 select M.idMaterial, M.NombreMaterial MATERIAL, A.Stock STOCK
 from Almacen A
 INNER JOIN Material M 
 ON A.idMaterial= M.idMaterial
end
GO
/****** Object:  StoredProcedure [dbo].[SP_AlmacenIng]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AlmacenIng]
@idMaterial int,
@IngMaterial decimal
as
begin
--descontar del Stock
update	Almacen
set Stock = Stock + @IngMaterial
where idMaterial = @idMaterial
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ConsumoProduccion]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ConsumoProduccion](

@Turno varchar(50),
@Responsable varchar(50),
@idBase int,
@CantidadBase int,
@Etapas varchar(50)
)

as
begin
declare @idMaterial int;
declare @CantidadNecesaria decimal(18,2);
declare @CantidadTotal decimal(18,2);

begin transaction;

begin try

	declare cur cursor for
	select idMaterial, Cantidad from Recetas
	where idBase=@idBase;

	OPEN CUR;
	FETCH NEXT FROM CUR INTO @idMaterial,@CantidadNecesaria;

	while @@FETCH_STATUS=0
	begin
	set @CantidadTotal = @CantidadNecesaria * @CantidadBase

	update Almacen
	set Stock=Stock-@CantidadTotal
	where idMaterial = @idMaterial;

 --verificacion de stock
	if(select Stock from Almacen where idMaterial=@idMaterial)<0
	begin
	  RAISERROR ('No hay suficiente inventario para el ingrediente %d', 16, 1, @idMaterial);
	  rollback transaction;
	  return;
	 end

	fetch next from cur into @idMaterial, @CantidadNecesaria;
 end

 close cur;
 deallocate cur;
 
 --registra la produccion
 insert into Produccion(Turno, Responsable, idBase, CantidadProducida, Etapa)
 values (@Turno, @Responsable, @idBase, @CantidadBase, @Etapas);

 commit transaction;
 end try

 begin catch;
 rollback transaction;
 throw;
 end catch
 end 
 
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAlmacenPorId]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_GetAlmacenPorId]
    @Id int
as
begin
    select M.idMaterial, M.NombreMaterial AS MATERIAL, A.Stock AS STOCK
    from Almacen A
    INNER JOIN Material M ON A.idMaterial = M.idMaterial
    where A.idMaterial = @Id;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Receta]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create procedure [dbo].[SP_Receta]
 @idBase int
 as
 begin
 select m.NombreMaterial Material, r.Cantidad Cantidad from Recetas R
inner join Base B on r.idBase=B.idBase
inner join Material M on r.idMaterial=M.idMaterial
where b.idBase=@idBase
end
GO
/****** Object:  StoredProcedure [dbo].[SP_RecetaId]    Script Date: 21/10/2024 21:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create procedure [dbo].[SP_RecetaId]
 @NombreBase nvarchar
 as
 begin
 select m.NombreMaterial Material, r.Cantidad Cantidad from Recetas R
inner join Base B on r.idBase=B.idBase
inner join Material M on r.idMaterial=M.idMaterial
where b.NombreBase=@NombreBase
end
GO
USE [master]
GO
ALTER DATABASE [GridoTechAdvance] SET  READ_WRITE 
GO
