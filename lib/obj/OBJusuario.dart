class Usuario {
  int? id;
  String? titulo;
  String? primer_nombre;
  String? segundo_nombre;
  String? primer_apellido;
  String? segundo_apellido;
  String? direccion;
  String? dni;
  int?    id_empleado;
  String? nif;
  String? fecha_antiguedad;
  String? categoria_profesional;
  String? puesto;
  int?    banco;
  int?    sucursal;
  int?    cuenta;
  int?    tipo_contrato;
  int?    grupo_cotiz;
  String? cnae;
  String? nro_afiliacion_ss;
  String? centro_trabajo_ciudad;
  String? centro_trabajo_info;
  String? created_at;
  String? updated_at;

  Usuario({
    this.id,
    this.titulo,
    this.primer_nombre,
    this.segundo_nombre,
    this.primer_apellido,
    this.segundo_apellido,
    this.direccion,
    this.dni,
    this.id_empleado,
    this.nif,
    this.fecha_antiguedad,
    this.categoria_profesional,
    this.puesto,
    this.banco,
    this.sucursal,
    this.cuenta,
    this.tipo_contrato,
    this.grupo_cotiz,
    this.cnae,
    this.nro_afiliacion_ss,
    this.centro_trabajo_ciudad,
    this.centro_trabajo_info,
    this.created_at,
    this.updated_at,
  });

  factory Usuario.fromJson(dynamic json)  => Usuario(
    id: json['id'] as int?,
    titulo: json['titulo'] as String?,
    primer_nombre: json['primer_nombre'] as String?,
    segundo_nombre: json['segundo_nombre'] as String?,
    primer_apellido: json['primer_apellido'] as String?,
    segundo_apellido: json['segundo_apellido'] as String?,
    direccion: json['direccion'] as String?,
    dni: json['dni'] as String?,
    id_empleado: json['id_empleado'] as int?,
    nif: json['nif'] as String?,
    fecha_antiguedad: json['fecha_antiguedad'] as String?,
    categoria_profesional: json['categoria_profesional'] as String?,
    puesto: json['puesto'] as String?,
    banco: json['banco'] as int?,
    sucursal: json['sucursal'] as int?,
    cuenta: json['cuenta'] as int?,
    tipo_contrato: json['tipo_contrato'] as int?,
    grupo_cotiz: json['grupo_cotiz'] as int?,
    cnae: json['cnae'] as String?,
    nro_afiliacion_ss: json['nro_afiliacion_ss'] as String?,
    centro_trabajo_ciudad: json['centro_trabajo_ciudad'] as String?,
    centro_trabajo_info: json['centro_trabajo_info'] as String?,
    created_at: json['created_at'] as String?,
    updated_at: json['updated_at'] as String?,
  );

  static List<Usuario> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<Usuario> items =
    bienvenidaList.map((e) => Usuario.fromJson(e)).toList();
    return items ?? [];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "titulo": titulo,
      "id":id,
      "titulo":titulo,
      "primer_nombre":primer_nombre,
      "segundo_nombre":segundo_nombre,
      "primer_apellido":primer_apellido,
      "segundo_apellido":segundo_apellido,
      "direccion":direccion,
      "dni":dni,
      "id_empleado":id_empleado,
      "nif":nif,
      "fecha_antiguedad":fecha_antiguedad,
      "categoria_profesional":categoria_profesional,
      "puesto":puesto,
      "banco":banco,
      "sucursal":sucursal,
      "cuenta":cuenta,
      "tipo_contrato":tipo_contrato,
      "grupo_cotiz":grupo_cotiz,
      "cnae":cnae,
      "nro_afiliacion_ss":nro_afiliacion_ss,
      "centro_trabajo_ciudad":centro_trabajo_ciudad,
      "centro_trabajo_info":centro_trabajo_info,
      "created_at":created_at,
      "updated_at":updated_at,
    };
  }
  
}