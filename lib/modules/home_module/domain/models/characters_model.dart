import 'dart:convert';

import 'models_export.dart';

class ListCharacterModel {
  InfoModel? info;
  List<CharacterModel> results;

  ListCharacterModel({
    this.info,
    required this.results,
  });

  ListCharacterModel copyWith({
    InfoModel? info,
    List<CharacterModel>? results,
  }) =>
      ListCharacterModel(
        info: info ?? this.info,
        results: results ?? this.results,
      );

  factory ListCharacterModel.fromRawJson(String str) =>
      ListCharacterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListCharacterModel.fromJson(Map<String, dynamic> json) =>
      ListCharacterModel(
        info: InfoModel.fromJson(json["info"]),
        results: List<CharacterModel>.from(
            json["results"].map((x) => CharacterModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info!.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class InfoModel {
  int count;
  int pages;
  String next;
  dynamic prev;

  InfoModel({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  InfoModel copyWith({
    int? count,
    int? pages,
    String? next,
    dynamic prev,
  }) =>
      InfoModel(
        count: count ?? this.count,
        pages: pages ?? this.pages,
        next: next ?? this.next,
        prev: prev ?? this.prev,
      );

  factory InfoModel.fromRawJson(String str) =>
      InfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
        count: json["count"] ?? 0,
        pages: json["pages"] ?? 0,
        next: json["next"] ?? '',
        prev: json["prev"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}

class CharacterModel {
  int id;
  String name;
  Status status;
  Species species;
  String type;
  Gender gender;
  LocationModel origin;
  LocationModel location;
  String image;
  List<String> episode;
  String url;
  DateTime created;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  CharacterModel copyWith({
    int? id,
    String? name,
    Status? status,
    Species? species,
    String? type,
    Gender? gender,
    LocationModel? origin,
    LocationModel? location,
    String? image,
    List<String>? episode,
    String? url,
    DateTime? created,
  }) =>
      CharacterModel(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
        species: species ?? this.species,
        type: type ?? this.type,
        gender: gender ?? this.gender,
        origin: origin ?? this.origin,
        location: location ?? this.location,
        image: image ?? this.image,
        episode: episode ?? this.episode,
        url: url ?? this.url,
        created: created ?? this.created,
      );

  factory CharacterModel.fromRawJson(String str) =>
      CharacterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        status: statusValues.map[json["status"]] ?? Status.UNKNOWN,
        species: speciesValues.map[json["species"]] ?? Species.UNKNOWN,
        type: json["type"] ?? '',
        gender: genderValues.map[json["gender"]] ?? Gender.UNKNOWN,
        origin: LocationModel.fromJson(json["origin"]),
        location: LocationModel.fromJson(json["location"]),
        image: json["image"] ?? '',
        episode: List<String>.from(json["episode"].map((x) => x)),
        url: json["url"] ?? '',
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": speciesValues.reverse[species],
        "type": type,
        "gender": genderValues.reverse[gender],
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
        "episode": List<dynamic>.from(episode.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  // Sobreescribe hashCode
  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

enum Gender { FEMALE, MALE, UNKNOWN }

final genderValues = EnumValues(
    {"Female": Gender.FEMALE, "Male": Gender.MALE, "unknown": Gender.UNKNOWN});

enum Species { ALIEN, HUMAN, UNKNOWN }

final speciesValues = EnumValues({
  "Alien": Species.ALIEN,
  "Human": Species.HUMAN,
  "UNKNOWN": Species.UNKNOWN
});

enum Status { ALIVE, DEAD, UNKNOWN }

final statusValues = EnumValues(
    {"Alive": Status.ALIVE, "Dead": Status.DEAD, "unknown": Status.UNKNOWN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
