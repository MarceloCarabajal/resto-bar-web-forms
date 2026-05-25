# Referencia técnica — Resto BAR

Consultar al programar. Organización del equipo: [EQUIPO.md](EQUIPO.md).

---

## Solución

| Proyecto | Contenido |
|----------|-----------|
| `resto-bar-web` | ASPX, Master Page, Session |
| `negocio` | `AccesoDatos` + clases `*Negocio` + llamadas a SP |
| `dominio` | Entidades |
| `scripts/` | `RESTO_BAR_DB_v1.sql` |

**Regla:** la UI no usa `SqlConnection` directo.

**Conexión** (`Web.config`):

```xml
<add key="cadenaConexion" value="Data Source=.\SQLEXPRESS;Initial Catalog=RESTO_BAR_DB;Integrated Security=True" />
```

---

## Usuarios de prueba (SQL)

| Usuario | Clave | Rol |
|---------|-------|-----|
| gerente | 123456 | Gerente |
| mesero1 | 123456 | Mesero (mesas 1–4) |
| mesero2 | 123456 | Mesero (mesas 5–8) |

---

## Tablas principales

| Tabla | Uso |
|-------|-----|
| Usuarios / Roles | Login |
| Insumos / TiposInsumo | Platos y bebidas + stock |
| Mesas / AsignacionesMesa | Mesero por mesa (vigente = hoy) |
| Pedidos / PedidoDetalle | Abierto/Cerrado, ítems, total |

---

## Pantallas → etapa

| Página | Rol | Etapa | SP principales |
|--------|-----|-------|----------------|
| Login.aspx | — | 3 | `sp_login` |
| InsumosLista.aspx | Gerente | 1–2 | `sp_listar_insumos` |
| InsumoForm.aspx | Gerente | 2 | `sp_agregar/modificar/inactivar_insumo` |
| MesasAsignacion.aspx | Gerente | 3 | `sp_asignar_mesa_mesero` |
| MesasPedidos.aspx | Ambos | 3 | `sp_listar_mesas_asignadas` |
| PedidoDetalle.aspx | Ambos | 3 | `sp_abrir/cerrar_pedido`, `sp_agregar_detalle_pedido` |
| Reportes.aspx | Gerente | Final | `sp_reporte_pedidos_por_mesa/mesero` |

---

## Session (después del login, Etapa 3)

| Clave | Uso |
|-------|-----|
| `usuario` | Objeto `Usuario` |
| `IdUsuario` | Filtro mesero |
| `Rol` | `Gerente` / `Mesero` |

---

## Clases de negocio (a crear)

| Clase | Etapa |
|-------|-------|
| `InsumoNegocio` | 1–2 |
| `UsuarioNegocio` + `Seguridad` | 3 |
| `MesaNegocio` | 3 |
| `PedidoNegocio` | 3 |
| `ReporteNegocio` | Final |

Patrón: copiar de `PokemonNegocio` / `AccesoDatos` en [ejemplos-asp-webforms](https://github.com/msarfernandez/ejemplos-asp-webforms).

---

## Stored procedures (lista)

**Insumos:** `sp_listar_insumos`, `sp_obtener_insumo`, `sp_agregar_insumo`, `sp_modificar_insumo`, `sp_inactivar_insumo`, `sp_listar_tipos_insumo`

**Mesas:** `sp_listar_mesas`, `sp_listar_meseros`, `sp_asignar_mesa_mesero`, `sp_listar_mesas_asignadas`

**Pedidos:** `sp_abrir_pedido`, `sp_cerrar_pedido`, `sp_agregar_detalle_pedido`, `sp_listar_detalle_pedido`

**Auth:** `sp_login`

**Reportes:** `sp_reporte_pedidos_por_mesa`, `sp_reporte_pedidos_por_mesero`

Definición completa: `scripts/RESTO_BAR_DB_v1.sql`
