import 'package:radar/cubit.dart/model.dart';

abstract class CardState {}

class CardEmptyState extends CardState {}

class CardLoadingState extends CardState {
  final List oldCard;
  final bool isFirstFetch;
  final bool stopFatch;
  CardLoadingState(this.oldCard,
      {this.isFirstFetch = false, this.stopFatch = false});
}

class CardInitial extends CardState {}

class CardLoadedState extends CardState {
  dynamic? loadedCard;

  CardLoadedState(this.loadedCard) {
    print("loadedCard $loadedCard");
  }
}

class CardErrorState extends CardState {}

abstract class FilmsState {}

class FilmsEmptyState extends FilmsState {}

class FilmsLoadingState extends FilmsState {}

class FilmsLoadedState extends FilmsState {
  List<dynamic>? loadedFilms;
  FilmsLoadedState({this.loadedFilms}) {}
}

class FilmsErrorState extends FilmsState {}
