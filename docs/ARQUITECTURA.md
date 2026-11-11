# Arquitectura V1

## Componentes
1. Central: React + Vite, Node.js + Express y MySQL 8 en servidor externo.
2. Sucursal: React + Vite, Node.js + Express y MySQL 8 en servidor Windows local.
3. Deployment: PowerShell para instalar prerrequisitos, configurar MySQL, desplegar la aplicación y registrar servicios Windows.

## Reglas
- Frontend -> API -> base de datos.
- Central y sucursal nunca comparten conexión SQL.
- Las operaciones locales se confirman primero en la base local.
- Cada evento posee `event_id` UUID, `branch_id`, `event_type`, `entity_id`, `occurred_at` y `payload`.
- Central registra `event_id` con restricción única para evitar duplicados.
- Las respuestas de sincronización confirman eventos aceptados; solo entonces se marcan como sincronizados.
- Las actualizaciones centrales se entregan a la sucursal mediante cursor/checkpoint.
- Stock se calcula a partir de movimientos; no se sobrescribe desde una venta sincronizada.
- Los conflictos se registran para resolución explícita; no se aplica último-escritor-gana a ventas.

## Seguridad mínima
HTTPS para Central, autenticación de dispositivo/sucursal, secretos fuera del repositorio, validación de payloads, logs de auditoría y firewall limitado a los puertos necesarios.
