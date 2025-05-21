// lib/screens/generate_unique_code_screen.dart
import 'package:flutter/material.dart';

class GenerateUniqueCodeScreen extends StatefulWidget {
  const GenerateUniqueCodeScreen({super.key});

  @override
  State<GenerateUniqueCodeScreen> createState() => _GenerateUniqueCodeScreenState();
}

class _GenerateUniqueCodeScreenState extends State<GenerateUniqueCodeScreen> {
  String? generatedCode;

  // Fungsi untuk generate kode unik 6 digit yang diawali dengan "25"
  String generateUniqueCode() {
    final now = DateTime.now().microsecondsSinceEpoch;
    final randomPart = now.remainder(10000); // hasilnya antara 0000 - 9999
    return '25${randomPart.toString().padLeft(4, '0')}'; // total 6 digit
  }

  void handleGenerateCode() {
    final code = generateUniqueCode();
    setState(() => generatedCode = code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Generate Kode")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: handleGenerateCode, child: const Text("Generate")),
            if (generatedCode != null) ...[
              const SizedBox(height: 20),
              const Text("Kode Unik Kamu:"),
              Text(generatedCode!, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const Text("Gunakan saat keluar dari kampus"),
            ]
          ],
        ),
      ),
    );
  }
}
