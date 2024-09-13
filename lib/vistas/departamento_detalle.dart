import 'dart:async';
import 'dart:convert';
import 'package:barcelonaroom/obj/OBJapartamentos.dart';
import 'package:barcelonaroom/utils/HelpersViewAlertaInfo.dart';
import 'package:barcelonaroom/utils/resources.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Detalle extends StatefulWidget {

    Apartamento? formData;
    Detalle(this.formData, {super.key});


  @override
  State<StatefulWidget> createState() => _Detalle();
}

class _Detalle extends State<Detalle> {

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
        /*appBar: AppBar(
          title: const Text(
            Resources.usuario,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 27, 65, 187),
          actions: [
            IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () {
                  logoutFunction();
                }
            )
          ],
        ), */
        //drawer: const MenuLateral(),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                Resources.backgroundAzul, // Replace with your image path
                fit: BoxFit.cover, // Adjust fit as needed
              ),
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

          Align(
            alignment: Alignment.center,
            child: //widget.formData?.urlimagen
            Image.network(
              widget.formData?.urlimagen != null
                  ? widget.formData!.urlimagen!
                  : 'path/to/placeholder_image.jpg',
              width: 200.0,
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

          Text("${widget.formData?.codigoApartamento} Descripción: ${widget.formData?.descripcionApartamento}",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

          Text(
            "Precio: ${widget.formData?.precioApartamento}",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),



        ],),
    );

  }


}
