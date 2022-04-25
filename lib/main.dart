import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/card_model.dart';
import 'package:radar/cubit.dart/state.dart';
import 'package:radar/films_screen.dart';
import 'package:radar/locator.dart' as servic;
import 'package:radar/locator.dart';

import 'cubit.dart/cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await servic.init();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CardCubit>(create: (context) => sl<CardCubit>()),
          BlocProvider<FilmsCubit>(create: (context) => sl<FilmsCubit>()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: "dcd"),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final scrollController = ScrollController();
  List cards = [];
  bool isLoading = false;

  void setupScrollController(BuildContext context) {
    print('isLoading $isLoading');
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          CardCubit blogersCubit = context.read<CardCubit>();
          blogersCubit.fetchBlogers(pagen: "scrool");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    CardCubit cardCubit = context.read<CardCubit>();
    cardCubit.fetchBlogers();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocBuilder<CardCubit, CardState>(
          builder: (context, state) {
            print(state);
            if (state is CardErrorState) {
              return Center(
                child: Text("Ошибка"),
              );
            }
            if (state is CardLoadingState) {
              cards = state.oldCard as List;
              isLoading = true;
            } else if (state is CardLoadedState) {
              cards = state.loadedCard as List;
            }
            // print("nvbkjkjbv ${state.loadedCard?.count}");
            //    ?   ??//print("card ${state.loadedCard?.results[0].name}");
            return ListView.builder(
                controller: scrollController,
                itemCount: cards.length + (isLoading ? 1 : 0),
                itemBuilder: ((context, index) {
                  if (index < cards.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Films(
                                  index: index,
                                  films: cards[index].films,
                                ),
                              ));
                          FilmsCubit filmsCubit = context.read<FilmsCubit>();
                          filmsCubit.fetchFilms(cards[index].films);
                        },
                        child: CardView(
                          title: cards[index].name,
                          text: "dddd",
                        ),
                      ),
                    );
                  } else {
                    print(isLoading);
                    Timer(Duration(milliseconds: 300), () {
                      scrollController
                          .jumpTo(scrollController.position.maxScrollExtent);
                    });
                    if (isLoading == false) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container();
                  }
                }));
          },
        ));
  }
}
