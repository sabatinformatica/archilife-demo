# Deployment de sucursal

El script `scripts/install.ps1` es el punto de entrada previsto para instalación elevada en Windows.

**Estado:** es un esqueleto de instalación, no un instalador productivo. Todavía no descarga ni instala MySQL/Node, no registra servicios NSSM y no publica el frontend. Esas tareas se implementarán y probarán en el siguiente incremento con versiones fijadas, checksums y manejo seguro de credenciales.
