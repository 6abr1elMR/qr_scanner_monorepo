import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_biometric/auth_biometric.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthBiometric _authBiometric;

  AuthBloc(this._authBiometric) : super(AuthInitial()) {
    on<AuthenticateUser>(_onAuthenticateUser);
    on<QRScanCompleted>(_onQRScanCompleted);
  }

  Future<void> _onAuthenticateUser(
      AuthenticateUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    bool isAuthenticated = await _authBiometric.authenticate();
    if (isAuthenticated) {
      emit(Authenticated());
    } else {
      emit(AuthFailed());
    }
  }

  void _onQRScanCompleted(QRScanCompleted event, Emitter<AuthState> emit) {
    emit(QRScanned(event.qrCode));
  }
}
