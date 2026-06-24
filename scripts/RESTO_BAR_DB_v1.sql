/*
================================================================================
  RESTO BAR - Base de datos v1
  Equipo 19 - Programación III - UTN TUP
  Script completo: tablas, datos iniciales y stored procedures
================================================================================
*/

USE master;
GO

IF DB_ID(N'RESTO_BAR_DB') IS NOT NULL
BEGIN
    ALTER DATABASE RESTO_BAR_DB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE RESTO_BAR_DB;
END
GO

CREATE DATABASE RESTO_BAR_DB;
GO

USE RESTO_BAR_DB;
GO

/* =============================================================================
   TABLAS
   ============================================================================= */

CREATE TABLE Roles (
    Id          INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Nombre      VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Usuarios (
    Id          INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    UserName    VARCHAR(50) NOT NULL UNIQUE,
    Clave       VARCHAR(100) NOT NULL,
    Nombre      VARCHAR(100) NOT NULL,
    Apellido    VARCHAR(100) NOT NULL,
    IdRol       INT NOT NULL,
    Activo      BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_Usuarios_Roles FOREIGN KEY (IdRol) REFERENCES Roles(Id)
);

CREATE TABLE TiposInsumo (
    Id          INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Nombre      VARCHAR(50) NOT NULL UNIQUE,
    Activo      BIT NOT NULL DEFAULT 1
);

CREATE TABLE Insumos (
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Nombre          VARCHAR(100) NOT NULL,
    IdTipoInsumo    INT NOT NULL,
    Precio          DECIMAL(10,2) NOT NULL,
    CantidadStock   INT NOT NULL DEFAULT 0,
    Activo          BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_Insumos_TiposInsumo FOREIGN KEY (IdTipoInsumo) REFERENCES TiposInsumo(Id),
    CONSTRAINT CK_Insumos_Precio CHECK (Precio >= 0),
    CONSTRAINT CK_Insumos_Stock CHECK (CantidadStock >= 0)
);

CREATE TABLE Mesas (
    Id          INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Numero      INT NOT NULL UNIQUE,
    Activo      BIT NOT NULL DEFAULT 1
);

CREATE TABLE AsignacionesMesa (
    Id                  INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdMesa              INT NOT NULL,
    IdMesero            INT NOT NULL,
    FechaAsignacion     DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    Vigente             BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_AsignacionesMesa_Mesas FOREIGN KEY (IdMesa) REFERENCES Mesas(Id),
    CONSTRAINT FK_AsignacionesMesa_Usuarios FOREIGN KEY (IdMesero) REFERENCES Usuarios(Id)
);

CREATE TABLE Pedidos (
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdMesa          INT NOT NULL,
    IdMesero        INT NOT NULL,
    FechaApertura   DATETIME NOT NULL DEFAULT GETDATE(),
    FechaCierre     DATETIME NULL,
    Estado          VARCHAR(20) NOT NULL DEFAULT 'Abierto',
    Total           DECIMAL(10,2) NOT NULL DEFAULT 0,
    CONSTRAINT FK_Pedidos_Mesas FOREIGN KEY (IdMesa) REFERENCES Mesas(Id),
    CONSTRAINT FK_Pedidos_Usuarios FOREIGN KEY (IdMesero) REFERENCES Usuarios(Id),
    CONSTRAINT CK_Pedidos_Estado CHECK (Estado IN ('Abierto', 'Cerrado')),
    CONSTRAINT CK_Pedidos_Total CHECK (Total >= 0)
);

CREATE TABLE PedidoDetalle (
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdPedido        INT NOT NULL,
    IdInsumo        INT NOT NULL,
    Cantidad        INT NOT NULL,
    PrecioUnitario  DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_PedidoDetalle_Pedidos FOREIGN KEY (IdPedido) REFERENCES Pedidos(Id),
    CONSTRAINT FK_PedidoDetalle_Insumos FOREIGN KEY (IdInsumo) REFERENCES Insumos(Id),
    CONSTRAINT CK_PedidoDetalle_Cantidad CHECK (Cantidad > 0),
    CONSTRAINT CK_PedidoDetalle_Precio CHECK (PrecioUnitario >= 0)
);

GO

/* =============================================================================
   DATOS INICIALES (SEED)
   ============================================================================= */

INSERT INTO Roles (Nombre) VALUES (N'Gerente'), (N'Mesero');

INSERT INTO Usuarios (UserName, Clave, Nombre, Apellido, IdRol, Activo)
VALUES
    (N'gerente', N'123456', N'Ana', N'García', 1, 1),
    (N'mesero1', N'123456', N'Juan', N'Pérez', 2, 1),
    (N'mesero2', N'123456', N'María', N'López', 2, 1);

INSERT INTO TiposInsumo (Nombre) VALUES (N'Plato'), (N'Bebida');

INSERT INTO Insumos (Nombre, IdTipoInsumo, Precio, CantidadStock, Activo)
VALUES
    (N'Milanesa con papas', 1, 8500.00, 30, 1),
    (N'Ensalada César', 1, 6200.00, 25, 1),
    (N'Empanadas x6', 1, 4800.00, 40, 1),
    (N'Hamburguesa completa', 1, 7800.00, 35, 1),
    (N'Pizza muzzarella', 1, 9500.00, 20, 1),
    (N'Agua mineral 500ml', 2, 1200.00, 80, 1),
    (N'Gaseosa 500ml', 2, 1500.00, 60, 1),
    (N'Cerveza artesanal', 2, 3200.00, 50, 1),
    (N'Café espresso', 2, 1800.00, 100, 1),
    (N'Jugo natural', 2, 2200.00, 45, 1);

INSERT INTO Mesas (Numero, Activo)
VALUES (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1);

DECLARE @IdMesero1 INT = (SELECT Id FROM Usuarios WHERE UserName = N'mesero1');
DECLARE @IdMesero2 INT = (SELECT Id FROM Usuarios WHERE UserName = N'mesero2');

INSERT INTO AsignacionesMesa (IdMesa, IdMesero, FechaAsignacion, Vigente)
SELECT m.Id, @IdMesero1, CAST(GETDATE() AS DATE), 1
FROM Mesas m
WHERE m.Numero BETWEEN 1 AND 4;

INSERT INTO AsignacionesMesa (IdMesa, IdMesero, FechaAsignacion, Vigente)
SELECT m.Id, @IdMesero2, CAST(GETDATE() AS DATE), 1
FROM Mesas m
WHERE m.Numero BETWEEN 5 AND 8;

GO

/* =============================================================================
   STORED PROCEDURES - AUTENTICACIÓN
   ============================================================================= */

CREATE OR ALTER PROCEDURE sp_login
    @UserName VARCHAR(50),
    @Clave    VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        u.Id,
        u.UserName,
        u.Clave,
        u.Nombre,
        u.Apellido,
        u.IdRol,
        r.Nombre AS RolNombre,
        u.Activo
    FROM Usuarios u
    INNER JOIN Roles r ON r.Id = u.IdRol
    WHERE u.UserName = @UserName
      AND u.Clave = @Clave
      AND u.Activo = 1;
END
GO

/* =============================================================================
   STORED PROCEDURES - INSUMOS
   ============================================================================= */

CREATE OR ALTER PROCEDURE sp_listar_insumos
    @SoloActivos BIT = 0,
    @ConStock    BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        i.Id,
        i.Nombre,
        i.IdTipoInsumo,
        t.Nombre AS Tipo,
        i.Precio,
        i.CantidadStock,
        i.Activo
    FROM Insumos i
    INNER JOIN TiposInsumo t ON t.Id = i.IdTipoInsumo
    WHERE (@SoloActivos = 0 OR i.Activo = 1)
      AND (@ConStock = 0 OR i.CantidadStock > 0)
    ORDER BY t.Nombre, i.Nombre;
END
GO

CREATE OR ALTER PROCEDURE sp_obtener_insumo
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        i.Id,
        i.Nombre,
        i.IdTipoInsumo,
        t.Nombre AS Tipo,
        i.Precio,
        i.CantidadStock,
        i.Activo
    FROM Insumos i
    INNER JOIN TiposInsumo t ON t.Id = i.IdTipoInsumo
    WHERE i.Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE sp_agregar_insumo
    @Nombre        VARCHAR(100),
    @IdTipoInsumo  INT,
    @Precio        DECIMAL(10,2),
    @CantidadStock INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM TiposInsumo WHERE Id = @IdTipoInsumo)
    BEGIN
        RAISERROR(N'Tipo de insumo inexistente.', 16, 1);
        RETURN;
    END

    IF @Precio < 0 OR @CantidadStock < 0
    BEGIN
        RAISERROR(N'Precio y stock deben ser mayores o iguales a cero.', 16, 1);
        RETURN;
    END

    INSERT INTO Insumos (Nombre, IdTipoInsumo, Precio, CantidadStock, Activo)
    VALUES (@Nombre, @IdTipoInsumo, @Precio, @CantidadStock, 1);

    SELECT SCOPE_IDENTITY() AS Id;
