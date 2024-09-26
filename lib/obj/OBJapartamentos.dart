import 'package:floor/floor.dart';

@entity
class Apartamento {
  @PrimaryKey(autoGenerate: true)
  int? codigoApartamento;
  String? ubigeo;
  String? descripcion;
  String? amenidades;
  String? caracteristicas; //CHARLA STRING
  String? precio;
  String? area;
  String? imagen;

  Apartamento({
    this.codigoApartamento,
    this.ubigeo,
    this.descripcion,
    this.amenidades,
    this.caracteristicas,
    this.precio,
    this.area,
    this.imagen
  });

  factory Apartamento.fromJson(dynamic json)  => Apartamento(
    codigoApartamento: json['codigoApartamento'] as int?,
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
      "codigoApartamento": codigoApartamento,
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