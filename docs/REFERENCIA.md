# Referencia técnica — Resto BAR

Consultar al programar. Organización del equipo: [EQUIPO.md](EQUIPO.md).

---

## Solución

| Proyecto | Contenido |
|----------|-----------|
| `resto-bar-web` | ASPX, Master Page, Session |
| `negocio` | `AccesoDatos` + clases `*Negocio` + llamadas a SP |
| `dominio` | Entidades |
| `scripts/` | `RESTO_BAR_DB_v1.sql`, `RESTO_BAR_DB_v2_etapa2.sql` |

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
| Usuarios / Roles | Login + ABM usuarios (Etapa 2) |
| Insumos / TiposInsumo | Platos y bebidas + stock + ABM tipos (Etapa 2) |
| Mesas / AsignacionesMesa | Mesero por mesa (vigente = hoy) |
| Pedidos / PedidoDetalle | Abierto/Cerrado, ítems, total |

---

## Pantallas → etapa

| Página | Rol | Etapa | Dueño | SP principales |
|--------|-----|-------|-------|----------------|
| Login.aspx | — | 3 | Melanie | `sp_login` |
| InsumosLista.aspx | Gerente | 1–2 | Marcelo | `sp_listar_insumos` |
| InsumoForm.aspx | Gerente | 2 | Marcelo | `sp_agregar/modificar/inactivar_insumo` |
| TiposInsumoLista.aspx | Gerente | 2 | Ferdinando | `sp_listar_tipos_insumo` |
| TipoInsumoForm.aspx | Gerente | 2 | Ferdinando | `sp_agregar/modificar/inactivar_tipo_insumo` |
| UsuariosLista.aspx | Gerente | 2 | Melanie | `sp_listar_usuarios` |
| UsuarioForm.aspx | Gerente | 2 | Melanie | `sp_agregar/modificar/inactivar_usuario` |
| MesasAsignacion.aspx | Gerente | 3 | Marcelo | `sp_asignar_mesa_mesero` |
| MesasPedidos.aspx | Ambos | 3 | Ferdinando | `sp_listar_mesas_asignadas` |
| PedidoDetalle.aspx | Ambos | 3 | Ferdinando | `sp_abrir/cerrar_pedido`, `sp_agregar_detalle_pedido` |
| Reportes.aspx | Gerente | Final | Marcelo | `sp_reporte_pedidos_por_mesa/mesero` |

---

## Dominio — composición (post Etapa 1B)

| Clase | Composición |
|-------|-------------|
| `Insumo` | `TipoInsumo Tipo` |
| `Pedido` | `List<ItemPedido> Items` |
| `ItemPedido` | `Insumo Insumo` |
| `Usuario` | `Rol Rol` |

`Elemento.cs` sigue para DropDownList genéricos si hace falta.

---

## Session (después del login, Etapa 3)

| Clave | Uso |
|-------|-----|
| `usuario` | Objeto `Usuario` |
| `IdUsuario` | Filtro mesero |
| `Rol` | `Gerente` / `Mesero` |

---

## Clases de negocio

| Clase | Etapa | Dueño |
|-------|-------|-------|
| `InsumoNegocio` | 1–2 | Marcelo |
| `TipoInsumoNegocio` | 2 | Ferdinando |
| `UsuarioNegocio` | 2–3 | Melanie |
| `Seguridad` | 3 | Melanie |
| `MesaNegocio` | 3 | Marcelo |
| `PedidoNegocio` | 3 | Ferdinando |
| `ReporteNegocio` | Final | Marcelo |

Patrón: copiar de `PokemonNegocio` / `AccesoDatos` en [ejemplos-asp-webforms](https://github.com/msarfernandez/ejemplos-asp-webforms).

---

## Stored procedures (lista)

**Insumos:** `sp_listar_insumos`, `sp_obtener_insumo`, `sp_agregar_insumo`, `sp_modificar_insumo`, `sp_inactivar_insumo`, `sp_listar_tipos_insumo`

**Tipos de insumo (v2):** `sp_listar_tipos_insumo`, `sp_obtener_tipo_insumo`, `sp_agregar_tipo_insumo`, `sp_modificar_tipo_insumo`, `sp_inactivar_tipo_insumo`

**Usuarios (v2):** `sp_listar_usuarios`, `sp_obtener_usuario`, `sp_agregar_usuario`, `sp_modificar_usuario`, `sp_inactivar_usuario`, `sp_listar_roles`

**Mesas:** `sp_listar_mesas`, `sp_listar_meseros`, `sp_asignar_mesa_mesero`, `sp_listar_mesas_asignadas`

**Pedidos:** `sp_abrir_pedido`, `sp_cerrar_pedido`, `sp_agregar_detalle_pedido`, `sp_listar_detalle_pedido`

**Auth:** `sp_login`

**Reportes:** `sp_reporte_pedidos_por_mesa`, `sp_reporte_pedidos_por_mesero`

Scripts: `scripts/RESTO_BAR_DB_v1.sql` (base) + `scripts/RESTO_BAR_DB_v2_etapa2.sql` (ABM tipos y usuarios)
