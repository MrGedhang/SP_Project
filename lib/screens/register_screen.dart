import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen.dart';
import '../services/database_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nimController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController(); // Simulasi, password tidak digunakan

  Future<void> _register() async {
    final nim = _nimController.text.trim();
    final name = _nameController.text.trim();
    final password = _passwordController.text.trim(); // Optional
    if (nim.isEmpty || name.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua kolom wajib diisi')),
      );
      return;
    }

    await DatabaseService.insertProfile(nim, name, 'Aktif'); // Tambahkan status default
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrasi Akun')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nimController,
              decoration: const InputDecoration(labelText: 'NIM/NIDN'),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Registrasi'),
            ),
          ],
        ),
      ),
    );
  }
}
