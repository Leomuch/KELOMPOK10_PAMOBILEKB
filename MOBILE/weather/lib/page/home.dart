import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'hour.dart';
import 'package:weather/controller/controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> cities = [
    "Samarinda",
    "Bontang",
    "Sangatta",
    "Balikpapan",
    "Tenggarong",
    "Muara Badak",
    "Muara Wahau",
    "Sangkulirang",
    "Penajam"
  ];

  final PageController _pageController = PageController();
  late List<Future<Map<String, dynamic>>> weatherDataList;
  int currentCityIndex = 0;

  @override
  void initState() {
    super.initState();
    weatherDataList = cities.map(fetchWeatherData).toList();
    // Fetch weather data and predictions when the app starts
    final predictionProvider = Provider.of<WeatherPredictionProvider>(context, listen: false);
    predictionProvider.fetchAndPredictWeather();
  }

  Future<Map<String, dynamic>> fetchWeatherData(String city) async {
    final url = Uri.parse(
      'https://api.weatherapi.com/v1/forecast.json?key=26f9fcacc03c434b99610156240212&q=$city&days=8',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('API Response for $city: ${response.body}');
      return jsonDecode(response.body);
    } else {
      print('Failed to load weather data for $city. Status Code: ${response.statusCode}');
      throw Exception('Failed to load weather data for $city');
    }
  }

  String getBackgroundImage(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
      case 'sunny':
        return 'assets/cerah.jpg';
      case 'cloudy':
      case 'overcast':
      case 'mist':
        return 'assets/berkabut.jpg';
      case 'rain':
      case 'heavy rain':
      case 'light rain':
      case 'moderate rain':
        return 'assets/hujan.jpg';
      default:
        return 'assets/default.jpg';
    }
  }

  Color getContainerColor(double temperature) {
    if (temperature >= 15 && temperature <= 27.9) {
      return const Color.fromARGB(255, 133, 141, 148).withOpacity(0.5);
    } else if (temperature >= 28 && temperature <= 30.9) {
      return const Color.fromARGB(255, 108, 122, 141).withOpacity(0.5);
    } else if (temperature >= 31 && temperature <= 32.9) {
      return const Color.fromARGB(255, 63, 85, 100).withOpacity(0.5);
    } else if (temperature >= 33) {
      return const Color.fromARGB(255, 212, 183, 138).withOpacity(0.5);
    }
    return Colors.white.withOpacity(0.5);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<WeatherPredictionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Prediction'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () => _selectCity(context),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: cities.length,
        onPageChanged: (index) {
          setState(() {
            currentCityIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return FutureBuilder<Map<String, dynamic>>(
            future: weatherDataList[index],
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('No data available'));
              }

              final data = snapshot.data!;
              final currentWeather = data['current'];
              double temperature = currentWeather['temp_c'];
              String conditionText = currentWeather['condition']['text'];
              String backgroundImage = getBackgroundImage(conditionText);
              Color containerColor = getContainerColor(temperature);

              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      backgroundImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.broken_image, size: 100, color: Colors.red),
                        );
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Hari Ini (${cities[index]})',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${currentWeather['temp_c']}°C',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Consumer<WeatherPredictionProvider>(
                              builder: (context, provider, child) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Text(
                                    provider.predictionMessage ?? 'Loading prediction...',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: data['forecast']['forecastday'].length,
                          itemBuilder: (context, dayIndex) {
                            var day = data['forecast']['forecastday'][dayIndex];
                            DateTime date = DateTime.parse(day['date']);
                            String dayOfWeek = _getDayOfWeek(date.weekday);

                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                title: Text(
                                  dayOfWeek,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: Text(
                                  '${day['day']['avgtemp_c']}°C',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                subtitle: Text('${day['day']['condition']['text']}'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HourlyForecastScreen(day['hour']),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _selectCity(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Search City',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  setState(() {
                    cities.retainWhere((city) => city.toLowerCase().contains(query.toLowerCase()));
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(cities[index]),
                    onTap: () {
                      final predictionProvider = Provider.of<WeatherPredictionProvider>(context, listen: false);
                      predictionProvider.setCity(cities[index]);
                      setState(() {
                        currentCityIndex = cities.indexOf(cities[index]);
                        _pageController.jumpToPage(currentCityIndex);
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Senin';
      case 2:
        return 'Selasa';
      case 3:
        return 'Rabu';
      case 4:
        return 'Kamis';
      case 5:
        return 'Jumat';
      case 6:
        return 'Sabtu';
      case 7:
        return 'Minggu';
      default:
        return '';
    }
  }
}
