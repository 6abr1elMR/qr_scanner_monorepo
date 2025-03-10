import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:qr_app/blocs/auth_bloc.dart';
import 'package:qr_app/main.dart';
import 'package:qr_app/screens/auth_screen.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  testWidgets('La aplicación se inicializa y muestra la pantalla de autenticación',
      (WidgetTester tester) async {
    final mockAuthBloc = MockAuthBloc();
    await tester.pumpWidget(
      BlocProvider<AuthBloc>.value(
        value: mockAuthBloc,
        child: const MyApp(),
      ),
    );

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(AuthScreen), findsOneWidget);
  });
}
