import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Welcome to Weather Prediction. By using this application, you agree to comply with and be bound by the following terms and conditions. Please read them carefully before using the app. If you do not agree with these terms, you must not use the application.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 24),
            _buildSectionTitle('1. General Use'),
            _buildSectionContent(
                'Weather Prediction provides weather-related data, forecasts, and information for personal use. You are responsible for ensuring that your device meets the application requirements and that your use complies with local laws.'),
            SizedBox(height: 16),
            _buildSectionTitle('2. Accuracy of Information'),
            _buildSectionContent(
                'The weather information provided by Weather Prediction is based on data from third-party sources and may not be completely accurate or up-to-date. We are not responsible for any decisions made based on the weather information provided by the app.'),
            SizedBox(height: 16),
            _buildSectionTitle('3. Privacy Policy'),
            _buildSectionContent(
                'Weather Prediction collects location data to provide accurate weather forecasts. Please refer to our Privacy Policy for detailed information.'),
            SizedBox(height: 16),
            _buildSectionTitle('4. Limitation of Liability'),
            _buildSectionContent(
                'Weather Prediction is not liable for any damages resulting from your use or inability to use the application.'),
            SizedBox(height: 16),
            _buildSectionTitle('5. Governing Law'),
            _buildSectionContent(
                'These terms are governed by the laws of Samarinda, and any disputes shall be resolved in courts located in Samarinda.'),
            SizedBox(height: 24),
            Text(
              'If you have questions about these terms, please contact us at: 081934407443',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(fontSize: 14),
    );
  }
}
