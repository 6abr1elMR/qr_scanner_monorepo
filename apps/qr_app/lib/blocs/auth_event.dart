abstract class AuthEvent {}

class AuthenticateUser extends AuthEvent {}

class QRScanCompleted extends AuthEvent {
  final String qrCode;
  QRScanCompleted(this.qrCode);
}
