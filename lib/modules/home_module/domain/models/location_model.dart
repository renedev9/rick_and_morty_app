import 'dart:convert';


class LocationModel{
    String name;
    String url;

    LocationModel({
        required this.name,
        required this.url,
    });

    LocationModel copyWith({
        String? name,
        String? url,
    }) => 
        LocationModel(
            name: name ?? this.name,
            url: url ?? this.url,
        );

    factory LocationModel.fromRawJson(String str) => LocationModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}