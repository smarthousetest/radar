import 'package:get_it/get_it.dart';
import 'package:radar/cubit.dart/cubit.dart';
import 'package:radar/cubit.dart/repo.dart';

final sl = GetIt.instance;

final cardRepository = CardRepository();
final filmRepository = FilmRepository();
Future<void> init() async {
  sl.registerFactory(() => CardCubit(cardRepository));
  sl.registerFactory(() => FilmsCubit(filmRepository));
}
