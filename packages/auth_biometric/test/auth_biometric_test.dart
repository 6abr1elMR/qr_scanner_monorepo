import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:local_auth/local_auth.dart';
import 'package:auth_biometric/auth_biometric.dart';

class MockLocalAuthentication extends Mock implements LocalAuthentication {}

void main() {
  late MockLocalAuthentication mockLocalAuth;
  late AuthBiometric authBiometric;

  setUp(() {
    mockLocalAuth = MockLocalAuthentication();
    authBiometric = AuthBiometric();
  });

  test('Debe retornar true si la biometría está disponible', () async {
    when(mockLocalAuth.canCheckBiometrics).thenAnswer((_) async => true);
    when(mockLocalAuth.isDeviceSupported()).thenAnswer((_) async => true);

    final result = await authBiometric.isBiometricAvailable();
    expect(result, true);
  });

  test('Debe retornar false si la biometría no está disponible', () async {
    when(mockLocalAuth.canCheckBiometrics).thenAnswer((_) async => false);
    when(mockLocalAuth.isDeviceSupported()).thenAnswer((_) async => false);

    final result = await authBiometric.isBiometricAvailable();
    expect(result, false);
  });

  test('Debe autenticar correctamente cuando el usuario usa biometría',
      () async {
    when(mockLocalAuth.authenticate(
      localizedReason: "Autenticación requerida",
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    )).thenAnswer((_) async => true);

    final result = await authBiometric.authenticate();
    expect(result, true);
  });

  test('Debe fallar autenticación cuando el usuario cancela', () async {
    when(mockLocalAuth.authenticate(
      localizedReason: "Autenticación requerida",
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    )).thenAnswer((_) async => false);

    final result = await authBiometric.authenticate();
    expect(result, false);
  });

  test('Debe manejar errores y retornar false si ocurre una excepción',
      () async {
    when(mockLocalAuth.authenticate(
      localizedReason: "Autenticación requerida",
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    )).thenThrow(Exception("Error de autenticación"));

    final result = await authBiometric.authenticate();
    expect(result, false);
  });
}
