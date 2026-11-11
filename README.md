# ArchiLife Demo – V1

Prototipo funcional de una plataforma web distribuida para farmacia.

## Repositorios
- `archilife-demo-central`: administración central (React + Node/Express + MySQL).
- `archilife-demo-branch`: operación de sucursal local (React + Node/Express + MySQL).
- `archilife-demo-deployment`: instalación y configuración de la sucursal en Windows.

## Arquitectura
- El navegador accede al frontend React servido por el backend local.
- React consume exclusivamente la API Node/Express; nunca accede directamente a MySQL.
- Cada sucursal conserva su propia base MySQL y puede registrar ventas sin Internet.
- La sincronización es asíncrona, basada en eventos con UUID, reintentos e idempotencia.
- Central publica maestros (productos/precios); las sucursales envían ventas y movimientos.
- No se sincronizan tablas completas ni se comparte acceso directo a las bases de datos.

## Alcance de demostración
Productos, clientes, stock, ventas, pagos, movimientos de inventario, comprobante no fiscal, dashboard y sincronización.

## Fuera de alcance V1
DGI/CFE fiscal, recetas, dispensación clínica, integración con proveedores, permisos avanzados y SaaS multiempresa.

Ver `docs/` para arquitectura, modelo de datos y flujo de demo.
