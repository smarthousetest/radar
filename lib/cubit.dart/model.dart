import 'dart:convert';

Model modelFromJson(String str) => Model.fromJson(json.decode(str));

String modelToJson(Model data) => json.encode(data.toJson());

class Model {
  Model({
    this.count,
    this.previous,
    this.results,
  });

  int? count;
  dynamic previous;
  List<Result>? results;

  factory Model.fromJson(Map<String, dynamic> json) {
    print("fdf");
    return Model(
      count: json["count"],
      previous: json["previous"],
      results:
          List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );
  }
  Map<String, dynamic> toJson() => {
        "count": count,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeworld,
    this.films,
    this.species,
    this.vehicles,
    this.starships,
    this.created,
    this.edited,
    this.url,
  });

  String? name;
  String? height;
  String? mass;
  String? hairColor;
  String? skinColor;
  String? eyeColor;
  String? birthYear;
  Gender? gender;
  String? homeworld;
  List<String>? films;
  List<String>? species;
  List<String>? vehicles;
  List<String>? starships;
  DateTime? created;
  DateTime? edited;
  String? url;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        height: json["height"],
        mass: json["mass"],
        hairColor: json["hair_color"],
        skinColor: json["skin_color"],
        eyeColor: json["eye_color"],
        birthYear: json["birth_year"],
        gender: genderValues.map[json["gender"]],
        homeworld: json["homeworld"],
        films: List<String>.from(json["films"].map((x) => x)),
        species: List<String>.from(json["species"].map((x) => x)),
        vehicles: List<String>.from(json["vehicles"].map((x) => x)),
        starships: List<String>.from(json["starships"].map((x) => x)),
        created: DateTime.parse(json["created"]),
        edited: DateTime.parse(json["edited"]),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "height": height,
        "mass": mass,
        "hair_color": hairColor,
        "skin_color": skinColor,
        "eye_color": eyeColor,
        "birth_year": birthYear,
        "gender": genderValues.reverse![gender],
        "homeworld": homeworld,
        "films": List<dynamic>.from(films!.map((x) => x)),
        "species": List<dynamic>.from(species!.map((x) => x)),
        "vehicles": List<dynamic>.from(vehicles!.map((x) => x)),
        "starships": List<dynamic>.from(starships!.map((x) => x)),
        "created": created!.toIso8601String(),
        "edited": edited!.toIso8601String(),
        "url": url,
      };
}

enum Gender { MALE, N_A, FEMALE }

final genderValues = EnumValues(
    {"female": Gender.FEMALE, "male": Gender.MALE, "n/a": Gender.N_A});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

//-----------------------

// To parse this JSON data, do
//
//     final films = filmsFromJson(jsonString);

List<Films> filmsFromJson(String str) =>
    List<Films>.from(json.decode(str).map((x) => Films.fromJson(x)));

String filmsToJson(List<Films> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Films {
  Films({
    this.title,
    this.episodeId,
    this.openingCrawl,
    this.director,
    this.producer,
    this.releaseDate,
    this.characters,
    this.planets,
    this.starships,
    this.vehicles,
    this.species,
    this.created,
    this.edited,
    this.url,
  });

  String? title;
  int? episodeId;
  String? openingCrawl;
  String? director;
  String? producer;
  DateTime? releaseDate;
  List<String>? characters;
  List<String>? planets;
  List<String>? starships;
  List<String>? vehicles;
  List<String>? species;
  DateTime? created;
  DateTime? edited;
  String? url;

  factory Films.fromJson(Map<String, dynamic> json) {
    print('check card');
    return Films(
      title: json["title"],
      episodeId: json["episode_id"],
      openingCrawl: json["opening_crawl"],
      director: json["director"],
      producer: json["producer"],
      releaseDate: DateTime.parse(json["release_date"]),
      characters: List<String>.from(json["characters"].map((x) => x)),
      planets: List<String>.from(json["planets"].map((x) => x)),
      starships: List<String>.from(json["starships"].map((x) => x)),
      vehicles: List<String>.from(json["vehicles"].map((x) => x)),
      species: List<String>.from(json["species"].map((x) => x)),
      created: DateTime.parse(json["created"]),
      edited: DateTime.parse(json["edited"]),
      url: json["url"],
    );
  }
  Map<String, dynamic> toJson() => {
        "title": title,
        "episode_id": episodeId,
        "opening_crawl": openingCrawl,
        "director": director,
        "producer": producer,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "characters": List<dynamic>.from(characters!.map((x) => x)),
        "planets": List<dynamic>.from(planets!.map((x) => x)),
        "starships": List<dynamic>.from(starships!.map((x) => x)),
        "vehicles": List<dynamic>.from(vehicles!.map((x) => x)),
        "species": List<dynamic>.from(species!.map((x) => x)),
        "created": created!.toIso8601String(),
        "edited": edited!.toIso8601String(),
        "url": url,
      };
}
