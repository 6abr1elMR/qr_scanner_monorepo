import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_biometric/auth_biometric.dart';
import 'blocs/auth_bloc.dart';
import 'screens/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthBiometric()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Auth App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const AuthScreen(),
      ),
    );
  }
}
