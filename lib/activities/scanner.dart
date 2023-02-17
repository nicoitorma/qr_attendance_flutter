import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanner extends StatelessWidget {
  const QRScanner({super.key});

  @override
  Widget build(BuildContext context) {
    MobileScannerController cameraController =
        MobileScannerController(facing: CameraFacing.back);
    return MobileScanner(
      // fit: BoxFit.contain,
      controller: cameraController,
      onDetect: (capture) {
        final List<Barcode> barcodes = capture.barcodes;

        for (final barcode in barcodes) {
          print('Barcode found! ${barcode.rawValue}');
        }
      },
    );
  }
}
