import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';
import 'package:qr_scanner/qr_scanner.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escanear QR')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is QRScanned) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Código escaneado: ${state.qrCode}')),
            );
          }
        },
        child: QRScannerView(
          onScanned: (String result) {
            if (context.mounted) {
              context.read<AuthBloc>().add(QRScanCompleted(result));
            }
          },
        ),
      ),
    );
  }
}
