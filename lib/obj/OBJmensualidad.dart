class Inversion {
  int? codigoInversion;
  String? codigoFondo;
  String? nombreInversion;
  int? montoInversion;
  double? porcentajeInteres;
  int? montoBeneficioTotal;
  String? fechaInversion;

  Inversion({
    this.codigoInversion,
    this.codigoFondo,
    this.nombreInversion,
    this.montoInversion,
    this.porcentajeInteres,
    this.montoBeneficioTotal,
    this.fechaInversion
  });

  factory Inversion.fromJson(dynamic json)  => Inversion(
    codigoInversion: json['codigoInversion'] as int?,
    codigoFondo: json['codigoFondo'] as String?,
    nombreInversion: json['nombreInversion'] as String?,
    montoInversion: json['montoInversion'] as int?,
    porcentajeInteres: json['porcentajeInteres'] as double?,
    montoBeneficioTotal: json['montoBeneficioTotal'] as int?,
    fechaInversion: json['fechaInversion'] as String?,
  );

  static List<Inversion> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<Inversion> items =
    bienvenidaList.map((e) => Inversion.fromJson(e)).toList();
    return items ?? [];
  }

  Map<String, dynamic> toMap() {
    return {
      "codigoInversion": codigoInversion,
      "codigoFondo": codigoFondo,
      "nombreInversion": nombreInversion,
      "montoInversion":montoInversion,
      "porcentajeInteres": porcentajeInteres,
      "montoBeneficioTotal": montoBeneficioTotal,
      "fechaInversion": fechaInversion,
    };
  }
  
}