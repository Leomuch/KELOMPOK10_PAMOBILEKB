import 'package:flutter/material.dart';
import 'package:weather/models/constants.dart';

class WeatherDetail extends StatelessWidget {
  final String cityName;
  final String day;

  final List<Map<String, dynamic>> hourlyForecast = [
    {
      "time": "06:00",
      "temp": "16°C",
      "icon": Icons.cloud,
      "color": Colors.blue
    },
    {
      "time": "09:00",
      "temp": "18°C",
      "icon": Icons.wb_sunny,
      "color": Colors.orange
    },
    {
      "time": "12:00",
      "temp": "21°C",
      "icon": Icons.wb_cloudy,
      "color": Colors.grey
    },
    {
      "time": "15:00",
      "temp": "22°C",
      "icon": Icons.wb_sunny,
      "color": Colors.orange
    },
    {
      "time": "18:00",
      "temp": "19°C",
      "icon": Icons.wb_cloudy,
      "color": Colors.grey
    },
    {
      "time": "21:00",
      "temp": "17°C",
      "icon": Icons.cloud,
      "color": Colors.blue
    },
  ];

  WeatherDetail({Key? key, required this.cityName, required this.day})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    final constants = Constants();

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Cuaca $cityName - $day'),
        backgroundColor: constants.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
      
            Container(
              height: 200.0,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hourlyForecast.length,
                itemBuilder: (context, index) {
                  final data = hourlyForecast[index];
                  return Container(
                    width: 120.0,
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: constants.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(data["icon"], color: data["color"], size: 40),
                        Text(
                          data["time"],
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          data["temp"],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: data["color"],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Container(
              height: 400,
              width: 300,
              padding: EdgeInsets.all(20.0),
              margin:
                  EdgeInsets.only(top: 20.0, bottom: 20.0), 
              decoration: BoxDecoration(
                color: constants.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: constants.secondaryColor,
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      'assets/clear.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Suhu Saat Ini',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: constants.TertiaryColor,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '20°C',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: constants.TertiaryColor,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Cerah', 
                    style: TextStyle(
                      fontSize: 20,
                      color: constants.TertiaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
