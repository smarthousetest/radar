import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilmCardView extends StatelessWidget {
  // int number;
  String title;
  FilmCardView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      margin: const EdgeInsets.only(left: 20.0, right: 21.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 25,
            // changes position of shadow
          ),
        ],
        border: Border.all(
          color: Color.fromARGB(255, 45, 45, 46),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(32.0),
        color: Color.fromARGB(255, 241, 241, 246),
        // gradient: const LinearGradient(
        //   colors: [Color(0xFFFFFFFF), Color(0xFFF3F3FF)],
        // ),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 270,
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        "$title",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 22, 22, 22)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
