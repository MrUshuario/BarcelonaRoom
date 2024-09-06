import 'dart:convert';

import 'package:barcelonaroom/obj/OBJusuario.dart';
import 'package:barcelonaroom/utils/resources_apis.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';


class apiprovider_formulario {


  final client = GetIt.I.get<Client>();
  final api_get_login_usuario       = apisResources.REST_LOGIN_USUARIO;
  final api_get_busqueda_listar        = apisResources.REST_BUSQUEDA_LISTAR;
  final api_get_detalle_producto     = apisResources.REST_DETALLE_PRODUCTO;
  final api_get_listar_usuarios     = apisResources.REST_LISTAR_USUARIOS;






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

  Future<List<Usuario>> post_Login(String token) async {
    final Map<String, dynamic> bodyData = {'idFormato': "ingresar login futuro"};
    try {
      print("post_Login");
      String url_login = api_get_login_usuario;
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
        return Usuario.listFromJson(data['formulario']);
      } else {
        List<Usuario> ubi = List.empty();
        return  ubi;
      }
    } catch (e) {
      List<Usuario> ubi = List.empty();
      return  ubi;
    }
  }


}