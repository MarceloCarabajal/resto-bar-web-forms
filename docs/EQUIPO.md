# Organización — Equipo 19

**Integrantes:** Marcelo · Ferdinando · Melanie

---

## Reglas (3 líneas)

1. En cada etapa los **tres** programamos en `dominio`, `negocio` y `resto-bar-web` (mínimo un archivo por capa).
2. Cada bloque tiene un **coordinador** (integra el PR); no es el único que codea.
3. `main` siempre tiene que **compilar** antes del merge.

**Ramas:** `feature/etapa{N}-{nombre}-{tema}` → PR → revisión de los otros dos → merge.

---

## Tablero — quién lidera qué

Marcar con ✅ en el grupo cuando esté mergeado a `main`.

### Etapa 1 — Dominio, SQL, maquetado, 1 listado BD

| | Marcelo | Melanie | Ferdinando |
|---|---------|---------|------------|
| **Lidera** | Dominio + SQL + AccesoDatos | `InsumosLista` + GridView | Páginas shell + menú |
| **Rama** | `feature/etapa1-marcelo-dominio-acceso` | `feature/etapa1-melanie-listado-insumos` | `feature/etapa1-ferdinando-maquetado` |
| **Estado** | ☐ | ☐ | ☐ |

**Merge:** Marcelo → Melanie → Ferdinando (Ferdinando puede ir en paralelo con Melanie).

**Cerrada cuando:** compila, SQL ejecutado en los 3 PCs, se listan insumos desde BD, se navega entre páginas.

---

### Etapa 2 — ABM Insumos (sin pedidos)

| | Marcelo | Melanie | Ferdinando |
|---|---------|---------|------------|
| **Lidera** | `InsumoNegocio` CRUD | Editar / inactivar UI | `InsumoForm` alta + validators |
| **Rama** | `feature/etapa2-marcelo-insumo-negocio` | `feature/etapa2-melanie-insumo-editar` | `feature/etapa2-ferdinando-insumo-alta` |
| **Estado** | ☐ | ☐ | ☐ |

**No hacer aún:** pedidos, asignación mesas, login, reportes.

---

### Etapa 3 — Login, mesas, pedidos

| | Marcelo | Melanie | Ferdinando |
|---|---------|---------|------------|
| **Lidera** | Asignación mesas | Login + roles + Session | Pedidos abrir/cerrar |
| **Rama** | `feature/etapa3-marcelo-asignacion` | `feature/etapa3-melanie-login` | `feature/etapa3-ferdinando-pedidos` |
| **Estado** | ☐ | ☐ | ☐ |

---

### Etapa final — Reportes y cierre

| | Marcelo | Melanie | Ferdinando |
|---|---------|---------|------------|
| **Lidera** | Reportes | Pruebas roles + Bootstrap | Validators en todos los forms |
| **Rama** | `feature/final-marcelo-reportes` | `feature/final-melanie-ui-roles` | `feature/final-ferdinando-validaciones` |
| **Estado** | ☐ | ☐ | ☐ |

---

## Qué pide el TPC (resumen)

| Etapa | Entrega oficial | En Resto BAR |
|-------|-----------------|--------------|
| **1** | Clases + pantallas + navegación + **1 lectura BD** | Dominio, Master, shells, listado insumos |
| **2** | ABM entidades administrables, **sin** núcleo | Solo ABM insumos |
| **3** | Funcionalidad central + validaciones | Login, asignación, pedidos |
| **Final** | Todo cerrado + perfiles + diseño | Reportes + validar todo + UI |

---

## Etapa 1 — Detalle por integrante

### Marcelo
- [x] `dominio/` (entidades)
- [x] `negocio/AccesoDatos.cs`
- [x] `scripts/RESTO_BAR_DB_v1.sql`
- [x] Proyectos en `.sln` + `Web.config` (`cadenaConexion`)

### Melanie
- [ ] `InsumoNegocio.Listar()`
- [ ] `InsumosLista.aspx` + `GridView` (`sp_listar_insumos`)
- [ ] Referencia `negocio` → `dominio` en `.csproj`

### Ferdinando
- [ ] `Login.aspx`, `MesasPedidos.aspx`, `Reportes.aspx` (vacías)
- [ ] Links en `MasterPage.Master`
- [ ] Navegación entre páginas

**Todos:** ejecutar el script SQL en tu SQL Server local.

---

## Antes de cada PR

- [ ] Compilé en Debug
- [ ] Trabajé en mi rama `feature/...`
- [ ] Tocé dominio, negocio y web (aunque sea poco)
- [ ] Avisé si modifiqué `.sln`, `Web.config` o `MasterPage.Master`

---

## 1ª reunión (30 min)

1. Confirmar tablero Etapa 1 y quién abre cada rama hoy.
2. Ejecutar `scripts/RESTO_BAR_DB_v1.sql` juntos (o compartir instancia).
3. Probar login de prueba: `gerente` / `123456` (cuando exista Login).
4. Acordar día de sync semanal y canal (WhatsApp / Discord).

---

## Setup rápido (nuevo en el repo)

```
git pull origin main
→ Ejecutar scripts/RESTO_BAR_DB_v1.sql
→ Abrir RestoBar_equipo-19.sln
→ Ajustar cadenaConexion en Web.config
→ Compilar
```

Detalle técnico: [REFERENCIA.md](REFERENCIA.md)
