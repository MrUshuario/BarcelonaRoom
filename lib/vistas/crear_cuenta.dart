import 'dart:async';
import 'dart:convert';
import 'package:barcelonaroom/obj/OBJapartamentos.dart';
import 'package:barcelonaroom/utils/HelpersViewAlertaInfo.dart';
import 'package:barcelonaroom/utils/helpersviewInputs.dart';
import 'package:barcelonaroom/utils/helpersviewLetrasSubs.dart';
import 'package:barcelonaroom/utils/resources.dart';
import 'package:barcelonaroom/vistas/home.dart';
import 'package:barcelonaroom/vistas/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Crear_cuenta extends StatefulWidget {

  TextEditingController formNombre1 = TextEditingController();
  TextEditingController formNombre2 = TextEditingController();
  TextEditingController formApeP = TextEditingController();
  TextEditingController formApeM = TextEditingController();
  TextEditingController formDirrecion= TextEditingController();
  TextEditingController formCorreo = TextEditingController();
  TextEditingController formDNI= TextEditingController();
  TextEditingController formContra = TextEditingController();
  TextEditingController formContra2 = TextEditingController();
  bool _isPasswordVisible = true;

  @override
  State<StatefulWidget> createState() => _Crear_cuenta();
}

class _Crear_cuenta extends State<Crear_cuenta> {

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
            icon: Icon(Icons.arrow_back, size: 40.0, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => login()),
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
        padding: const EdgeInsets.only(top: 30.0, bottom: 8.0, left: 8.0, right: 8.0),
      child:
      Column(
        children: [

          HelpersViewLetrasSubs.formItemsDesignBig("Ingrese sus datos"),
          const SizedBox(height: 10.0),

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

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

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

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

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

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

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

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

          HelpersViewLetrasSubs.formItemsDesign("Documento de Identidad"),
          HelpersViewInputs.formItemsDesignInput(
            Icons.person,
            Center(
              child: TextFormField(
                controller: widget.formDNI,
                //readOnly: true, // Optional: Set to true if the field is read-only
                maxLength: 50,
                decoration: const InputDecoration(
                  hintText: "Documento", // Hint text for empty field
                  counterText: "", // Hides character counter (optional)
                ),
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

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

          HelpersViewLetrasSubs.formItemsDesign("Correo"),
          HelpersViewInputs.formItemsDesignInput(
            Icons.email,
            Center(
              child: TextFormField(
                controller: widget.formCorreo,
                //readOnly: true, // Optional: Set to true if the field is read-only
                maxLength: 50,
                decoration: const InputDecoration(
                  hintText: "Correo electronico", // Hint text for empty field
                  counterText: "", // Hides character counter (optional)
                ),
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

          HelpersViewLetrasSubs.formItemsDesign("Contraseña"),
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

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

          HelpersViewLetrasSubs.formItemsDesign("Repita Contraseña"),
          HelpersViewInputs.formItemsDesignInput(
            Icons.key,
            Center( // Center the text field content
              child: TextFormField(
                controller: widget.formContra2,
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
                child: const Text("Crear Cuenta",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),



        ],
      ),),],),
    );

  }


}
