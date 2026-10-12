# Operaciones y publicación
Android: Flutter test/analyze -> AAB release -> firma con keystore en CI secrets -> fastlane supply -> Play Internal Testing -> validación -> promoción aprobada. Primera configuración manual: app Play, cuenta desarrollador, API, política de privacidad, fichas, Data Safety, permisos y revisión. No prometer publicación sin aprobaciones.
Windows: `flutter build windows --release` desde Windows con toolchain Visual Studio C++; empaquetado/firmado definido en E3.
iOS: runner macOS/Xcode -> `flutter build ipa` -> fastlane pilot/TestFlight -> revisión y App Store; Apple Developer Program, API keys, perfiles y certificados protegidos. iOS se implementa en E4.
HTTPS: DNS público, Caddy con almacenamiento persistente, puertos 80/443 o desafío DNS-01 configurado; renovación ACME automática y alarmas por expiración; Go escucha solo loopback/red privada. No publicar contraseña SIP ni token en trazas.
CI: GitHub Actions inicialmente, con workflow mínimo de lint/test en cada repositorio y builds de release añadidos por etapa. Tags inmutables, secretos de CI y aprobación humana para promoción a producción.
