create database GridoTech1
go


-- Usar la base de datos
USE GridoTech1
GO

-- Tabla de Proveedores
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName NVARCHAR(100) NOT NULL,
    ContactInfo NVARCHAR(255)
);
GO

-- Tabla de Materiales
CREATE TABLE Materials (
    MaterialID INT PRIMARY KEY IDENTITY(1,1),
    MaterialName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    SupplierID INT,
    StockQuantity INT NOT NULL,
    StockUnit NVARCHAR(50),
    
);
GO

-- Tabla de Inventario (Registro de stock inicial y final)
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1),
    MaterialID INT NOT NULL,
    InitialStock INT NOT NULL,
    FinalStock INT NOT NULL,
    Date DATETIME NOT NULL,
    BatchNumber NVARCHAR(50),
   
);
GO
--Tabla de Productos
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE()
);
go

--Tabla de Recetas
CREATE TABLE Recipes (
    RecipeID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    MaterialID INT,
    Quantity INT NOT NULL,
    RecipeName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE(),
   
);
GO

-- Tabla de Materiales Retenidos
CREATE TABLE RetainedMaterials (
    RetainID INT PRIMARY KEY IDENTITY(1,1),
    MaterialID INT NOT NULL,
    Reason NVARCHAR(255) NOT NULL,
    DateRetained DATETIME NOT NULL,
   
);
GO

-- Tabla de Materiales Descartados
CREATE TABLE DiscardedMaterials (
    DiscardID INT PRIMARY KEY IDENTITY(1,1),
    MaterialID INT NOT NULL,
    Reason NVARCHAR(255) NOT NULL,
    DateDiscarded DATETIME NOT NULL,
    
);
GO

-- Tabla de Órdenes de Producción
CREATE TABLE WorkOrders (
    WorkOrderID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    Quantity INT NOT NULL,
    Status NVARCHAR(50) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    
);
GO


-- Tabla de Materiales Utilizados en la Producción
CREATE TABLE WorkOrderMaterials (
    WorkOrderMaterialID INT PRIMARY KEY IDENTITY(1,1),
    WorkOrderID INT,
    MaterialID INT,
    Quantity INT NOT NULL,
    
);
GO


--Registro de Material (Procedimiento)
CREATE PROCEDURE RegisterMaterial
    @MaterialName NVARCHAR(100),
    @Description NVARCHAR(255) = NULL,
    @SupplierID INT = NULL,
    @StockQuantity INT,
    @StockUnit NVARCHAR(50) = NULL
AS
BEGIN

    -- Validación: Verificar que la cantidad de stock sea mayor o igual a 0
    IF @StockQuantity < 0
    BEGIN
        RAISERROR('La cantidad de stock no puede ser negativa.', 16, 1);
        RETURN;
    END

    -- Inserción en la tabla Materials
    INSERT INTO Materials (MaterialName, Description, SupplierID, StockQuantity, StockUnit)
    VALUES (@MaterialName, @Description, @SupplierID, @StockQuantity, @StockUnit);

   
END
GO

--Actualizacion de Material (Procedimiento)
CREATE PROCEDURE UpdateMaterial
    @MaterialID INT,
    @MaterialName NVARCHAR(100) = NULL,
    @Description NVARCHAR(255) = NULL,
    @SupplierID INT = NULL,
    @StockQuantity INT = NULL,
    @StockUnit NVARCHAR(50) = NULL
AS
BEGIN

    -- Actualización condicional: Solo se actualizan los campos no nulos
    UPDATE Materials
    SET 
        MaterialName = ISNULL(@MaterialName, MaterialName),  -- Si no se proporciona un nuevo nombre, se conserva el actual
        Description = ISNULL(@Description, Description),     -- Si no se proporciona una nueva descripción, se conserva la actual
        SupplierID = ISNULL(@SupplierID, SupplierID),        -- Si no se proporciona un nuevo SupplierID, se conserva el actual
        StockQuantity = ISNULL(@StockQuantity, StockQuantity),-- Si no se proporciona una nueva cantidad, se conserva la actual
        StockUnit = ISNULL(@StockUnit, StockUnit)            -- Si no se proporciona una nueva unidad, se conserva la actual
    WHERE MaterialID = @MaterialID;

END
GO


--Eliminacion de Material (Procedimiento)
CREATE PROCEDURE DeleteMaterial
    @MaterialID INT
AS
BEGIN
 
    -- Eliminación del material
    DELETE FROM Materials
    WHERE MaterialID = @MaterialID;

END
GO


--Busqueda de Material (vista).
CREATE VIEW MaterialSearchView
AS
SELECT 
    M.MaterialID,
    M.MaterialName,
    M.Description,
    M.StockQuantity,
    M.StockUnit,
    S.SupplierID,
    S.SupplierName,
    S.ContactInfo
FROM 
    Materials M
LEFT JOIN 
    Suppliers S ON M.SupplierID = S.SupplierID;
GO

--Registro de Material Retenido (Procedimiento)
CREATE PROCEDURE InsertRetainedMaterial
    @MaterialID INT,
    @Reason NVARCHAR(255),
    @DateRetained DATETIME
AS
BEGIN
 
    -- Inserción en la tabla RetainedMaterials
    INSERT INTO RetainedMaterials (MaterialID, Reason, DateRetained)
    VALUES (@MaterialID, @Reason, @DateRetained);

END
go

--Actualizacion de Material Retenido (Procedimiento)
CREATE PROCEDURE UpdateRetainedMaterial
    @RetainID INT,
    @MaterialID INT = NULL,
    @Reason NVARCHAR(255) = NULL,
    @DateRetained DATETIME = NULL
