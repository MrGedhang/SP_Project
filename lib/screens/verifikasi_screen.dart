// lib/screens/verifikasi_screen.dart
import 'package:flutter/material.dart';

class VerifikasiScreen extends StatefulWidget {
  const VerifikasiScreen({super.key});

  @override
  State<VerifikasiScreen> createState() => _VerifikasiScreenState();
}

class _VerifikasiScreenState extends State<VerifikasiScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _message;

  void _verifikasiKode() {
    final input = _controller.text.trim();

    if (input.length != 6 || !RegExp(r'^25\d{4}$').hasMatch(input)) {
      setState(() => _message = 'Kode tidak valid. Harus 6 digit dan diawali dengan 25.');
    } else {
      setState(() => _message = 'Kode valid! Silakan lanjut.');
      // Tambahkan proses lanjut di sini jika perlu (navigasi, simpan, dll)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verifikasi Serial Number")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Masukkan Kode Serial", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Contoh: 250123",
              ),
              maxLength: 6,
            ),
            ElevatedButton(
              onPressed: _verifikasiKode,
              child: const Text("Verifikasi"),
            ),
            if (_message != null) ...[
              const SizedBox(height: 16),
              Text(
                _message!,
                style: TextStyle(
                  color: _message!.contains("valid") ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
