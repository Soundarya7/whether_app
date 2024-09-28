import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whether_app/weather_model.dart';
import 'package:whether_app/weather_service.dart';
// Provider for the weather service
final weatherServiceProvider = Provider((ref) => WeatherService());

// Provider for current weather
final weatherProvider = FutureProvider.family<Weather, String>((ref, city) {
  final weatherService = ref.watch(weatherServiceProvider);
  return weatherService.fetchWeather(city);
});

// Provider for forecast weather
final forecastProvider = FutureProvider.family<List<Weather>, String>((ref, city) {
  final weatherService = ref.watch(weatherServiceProvider);
  return weatherService.fetchForecast(city);
});
