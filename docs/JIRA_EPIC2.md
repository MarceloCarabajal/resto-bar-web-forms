# Jira — Epic 2: 3 ABM completos (Etapa 2)

Plantilla para cargar en Jira. El seguimiento (estados, subtareas hechas) va **solo en Jira**, no en este archivo.

Organización del equipo: [EQUIPO.md](EQUIPO.md)

**Orden de merge:** TipoInsumo → Insumos → Usuarios → QA

---

## Epic 2 — Etapa 2: ABM entidades administrables

**Objetivo:** cada integrante entrega un ABM de punta a punta (dominio + negocio + web + PR).

**Fuera de alcance:** login funcional, pedidos, asignación mesas, reportes.

---

## Tarea 2-M — ABM Insumos completo

**Assignee:** Marcelo  
**Rama:** `feature/etapa2-marcelo-abm-insumos`  
**Labels:** `marcelo`, `etapa2`, `abm`, `insumos`

**Sub-tasks sugeridas:**

- `InsumoNegocio.listar()` vía `sp_listar_insumos` (mapear `TipoInsumo`)
- `InsumoNegocio.obtener()` → `sp_obtener_insumo`
- `InsumoNegocio.agregar()` → `sp_agregar_insumo`
- `InsumoNegocio.modificar()` → `sp_modificar_insumo`
- `InsumoNegocio.inactivar()` → `sp_inactivar_insumo`
- `InsumoNegocio.listarTipos()` → `sp_listar_tipos_insumo`
- `InsumosLista.aspx` — botones editar / inactivar
- `InsumoForm.aspx` — alta y edición
- Validators ASP.NET en formulario
- Link "Insumos" en menú (Gerente)
- Compilar Debug + probar en local
- PR + revisión de Melanie y Ferdinando
- Demo ABM Insumos

---

## Tarea 2-F — ABM TipoInsumo completo

**Assignee:** Ferdinando  
**Rama:** `feature/etapa2-ferdinando-abm-tipo-insumo`  
**Labels:** `ferdinando`, `etapa2`, `abm`, `tipo-insumo`

**Sub-tasks sugeridas:**

- Ejecutar `scripts/RESTO_BAR_DB_v2_etapa2.sql` en SQL Server local
- Crear `TipoInsumoNegocio.cs` — listar, obtener, agregar, modificar, inactivar
- `TiposInsumoLista.aspx` + code-behind + designer
- `TipoInsumoForm.aspx` — alta y edición
- Validators (nombre obligatorio)
- Link "Tipos de insumo" en menú (Gerente)
- Compilar Debug + probar en local
- PR + revisión de Marcelo y Melanie
- Demo ABM TipoInsumo

**Dependencia:** mergear antes del ABM Insumos final (dropdown de tipos).

---

## Tarea 2-Me — ABM Usuarios completo

**Assignee:** Melanie  
**Rama:** `feature/etapa2-melanie-abm-usuarios`  
**Labels:** `melanie`, `etapa2`, `abm`, `usuarios`

**Sub-tasks sugeridas:**

- Ejecutar `scripts/RESTO_BAR_DB_v2_etapa2.sql` en SQL Server local
- Crear `UsuarioNegocio.cs` — listar, obtener, agregar, modificar, inactivar, listarRoles
- `UsuariosLista.aspx` + code-behind + designer
- `UsuarioForm.aspx` — rol (DropDownList), clave, activo
- Validators (user único, campos obligatorios)
- Link "Usuarios" en menú (Gerente)
- Compilar Debug + probar en local
- PR + revisión de Marcelo y Ferdinando
- Demo ABM Usuarios

**Nota Etapa 3:** extender `UsuarioNegocio` con `login()` — no reescribir desde cero.

---

## Tarea 2-QA — Cierre Etapa 2

**Assignee:** todos  
**Labels:** `etapa2`, `qa`

**Sub-tasks sugeridas:**

- Los 3 integrantes ejecutaron v1 + v2 SQL
- ABM Insumos OK en 3 PCs
- ABM TipoInsumo OK en 3 PCs
- ABM Usuarios OK en 3 PCs
- Gerente navega: Insumos → Tipos → Usuarios
- Demo Etapa 2 en clase

---

## Columnas sugeridas del board

`Por hacer` → `En curso` → `En revisión (PR)` → `Finalizado`

## Definition of Done (cada ABM)

- Compila en Debug
- Dueño tocó dominio, negocio y web de su entidad
- PR revisado por los otros dos
- Mergeado a `master`
- Demo breve en sync semanal
