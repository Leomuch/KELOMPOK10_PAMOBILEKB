import 'package:flutter/material.dart';
import 'package:weather/page/home.dart';

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView untuk halaman perkenalan
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildPage(
                context,
                title: "Selamat Datang!",
                description:
                    "Aplikasi cuaca ini memberikan prediksi harian dan mingguan.",
                bgImage: "assets/cerah.jpg",
              ),
              _buildPage(
                context,
                title: "Beragam Kota",
                description:
                    "Pilih kota favorit Anda dan nikmati prediksi yang akurat.",
                bgImage: "assets/berawan.jpg",
              ),
              _buildPage(
                context,
                title: "Mulai Eksplorasi",
                description:
                    "Geser untuk memulai pengalaman cuaca terbaik Anda.",
                bgImage: "assets/berkabut.jpg",
                isLast: true,
              ),
            ],
          ),
          // Tombol Skip di kanan atas
          Positioned(
            top: 40,
            right: 20,
            child: Visibility(
              visible: _currentPage < 2,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // Indikator halaman di bagian bawah
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: _currentPage == index ? 12 : 8,
                  height: _currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index ? Colors.orange : Colors.white54,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(
    BuildContext context, {
    required String title,
    required String description,
    required String bgImage,
    bool isLast = false,
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Image.asset(
          bgImage,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey,
              child: const Center(
                child: Icon(
                  Icons.broken_image,
                  size: 100,
                  color: Colors.red,
                ),
              ),
            );
          },
        ),
        // Content
        Container(
          color: Colors.black.withOpacity(0.5), // Transparansi untuk teks
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              if (isLast)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: const Text(
                    "Mulai Sekarang",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
