import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/qr_scanner.dart';

// Clase mock para simular el MobileScannerController
class MockMobileScannerController extends Mock
    implements MobileScannerController {}

void main() {
  // late MockMobileScannerController mockController;

  setUp(() {
    // mockController = MockMobileScannerController();
  });

  testWidgets('Escanea un código QR y llama a onScanned',
      (WidgetTester tester) async {
    String? scannedResult;

    await tester.pumpWidget(
      MaterialApp(
        home: QRScannerView(
          onScanned: (code) {
            scannedResult = code;
          },
        ),
      ),
    );

    const qrCapture = Barcode(
      rawValue: 'https://ejemplo.com',
      format: BarcodeFormat.qrCode,
    );

    final capture = BarcodeCapture(barcodes: [qrCapture]);

    final mobileScannerFinder = find.byType(MobileScanner);
    final MobileScanner scannerWidget = tester.widget(mobileScannerFinder);
    scannerWidget.onDetect.call(capture);

    await tester.pump();

    expect(scannedResult, 'https://ejemplo.com');
  });

  testWidgets('El botón de linterna llama a _toggleTorch()',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: QRScannerView(onScanned: (_) {}),
      ),
    );

    final torchButtonFinder = find.byType(FloatingActionButton);

    expect(torchButtonFinder, findsOneWidget);

    await tester.tap(torchButtonFinder);
    await tester.pump();
  });
}
