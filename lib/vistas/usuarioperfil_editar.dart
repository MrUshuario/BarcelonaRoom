import 'dart:async';
import 'dart:convert';
import 'package:barcelonaroom/obj/OBJapartamentos.dart';
import 'package:barcelonaroom/utils/HelpersViewAlertaInfo.dart';
import 'package:barcelonaroom/utils/helpersviewInputs.dart';
import 'package:barcelonaroom/utils/helpersviewLetrasSubs.dart';
import 'package:barcelonaroom/utils/resources.dart';
import 'package:barcelonaroom/vistas/home.dart';
import 'package:barcelonaroom/vistas/usuarioperfil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class Usuario_perfileditar extends StatefulWidget {

  TextEditingController formNombre1 = TextEditingController();
  TextEditingController formNombre2 = TextEditingController();
  TextEditingController formApeP = TextEditingController();
  TextEditingController formApeM = TextEditingController();
  TextEditingController formDirrecion = TextEditingController();
  TextEditingController formContra = TextEditingController();
  TextEditingController formContraRepetir = TextEditingController();
  TextEditingController formContra2 = TextEditingController();
  bool _isPasswordVisible = true;
  bool _isPasswordVisibleRepetir = true;
  bool _isPasswordVisible2 = true;

  @override
  State<StatefulWidget> createState() => _Usuario_perfileditar();
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

class _Usuario_perfileditar extends State<Usuario_perfileditar> {

  @override
  void initState() {
    funcion();
    super.initState();

  }

  void funcion()  {

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
                MaterialPageRoute(builder: (context) => Usuario_perfil()),
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

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

          HelpersViewLetrasSubs.formItemsDesign("Primer Nombre"),
          HelpersViewInputs.formItemsDesignInput(
            Icons.person,
            Center(
              child: TextFormField(
                controller: widget.formNombre1,
                //readOnly: true, // Optional: Set to true if the field is read-only
                maxLength: 50,
                decoration: const InputDecoration(
                  hintText: "Primer Nombre", // Hint text for empty field
                  counterText: "", // Hides character counter (optional)
                ),
              ),
            ),
          ),

          HelpersViewLetrasSubs.formItemsDesign("Segundo Nombre"),
          HelpersViewInputs.formItemsDesignInput(
            Icons.person,
            Center(
              child: TextFormField(
                controller: widget.formNombre2,
                //readOnly: true, // Optional: Set to true if the field is read-only
                maxLength: 50,
                decoration: const InputDecoration(
                  hintText: "Segundo Nombre", // Hint text for empty field
                  counterText: "", // Hides character counter (optional)
                ),
              ),
            ),
          ),

          HelpersViewLetrasSubs.formItemsDesign("Apellido Paterno"),
          HelpersViewInputs.formItemsDesignInput(
            Icons.person,
            Center(
              child: TextFormField(
                controller: widget.formApeP,
                //readOnly: true, // Optional: Set to true if the field is read-only
                maxLength: 50,
                decoration: const InputDecoration(
                  hintText: "Apellido Paterno", // Hint text for empty field
                  counterText: "", // Hides character counter (optional)
                ),
              ),
            ),
          ),

          HelpersViewLetrasSubs.formItemsDesign("Apellido Materno"),
          HelpersViewInputs.formItemsDesignInput(
            Icons.person,
            Center(
              child: TextFormField(
                controller: widget.formApeM,
                //readOnly: true, // Optional: Set to true if the field is read-only
                maxLength: 50,
                decoration: const InputDecoration(
                  hintText: "Apellido Materno", // Hint text for empty field
                  counterText: "", // Hides character counter (optional)
                ),
              ),
            ),
          ),

          HelpersViewLetrasSubs.formItemsDesign("Dirección"),
          HelpersViewInputs.formItemsDesignInput(
            Icons.map,
            Center(
              child: TextFormField(
                controller: widget.formDirrecion,
                //readOnly: true, // Optional: Set to true if the field is read-only
                maxLength: 250,
                decoration: const InputDecoration(
                  hintText: "Dirección", // Hint text for empty field
                  counterText: "", // Hides character counter (optional)
                ),
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),
          HelpersViewLetrasSubs.formItemsDesignLineaGris(),

          HelpersViewLetrasSubs.formItemsDesign("Cambiar Contraseña"),
          HelpersViewInputs.formItemsDesignInput(
            Icons.key,
            Center( // Center the text field content
              child: TextFormField(
                controller: widget.formContra,
                obscureText: widget._isPasswordVisible,
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: "Nueva Contraseña",
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

          HelpersViewLetrasSubs.formItemsDesign("Repetir Nueva Contraseña"),
          HelpersViewInputs.formItemsDesignInput(
            Icons.key,
            Center( // Center the text field content
              child: TextFormField(
                controller: widget.formContraRepetir,
                obscureText: widget._isPasswordVisibleRepetir,
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: "Repetir Nueva Contraseña",
                  counterText: "",
                  suffixIcon: PasswordVisibilityToggle(
                    isPasswordVisible: widget._isPasswordVisibleRepetir,
                    onToggle: () {
                      setState(() {
                        widget._isPasswordVisibleRepetir = !widget._isPasswordVisibleRepetir;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),


          HelpersViewLetrasSubs.formItemsDesign("Anterior Contraseña"),
          HelpersViewInputs.formItemsDesignInput(
            Icons.key,
            Center( // Center the text field content
              child: TextFormField(
                controller: widget.formContra2,
                obscureText: widget._isPasswordVisible2,
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: "Anterior Contraseña",
                  counterText: "",
                  suffixIcon: PasswordVisibilityToggle(
                    isPasswordVisible: widget._isPasswordVisible2,
                    onToggle: () {
                      setState(() {
                        widget._isPasswordVisible2 = !widget._isPasswordVisible2;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),
          HelpersViewLetrasSubs.formItemsDesignLineaGris(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

          GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.amber,
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: const Text("Confirmar Modificación",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

        ],),
    );

  }


}
