import 'dart:convert';
import 'package:meta/meta.dart';

class Medicine {
  String idMedicine;
  String description;
  String imageUrl;
  String indications;
  String name;
  String presentation;
  int stock;
  bool isSelected;

  Medicine({
    @required this.description,
    @required this.idMedicine,
    @required this.imageUrl,
    @required this.indications,
    @required this.isSelected,
    @required this.name,
    @required this.presentation,
    @required this.stock,
  })  : assert(description != null),
        assert(idMedicine != null),
        assert(imageUrl != null),
        assert(indications != null),
        assert(isSelected != null),
        assert(name != null),
        assert(presentation != null),
        assert(stock != null);

  factory Medicine.fromRawJson(String str) =>
      Medicine.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        description: json['description'],
        idMedicine: json['idMedicine'],
        imageUrl: json['imageUrl'],
        indications: json['indications'],
        name: json['name'],
        presentation: json['presentation'],
        stock: json['stock'],
        isSelected: false,
      );

  Map<String, dynamic> toJson() => {
        'description': description,
        'idMedicine': idMedicine,
        'imageUrl': imageUrl,
        'indications': indications,
        'name': name,
        'presentation': presentation,
        'stock': stock,
      };
}