END
GO

CREATE OR ALTER PROCEDURE sp_modificar_insumo
    @Id            INT,
    @Nombre        VARCHAR(100),
    @IdTipoInsumo  INT,
    @Precio        DECIMAL(10,2),
    @CantidadStock INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Insumos WHERE Id = @Id)
    BEGIN
        RAISERROR(N'Insumo inexistente.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM TiposInsumo WHERE Id = @IdTipoInsumo)
    BEGIN
        RAISERROR(N'Tipo de insumo inexistente.', 16, 1);
        RETURN;
    END

    IF @Precio < 0 OR @CantidadStock < 0
    BEGIN
        RAISERROR(N'Precio y stock deben ser mayores o iguales a cero.', 16, 1);
        RETURN;
    END

    UPDATE Insumos
    SET Nombre = @Nombre,
        IdTipoInsumo = @IdTipoInsumo,
        Precio = @Precio,
        CantidadStock = @CantidadStock
    WHERE Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE sp_inactivar_insumo
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Insumos WHERE Id = @Id)
    BEGIN
        RAISERROR(N'Insumo inexistente.', 16, 1);
        RETURN;
    END

    UPDATE Insumos SET Activo = 0 WHERE Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE sp_activar_insumo
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Insumos WHERE Id = @Id)
    BEGIN
        RAISERROR(N'Insumo inexistente.', 16, 1);
        RETURN;
    END

    IF EXISTS (
        SELECT 1 FROM Insumos i
        INNER JOIN TiposInsumo t ON t.Id = i.IdTipoInsumo
        WHERE i.Id = @Id AND t.Activo = 0
    )
    BEGIN
        RAISERROR(N'No se puede activar: el tipo de insumo esta inactivo.', 16, 1);
        RETURN;
    END

    UPDATE Insumos SET Activo = 1 WHERE Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE sp_listar_tipos_insumo
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id, Nombre
    FROM TiposInsumo
    ORDER BY Nombre;
