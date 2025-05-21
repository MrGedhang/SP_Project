import 'package:flutter/material.dart';
import '../models/kendaraan.dart';

class HistoryKendaraanScreen extends StatelessWidget {
  final List<Kendaraan> kendaraanList;

  const HistoryKendaraanScreen({
    super.key, // ✅ super parameter digunakan di sini
    required this.kendaraanList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Kendaraan"),
        backgroundColor: Colors.blueAccent,
      ),
      body: kendaraanList.isEmpty
          ? const Center(
              child: Text("Belum ada kendaraan terdaftar."),
            )
          : ListView.builder(
              itemCount: kendaraanList.length,
              itemBuilder: (context, index) {
                final kendaraan = kendaraanList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      leading: Icon(
                        kendaraan.tipe == 'Motor'
                            ? Icons.motorcycle
                            : Icons.directions_car,
                        color: Colors.blueGrey,
                      ),
                      title: Text("Nopol: ${kendaraan.nopol}"),
                      subtitle: Text("Tipe: ${kendaraan.tipe}"),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
