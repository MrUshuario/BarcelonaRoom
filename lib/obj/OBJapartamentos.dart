import 'package:floor/floor.dart';


class Apartamento {
  @PrimaryKey(autoGenerate: true)
  int? idDepartamento;
  String? ubigeo;
  String? descripcion;
  String? amenidades;
  String? caracteristicas; //CHARLA STRING
  String? precio;
  String? area;
  String? imagen;

  Apartamento({
    this.idDepartamento,
    this.ubigeo,
    this.descripcion,
    this.amenidades,
    this.caracteristicas,
    this.precio,
    this.area,
    this.imagen
  });

  factory Apartamento.fromJson(dynamic json)  => Apartamento(
    idDepartamento: json['idDepartamento'] as int?,
    ubigeo: json['ubigeo'] as String?,
    descripcion: json['descripcion'] as String?,
    amenidades: json['amenidades'] as String?,
    caracteristicas: json['caracteristicas'] as String?,
    precio: json['precio'] as String?,
    area: json['area'] as String?,
    imagen: json['imagen'],
  );

  static List<Apartamento> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<Apartamento> items =
    bienvenidaList.map((e) => Apartamento.fromJson(e)).toList();
    return items ?? [];
  }

  Map<String, dynamic> toMap() {
    return {
      "idDepartamento": idDepartamento,
      "ubigeo":ubigeo,
      "descripcion":descripcion,
      "amenidades":amenidades,
      "caracteristicas": caracteristicas,
      "precio": precio,
      "area": area,
      "imagen": imagen,
    };
  }
  
}