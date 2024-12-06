import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherPredictionProvider with ChangeNotifier {
  List<double> inputData = [
    0.0,
    0.0,
    0.0,
    0.0
  ]; // [suhu, kelembapan, tekanan, kecepatan angin]
  String? predictionMessage;
  String? city;
  Map<String, dynamic>? cachedWeatherData =
      {}; // Cache untuk data cuaca per kota

  Future<void> fetchAndPredictWeather() async {
    if (city == null) {
      predictionMessage = 'Please select a city first.';
      notifyListeners();
      return;
    }

    if (cachedWeatherData?.containsKey(city) ?? false) {
      _processWeatherData(cachedWeatherData![city]);
      return;
    }

    final weatherApiUrl = Uri.parse(
        'https://api.weatherapi.com/v1/forecast.json?key=26f9fcacc03c434b99610156240212&q=$city&days=8');

    try {
      final response = await http.get(weatherApiUrl);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        cachedWeatherData![city!] = data; // Simpan dalam cache
        _processWeatherData(data);
      } else {
        predictionMessage = 'Failed to fetch weather data: ${response.body}';
        notifyListeners();
      }
    } catch (e) {
      predictionMessage = 'Error fetching weather data: $e';
      notifyListeners();
    }
  }

  void _processWeatherData(Map<String, dynamic> data) async {
    try {
      inputData = [
        (data['current']['temp_c'] as num).toDouble(),
        (data['current']['humidity'] as num).toDouble(),
        (data['current']['pressure_mb'] as num).toDouble(),
        (data['current']['wind_kph'] as num).toDouble(),
      ];
      await predictWeather();
    } catch (e) {
      predictionMessage = 'Error processing weather data: $e';
      notifyListeners();
    }
  }

  Future<void> predictWeather() async {
    final predictionApiUrl = Uri.parse(
        'http://127.0.0.1:8000/api/predict'); // Ganti dengan URL API prediksi
    final body = jsonEncode({'data': inputData});

    try {
      final response = await http.post(
        predictionApiUrl,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        predictionMessage = _mapPredictionToMessage(data['prediction']);
      } else {
        predictionMessage = 'Failed to get prediction: ${response.body}';
      }
    } catch (e) {
      predictionMessage = 'Error during prediction: $e';
    }

    notifyListeners();
  }

  String _mapPredictionToMessage(String prediction) {
    switch (prediction) {
      case 'rainy':
        return 'It will be rainy. Don’t forget your umbrella!';
      case 'sunny':
        return 'It will be sunny. Enjoy the nice weather!';
      case 'cloudy':
        return 'It will be cloudy. You might need a light jacket.';
      default:
        return 'Weather prediction is unclear.';
    }
  }

  void setCity(String cityName) {
    city = cityName;
    fetchAndPredictWeather(); // Fetch and predict after setting the city
  }

  @override
  void dispose() {
    super.dispose();
  }
}
