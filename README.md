# QR Auth App - Monorepo

Este es un monorepo que contiene la aplicación principal y dos paquetes independientes:

- `auth_biometric`: Manejo de autenticación biométrica.
- `qr_scanner`: Escaneo de códigos QR.

## Estructura del Proyecto

```
monorepo/
│-- apps/
│   ├── qr_auth_app/          # Aplicación principal
│-- packages/
│   ├── auth_biometric/       # Paquete para autenticación biométrica
│   ├── qr_scanner/           # Paquete para escaneo de códigos QR
│-- README.md                 # Documentación
│-- pubspec.yaml               # Configuración del monorepo
```

## Instalación

### Requisitos previos

1. Tener instalado [Flutter](https://flutter.dev/docs/get-started/install).
2. Asegurar que Dart esté correctamente configurado.
3. Agregar las dependencias en `pubspec.yaml` de la app principal.

### Clonar el repositorio
```sh
git clone <URL_DEL_REPOSITORIO>
cd monorepo
```

### Instalar dependencias
```sh
flutter pub get
```

## Ejecutar la aplicación

Dentro del directorio de la aplicación principal (`apps/qr_auth_app`):

```sh
cd apps/qr_auth_app
flutter run
```

## Uso de los paquetes

### `auth_biometric`

```dart
import 'package:auth_biometric/auth_biometric.dart';

final auth = AuthBiometric();
bool isAuthenticated = await auth.authenticate();
```

### `qr_scanner`

```dart
import 'package:qr_scanner/qr_scanner.dart';

QRScannerView(
  onScanned: (String result) {
    print("Código escaneado: $result");
  },
)
```

## Scripts Útiles

### Limpiar y reconstruir dependencias
```sh
flutter clean && flutter pub get
```

### Analizar el código
```sh
flutter analyze
```

## Contribuciones

1. Crea un branch con la nueva funcionalidad o corrección de bug.
2. Realiza los cambios y confirma los commits.
3. Abre un Pull Request.

## Licencia
Este proyecto está bajo la licencia MIT.
