# Resto BAR

Sistema web para la gestión de un restaurante/bar: mesas, pedidos, insumos (platos y bebidas) y meseros.  
**Trabajo práctico cuatrimestral** — Programación III, TUP UTN (2026).

**Repositorio:** [github.com/MarceloCarabajal/resto-bar-web-forms](https://github.com/MarceloCarabajal/resto-bar-web-forms)

---

## Qué hace la aplicación

- **Mesas y pedidos:** abrir y cerrar pedidos por mesa (varias veces al día).
- **Insumos:** catálogo de platos y bebidas con precio y stock; carga inicial en base de datos.
- **Meseros:** cada mesa asignada a un mesero; los pedidos quedan ligados a quien atiende esa mesa.
- **Administración diaria:** el gerente asigna o reasigna mesas a meseros al inicio del turno.
- **Perfiles:**
  - **Gerente** — acceso completo (insumos, asignaciones, todas las mesas, reportes).
  - **Mesero** — solo sus mesas asignadas; puede abrir y cerrar pedidos ahí.
- **Reportes:** al cierre del día, pedidos por mesa y por mesero.

---

## Tecnologías

| Área | Elección |
|------|----------|
| Frontend | ASP.NET Web Forms 4.8, Bootstrap, Master Page |
| Backend | C# — capas `dominio` y `negocio` |
| Base de datos | SQL Server — tablas + **stored procedures** |
| Patrón de datos | `AccesoDatos` + ADO.NET

No se usa Entity Framework, ASP.NET Core ni MVC.

---

## Arquitectura

```
resto-bar-web   →  páginas .aspx (UI, eventos, Session)
      ↓
negocio         →  lógica + llamadas a stored procedures
      ↓
dominio         →  entidades (Usuario, Insumo, Mesa, Pedido, …)
```

La base `RESTO_BAR_DB` se crea con `scripts/RESTO_BAR_DB_v1.sql`.

---

## Estructura del repositorio

```
RestoBar_equipo-19/
├── RestoBar_equipo-19.sln
├── resto-bar-web/       Sitio WebForms
├── dominio/             Entidades
├── negocio/             AccesoDatos y clases *Negocio
├── scripts/             Script de base de datos
└── docs/                Documentación del equipo
```

---

## Requisitos e instalación

- Visual Studio 2022 (carga de trabajo ASP.NET)
- SQL Server o LocalDB
- .NET Framework 4.8

1. Clonar el repositorio.
2. En SSMS, ejecutar `scripts/RESTO_BAR_DB_v1.sql`.
3. Desde Etapa 2, ejecutar también `scripts/RESTO_BAR_DB_v2_etapa2.sql`.
4. En `resto-bar-web/Web.config`, configurar la instancia SQL:

```xml
<add key="cadenaConexion" value="Data Source=.\SQLEXPRESS;Initial Catalog=RESTO_BAR_DB;Integrated Security=True" />
```

4. Abrir `RestoBar_equipo-19.sln`, Restore NuGet y compilar (Rebuild).
5. Establecer `resto-bar-web` como proyecto de inicio y ejecutar (F5).

**Usuarios de prueba** (después del script): `gerente` / `mesero1` / `mesero2` — clave `123456`.

---

## Documentación

| Documento | Contenido |
|-----------|-----------|
| [docs/EQUIPO.md](docs/EQUIPO.md) | División de tareas, etapas del TPC, ramas Git |
| [docs/REFERENCIA.md](docs/REFERENCIA.md) | Pantallas, SP, tablas y Session |
| [docs/JIRA_EPIC2.md](docs/JIRA_EPIC2.md) | Tareas Jira Etapa 2 (3 ABM E2E) |

---

## Equipo 19

Marcelo Carabajal · Ferdinando Pedrini · Melanie Hernández
