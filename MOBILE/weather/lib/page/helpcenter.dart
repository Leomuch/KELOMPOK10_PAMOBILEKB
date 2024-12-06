import 'package:flutter/material.dart';

class HelpCenterScreen extends StatefulWidget {
  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final List<Map<String, String>> faq = [
    {
      'question': 'Bagaimana cara melihat prediksi cuaca?',
      'answer': 'Anda dapat melihat prediksi cuaca dengan memasukkan lokasi Anda di aplikasi dan menekan tombol prediksi.'
    },
    {
      'question': 'Dari mana data cuaca diambil?',
      'answer': 'Data cuaca diambil dari sumber terpercaya seperti API cuaca dan diproses menggunakan teknologi prediksi kami.'
    },
    {
      'question': 'Seberapa akurat prediksi cuaca di aplikasi ini?',
      'answer': 'Prediksi cuaca kami memiliki tingkat akurasi tinggi karena menggunakan model machine learning yang terus diperbarui.'
    },
    {
      'question': 'Apakah aplikasi ini dapat digunakan secara offline?',
      'answer': 'Aplikasi memerlukan koneksi internet untuk mengambil data cuaca terbaru. Namun, data yang telah diunduh tetap dapat dilihat secara offline.'
    },
    {
      'question': 'Bagaimana cara mengatur lokasi secara otomatis?',
      'answer': 'Anda dapat mengaktifkan layanan lokasi pada perangkat Anda, dan aplikasi akan mendeteksi lokasi Anda secara otomatis.'
    },
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center - Weather Prediction'),
        backgroundColor: Colors.blue[300],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section for feedback
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Kritik dan Saran',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue[800]),
                ),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  labelStyle: TextStyle(color: Colors.blue[300]),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[300]!),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Kritik dan Saran',
                  labelStyle: TextStyle(color: Colors.blue[300]),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[300]!),
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  String name = nameController.text;
                  String feedback = feedbackController.text;
                  if (name.isEmpty || feedback.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Nama dan saran tidak boleh kosong')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Terima kasih atas masukannya, $name!')),
                    );
                    nameController.clear();
                    feedbackController.clear();
                  }
                },
                child: Text('Kirim'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: Colors.blue[300],
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 30),

              // FAQ Section
              Text(
                'Sering Ditanyakan',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue[800]),
              ),
              SizedBox(height: 20),
              Column(
                children: faq.map((faqItem) {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        faqItem['question']!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            faqItem['answer']!,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
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
    home: HelpCenterScreen(),
  ));
}
