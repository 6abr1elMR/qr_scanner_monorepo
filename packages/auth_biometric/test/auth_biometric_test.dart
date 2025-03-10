import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:local_auth/local_auth.dart';
import 'package:auth_biometric/auth_biometric.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([LocalAuthentication])
import 'auth_biometric_test.mocks.dart';

class TestAuthBiometric extends AuthBiometric {
  final LocalAuthentication localAuth;
  TestAuthBiometric(this.localAuth);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockLocalAuthentication mockLocalAuth;
  late TestAuthBiometric authBiometric;

  setUp(() {
    mockLocalAuth = MockLocalAuthentication();
    authBiometric = TestAuthBiometric(mockLocalAuth);

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/local_auth'),
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'getAvailableBiometrics':
            return [
              'fingerprint'
            ]; // ✅ Devuelve String para el canal de plataforma
          case 'isDeviceSupported':
            return true;
          case 'canCheckBiometrics':
            return true;
          case 'authenticate':
            return true;
          default:
            return null;
        }
      },
    );
  });

  test('Debe retornar true si la biometría está disponible', () async {
    when(mockLocalAuth.canCheckBiometrics).thenAnswer((_) async => true);
    when(mockLocalAuth.isDeviceSupported()).thenAnswer((_) async => true);
    when(mockLocalAuth.getAvailableBiometrics()).thenAnswer((_) async =>
        [BiometricType.fingerprint]);

    final result = await authBiometric.isBiometricAvailable();
    expect(result, isTrue);
  });

  test('Debe retornar false si la biometría no está disponible', () async {
    when(mockLocalAuth.canCheckBiometrics).thenAnswer((_) async => false);
    when(mockLocalAuth.isDeviceSupported()).thenAnswer((_) async => false);
    when(mockLocalAuth.getAvailableBiometrics()).thenAnswer((_) async => []);

    final result = await authBiometric.isBiometricAvailable();
    expect(result, isFalse);
  });

  test('Debe autenticar correctamente cuando el usuario usa biometría',
      () async {
    when(mockLocalAuth.authenticate(
      localizedReason: anyNamed("localizedReason"),
      options: anyNamed("options"),
    )).thenAnswer((_) async => true);

    final result = await authBiometric.authenticate();
    expect(result, isTrue);
  });

  test('Debe fallar autenticación cuando el usuario cancela', () async {
    when(mockLocalAuth.authenticate(
      localizedReason: anyNamed("localizedReason"),
      options: anyNamed("options"),
    )).thenAnswer((_) async => false);

    final result = await authBiometric.authenticate();
    expect(result, isFalse);
  });

  test('Debe manejar errores y retornar false si ocurre una excepción',
      () async {
    when(mockLocalAuth.authenticate(
      localizedReason: anyNamed("localizedReason"),
      options: anyNamed("options"),
    )).thenThrow(Exception("Error de autenticación"));

    final result = await authBiometric.authenticate();
    expect(result, isFalse);
  });
}
