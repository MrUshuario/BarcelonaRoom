import 'dart:convert';
import 'package:barcelonaroom/obj/OBJapartamentos.dart';
import 'package:barcelonaroom/obj/OBJusuarios.dart';
import 'package:barcelonaroom/utils/resources_apis.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';


class apiprovider_formulario {


  final client = GetIt.I.get<Client>();
  final api_get_busqueda_listar_general               = apisResources.REST_BUSQUEDA_LISTAR_GENERAL;
  final api_get_busqueda_listar                       = apisResources.REST_BUSQUEDA_LISTAR_HABITACION;
  final api_get_detalle_producto                      = apisResources.REST_habitaciondetalle;
  final api_get_listar_departamento_detalle           = apisResources.REST_BUSQUEDA_LISTAR_DESCRIPCION;
  final api_get_inversiones                           = apisResources.REST_inversiones;
  final api_get_usuariosdeinversiones 		            = apisResources.REST_usuariosdeinversiones;
  final api_get_listar_usuarios_inversiones           = apisResources.REST_LISTAR_USUARIOS_INVERSIONES;





  //EJEMPLO CON LISTAS
/*
  Future<List<Formulario>> get_FormularioLista() async {
    try {
      print("iniciando api_get_LoginForm...");
    String url_login = api_get_LoginForm;
    Uri uri = Uri.parse(url_login);
    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    print("response api_get_LoginForm...${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Formulario.listFromJson(data['formulario']);
      } else {
        List<Formulario> ubi = List.empty();
        return  ubi;
      }
    } catch (e) {
      List<Formulario> ubi = List.empty();
      return  ubi;
    }
  }
*/

  //AUTOGENERADO YA NO SE USA

  Future<List<usuariotrabajador>> post_Login(String token) async {
    final Map<String, dynamic> bodyData = {'idFormato': "ingresar login futuro"};
    try {
      print("post_Login");
      String url_login = "api_get_login_usuario";
      Uri uri = Uri.parse(url_login);
      final response = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(bodyData),
      );
      print("response api_get_LoginForm FINAL...${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return usuariotrabajador.listFromJson(data['formulario']);
      } else {
        List<usuariotrabajador> ubi = List.empty();
        return  ubi;
      }
    } catch (e) {
      List<usuariotrabajador> ubi = List.empty();
      return  ubi;
    }
  }

  //DESCARGAR APARTAMENTO
  Future<List<Apartamento>> get_DescargarApartamento(String distrito) async {
    try {

      //SharedPreferences prefs = await SharedPreferences.getInstance();
      //String token = prefs.getString('token') ?? "ERROR";
      String url_login = "$api_get_busqueda_listar$distrito";
      print("iniciando post_DescargarApartamento...");
      if ( distrito == ""){
        url_login = api_get_busqueda_listar_general;
      }

      Uri uri = Uri.parse(url_login);
      final response = await client.get(
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


}