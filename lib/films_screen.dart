import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:radar/cubit.dart/cubit.dart';
import 'package:radar/cubit.dart/state.dart';
import 'package:radar/film_card_model.dart';

class Films extends StatefulWidget {
  int index;
  List films;

  Films({Key? key, required this.index, required this.films});
  @override
  State<Films> createState() => _FilmsState();
}

class _FilmsState extends State<Films> {
  @override
  void initState() {
    print(widget.films);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<FilmsCubit, FilmsState>(
        builder: (context, state) {
          print("state $state");
          if (state is FilmsErrorState) {
            return Center(
              child: Text("Ошибка"),
            );
          }
          if (state is FilmsLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FilmsLoadedState) {
            print("title ${state.loadedFilms}");
            return ListView.builder(
                itemCount: widget.films.length,
                itemBuilder: ((context, index) {
                  return Center(
                      child: Text('${state.loadedFilms?[index].title}'));
                }));
          }

          return Text('ffffff');
        },
      ),
    );
  }
}
