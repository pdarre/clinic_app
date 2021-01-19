import 'dart:convert';

class Recetas {
  String idReceta;
  String idMedicina;
  String idMedico;
  String idUsuario;
  String notas;
  DateTime fecha;
  bool activa;
  String imagen;
  String nombre;

  Recetas({
    this.activa,
    this.fecha,
    this.idMedicina,
    this.idMedico,
    this.idReceta,
    this.idUsuario,
    this.notas,
    this.imagen,
    this.nombre,
  });

  factory Recetas.fromRawJson(String str) => Recetas.fromJson(json.decode(str));

  factory Recetas.fromJson(Map<String, dynamic> json) => Recetas(
        activa: json['activa'],
        fecha: json['fecha'].toDate(),
        idMedicina: json['idMedicina'],
        idMedico: json['idMedico'],
        idReceta: json['idReceta'],
        idUsuario: json['idUsuario'],
        notas: json['notas'],
        imagen: json['imagen'],
        nombre: json['nombre'],
      );
}
