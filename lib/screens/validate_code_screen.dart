// lib/screens/validate_code_screen.dart
import 'package:flutter/material.dart';
import '../services/unique_code_service.dart';

class ValidateCodeScreen extends StatefulWidget {
  final UniqueCodeService codeService;

  const ValidateCodeScreen({super.key, required this.codeService});

  @override
  State<ValidateCodeScreen> createState() => _ValidateCodeScreenState();
}

class _ValidateCodeScreenState extends State<ValidateCodeScreen> {
  final TextEditingController codeController = TextEditingController();
  String? result;

  void validate() {
    final code = codeController.text.trim();
    final isValid = widget.codeService.validateCode(code);
    setState(() {
      result = isValid ? "✅ Kode valid!" : "❌ Kode tidak valid atau sudah digunakan.";
      if (isValid) widget.codeService.markCodeAsUsed(code);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Validasi Kode Tamu")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Masukkan Kode:", style: TextStyle(fontSize: 16)),
            TextField(controller: codeController),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: validate, child: const Text("Validasi")),
            if (result != null) ...[
              const SizedBox(height: 20),
              Text(result!, style: const TextStyle(fontSize: 16)),
            ]
          ],
        ),
      ),
    );
  }
}
