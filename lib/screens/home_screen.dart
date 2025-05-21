import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/screens/input_kendaraan_screen.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/scan_screen.dart';
import 'package:myapp/screens/generate_unique_code_screen.dart';
import 'package:myapp/screens/history_screen.dart';
import 'package:myapp/screens/settings_screen.dart';
import 'package:myapp/screens/verifikasi_screen.dart';
// Unused import removed: '../services/unique_code_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  Timer? _sliderTimer;

  final List<String> sliderImages = [
    'Images/11.jpg',
    'Images/22.jpg',
    'Images/33.jpg',
    'Images/55.jpg',
    'Images/77.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _sliderTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentIndex + 1) % sliderImages.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _sliderTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // === SLIDER ===
            SizedBox(
              height: 160,
              child: PageView.builder(
                controller: _pageController,
                itemCount: sliderImages.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      sliderImages[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Text(
                              'Gambar tidak ditemukan',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(sliderImages.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentIndex == index ? 10 : 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.black : Colors.grey,
                  ),
                );
              }),
            ),

            const SizedBox(height: 30),

            // === FITUR REGISTRASI ===
            _buildFeatureTile(
              icon: Icons.motorcycle_outlined,
              text: 'Registrasi id/nopol anda',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InputKendaraanScreen()),
              ),
            ),

            const SizedBox(height: 10),

            // === FITUR GENERATE KODE ===
            _buildFeatureTile(
              icon: Icons.numbers_sharp,
              text: 'Generate Nomor Seri',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GenerateUniqueCodeScreen(),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // === FITUR VERIFIKASI NOMOR SERI ===
            _buildFeatureTile(
              icon: Icons.verified_rounded,
              text: 'Input Nomor Seri',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VerifikasiScreen()),
              ),
            ),

            const SizedBox(height: 10),

            // === FITUR SCAN ===
            _buildFeatureTile(
              icon: Icons.qr_code_scanner,
              text: 'Scan',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ScanScreen(),
                ),
              ),
            ),
          ],
        ),
      ),

      // === DRAWER ===
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Icon(Icons.person, size: 100, color: Colors.grey),
            ),
            _buildDrawerItem(Icons.home, 'Beranda', const HomeScreen()),
            _buildDrawerItem(Icons.history, 'Log History', const HistoryScreen()),
            _buildDrawerItem(Icons.settings, 'Pengaturan', const SettingsScreen()),
            const Divider(),
            _buildDrawerItem(Icons.logout, 'Keluar', const LoginScreen()),
          ],
        ),
      ),

      // === BOTTOM NAVIGATION BAR ===
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Pengaturan'),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
          }
        },
      ),
    );
  }

  Widget _buildFeatureTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 32, color: Colors.black),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, Widget destination) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => destination)),
    );
  }
}
