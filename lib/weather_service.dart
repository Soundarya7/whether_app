import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whether_app/weather_model.dart';

class WeatherService {
  final String apiKey = '40e0bb00dfd8d1aded0c76df89aa9675'; // Use your own API key from a weather API provider
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/';

  Future<Weather> fetchWeather(String city) async {
    print("Data  City$city");
    final url = '${baseUrl}weather?q=$city&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
       print("Data $data");
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<Weather>> fetchForecast(String city) async {
    final url = '${baseUrl}forecast?q=$city&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
   
  
   if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
     print('API Response: $data'); // Print the entire response for debugging
    if (data.containsKey('list') && data['list'] is List) {
      return (data['list'] as List)
          .map((forecast) => Weather.fromJson(forecast))
          .toList();
    } else {
      throw Exception('No forecast data available');
    }
  } else {
    throw Exception('Failed to load forecast data');
  }
    
  }
}
