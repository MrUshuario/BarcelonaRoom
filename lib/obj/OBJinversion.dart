class AportacionEmpresarial {
  int? codigoInversion; //LLAVE
  int? codigoApartamento; //FK OBJapartamentos
  int? codigoaportacion;  //FK OBJimporte
  int? codigoUsuario; //FK OBJUsuario
  String? codigoFondo;
  String? nombreInversion;
  int? montoInversion;
  double? porcentajeInteres;
  int? montoBeneficioTotal;
  String? fechaInversion;

  AportacionEmpresarial({
    this.codigoInversion,
    this.codigoApartamento, //FK
    this.codigoaportacion,  //FK
    this.codigoUsuario, //FK
    this.codigoFondo,
    this.nombreInversion,
    this.montoInversion,
    this.porcentajeInteres,
    this.montoBeneficioTotal,
    this.fechaInversion
  });

  factory AportacionEmpresarial.fromJson(dynamic json)  => AportacionEmpresarial(
    codigoInversion: json['codigoInversion'] as int?,
    codigoApartamento: json['codigoApartamento'] as int?,
    codigoaportacion: json['codigoaportacion'] as int?,
    codigoUsuario: json['codigoUsuario'] as int?,
    codigoFondo: json['codigoFondo'] as String?,
    nombreInversion: json['nombreInversion'] as String?,
    montoInversion: json['montoInversion'] as int?,
    porcentajeInteres: json['porcentajeInteres'] as double?,
    montoBeneficioTotal: json['montoBeneficioTotal'] as int?,
    fechaInversion: json['fechaInversion'] as String?,
  );

  static List<AportacionEmpresarial> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<AportacionEmpresarial> items =
    bienvenidaList.map((e) => AportacionEmpresarial.fromJson(e)).toList();
    return items ?? [];
  }

  Map<String, dynamic> toMap() {
    return {
      "codigoInversion": codigoInversion,
      "codigoApartamento": codigoApartamento,
      "codigoaportacion": codigoaportacion,
      "codigoUsuario": codigoUsuario,
      "codigoFondo": codigoFondo,
      "nombreInversion": nombreInversion,
      "montoInversion":montoInversion,
      "porcentajeInteres": porcentajeInteres,
      "montoBeneficioTotal": montoBeneficioTotal,
      "fechaInversion": fechaInversion,
    };
  }
  
}