abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {}

class AuthFailed extends AuthState {}

class QRScanned extends AuthState {
  final String qrCode;
  QRScanned(this.qrCode);
}
