part of 'tema_bloc.dart';

abstract class TemaEvent extends Equatable {
  const TemaEvent();

  @override
  List<Object> get props => [];
}

class TemaDegistirEvent extends TemaEvent {
  @override
  List<Object> get props => [havaDurumuKisaltmasi];
  final String havaDurumuKisaltmasi;
  const TemaDegistirEvent({required this.havaDurumuKisaltmasi});
}