END
GO

/* =============================================================================
   STORED PROCEDURES - MESAS Y ASIGNACIONES
   ============================================================================= */

CREATE OR ALTER PROCEDURE sp_listar_meseros
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        u.Id,
        u.UserName,
        u.Nombre,
        u.Apellido,
        u.IdRol,
        r.Nombre AS RolNombre,
        u.Activo
    FROM Usuarios u
    INNER JOIN Roles r ON r.Id = u.IdRol
    WHERE r.Nombre = N'Mesero'
      AND u.Activo = 1
    ORDER BY u.Apellido, u.Nombre;
END
GO

CREATE OR ALTER PROCEDURE sp_listar_mesas
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id, Numero, Activo
    FROM Mesas
    WHERE Activo = 1
    ORDER BY Numero;
END
GO

CREATE OR ALTER PROCEDURE sp_asignar_mesa_mesero
    @IdMesa   INT,
    @IdMesero INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Mesas WHERE Id = @IdMesa AND Activo = 1)
    BEGIN
        RAISERROR(N'Mesa inexistente o inactiva.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (
        SELECT 1
        FROM Usuarios u
        INNER JOIN Roles r ON r.Id = u.IdRol
        WHERE u.Id = @IdMesero AND r.Nombre = N'Mesero' AND u.Activo = 1
    )
    BEGIN
        RAISERROR(N'Mesero inexistente o inactivo.', 16, 1);
        RETURN;
    END

    UPDATE AsignacionesMesa
    SET Vigente = 0
    WHERE IdMesa = @IdMesa AND Vigente = 1;

    INSERT INTO AsignacionesMesa (IdMesa, IdMesero, FechaAsignacion, Vigente)
    VALUES (@IdMesa, @IdMesero, CAST(GETDATE() AS DATE), 1);
END
GO

CREATE OR ALTER PROCEDURE sp_listar_mesas_asignadas
    @IdMesero INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        m.Id,
        m.Numero,
        m.Activo,
        CASE
            WHEN p.Id IS NOT NULL THEN N'Ocupada'
            ELSE N'Libre'
        END AS EstadoMesa,
        p.Id AS IdPedidoAbierto,
        a.IdMesero,
        u.Nombre + N' ' + u.Apellido AS Mesero
    FROM Mesas m
    INNER JOIN AsignacionesMesa a ON a.IdMesa = m.Id AND a.Vigente = 1
    INNER JOIN Usuarios u ON u.Id = a.IdMesero
    LEFT JOIN Pedidos p ON p.IdMesa = m.Id AND p.Estado = N'Abierto'
    WHERE m.Activo = 1
      AND (@IdMesero IS NULL OR a.IdMesero = @IdMesero)
    ORDER BY m.Numero;
END
GO

/* =============================================================================
   STORED PROCEDURES - PEDIDOS
   ============================================================================= */

