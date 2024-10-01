import 'dart:async';
import 'dart:convert';
import 'package:barcelonaroom/obj/OBJapartamentos.dart';
import 'package:barcelonaroom/utils/HelpersViewAlertaInfo.dart';
import 'package:barcelonaroom/utils/helpersviewInputs.dart';
import 'package:barcelonaroom/utils/helpersviewLetrasSubs.dart';
import 'package:barcelonaroom/utils/resources.dart';
import 'package:barcelonaroom/vistas/home.dart';
import 'package:barcelonaroom/vistas/usuarioperfil_editar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Usuario_perfil extends StatefulWidget {

  TextEditingController formNombre = TextEditingController();
  TextEditingController formContra = TextEditingController();
  bool _isPasswordVisible = true;

  @override
  State<StatefulWidget> createState() => _Usuario_perfil();
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

class _Usuario_perfil extends State<Usuario_perfil> {
  String? PREFname; //1er nombre 2do nombre apellidos
  String? PREFcorreo;


  @override
  void initState() {
    cargardata();
    super.initState();

  }

  Future<void> cargardata()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      PREFname = prefs.getString('name') ?? "USUARIO PRUEBA";
      PREFcorreo = prefs.getString('Correoname') ?? "prueba@gmail.com";
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true, //SACA LA BARRA DEBUG
      home: Scaffold(
        backgroundColor: Resources.fondoBlanquiso,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 40.0, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
            ),

            // Existing content with Center, SingleChildScrollView, and Container
            //Center( child:
            SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    //key: widget.keyForm,
                    child: formUI(),
                  ),
                ),
              ),
           // ),
          ],
        ),
      ),
    );
  }


  Widget formUI() {
    return Container(
        child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 8.0, left: 8.0, right: 8.0),
            child:
            Card(
              elevation: 10,
              child:
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Column(
                        // Add spacing between icon and text (optional)
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [

                      Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child:
                      const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text("A"),
                        maxRadius: 30,
                        //foregroundImage: NetworkImage("enterImageUrl"),
                      ),
                      ),


                        ],
                      ),
                    ),
                  ),


                  Expanded(
                    flex: 8,
                    child:

                    Column(
                      children: [
                        HelpersViewLetrasSubs.formItemsDesign(PREFname!),
                      ],),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

          HelpersViewLetrasSubs.formItemsDesignSub("Documento de Identidad"),
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child:
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      // Add spacing between icon and text (optional)
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.person, size: 50.0, color: Colors.black),
                          onPressed: () {
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child:
                  Column(
                    children: [
                      HelpersViewLetrasSubs.formItemsDesign("00000008"),
                    ],),
                ),
              ],
            ),
          ),
          HelpersViewLetrasSubs.formItemsDesignLinea(),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),
          HelpersViewLetrasSubs.formItemsDesignSub("Direción"),
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child:
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      // Add spacing between icon and text (optional)
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.map, size: 50.0, color: Colors.black),
                          onPressed: () {
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child:
                  Column(
                    children: [
                      HelpersViewLetrasSubs.formItemsDesign("Mz1 Lt1b"),
                    ],),
                ),
              ],
            ),
          ),
          HelpersViewLetrasSubs.formItemsDesignLinea(),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),
          HelpersViewLetrasSubs.formItemsDesignSub("Correo electrónico"),
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child:
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      // Add spacing between icon and text (optional)
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.mail, size: 50.0, color: Colors.black),
                          onPressed: () {
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child:
                  Column(
                    children: [
                      HelpersViewLetrasSubs.formItemsDesign(PREFcorreo!),
                    ],),
                ),
              ],
            ),
          ),
          HelpersViewLetrasSubs.formItemsDesignLinea(),
          HelpersViewLetrasSubs.formItemsDesignSub("Fecha de registro"),
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child:
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      // Add spacing between icon and text (optional)
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.calendar_month, size: 50.0, color: Colors.black),
                          onPressed: () {
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child:
                  Column(
                    children: [
                      HelpersViewLetrasSubs.formItemsDesign("10/10/2024"),
                    ],),
                ),
              ],
            ),
          ),
          HelpersViewLetrasSubs.formItemsDesignLinea(),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),


          GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Usuario_perfileditar()),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Resources.AzulTema,
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: const Text("Modificar datos a",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

        ],),
    );

  }


}
