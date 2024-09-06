class Apartamento {
  int? codigoApartamento;
  String? descripcionApartamento; //CHARLA STRING
  int? precioApartamento; //Condicion visita
  String? urlimagen;

  Apartamento({this.codigoApartamento, this.descripcionApartamento, this.precioApartamento, this.urlimagen});

  factory Apartamento.fromJson(dynamic json)  => Apartamento(
    codigoApartamento: json['codigoApartamento'] as int?,
    descripcionApartamento: json['descripcionApartamento'] as String?,
    precioApartamento: json['precioApartamento'] as int?,
    urlimagen: json['urlimagen'],
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
      "descripcionApartamento": descripcionApartamento,
      "precioApartamento": precioApartamento,
      "urlimagen": urlimagen,

    };
  }
  
}