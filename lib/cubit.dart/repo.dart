import 'package:radar/cubit.dart/cubit.dart';
import 'package:radar/cubit.dart/model.dart';

class CardRepository {
  ApiCubit apiCubit = ApiCubit();
  Future<Model?> getAllCards(int page) => apiCubit.getConfig(page);
}

class FilmRepository {
  FilmsApi filmsApi = FilmsApi();
  Future<List<Films>?> getAllFilms(List films) => filmsApi.getConfig2(films);
}
