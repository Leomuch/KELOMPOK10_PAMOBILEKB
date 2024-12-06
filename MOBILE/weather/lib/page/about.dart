import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Daftar URL gambar
  final List<String> imageUrls = [
    'https://picsum.photos/200/300?random=1',
    'https://picsum.photos/200/300?random=2',
    'https://picsum.photos/200/300?random=3',
    'https://picsum.photos/200/300?random=4',
    'https://picsum.photos/200/300?random=5',
    'https://picsum.photos/200/300?random=6',
  ];

  @override
  void initState() {
    super.initState();
    // Mengatur pergerakan otomatis untuk PageView
    Future.delayed(Duration(seconds: 2), autoSlideImages);
  }

  void autoSlideImages() {
    if (_pageController.hasClients) {
      _currentPage = (_currentPage + 1) % imageUrls.length;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
    Future.delayed(Duration(seconds: 3), autoSlideImages); // Timer ulang
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.blue[300],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Judul
              Text(
                'Tentang Aplikasi Weather Prediction',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),

              // Deskripsi aplikasi
              Text(
                'Aplikasi Weather Prediction adalah platform yang memberikan prediksi cuaca terkini dengan menggunakan teknologi '
                'machine learning canggih. Aplikasi ini membantu pengguna untuk mengetahui cuaca di berbagai lokasi secara akurat '
                'dan mempersiapkan diri sesuai kebutuhan.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 20),

              // Gambar-gambar cuaca
              Text(
                'Galeri Cuaca',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700]),
              ),
              SizedBox(height: 10),
              Container(
                height: 300,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          imageUrls[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Indikator halaman
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  imageUrls.length,
                  (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 12 : 8,
                    height: _currentPage == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.blue : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Additional Information Section
              Text(
                'Fitur Utama Aplikasi:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700]),
              ),
              SizedBox(height: 10),
              Text(
                '1. Prediksi Cuaca Akurat\n Menggunakan teknologi machine learning untuk memberikan prediksi cuaca yang tepat.\n\n'
                '2. Pemberitahuan Cuaca Ekstrem\n Menerima peringatan cuaca ekstrem secara real-time.\n\n'
                '3. Data Cuaca Terpercaya\n Data cuaca diambil dari sumber terpercaya yang selalu diperbarui setiap waktu.\n\n'
                '4. Tampilan User-Friendly\n Aplikasi ini dirancang dengan antarmuka yang mudah digunakan untuk semua kalangan.',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 20),

              // Tips Menggunakan Aplikasi
              Text(
                'Tips Menggunakan Aplikasi:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700]),
              ),
              SizedBox(height: 10),
              Text(
                '1. Selalu perbarui aplikasi untuk mendapatkan fitur terbaru.\n\n'
                '2. Aktifkan notifikasi cuaca agar tidak ketinggalan informasi penting.\n\n'
                '3. Gunakan mode offline untuk melihat data cuaca yang telah diunduh.\n\n'
                '4. Sesuaikan pengaturan suhu dengan preferensi Anda di menu Pengaturan.',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AboutScreen(),
  ));
}
