
class apisResources {

  //FORMULARIO
  static const String urlbase 							= "https://iasoftworld.com/public/";

  //OFICIAL
  //SI SE LE AGREGA UN LUGAR SE PUEDE TRAER UNO ESPECIFICO
  static const String REST_BUSQUEDA_LISTAR_GENERAL					          = "${urlbase}habitaciones/";
  //SI SE LE AGREGA UN LUGAR SE PUEDE TRAER UNO ESPECIFICO UBIGEO
  static const String REST_BUSQUEDA_LISTAR_HABITACION							    = "${urlbase}habitaciones/ubigeo/"; //POR LUGAR
  //SI SE LE AGREGA UN LUGAR SE PUEDE TRAER UNO ESPECIFICO DESCRIPCION
  static const String REST_BUSQUEDA_LISTAR_DESCRIPCION						    = "${urlbase}habitaciones/descripcion/Departamento"; //ME LISTA ALL
  //PASO EL ID DE LA HABITACION SELECCIONADA
  static const String REST_habitaciondetalle 							            = "${urlbase}habitaciondetalle/";
  //DETALLES INVERSION LO ODEL USUARIO
  static const String REST_inversiones						                    =	"${urlbase}inversiones";
  //Un usuarios con su inversiones
  static const String REST_usuariosdeinversiones 					            =	"${urlbase}usuariosdeinversiones";
  //Un usuarios con su inversiones
  static const String REST_LISTAR_USUARIOS_INVERSIONES	 					    =	"${urlbase}inversiones-con-usuarios";

}