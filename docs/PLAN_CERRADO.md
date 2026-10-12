# Plan cerrado — MI IPRED Phone
## Alcance contractual
Producto gratuito, componentes de código 100% open source (validar licencias y compatibilidad antes de integrar), Asterisk PJSIP/SIP por defecto; IAX2 diferido y no comprometido. Flutter Android, Windows desktop e iOS; backend Go independiente y nuevo, alojado en Linux. Go presta identidad, autorización, dispositivos y provisioning por HTTPS; SIP y medios van directamente al entorno Asterisk, nunca se retransmiten por el API Go. No compartir credenciales SIP en logs ni repositorio. Multicuenta, contactos del dispositivo y agenda propia, dialer, historial, entrantes/salientes. Grabación local y backup remoto son opcionales.

## Etapas y puertas de aceptación (4 + opcional)
### E1 — Prueba de viabilidad SIP (1 entrega integrada)
- Crear Flutter base y configuración local de desarrollo **sin secretos versionados**.
- Validar compatibilidad real de `sip_ua`/`flutter_webrtc` en Android **y Windows**, versiones y licencias; registrar contra Asterisk PJSIP, llamada entrante con app en primer plano, saliente, audio bidireccional, colgar, mute, altavoz, DTMF, estado de registro y errores de red.
- Gate: evidencias reproducibles Android y Windows; si un plugin falla en Windows, documentar alternativa OSS nativa (p.ej. liblinphone/PJSIP con evaluación de GPL) y replanificar explícitamente antes de avanzar. No prometer soporte de escritorio sin prueba.
### E2 — Backend Go nuevo y provisioning seguro (1 entrega integrada)
- `go.mod`, API y migraciones, usuarios, sesiones/tokens revocables, dispositivos, asignación de líneas, provisioning, logout, pruebas y documentación OpenAPI.
- Contrato inicial: POST /v1/auth/login; POST /v1/auth/refresh; POST /v1/auth/logout; GET /v1/telephony/accounts; POST /v1/devices; DELETE /v1/devices/{id}. Ajustar en ADR si se requiere.
- HTTPS obligatorio con Caddy + ACME Let's Encrypt, renovación desatendida, almacenamiento persistente de Caddy, DNS y puertos/ACME documentados; validar reinicio y renovación en staging. SIP sobre TLS/SRTP y WebRTC/WSS se diseñan aparte: HTTPS del API no cifra por sí solo las llamadas.
- Gate: login persistente en almacenamiento seguro, revocación y carga automática de cuentas sin claves hardcodeadas, pruebas API y TLS.
### E3 — Producto usable + Android/Windows (1 entrega integrada)
- Dialer, entrantes/salientes, selector multicuenta, contactos del teléfono con consentimiento, agenda local separada, favoritos, historial local, UX/errores/permisos, audio routing y pruebas de regresión.
- Windows desktop: build firmado/distribuible cuando sea posible, permisos/audio y notificaciones; no asumir que los plugins móviles soportan Windows.
- CI: tests, análisis, builds Android AAB y Windows, firma Android, fastlane/Google Play Developer API, secretos CI, track internal testing y promoción manual aprobada a producción. Metadata, privacidad, capturas, Data Safety, políticas de llamadas/permisos y requisitos vigentes de Google Play son gates de publicación.
- Gate: builds reproducibles, pruebas reales de audio Android/Windows, Play Internal Testing.
### E4 — Recepción móvil en segundo plano + iOS al final (1 entrega integrada)
- Diseñar e implementar gateway de señalización de llamada y push (FCM/APNs), sin asumir que un push genérico garantiza despertar SIP. Integración Android Telecom/foreground services conforme política vigente; iOS PushKit/CallKit y reglas Apple; Asterisk/PJSIP y proxy/push según arquitectura validada.
- Pruebas con pantalla bloqueada, app suspendida, red Wi-Fi/celular, reconexión, batería, NAT, llamadas perdidas y cancelación de llamadas.
- Compilación iOS solo con macOS/Xcode; CI runner macOS, firma/provisioning, App Store Connect API, TestFlight, revisión y publicación. Costos obligatorios de cuentas de desarrollador Apple/Google y runners/infraestructura son externos a licencias de SDK.
- Gate: llamadas entrantes confiables bajo escenarios acordados Android/iOS y publicación TestFlight; App Store depende de revisión externa.
### E5 — Opcionales (NO bloquean cierre)
Grabación local de ambos canales si la pila permite captura y se valida consentimiento/ley aplicable; backup remoto cifrado de agenda; IAX2; transferencia, hold, conferencias. Cada uno requiere aprobación de alcance.

## Reglas de ejecución
- Máximo una entrega integrada por etapa; correcciones necesarias dentro de la misma etapa no cuentan como cambio de alcance.
- No adelantar funcionalidades; no marcar PASS sin ejecución/evidencia. Un gate fallido bloquea la etapa siguiente.
- Backend y frontend son repositorios distintos; ZIP de iteración contendrá `backend/` y `frontend/`, únicamente archivos intervenidos, con manifest de cambios y tests; el primer ZIP es excepcionalmente un scaffold completo.
- Toda decisión y hallazgo se registra en docs/decisions y handoff. Antes de editar: leer reglas, docs y código actual de ambos ZIP provistos por el usuario; son la fuente de verdad.
- Seguridad: sin contraseñas SIP en logs, TLS, tokens cortos/refresh rotativo, almacenamiento seguro, control de dispositivos, mínimo privilegio y política de retención de datos.
