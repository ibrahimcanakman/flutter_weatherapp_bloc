import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weatherapp_blocc/widgets/sehir_sec.dart';

import '../bloc/tema/bloc/tema_bloc.dart';
import '../bloc/weather/bloc/weather_bloc.dart';
import 'gecisli_arkaplan_renk.dart';
import 'hava_durumu_resim.dart';
import 'location.dart';
import 'max_min_sicaklik.dart';
import 'son_guncelleme.dart';

// ignore: must_be_immutable
class WeatherApp extends StatelessWidget {
  String? kullanicininSectigiSehir = '';
  Completer<void> _refreshCompleter = Completer<void>();

  WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return BlocBuilder(
      bloc: BlocProvider.of<TemaBloc>(context),
      builder: (context, TemaState state) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: (state as UygulamaTemasi).renk,
          title: const Text('Weather App'),
          actions: [
            IconButton(
                onPressed: () async {
                  kullanicininSectigiSehir = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SehirSecWidget(),
                      ));
                  
                  if (kullanicininSectigiSehir != null) {
                    _weatherBloc.add(
                        FetchWeatherEvent(sehirAdi: kullanicininSectigiSehir!));
                  }
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: Center(
          child: BlocBuilder(
            bloc: _weatherBloc,
            builder: (context, WeatherState state) {
              if (state is WeatherInitial) {
                return const Center(
                  child: Text('Şehir Seçiniz...'),
                );
              } else if (state is WeatherLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WeatherLoadedState) {
                final getirilenWeather = state.weather;
                final _havaDurumKisaltma =
                    getirilenWeather.consolidatedWeather![0].weatherStateAbbr;
                
                kullanicininSectigiSehir = getirilenWeather.title;

                BlocProvider.of<TemaBloc>(context).add(TemaDegistirEvent(
                    havaDurumuKisaltmasi: _havaDurumKisaltma!));

                _refreshCompleter.complete();
                _refreshCompleter = Completer();
                return BlocBuilder(
                    bloc: BlocProvider.of<TemaBloc>(context),
                    builder: (context, TemaState state) => GecisliRenkContainer(
                          renk: (state as UygulamaTemasi).renk,
                          child: RefreshIndicator(
                            onRefresh: () {
                              _weatherBloc.add(RefreshhWeatherEvent(
                                  sehirAdi: kullanicininSectigiSehir!));
                              return _refreshCompleter.future;
                            },
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: LocationWidget(
                                    secilenSehir: getirilenWeather.title!,
                                  )),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(child: SonGuncellemeWidget()),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(child: HavaDurumuResimWidget()),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child:
                                      Center(child: MaxveMinSicaklikWidget()),
                                ),
                              ],
                            ),
                          ),
                        ));
              } else if (state is WeatherErrorState) {
                return const Center(
                  child: Text('Hata Oluştu...'),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