AS
BEGIN
       -- Actualización condicional: Solo se actualizan los campos no nulos
    UPDATE RetainedMaterials
    SET 
        MaterialID = ISNULL(@MaterialID, MaterialID),    -- Actualizar MaterialID si se proporciona uno nuevo
        Reason = ISNULL(@Reason, Reason),                -- Actualizar Reason si se proporciona uno nuevo
        DateRetained = ISNULL(@DateRetained, DateRetained) -- Actualizar DateRetained si se proporciona uno nuevo
    WHERE 
        RetainID = @RetainID;

END
GO

--Listar de Material Retenido (Vista)
CREATE VIEW RetainedMaterialsView
AS
SELECT 
    RM.RetainID,
    RM.MaterialID,
    M.MaterialName,
    RM.Reason,
    RM.DateRetained
FROM 
    RetainedMaterials RM
JOIN 
    Materials M ON RM.MaterialID = M.MaterialID;
GO

--Registro de Inventario (Procedimiento)
CREATE PROCEDURE InsertInventory
    @MaterialID INT,
    @InitialStock INT,
    @FinalStock INT,
    @Date DATETIME,
    @BatchNumber NVARCHAR(50) = NULL
AS
BEGIN
 
    -- Inserción en la tabla Inventory
    INSERT INTO Inventory (MaterialID, InitialStock, FinalStock, Date, BatchNumber)
    VALUES (@MaterialID, @InitialStock, @FinalStock, @Date, @BatchNumber);

    -- Mensaje de éxito
    PRINT 'Registro de inventario insertado exitosamente.';
END
GO

--Actualizacion de Inventario (Procedimiento)
CREATE PROCEDURE UpdateInventory
    @InventoryID INT,
    @MaterialID INT = NULL,
    @InitialStock INT = NULL,
    @FinalStock INT = NULL,
    @Date DATETIME = NULL,
    @BatchNumber NVARCHAR(50) = NULL
AS
BEGIN
      -- Actualización condicional: Solo se actualizan los campos no nulos
    UPDATE Inventory
    SET 
        MaterialID = ISNULL(@MaterialID, MaterialID),      -- Si se proporciona MaterialID, se actualiza
        InitialStock = ISNULL(@InitialStock, InitialStock),-- Si se proporciona InitialStock, se actualiza
        FinalStock = ISNULL(@FinalStock, FinalStock),      -- Si se proporciona FinalStock, se actualiza
        Date = ISNULL(@Date, Date),                        -- Si se proporciona Date, se actualiza
        BatchNumber = ISNULL(@BatchNumber, BatchNumber)    -- Si se proporciona BatchNumber, se actualiza
    WHERE 
        InventoryID = @InventoryID;

END
GO

--Listar de Inventario (Vista)
CREATE VIEW InventoryView
AS
SELECT 
    I.InventoryID,
    I.MaterialID,
    M.MaterialName,
    I.InitialStock,
    I.FinalStock,
    I.Date,
    I.BatchNumber
FROM 
    Inventory I
JOIN 
    Materials M ON I.MaterialID = M.MaterialID;
GO

--Registro de Material Descartado (Procedimiento)
CREATE PROCEDURE InsertDiscardedMaterial
    @MaterialID INT,
    @Reason NVARCHAR(255),
    @DateDiscarded DATETIME
AS
BEGIN

    -- Inserción en la tabla DiscardedMaterials
    INSERT INTO DiscardedMaterials (MaterialID, Reason, DateDiscarded)
    VALUES (@MaterialID, @Reason, @DateDiscarded);

END
GO

--Actualizacion de Material Descartado (Procedimiento)
CREATE PROCEDURE UpdateDiscardedMaterial
    @DiscardID INT,
    @MaterialID INT = NULL,
    @Reason NVARCHAR(255) = NULL,
    @DateDiscarded DATETIME = NULL
AS
BEGIN
 
    -- Actualización condicional: Solo se actualizan los campos no nulos
    UPDATE DiscardedMaterials
    SET 
        MaterialID = ISNULL(@MaterialID, MaterialID),        -- Si se proporciona MaterialID, se actualiza
        Reason = ISNULL(@Reason, Reason),                    -- Si se proporciona Reason, se actualiza
        DateDiscarded = ISNULL(@DateDiscarded, DateDiscarded)-- Si se proporciona DateDiscarded, se actualiza
    WHERE 
        DiscardID = @DiscardID;

END
GO

--Listar de Marterial descartado (Vista)
CREATE VIEW DiscardedMaterialsView
AS
SELECT 
    DM.DiscardID,
    DM.MaterialID,
    M.MaterialName,
    DM.Reason,
    DM.DateDiscarded
FROM 
    DiscardedMaterials DM
JOIN 
    Materials M ON DM.MaterialID = M.MaterialID;
GO


create view V_GetAll_WorkOrders
as
select w.WorkOrderID as OT, p.ProductName as Producto, w.Quantity as Cantidad, w.Status as Estado, w.CreatedAt as FechaAlta, w.UpdatedAt as FechaActualizacion from WorkOrders w
join Products p on w.ProductID=p.ProductName
go

create procedure SP_GetAll_WorkOrders1
as
BEGIN
select w.WorkOrderID as OT, p.ProductName as Producto, w.Quantity as Cantidad, w.Status as Estado, w.CreatedAt as FechaAlta, w.UpdatedAt as FechaActualizacion from WorkOrders w
join Products p on w.ProductID=p.ProductID
END
go




CREATE PROCEDURE SP_Insert_WorkOrders
  @ProductID INT,
    @Quantity INT,
    @Status NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO WorkOrders (ProductID, Quantity, Status)
    VALUES (@ProductID, @Quantity, @Status);
END;
GO

