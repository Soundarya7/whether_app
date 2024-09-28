import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whether_app/weather_model.dart';
import 'package:whether_app/weather_provider.dart';

class WeatherScreen extends ConsumerWidget {
  final String city;

  WeatherScreen({required this.city});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsyncValue = ref.watch(weatherProvider(city));
    final forecastAsyncValue = ref.watch(forecastProvider(city));

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather in $city'),
      ),
      body: weatherAsyncValue.when(
        data: (weather) => Column(
          children: [
            Text('${weather.name}: ${weather.main.temp}°C'),
            Text('${weather.weather[0].description}'),
            const SizedBox(height: 20),
            forecastAsyncValue.when(
              data: (forecast) => Expanded(
                child: ListView.builder(
                  itemCount: forecast.length,
                  itemBuilder: (context, index) {
                    final weather = forecast[
                        index]; // Ensure this is the correct reference to weather

                    return ListTile(
                      title: Text(
                        'Temperature: ${weather.main.temp} °C, Description: ${weather.weather[0].description}',
                      ),
                      subtitle: Text(
                        'Feels like: ${weather.main.feelsLike} °C, Min: ${weather.main.tempMin} °C, Max: ${weather.main.tempMax} °C',
                      ),
                    );
                  },
                ),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stack) {
                print('Error loading forecast: $error');
                return Center(child: Text('Error loading forecast: $error'));
              },
            )
          ],
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
