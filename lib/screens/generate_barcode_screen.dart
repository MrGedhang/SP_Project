import 'package:flutter/material.dart';

class GenerateBarcodeScreen extends StatelessWidget {
  const GenerateBarcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generate Barcode')),
      body: Center(
        child: Image.asset('assets/barcode_placeholder.png', height: 200),
      ),
    );
  }
}
