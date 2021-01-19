import 'dart:convert';

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
    this.description,
    this.idMedicine,
    this.imageUrl,
    this.indications,
    this.isSelected,
    this.name,
    this.presentation,
    this.stock,
  });

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
        "description": description,
        "idMedicine": idMedicine,
        "imageUrl": imageUrl,
        "indications": indications,
        "name": name,
        "presentation": presentation,
        "stock": stock,
      };
}
