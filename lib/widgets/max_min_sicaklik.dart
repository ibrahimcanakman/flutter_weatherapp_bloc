import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weather/bloc/weather_bloc.dart';

class MaxveMinSicaklikWidget extends StatelessWidget {
  const MaxveMinSicaklikWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return BlocBuilder(
      bloc: _weatherBloc,
      builder: (context, WeatherState state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Maksimum: ' +
                (state as WeatherLoadedState)
                    .weather
                    .consolidatedWeather![0]
                    .maxTemp!
                    .floor()
                    .toString() +
                '°C',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            'Minimum: ' +
                (state)
                    .weather
                    .consolidatedWeather![0]
                    .minTemp!
                    .floor()
                    .toString() +
                '°C',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
