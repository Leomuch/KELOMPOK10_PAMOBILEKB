import 'package:flutter/material.dart';

class HourlyForecastScreen extends StatelessWidget {
  final List<dynamic> hourlyData;

  HourlyForecastScreen(this.hourlyData);

  String getBackgroundImage(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return 'assets/cerah.jpg'; // Clear
      case 'Partly cloudy':
        return 'assets/berawan.jpg'; // Partly Cloudy
      case 'Cloudy':
        return 'assets/berkabut.jpg'; // Cloudy
      case 'rain':
        return 'assets/hujan.jpg'; // Rain
      case 'fog':
        return 'assets/berkabut.jpg'; // Fog
      case 'heavy rain':
        return 'assets/hujan.jpg'; // Fog
      case 'light rain shower':
        return 'assets/hujan.jpg'; // Fog
      case 'light rain':
        return 'assets/hujan.jpg'; // Fog
      case 'light drizzle':
        return 'assets/berawan.jpg'; // Fog
      case 'Overcast':
        return 'assets/berawan.jpg'; // Fog
      case 'mist':
        return 'assets/berkabut.jpg'; // Fog
      case 'patchy rain nearby':
        return 'assets/hujan.jpg'; // Fog
      case 'patchy light rain':
        return 'assets/hujan.jpg'; // Fog
      case 'patchy light rain in area with thunder':
        return 'assets/hujan.jpg'; // Fog
      case 'patchy light drizzle':
        return 'assets/hujan.jpg'; // Fog
      case 'moderate rain':
        return 'assets/hujan.jpg'; // Fog
      case 'sunny':
        return 'assets/cerah.jpg'; // Fog
      default:
        return 'assets/default.jpg'; // Default image for unknown conditions
    }
  }

  List<dynamic> filterDataByHour(List<dynamic> data) {
    // Memfilter data untuk hanya jam dengan kelipatan 3
    return data.where((hour) {
      int hourValue = int.parse(hour['time'].split(' ')[1].split(':')[0]);
      return hourValue % 3 == 0;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Data setelah difilter
    final filteredData = filterDataByHour(hourlyData);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Prediction Per Hours'),
        backgroundColor: const Color.fromARGB(255, 149, 179, 231),
      ),
      body: ListView.builder(
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          var hour = filteredData[index];

          // Mengambil waktu dalam format 'HH:MM'
          String hourOnly =
              hour['time'].split(' ')[1].substring(0, 5); // Extracts 'HH:MM'

          String conditionText = hour['condition']['text'];
          String backgroundImage = getBackgroundImage(conditionText);

          return Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    hourOnly,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Text(
                    '${hour['temp_c']}°C',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 253, 253, 253),
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${hour['condition']['text']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(179, 0, 0, 0),
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.wind_power, // Icon untuk angin
                        size: 20,
                        color: Colors.white70,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Kecepatan Angin: ${hour['wind_kph']} kph',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.water_drop, // Icon untuk hujan
                        size: 20,
                        color: Colors.white70,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Curah Hujan: ${hour['precip_mm']} mm',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
