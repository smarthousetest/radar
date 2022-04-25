import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/cubit.dart/model.dart';
import 'package:radar/cubit.dart/repo.dart';
import 'package:radar/cubit.dart/state.dart';

class ApiCubit {
  Future<Model?> getConfig(int page) async {
    print(page);

    final response = await http.get(
      Uri.parse('https://swapi.dev/api/people/?page=$page'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      print("responce ${response.body}");
      // final dynamic cardJson = json.decode(response.body);
      print("fffffff ${modelFromJson(response.body)}");
      return modelFromJson(response.body);
    } else {
      return null;
    }
  }
}

class FilmsApi {
  Future<List<Films>> getConfig2(List films) async {
    String film = '';
    List allFilms = [];
    print("films arrat $films");
    for (int i = 0; i < films.length; i++) {
      print("i = $i");
      print("len ${films.length}");
      print("film i =  ${films[i]}");
      film = films[i];
      print("film $film");
      final response = await http.get(
        Uri.parse(film),
        headers: {"Content-Type": "application/json"},
      );
      print("responce ${response.body}");
      allFilms.add(response.body);
    }
    print("all films ${allFilms}");
    return filmsFromJson(allFilms.toString());
  }
}

class FilmsCubit extends Cubit<FilmsState> {
  final FilmRepository filmRepository;

  FilmsCubit(this.filmRepository) : super(FilmsLoadedState());

  Future<void> fetchFilms(List films) async {
    try {
      emit(FilmsLoadingState());
      List<Films>? _loaded = await filmRepository.getAllFilms(films);
      print("приватная  $_loaded");
      emit(FilmsLoadedState(loadedFilms: _loaded));
    } catch (_) {
      emit(FilmsErrorState());
    }
  }
}

bool stopLoading = false;

class CardCubit extends Cubit<CardState> {
  CardCubit(this.cardRepository) : super(CardInitial());
  final CardRepository cardRepository;
  int page = 1;
  Future<void> fetchBlogers({String pagen = "1"}) async {
    if (state is CardLoadingState) return;
    var oldPosts = [];
    bool stopFatch;
    if (pagen != "scrool") {
      page = 1;
      oldPosts.clear();
      emit(CardEmptyState());
    }

    final currentState = state;
    if (currentState is CardLoadedState) {
      oldPosts = currentState.loadedCard;
    }

    emit(CardLoadingState(oldPosts, isFirstFetch: page == 1));

    giveBlogers();
  }

  Future<void> giveBlogers() async {
    cardRepository.getAllCards(page).then((newPosts) {
      // if (newPosts.isEmpty == false) {

      if (newPosts != null) {
        page++;
        final posts = (state as CardLoadingState).oldCard;
        posts.addAll(newPosts.results!);
        emit(CardLoadedState(posts));
      }

      //}
    });
  }

  Future<void> clearBlogers() async {
    emit(CardEmptyState());
  }
}
