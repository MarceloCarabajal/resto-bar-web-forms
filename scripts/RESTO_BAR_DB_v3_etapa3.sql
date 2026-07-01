/*
================================================================================
  RESTO BAR - Base de datos v3 (Etapa 3)
  Equipo 19 - ABM Mesas (Marcelo)

  Ejecutar DESPUÉS de RESTO_BAR_DB_v1.sql y RESTO_BAR_DB_v2_etapa2.sql
  sobre la base RESTO_BAR_DB existente.
  No recrea la base; agrega y actualiza SPs de mesas para el ABM.
================================================================================
*/

USE RESTO_BAR_DB;
GO

/* =============================================================================
   STORED PROCEDURES - MESAS (ABM Marcelo)
   ============================================================================= */

CREATE OR ALTER PROCEDURE sp_listar_mesas
    @SoloActivos BIT = 1
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id, Numero, Activo
    FROM Mesas
    WHERE (@SoloActivos = 0 OR Activo = 1)
    ORDER BY Numero;
END
GO

CREATE OR ALTER PROCEDURE sp_obtener_mesa
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id, Numero, Activo
    FROM Mesas
    WHERE Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE sp_agregar_mesa
    @Numero INT
AS
BEGIN
    SET NOCOUNT ON;

    IF @Numero IS NULL OR @Numero <= 0
    BEGIN
        RAISERROR(N'El número de mesa debe ser mayor a cero.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM Mesas WHERE Numero = @Numero)
    BEGIN
        RAISERROR(N'Ya existe una mesa con ese número.', 16, 1);
        RETURN;
    END

    INSERT INTO Mesas (Numero, Activo)
    VALUES (@Numero, 1);

    SELECT SCOPE_IDENTITY() AS Id;
END
GO

CREATE OR ALTER PROCEDURE sp_modificar_mesa
    @Id     INT,
    @Numero INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Mesas WHERE Id = @Id)
    BEGIN
        RAISERROR(N'Mesa inexistente.', 16, 1);
        RETURN;
    END

    IF @Numero IS NULL OR @Numero <= 0
    BEGIN
        RAISERROR(N'El número de mesa debe ser mayor a cero.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM Mesas WHERE Numero = @Numero AND Id <> @Id)
    BEGIN
        RAISERROR(N'Ya existe otra mesa con ese número.', 16, 1);
        RETURN;
    END

    UPDATE Mesas
    SET Numero = @Numero
    WHERE Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE sp_inactivar_mesa
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Mesas WHERE Id = @Id)
    BEGIN
        RAISERROR(N'Mesa inexistente.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM Pedidos WHERE IdMesa = @Id AND Estado = N'Abierto')
    BEGIN
        RAISERROR(N'No se puede inactivar: la mesa tiene un pedido abierto.', 16, 1);
        RETURN;
    END

    UPDATE AsignacionesMesa
    SET Vigente = 0
    WHERE IdMesa = @Id AND Vigente = 1;

    UPDATE Mesas
    SET Activo = 0
    WHERE Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE sp_activar_mesa
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Mesas WHERE Id = @Id)
    BEGIN
        RAISERROR(N'Mesa inexistente.', 16, 1);
        RETURN;
    END

    UPDATE Mesas
    SET Activo = 1
    WHERE Id = @Id;
END
GO
