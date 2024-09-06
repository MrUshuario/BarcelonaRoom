import 'dart:async';
import 'dart:convert';
import 'package:barcelonaroom/firebase_options.dart';
import 'package:barcelonaroom/utils/resources.dart';
import 'package:barcelonaroom/vistas/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;



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

  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  //GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formUsuarioCtrl = TextEditingController();
  TextEditingController formClaveCtrl = TextEditingController();


  bool _isPasswordVisible = true;

  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => login());

  @override
  State<StatefulWidget> createState() => _login();
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

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
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
    return Column(
      children: <Widget>[

        const Text("prueba"),


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
              child: const Text("GOOGLE SIGILO",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
            )),

        GestureDetector(
            onTap: ()  {
              _handleSignIn();
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
              child: const Text("GOOGLE SIGN",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
            )),


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
              child: const Text("SALIR",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
            )),

        GestureDetector(
            onTap: ()  {
              //Navigator.pop(context); // Cierra el diálogo
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
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
              child: const Text("IR A HOME",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
            )),


            IconButton(
                icon: Image.asset(Resources.google),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }
            )





      ],
    );
  }


}
