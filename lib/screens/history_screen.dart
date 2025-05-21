import 'package:flutter/material.dart';
import 'package:myapp/services/database_service.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/settings_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _attendanceList = [];

  @override
  void initState() {
    super.initState();
    _loadAttendance();
  }

  Future<void> _loadAttendance() async {
    final data = await DatabaseService.getAllAttendance();
    setState(() {
      _attendanceList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Riwayat Kunjungan'),
        ),
      ),
      body: _attendanceList.isEmpty
          ? const Center(child: Text('Belum ada data kunjungan.'))
          : ListView.builder(
              itemCount: _attendanceList.length,
              itemBuilder: (context, index) {
                final item = _attendanceList[index];
                final timestamp = DateTime.tryParse(item['timestamp'] ?? '') ?? DateTime.now();
                final studentId = item['student_id'];

                return ListTile(
                  leading: const Icon(Icons.date_range),
                  title: Text(
                    'Tanggal: ${timestamp.day}-${timestamp.month}-${timestamp.year}',
                  ),
                  subtitle: Text('Student ID: $studentId'),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          } else if (index == 1) {
            // Sudah di Riwayat
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            );
          }
        },
      ),
    );
  }
}
