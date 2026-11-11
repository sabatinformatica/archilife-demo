# Modelo de datos inicial

Entidades principales:
- `branches`: sucursales.
- `products`: catálogo maestro y precio vigente.
- `customers`: clientes.
- `branch_stock`: existencia por sucursal (proyección local).
- `sales`: cabecera de venta.
- `sale_items`: líneas de venta.
- `payments`: medios e importes de pago.
- `stock_movements`: entradas, salidas y ajustes.
- `sync_outbox`: eventos locales pendientes de enviar.
- `sync_inbox`: eventos recibidos/procesados, con `event_id` único.
- `sync_checkpoints`: cursor de recepción desde Central.
- `audit_log`: acciones relevantes.

Los identificadores de entidades distribuidas serán UUID. Importes monetarios se almacenarán como DECIMAL, nunca FLOAT.
