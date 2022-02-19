import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/weather_repository.dart';
import '../../../locator.dart';
import '../../../models/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository = locator<WeatherRepository>();
  //final WeatherRepository weatherRepository2 = locator.get<WeatherRepository>();

  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      if (event is FetchWeatherEvent) {
        emit(WeatherLoadingState());
        try {
          //hava durumunu getirme kodları
          final Weather getirilenWeather =
              await weatherRepository.getWeather(event.sehirAdi);
          emit(WeatherLoadedState(weather: getirilenWeather));
        } catch (e) {
          emit(WeatherErrorState());
        }
      } else if (event is RefreshhWeatherEvent) {
        try {
          //hava durumunu getirme kodları
          final Weather getirilenWeather =
              await weatherRepository.getWeather(event.sehirAdi);
          emit(WeatherLoadedState(weather: getirilenWeather));
        } catch (e) {
          emit(state);
        }
      }
    });
  }
}
