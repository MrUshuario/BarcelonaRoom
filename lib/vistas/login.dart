import 'dart:async';
import 'dart:convert';
import 'package:barcelonaroom/firebase_options.dart';
import 'package:barcelonaroom/utils/helpersviewInputs.dart';
import 'package:barcelonaroom/utils/helpersviewLetrasSubs.dart';
import 'package:barcelonaroom/utils/resources.dart';
import 'package:barcelonaroom/vistas/crear_cuenta.dart';
import 'package:barcelonaroom/vistas/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);


class login extends StatefulWidget {


  //GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formUsuarioCtrl = TextEditingController();
  TextEditingController formClaveCtrl = TextEditingController();


  bool _isPasswordVisible = true;

  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => login());

  @override
  State<StatefulWidget> createState() => _login();
}

class PasswordVisibilityToggle extends StatefulWidget {
  const PasswordVisibilityToggle({
    Key? key,
    required this.isPasswordVisible,
    required this.onToggle,
  }) : super(key: key);
  final bool isPasswordVisible;
  final VoidCallback onToggle;
  @override
  State<PasswordVisibilityToggle> createState() => _PasswordVisibilityToggleState();
}

class _PasswordVisibilityToggleState extends State<PasswordVisibilityToggle> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
      ),
      onPressed: () {
        widget.onToggle();
      },
    );
  }
}


class _login extends State<login> {

  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';


