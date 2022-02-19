import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather/bloc/weather_bloc.dart';

class SonGuncellemeWidget extends StatelessWidget {
  const SonGuncellemeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return BlocBuilder(
        bloc: _weatherBloc,
        builder: (context, WeatherState state) {
          var yeniTarih =
              DateTime.parse((state as WeatherLoadedState).weather.time!)
                  .toLocal();

          return Text(
            'Son Güncelleme ' +
                TimeOfDay.fromDateTime(yeniTarih).format(context),
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          );
        });
  }
}
