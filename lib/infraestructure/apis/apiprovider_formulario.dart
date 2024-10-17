import 'dart:convert';
import 'package:barcelonaroom/obj/OBJapartamentos.dart';
import 'package:barcelonaroom/obj/OBJapartamentosDetalle.dart';
import 'package:barcelonaroom/obj/OBJusuarios.dart';
import 'package:barcelonaroom/obj/sql/respformato.dart';
import 'package:barcelonaroom/utils/resources_apis.dart';
import 'package:crypto/crypto.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;


class apiprovider_formulario {


  //final client = GetIt.I.get<Client>();
  final api_get_busqueda_listar_general               = apisResources.REST_BUSQUEDA_LISTAR_GENERAL;
  final api_get_busqueda_listar                       = apisResources.REST_BUSQUEDA_LISTAR_HABITACION;
  final api_get_detalle_producto                      = apisResources.REST_habitaciondetalle;
  final api_get_listar_departamento_detalle           = apisResources.REST_BUSQUEDA_LISTAR_DESCRIPCION;
  final api_get_inversiones                           = apisResources.REST_inversiones;
  final api_get_usuariosdeinversiones 		            = apisResources.REST_usuariosdeinversiones;
  final api_get_listar_usuarios_inversiones           = apisResources.REST_LISTAR_USUARIOS_INVERSIONES;

  final api_post_enviarUsuario                        = apisResources.REST_ENVIAR_USUARIO;

  final api_get_login_contra        = apisResources.REST_LOGIN_CONTRA;
  final api_get_login_google       = apisResources.REST_LOGIN_GOOGLE;
  final api_get_login_facebook        = apisResources.REST_LOGIN_FACABOOK;




  //EJEMPLO CON LISTAS

  Future<usuariotrabajador> post_Login(String correo, String contra, String tipo) async {
    try {
      var bytes1 = utf8.encode(contra);         // data being hashed
      var hash = sha256.convert(bytes1);         // Hashing Process

      final Map<String, dynamic> bodyData = {'hash': '$hash', 'correo': '$correo'};
      print(bodyData);
      String url_login = "$api_get_login_contra";
     if (tipo == "google") {
       url_login = "$api_get_login_google";
      } else if (tipo == "facebook"){
       url_login = "$api_get_login_facebook";
      }
     /*
             headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      */
      print("iniciando get_Login...");
      Uri uri = Uri.parse(url_login);
      final response = await http.post(
        uri,
        body: bodyData,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return usuariotrabajador.fromJson(data);
      } else {
        usuariotrabajador obj = usuariotrabajador();
        obj.primernombre = "errorNOENVIADO";
        return  obj;
      }
    } catch (e) {
      usuariotrabajador obj = usuariotrabajador();
      obj.primernombre = "errorNOENVIADO";
      return  obj;
    }
  }


  //DESCARGAR APARTAMENTO
  Future<List<Apartamento>> get_DescargarApartamento(String distrito) async {
    try {

      //SharedPreferences prefs = await SharedPreferences.getInstance();
      //String token = prefs.getString('token') ?? "ERROR";
      String url_login = "$api_get_busqueda_listar$distrito";
      print("iniciando get_DescargarApartamento...");
      if ( distrito == ""){
        url_login = api_get_busqueda_listar_general;
      }

      Uri uri = Uri.parse(url_login);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("response DEPARTAMENTO...${response.body}");
        //List<dynamic> datapre = jsonDecode(response.body);
        final Map<String, dynamic> data = jsonDecode(response.body);
        //DEVOLVER DATOS LOGIN
        //return Apartamento.listFromJson(data['object']);
        return Apartamento.listFromJson(data['habitaciones']);
      } else if (response.statusCode == 401) {
        List<Apartamento> tipo = [];
        Apartamento obj = Apartamento();
        obj.idDepartamento = 999999;
        tipo.add(obj);
        return  tipo;
      } else {
        List<Apartamento> tipo = List.empty();
        return  tipo;
      }
    } catch (e) {
      List<Apartamento> tipo = List.empty();
      return  tipo;
    }
  }

  //DESCARGAR APARTAMENTO DETALLE
  Future<ApartamentoDetalle> get_DescargarApartamentoDETALLE(int? idapartamento) async {
    try {

      //idapartamento
      String url_login = "$api_get_detalle_producto";
      print("iniciando get_DescargarApartamentoDETALLE...");

      Uri uri = Uri.parse(url_login);
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("response get_DescargarApartamentoDETALLE...${response.body}");
        final Map<String, dynamic> data = jsonDecode(response.body);
        //DEVOLVER DATOS LOGIN
        return ApartamentoDetalle.fromJson(data['habitaciones']);
      } else if (response.statusCode == 401) {
        ApartamentoDetalle obj = ApartamentoDetalle();
        obj.id = 999999;
        return  obj;
      } else {
        ApartamentoDetalle obj = ApartamentoDetalle();
        return  obj;
      }
    } catch (e) {
      ApartamentoDetalle obj = ApartamentoDetalle();
      return  obj;
    }
  }


  //DESCARGAR APARTAMENTO
  Future<respFormato> post_EnviarUsuario(usuariotrabajador usuario) async {
    try {

      String url_login = "$api_post_enviarUsuario";
      print("iniciando post_EnviarUsuario...");
      var body = json.encode(usuario.toMap());
      print(body);
      Uri uri = Uri.parse(url_login);
      final response = await http.post(
        uri,
        body: json.encode(usuario.toMap()),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return respFormato.fromJson(json.decode(response.body));
      } else {
        respFormato obj = respFormato();
        obj.coMensaje = "Ocurrio un error en el envio";
        return  obj;
      }
    } catch (e) {
      respFormato obj = respFormato();
      obj.coMensaje = "Ocurrio un error en el envio";
      return  obj;
    }
  }



}