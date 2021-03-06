import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'tema_event.dart';
part 'tema_state.dart';

class TemaBloc extends Bloc<TemaEvent, TemaState> {
  TemaBloc()
      : super(UygulamaTemasi(tema: ThemeData.light(), renk: Colors.blue)) {
    on<TemaEvent>((event, emit) {
      UygulamaTemasi uygulamaTemasi;

      if (event is TemaDegistirEvent) {
        switch (event.havaDurumuKisaltmasi) {
          case 'sn': //karlı
          case 'sl': //sulu kar
          case 'h': //dolu
          case 't': //fırtına
          case 'hc': //çok bulutlu
            uygulamaTemasi = UygulamaTemasi(
                tema: ThemeData(primaryColor: Colors.blueGrey),
                renk: Colors.grey);
            break;

          case 'hr': //ağır yağmurlu
          case 'lr': //hafif yağmurlu
          case 's': //sağanak yağış
            uygulamaTemasi = UygulamaTemasi(
                tema: ThemeData(primaryColor: Colors.indigoAccent),
                renk: Colors.indigo);
            break;

          case 'lc': //az bulutlu
          case 'c': //açık güneşli
            uygulamaTemasi = UygulamaTemasi(
                tema: ThemeData(primaryColor: Colors.orangeAccent),
                renk: Colors.yellow);
            break;
          default:
            uygulamaTemasi =
                UygulamaTemasi(tema: ThemeData.light(), renk: Colors.blue);
            break;
        }
        emit(uygulamaTemasi);
      }
    });
  }
}