  @override
  void initState() {
    initializeDatabase();
    super.initState();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      bool isAuthorized = account != null;
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }
      setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });
      if (isAuthorized) {
        unawaited(_handleGetContact(account!));
      }
    });

    //_googleSignIn.signInSilently();

  }

  Future<void> initializeDatabase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,);
  }

  //FUNCION PRINCIPAL DEL LOGEO!
  Future<void> _handleSignIn() async {
    try {
      _currentUser = await _googleSignIn.signIn();

      if (_currentUser != null) {
        String? username = _currentUser?.displayName;
        String? correoname = _currentUser?.email;
        if (username != null) {
          // Use the username as needed
          print("Username: $username");
          print("Correoname: $correoname");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('name', username!);
          await prefs.setString('Correoname', correoname!);
        }
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } catch (error) {
      print("VALLA FALLO DE NUEVO");
      print(error);
    }
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
            (dynamic name) =>
        (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleAuthorizeScopes() async {
    final bool isAuthorized = await _googleSignIn.requestScopes(scopes);
    // #enddocregion RequestScopes
    setState(() {
      _isAuthorized = isAuthorized;
    });
    // #docregion RequestScopes
    if (isAuthorized) {
      unawaited(_handleGetContact(_currentUser!));
    }
    // #enddocregion RequestScopes
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  void googlelogin() {
    _googleSignIn.signInSilently();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true, //SACA LA BARRA DEBUG
      home: Scaffold(
        appBar: null,
        //drawer: const MenuLateral(),
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Container(
                  width: 420,
                  margin: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Form(
                    //key: widget.keyForm,
                    child: formUI(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }





  Widget formUI() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Column(
          children: <Widget>[
            GestureDetector(
                onTap: ()  {
                  //BOTON GOOGLE
                  _handleSignIn();
                },
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    color: Resources.AzulTema,
                  ),
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: const Text("GOOGLE SIGN",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                )),
          ],
      );
    } else {
      return Column(
        children: <Widget>[

          Align(
              alignment: Alignment.topCenter,
              child: Container(
                /*
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ), */
                margin: EdgeInsets.only(top: 10),
                child: Image.asset( Resources.loginlogo,
                  width: 250,
                  height: 60,),
              )),

          Align(
              alignment: Alignment.topCenter,
              child: Container(
                //margin: EdgeInsets.only(bottom: 20),
                child: Image.asset( Resources.siContigo,
                  width: 250,
                  height: 100,),
              )),

          //TESTEO
          Visibility(
            visible: _isAuthorized,
            child: const Text("AUTORIZADO TESTEO"),
          ),

          //ENTRADA SIGILOSA
          /*
          GestureDetector(
              onTap: ()  {
                googlelogin();
              },
              child: Container(
                margin: const EdgeInsets.all(10.0),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Color.fromARGB(255, 27, 65, 187),
                ),
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: const Text("GOOGLE SIGILO TESTEO",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              )),

           */

          HelpersViewInputs.formItemsDesignlogin(
            "Usuario:", // Empty title (optional)
            Center(
              child: TextFormField(
                controller: widget.formUsuarioCtrl,
                //readOnly: true, // Optional: Set to true if the field is read-only
                inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Optional: Restrict input to digits
                maxLength: 8,
                decoration: InputDecoration(
                  hintText: "Usuario", // Hint text for empty field
                  counterText: "", // Hides character counter (optional)
                ),
              ),
            ),
          ),


          Card(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              //side: BorderSide(color: Color.fromARGB(255, 45, 55, 207)), // Red border
              side: BorderSide(color: Colors.black), // Red border
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Optional padding
              child: Center( // Center the text field content
                child: TextFormField(
                  controller: widget.formClaveCtrl,
                  obscureText: widget._isPasswordVisible,
                  maxLength: 20,
                  decoration: InputDecoration(
                    hintText: "Ingrese su contraseña",
                    counterText: "",
                    suffixIcon: PasswordVisibilityToggle(
                      isPasswordVisible: widget._isPasswordVisible,
                      onToggle: () {
                        setState(() {
                          widget._isPasswordVisible = !widget._isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),

          GestureDetector(
              onTap: () async {
                //CargaDialog();

                String usuario = widget.formUsuarioCtrl.text!;
                String contra = widget.formClaveCtrl.text!;

                /*
                ReponseInicioFinActividades resp = ReponseInicioFinActividades();
                resp = await apiVersion.post_LoginUsuarios(usuario,contra);
                print(resp.nroDoc);
                if(resp.nroDoc != null){

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('name', resp.name!);
                  await prefs.setString('apPaterno', resp.apPaterno!);
                  await prefs.setString('apMaterno', resp.apMaterno!);
                  await prefs.setString('nroDoc', resp.nroDoc!);
                  await prefs.setString('typeUser', resp.typeUser!);
                  if (resp.distrito != null) {
                    await prefs.setString('distrito', resp.distrito!);
                  } else {
                    await prefs.setString('distrito', "No registrado");
                  }
                  //TALVEZ DEPARTAMENTO

                  //GUARDAR DATOS

                 */
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Home()),
                  );
                  /*
                }else {
                  if(resp.name == "9999"){
                    //ENCONTRO UN ERROR
                    _mostrarLoadingStreamController.add(true);
                    _mostrarLoadingStreamControllerTEXTO.add("Error en la base de datos");
                    //UsuarioNoEncontrado( "Error en la base de datos");
                  } else {
                    //NO ENCONTRO
                    _mostrarLoadingStreamController.add(true);
                    _mostrarLoadingStreamControllerTEXTO.add("No se ha encontrado el usuario");
                    //UsuarioNoEncontrado( "No se ha encontrado el usuario");
                  }
                } */

              },
              child: Container(
                //margin: const EdgeInsets.all(30.0),
                margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Resources.AzulTema,
                ),
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: const Text("Ingresar",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),

          GestureDetector(
              onTap: () async {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Crear_cuenta()),
                );


              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Resources.AzulTema,
                ),
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: const Text("Crear cuenta",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),

          HelpersViewLetrasSubs.formItemsDesign2("Ingreso con Google"),

          IconButton(
              icon: Image.asset(
                  Resources.google,
                width: double.maxFinite,
                height: 50.0,),
              onPressed: () async {
                await _handleSignIn();
                //POR EL MOMENTO
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
                //BORAR DESPUES
              }
          ),

        ],
      );
    }

  }


}
