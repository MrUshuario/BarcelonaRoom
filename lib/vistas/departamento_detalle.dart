import 'dart:async';
import 'dart:convert';
import 'package:barcelonaroom/obj/OBJapartamentos.dart';
import 'package:barcelonaroom/utils/HelpersViewAlertaInfo.dart';
import 'package:barcelonaroom/utils/helpersviewInputs.dart';
import 'package:barcelonaroom/utils/helpersviewLetrasSubs.dart';
import 'package:barcelonaroom/utils/resources.dart';
import 'package:barcelonaroom/vistas/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class Detalle extends StatefulWidget {

    TextEditingController inversion = TextEditingController();
    Apartamento? formData;
    Detalle(this.formData, {super.key});


  @override
  State<StatefulWidget> createState() => _Detalle();
}

class _Detalle extends State<Detalle> {
  int currentPageIndex = 0;
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
        body: <Widget>[

          //FORM1 DETALLE
          Stack(
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

          //FORM2 OPCIONES.
          Stack(
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
                    child: formUI2(),
                  ),
                ),
              ),
              // ),
            ],
          ),

        ][currentPageIndex],
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.amber,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[

            NavigationDestination(
              selectedIcon: Icon(Icons.list_alt),
              icon: Icon(Icons.list_alt_sharp),
              label: 'Detalle',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.monetization_on),
              icon: Icon(Icons.monetization_on_outlined),
              label: 'Movimientos',
            ),
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

          HelpersViewLetrasSubs.formItemsDesignLineaAmarilla(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

          //BOTON FILTRO
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
                child: const Text("Volver al menú",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),



        ],),
    );

  }

  Widget formUI2() {
    return Container(
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 8.0, left: 8.0, right: 8.0),
            child:
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: ShapeDecoration(
                      color: const Color(0xffEDF1F1),
                      shape: RoundedRectangleBorder( // Define rounded rectangle shape
                        borderRadius: BorderRadius.circular(10.0), // Adjust border radius
                        side: const BorderSide( // Add border with desired properties
                          color: Colors.black54, // Set border color to black
                          width: 3.0, // Adjust border width (optional)
                        ),
                      ),
                    ),
                    child: Column(
                      // Add spacing between icon and text (optional)
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.attach_money, size: 50.0, color: Colors.black),
                          onPressed: () {
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const Expanded(
                  flex: 1,
                  child: const SizedBox(height: 1.0),
                ),

                Expanded(
                  flex: 7,
                  child:

                  Column(
                    children: [
                      HelpersViewLetrasSubs.formItemsDesign("Tus ahorros"),
                      const SizedBox(height: 5.0),
                      HelpersViewLetrasSubs.formItemsDesign( "10000 e"),
                    ],),
                ),
              ],
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

          Row(
            children: [
              const Text('Monto mínimo:', style: TextStyle(
                fontSize: 12.0,
                //color: Colors.white,
              ),),

              HelpersViewInputs.formItemsDesignDNI(
                  TextFormField(
                    controller: widget.inversion,
                    decoration: const InputDecoration(
                      labelText: '€',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 8,
                  ), context),

              Icon(Icons.monetization_on, size: 20.0, color: Colors.black),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),
          HelpersViewLetrasSubs.formItemsDesignLineaAmarilla(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),
          //BOTON FILTRO
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
                child: const Text("Invertir",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),



        ],),
    );

  }


}
