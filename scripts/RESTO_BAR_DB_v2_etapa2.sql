/*
================================================================================
  RESTO BAR - Base de datos v2 (Etapa 2)
  Equipo 19 - ABM TipoInsumo + ABM Usuarios

  Ejecutar DESPUÉS de RESTO_BAR_DB_v1.sql sobre la base RESTO_BAR_DB existente.
  No recrea la base; agrega columna Activo en TiposInsumo y SPs nuevos.
================================================================================
*/

USE RESTO_BAR_DB;
GO

/* =============================================================================
   ALTER TABLA TiposInsumo — columna Activo para inactivar tipos
   ============================================================================= */

IF COL_LENGTH('TiposInsumo', 'Activo') IS NULL
BEGIN
    ALTER TABLE TiposInsumo
    ADD Activo BIT NOT NULL CONSTRAINT DF_TiposInsumo_Activo DEFAULT 1;
END
GO

UPDATE TiposInsumo SET Activo = 1 WHERE Activo IS NULL;
GO

/* =============================================================================
   STORED PROCEDURES - TIPOS DE INSUMO (ABM Ferdinando)
   ============================================================================= */

CREATE OR ALTER PROCEDURE sp_listar_tipos_insumo
    @SoloActivos BIT = 1
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id, Nombre, Activo
    FROM TiposInsumo
    WHERE (@SoloActivos = 0 OR Activo = 1)
    ORDER BY Nombre;
END
GO

CREATE OR ALTER PROCEDURE sp_obtener_tipo_insumo
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id, Nombre, Activo
    FROM TiposInsumo
    WHERE Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE sp_agregar_tipo_insumo
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF LTRIM(RTRIM(@Nombre)) = ''
    BEGIN
        RAISERROR(N'El nombre del tipo es obligatorio.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM TiposInsumo WHERE Nombre = @Nombre)
    BEGIN
        RAISERROR(N'Ya existe un tipo de insumo con ese nombre.', 16, 1);
        RETURN;
    END

    INSERT INTO TiposInsumo (Nombre, Activo)
    VALUES (@Nombre, 1);

    SELECT SCOPE_IDENTITY() AS Id;
END
GO

CREATE OR ALTER PROCEDURE sp_modificar_tipo_insumo
    @Id     INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM TiposInsumo WHERE Id = @Id)
    BEGIN
        RAISERROR(N'Tipo de insumo inexistente.', 16, 1);
        RETURN;
    END

    IF LTRIM(RTRIM(@Nombre)) = ''
    BEGIN
        RAISERROR(N'El nombre del tipo es obligatorio.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM TiposInsumo WHERE Nombre = @Nombre AND Id <> @Id)
    BEGIN
        RAISERROR(N'Ya existe otro tipo de insumo con ese nombre.', 16, 1);
        RETURN;
    END

    UPDATE TiposInsumo
    SET Nombre = @Nombre
    WHERE Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE sp_inactivar_tipo_insumo
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM TiposInsumo WHERE Id = @Id)
    BEGIN
        RAISERROR(N'Tipo de insumo inexistente.', 16, 1);
        RETURN;
    END

    IF EXISTS (
        SELECT 1 FROM Insumos
        WHERE IdTipoInsumo = @Id AND Activo = 1
    )
    BEGIN
        RAISERROR(N'No se puede inactivar: hay insumos activos de este tipo.', 16, 1);
        RETURN;
    END

    UPDATE TiposInsumo SET Activo = 0 WHERE Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE sp_activar_tipo_insumo
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM TiposInsumo WHERE Id = @Id)
    BEGIN
        RAISERROR(N'Tipo de insumo inexistente.', 16, 1);
        RETURN;
    END

    UPDATE TiposInsumo SET Activo = 1 WHERE Id = @Id;
END
GO

/* =============================================================================
   STORED PROCEDURES - USUARIOS (ABM Melanie)
   ============================================================================= */

CREATE OR ALTER PROCEDURE sp_listar_roles
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id, Nombre
    FROM Roles
    ORDER BY Nombre;
END
GO

CREATE OR ALTER PROCEDURE sp_listar_usuarios
    @SoloActivos BIT = 1
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
    WHERE (@SoloActivos = 0 OR u.Activo = 1)
    ORDER BY u.Apellido, u.Nombre;
END
GO

CREATE OR ALTER PROCEDURE sp_obtener_usuario
    @Id INT
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
    WHERE u.Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE sp_agregar_usuario
    @UserName VARCHAR(50),
    @Clave    VARCHAR(100),
    @Nombre   VARCHAR(100),
    @Apellido VARCHAR(100),
    @IdRol    INT
AS
BEGIN
    SET NOCOUNT ON;

    IF LTRIM(RTRIM(@UserName)) = '' OR LTRIM(RTRIM(@Clave)) = ''
    BEGIN
        RAISERROR(N'Usuario y clave son obligatorios.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Roles WHERE Id = @IdRol)
    BEGIN
        RAISERROR(N'Rol inexistente.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM Usuarios WHERE UserName = @UserName)
    BEGIN
        RAISERROR(N'El nombre de usuario ya existe.', 16, 1);
        RETURN;
    END

    INSERT INTO Usuarios (UserName, Clave, Nombre, Apellido, IdRol, Activo)
    VALUES (@UserName, @Clave, @Nombre, @Apellido, @IdRol, 1);

    SELECT SCOPE_IDENTITY() AS Id;
END
GO

CREATE OR ALTER PROCEDURE sp_modificar_usuario
    @Id       INT,
    @UserName VARCHAR(50),
    @Clave    VARCHAR(100),
    @Nombre   VARCHAR(100),
    @Apellido VARCHAR(100),
    @IdRol    INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE Id = @Id)
    BEGIN
        RAISERROR(N'Usuario inexistente.', 16, 1);
        RETURN;
    END

    IF LTRIM(RTRIM(@UserName)) = '' OR LTRIM(RTRIM(@Clave)) = ''
    BEGIN
        RAISERROR(N'Usuario y clave son obligatorios.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Roles WHERE Id = @IdRol)
    BEGIN
        RAISERROR(N'Rol inexistente.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM Usuarios WHERE UserName = @UserName AND Id <> @Id)
    BEGIN
        RAISERROR(N'El nombre de usuario ya existe.', 16, 1);
        RETURN;
    END

    UPDATE Usuarios
    SET UserName = @UserName,
        Clave = @Clave,
        Nombre = @Nombre,
        Apellido = @Apellido,
        IdRol = @IdRol
    WHERE Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE sp_inactivar_usuario
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE Id = @Id)
    BEGIN
        RAISERROR(N'Usuario inexistente.', 16, 1);
        RETURN;
    END

    UPDATE Usuarios SET Activo = 0 WHERE Id = @Id;
END
GO