CREATE OR ALTER PROCEDURE sp_abrir_pedido
    @IdMesa   INT,
    @IdMesero INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM Pedidos WHERE IdMesa = @IdMesa AND Estado = N'Abierto')
    BEGIN
        RAISERROR(N'La mesa ya tiene un pedido abierto.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (
        SELECT 1
        FROM AsignacionesMesa
        WHERE IdMesa = @IdMesa AND IdMesero = @IdMesero AND Vigente = 1
    )
    BEGIN
        RAISERROR(N'El mesero no tiene asignada esa mesa.', 16, 1);
        RETURN;
    END

    INSERT INTO Pedidos (IdMesa, IdMesero, FechaApertura, Estado, Total)
    VALUES (@IdMesa, @IdMesero, GETDATE(), N'Abierto', 0);

    SELECT SCOPE_IDENTITY() AS Id;
END
GO

CREATE OR ALTER PROCEDURE sp_cerrar_pedido
    @IdPedido INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Id = @IdPedido)
    BEGIN
        RAISERROR(N'Pedido inexistente.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Id = @IdPedido AND Estado = N'Abierto')
    BEGIN
        RAISERROR(N'El pedido no está abierto.', 16, 1);
        RETURN;
    END

    DECLARE @Total DECIMAL(10,2);

    SELECT @Total = ISNULL(SUM(d.Cantidad * d.PrecioUnitario), 0)
    FROM PedidoDetalle d
    WHERE d.IdPedido = @IdPedido;

    UPDATE Pedidos
    SET Estado = N'Cerrado',
        FechaCierre = GETDATE(),
        Total = @Total
    WHERE Id = @IdPedido;
END
GO

CREATE OR ALTER PROCEDURE sp_agregar_detalle_pedido
    @IdPedido  INT,
    @IdInsumo  INT,
    @Cantidad  INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Id = @IdPedido AND Estado = N'Abierto')
        BEGIN
            RAISERROR(N'El pedido no existe o no está abierto.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @Cantidad <= 0
        BEGIN
            RAISERROR(N'La cantidad debe ser mayor a cero.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        DECLARE @Stock INT;
        DECLARE @Precio DECIMAL(10,2);
        DECLARE @Activo BIT;

        SELECT @Stock = CantidadStock, @Precio = Precio, @Activo = Activo
        FROM Insumos
        WHERE Id = @IdInsumo;

        IF @Activo IS NULL OR @Activo = 0
        BEGIN
            RAISERROR(N'Insumo inexistente o inactivo.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @Stock < @Cantidad
        BEGIN
            RAISERROR(N'Stock insuficiente para el insumo solicitado.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO PedidoDetalle (IdPedido, IdInsumo, Cantidad, PrecioUnitario)
        VALUES (@IdPedido, @IdInsumo, @Cantidad, @Precio);

        UPDATE Insumos
        SET CantidadStock = CantidadStock - @Cantidad
        WHERE Id = @IdInsumo;

        UPDATE Pedidos
        SET Total = (
            SELECT ISNULL(SUM(d.Cantidad * d.PrecioUnitario), 0)
            FROM PedidoDetalle d
            WHERE d.IdPedido = @IdPedido
        )
        WHERE Id = @IdPedido;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_listar_detalle_pedido
    @IdPedido INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        d.Id,
        d.IdPedido,
        d.IdInsumo,
        i.Nombre AS Insumo,
        d.Cantidad,
        d.PrecioUnitario,
        d.Cantidad * d.PrecioUnitario AS Subtotal
    FROM PedidoDetalle d
    INNER JOIN Insumos i ON i.Id = d.IdInsumo
    WHERE d.IdPedido = @IdPedido
    ORDER BY d.Id;
END
GO

/* =============================================================================
   STORED PROCEDURES - REPORTES (pedidos cerrados del día)
   ============================================================================= */

CREATE OR ALTER PROCEDURE sp_reporte_pedidos_por_mesa
    @Fecha DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        m.Numero AS NumeroMesa,
        COUNT(p.Id) AS CantidadPedidos,
        ISNULL(SUM(p.Total), 0) AS TotalVendido
    FROM Pedidos p
    INNER JOIN Mesas m ON m.Id = p.IdMesa
    WHERE p.Estado = N'Cerrado'
      AND CAST(p.FechaCierre AS DATE) = @Fecha
    GROUP BY m.Numero
    ORDER BY m.Numero;
END
GO

CREATE OR ALTER PROCEDURE sp_reporte_pedidos_por_mesero
    @Fecha DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        u.Nombre + N' ' + u.Apellido AS Mesero,
        COUNT(p.Id) AS CantidadPedidos,
        ISNULL(SUM(p.Total), 0) AS TotalVendido
    FROM Pedidos p
    INNER JOIN Usuarios u ON u.Id = p.IdMesero
    WHERE p.Estado = N'Cerrado'
      AND CAST(p.FechaCierre AS DATE) = @Fecha
    GROUP BY u.Nombre, u.Apellido
    ORDER BY Mesero;
END
GO

PRINT N'Base RESTO_BAR_DB creada correctamente (Equipo 19 - Programación III).';
GO
