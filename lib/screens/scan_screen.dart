import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool isScanned = false;

  void _handleBarcode(BarcodeCapture barcode) {
    if (isScanned) return;

    final String? code = barcode.barcodes.first.rawValue;
    if (code != null) {
      setState(() {
        isScanned = true;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('KTM Terdeteksi'),
          content: Text('Data dari KTM: $code'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                setState(() {
                  isScanned = false; // Reset agar bisa scan lagi
                });
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan KTM'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          facing: CameraFacing.back,
        ),
        onDetect: _handleBarcode,
      ),
    );
  }
}
