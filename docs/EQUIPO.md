# Organización — Equipo 19

**Integrantes:** Marcelo · Ferdinando · Melanie

---

## Reglas de trabajo

1. **Dueño del bloque** = hace dominio + negocio + web + SQL (si aplica) de **su** módulo y abre el PR.
2. Los otros **dos revisan** el PR antes del merge.
3. Cada entrega debe **compilar y demostrarse** antes de mergear a `master`.
4. `master` siempre tiene que **compilar** antes del merge.

**Ramas:** `feature/etapa{N}-{nombre}-{tema}` → PR → revisión de los otros dos → merge.

**Orden de merge Etapa 2:** TipoInsumo → Insumos → Usuarios (dropdown de tipos).

---

## Tablero — quién lidera qué

Marcar con ✅ en el grupo cuando esté mergeado a `master`.

### Etapa 1 — Dominio, SQL, maquetado, 1 listado BD ✅

| | Marcelo | Melanie | Ferdinando |
|---|---------|---------|------------|
| **Lidera** | Dominio + SQL + AccesoDatos | `InsumosLista` + GridView | Páginas shell + menú |
| **Estado** | ✅ | ✅ | ✅ |

**Cerrada cuando:** compila, SQL ejecutado en los 3 PCs, se listan insumos desde BD, se navega entre páginas.

---

### Etapa 1B — Refactor dominio (feedback profesor)

| | Marcelo | Ferdinando | Melanie |
|---|---------|------------|---------|
| **Lidera** | Clases dominio composición | `InsumoNegocio` + GridView | Documentación |
| **Estado** | ☐ | ☐ | ☐ |

Composición: `Insumo.TipoInsumo`, `Pedido.Items`, `Usuario.Rol`, `ItemPedido` (sin `PedidoDetalle.cs`).

---

### Etapa 2 — 3 ABM completos (uno por integrante)

Cada integrante entrega **un ABM de punta a punta**: dominio → `*Negocio` → Lista + Form → validators → PR → demo.

| | Marcelo | Ferdinando | Melanie |
|---|---------|------------|---------|
| **ABM** | **Insumos** | **TipoInsumo** | **Usuarios** |
| **Negocio** | `InsumoNegocio` | `TipoInsumoNegocio` | `UsuarioNegocio` |
| **Pantallas** | `InsumosLista` + `InsumoForm` | `TiposInsumoLista` + `TipoInsumoForm` | `UsuariosLista` + `UsuarioForm` |
| **SQL** | SPs en v1 (ya existen) | `scripts/RESTO_BAR_DB_v2_etapa2.sql` | `scripts/RESTO_BAR_DB_v2_etapa2.sql` |
| **Rama** | `feature/etapa2-marcelo-abm-insumos` | `feature/etapa2-ferdinando-abm-tipo-insumo` | `feature/etapa2-melanie-abm-usuarios` |
| **Estado** | ☐ | ☐ | ☐ |

**No hacer aún:** pedidos, asignación mesas, login funcional, reportes.

**Cerrada cuando:** los 3 ABM funcionan en los 3 PCs; gerente navega Insumos, Tipos de insumo y Usuarios.

Detalle Jira: [JIRA_EPIC2.md](JIRA_EPIC2.md)

---

### Etapa 3 — Módulos verticales (punta a punta)

| | Marcelo | Melanie | Ferdinando |
|---|---------|---------|------------|
| **Lidera** | Asignación mesas | Login + Session + roles | Pedidos abrir/cerrar |
| **Pantallas** | `MesasAsignacion.aspx` | `Login.aspx` + protección | `MesasPedidos.aspx` + `PedidoDetalle.aspx` |
| **Rama** | `feature/etapa3-marcelo-asignacion` | `feature/etapa3-melanie-login` | `feature/etapa3-ferdinando-pedidos` |
| **Estado** | ☐ | ☐ | ☐ |

Melanie extiende `UsuarioNegocio` (Etapa 2) con `login()` — no empieza de cero.

---

### Etapa final — 2 módulos por integrante

| | Marcelo | Melanie | Ferdinando |
|---|---------|---------|------------|
| **Lidera** | Reportes | Menú dinámico + UI Bootstrap | Validators en todos los forms |
| **Rama** | `feature/final-marcelo-reportes` | `feature/final-melanie-ui-roles` | `feature/final-ferdinando-validaciones` |
| **Estado** | ☐ | ☐ | ☐ |

---

## Qué pide el TPC (resumen)

| Etapa | Entrega oficial | En Resto BAR |
|-------|-----------------|--------------|
| **1** | Clases + pantallas + navegación + **1 lectura BD** | Dominio, Master, shells, listado insumos |
| **2** | ABM entidades administrables, **sin** núcleo | ABM Insumos + TipoInsumo + Usuarios (1 c/u) |
| **3** | Funcionalidad central + validaciones | Login, asignación, pedidos |
| **Final** | Todo cerrado + perfiles + diseño | Reportes + validar todo + UI |

---

## Etapa 2 — Checklist por ABM

### Marcelo — ABM Insumos
- [ ] `InsumoNegocio`: listar, obtener, agregar, modificar, inactivar, listarTipos (SP)
- [ ] `InsumosLista.aspx` — editar / inactivar
- [ ] `InsumoForm.aspx` — alta y edición + validators
- [ ] Link en menú (Gerente)
- [ ] PR + demo

### Ferdinando — ABM TipoInsumo
- [ ] Ejecutar `RESTO_BAR_DB_v2_etapa2.sql` (SPs tipos)
- [ ] `TipoInsumoNegocio` — CRUD completo
- [ ] `TiposInsumoLista.aspx` + `TipoInsumoForm.aspx` + validators
- [ ] Link en menú (Gerente)
- [ ] PR + demo

### Melanie — ABM Usuarios
- [ ] Ejecutar `RESTO_BAR_DB_v2_etapa2.sql` (SPs usuarios)
- [ ] `UsuarioNegocio` — listar, obtener, agregar, modificar, inactivar, listarRoles
- [ ] `UsuariosLista.aspx` + `UsuarioForm.aspx` + validators
- [ ] Link en menú (Gerente)
- [ ] PR + demo

---

## Antes de cada PR

- [ ] Compilé en Debug
- [ ] Trabajé en mi rama `feature/...`
- [ ] Mi ABM/módulo funciona de punta a punta
- [ ] Avisé si modifiqué `.sln`, `Web.config` o `MasterPage.Master`

---

## Setup rápido (nuevo en el repo)

```
git pull origin master
→ Ejecutar scripts/RESTO_BAR_DB_v1.sql
→ Ejecutar scripts/RESTO_BAR_DB_v2_etapa2.sql (desde Etapa 2)
→ Abrir RestoBar_equipo-19.sln
→ Ajustar cadenaConexion en Web.config
→ Restore NuGet + Rebuild
```

Detalle técnico: [REFERENCIA.md](REFERENCIA.md)
