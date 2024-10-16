class usuariotrabajador {
  int? codigoUsuario;
  String? primernombre;
  String? segundonombre;
  String? primerapellido;
  String? segundoapellido;
  String? direccion;
  String? telefono;
  String? dni;
  String? fechanacimiento;
  String? idempleado; //esto podria ir a una nueva tabla
  String? nif;
  String? fechaantiguedad;
  String? categoriaprofesional;
  String? puesto;
  int? banco;
  int? sucursal;
  int? cuenta;
  int? tipocontrato;
  int? cnae;
  String? nroafiliaciones;
  String? centrotrabajociudad;
  String? centrotrabajoinfo;
  String? createat;
  String? uploadat;
  String? imagen;
  String? hashcontra;
  String? token;

  //TOKEN verificaiion en otra tabla

  usuariotrabajador({
    this.codigoUsuario,
    this.primernombre,
    this.segundonombre,
    this.primerapellido,
    this.segundoapellido,
    this.direccion,
    this.telefono,
    this.dni,
    this.fechanacimiento,
    this.idempleado,
    this.nif,
    this.fechaantiguedad,
    this.categoriaprofesional,
    this.puesto,
    this.banco,
    this.sucursal,
    this.cuenta,
    this.tipocontrato,
    this.cnae,
    this.nroafiliaciones,
    this.centrotrabajociudad,
    this.centrotrabajoinfo,
    this.createat,
    this.uploadat,
    this.imagen,
    this.hashcontra,
    this.token,
  });

  factory usuariotrabajador.fromJson(dynamic json)  => usuariotrabajador(
    codigoUsuario: json['codigoUsuario'] as int?,
    primernombre: json['primernombre'] as String?,
    segundonombre: json['segundonombre'] as String?,
    primerapellido: json['primerapellido'] as String?,
    segundoapellido: json['segundoapellido'] as String?,
    direccion: json['direccion'] as String?,
    telefono: json['telefono'] as String?,
    dni: json['dni'] as String?,
    fechanacimiento: json['fechanacimiento'] as String?,
    idempleado: json['idempleado'] as String?,
    nif: json['nif'] as String?,
    fechaantiguedad: json['fechaantiguedad'] as String?,
    categoriaprofesional: json['categoriaprofesional'] as String?,
    puesto: json['puesto'] as String?,
    banco: json['banco'] as int?,
    sucursal: json['sucursal'] as int?,
    cuenta: json['cuenta'] as int?,
    tipocontrato: json['tipocontrato'] as int?,
    cnae: json['cnae'] as int?,
    nroafiliaciones: json['nroafiliaciones'] as String?,
    centrotrabajociudad: json['centrotrabajociudad'] as String?,
    centrotrabajoinfo: json['centrotrabajoinfo'] as String?,
    createat: json['createat'] as String?,
    uploadat: json['uploadat'] as String?,
    imagen: json['imagen'] as String?,
    hashcontra: json['hashcontra'] as String?,
    token: json['token'] as String?
  );

  static List<usuariotrabajador> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<usuariotrabajador> items =
    bienvenidaList.map((e) => usuariotrabajador.fromJson(e)).toList();
    return items ?? [];
  }

  Map<String, dynamic> toMap() {
    return {
      "codigoUsuario": codigoUsuario,
      "primernombre": primernombre,
      "segundonombre": segundonombre,
      "primerapellido": primerapellido,
      "segundoapellido": segundoapellido,
      "direccion": direccion,
      "telefono":telefono,
      "dni": dni,
      "fechanacimiento":fechanacimiento,
      "idempleado": idempleado,
      "nif": nif,
      "fechaantiguedad": fechaantiguedad,
      "categoriaprofesional": categoriaprofesional,
      "puesto": puesto,
      "banco": banco,
      "sucursal": sucursal,
      "cuenta": cuenta,
      "tipocontrato": tipocontrato,
      "cnae": cnae,
      "nroafiliaciones": nroafiliaciones,
      "centrotrabajociudad": centrotrabajociudad,
      "centrotrabajoinfo": centrotrabajoinfo,
      "createat": createat,
      "uploadat": uploadat,
      "imagen":imagen,
      "hashcontra":hashcontra,
      "token":token,
    };
  }
  
}