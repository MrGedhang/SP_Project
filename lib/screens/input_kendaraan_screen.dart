import 'package:flutter/material.dart';
import '../services/database_service.dart';
import 'settings_screen.dart';

class InputKendaraanScreen extends StatefulWidget {
  const InputKendaraanScreen({super.key});

  @override
  State<InputKendaraanScreen> createState() => _InputKendaraanScreenState();
}

class _InputKendaraanScreenState extends State<InputKendaraanScreen> {
  final TextEditingController nopolController = TextEditingController();
  String? tipeKendaraan;

  Future<void> tambahDataKendaraan() async {
    if (nopolController.text.isNotEmpty && tipeKendaraan != null) {
      await DatabaseService.insertVehicle(nopolController.text, tipeKendaraan!);

      if (!mounted) return;

      // Reset form
      nopolController.clear();
      setState(() {
        tipeKendaraan = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data kendaraan berhasil disimpan')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SettingsScreen()),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi data terlebih dahulu')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Input Kendaraan")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nopolController,
              decoration: const InputDecoration(labelText: 'Nomor Polisi'),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Tipe Kendaraan'),
              items: ['Motor', 'Mobil'].map((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  tipeKendaraan = value;
                });
              },
              value: tipeKendaraan,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: tambahDataKendaraan,
              child: const Text("Simpan Data"),
            ),
          ],
        ),
      ),
    );
  }
}
