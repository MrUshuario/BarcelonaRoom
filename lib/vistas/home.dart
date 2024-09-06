import 'dart:async';
import 'dart:convert';
import 'package:barcelonaroom/obj/OBJapartamentos.dart';
import 'package:barcelonaroom/utils/HelpersViewAlertaInfo.dart';
import 'package:barcelonaroom/utils/resources.dart';
import 'package:barcelonaroom/vistas/detalle.dart';
import 'package:barcelonaroom/vistas/usuario.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;





class Home extends StatefulWidget {

  //LISTA QUE SE MUESTRA
  List<Apartamento> listApartamentos = List.empty(growable: true);

  //LISTA DE COLORES ICONOS BOTONES
  bool activadoCasa = false;
  bool activadoHabitacion = false;
  bool activadoComunitario = false;
  bool activadoAlquilados = false;
  bool activadoSinAlquilar= false;
  bool activadoGaraje = false;
  bool activadoZonaTuristica = false;

  Color botoniconDesactivado = const Color.fromARGB(255, 164, 181, 236);
  Color botoniconActivado = const Color.fromARGB(255, 8, 157, 243);


  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {


  @override
  void initState() {
    cargardataprueba();
    super.initState();

  }

  void cargardataprueba()  {
    for (int i = 1; i <= 10; i++) {
      Apartamento objaux = Apartamento();
      objaux.codigoApartamento = i;
      objaux.urlimagen = "https://picsum.photos/250?image=3";
      objaux.descripcionApartamento = "Por el momento";
      objaux.precioApartamento = (i+1)*100;
      widget.listApartamentos.add(objaux);
    }
  }

  void filtro(String boton)  {


    setState(() {

      widget.activadoCasa = false;
      widget.activadoHabitacion = false;
      widget.activadoComunitario = false;
      widget.activadoAlquilados = false;
      widget.activadoSinAlquilar= false;
      widget.activadoGaraje = false;
      widget.activadoZonaTuristica = false;


      switch (boton) {
        case "a":
        widget.activadoCasa =           true;
        case "b":
        widget.activadoHabitacion =     true;
        case "c":
        widget.activadoComunitario =    true;
        case "d":
        widget.activadoAlquilados =     true;
        case "e":
        widget.activadoSinAlquilar =    true;
        case "f":
        widget.activadoGaraje =         true;
        case "g":
        widget.activadoZonaTuristica =  true;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true, //SACA LA BARRA DEBUG
      home: Scaffold(
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
                  width: double.infinity,
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


  //Filtro
  void logoutFunction() {
    String titulo = "¿Desea Salir?";
    String subtitulo = "Aceptar";
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      HelpersViewAlertaInfo.formItemsDesign(titulo,subtitulo),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end, // Align row to the end
                        children: [
                        ],
                      ),
                    ],
                  )
              )
          );
        }
    );
  }


  Widget formUI() {
    return Container(
        child: Column(
        children: [
          //PARTE 2 FILTROS
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: Padding(
              padding: const EdgeInsets.all(0), // Add margin here
              child: Row(
                  children: [


                    Padding(
                        padding: const EdgeInsets.all(10), // Add margin here
                        child: Row(
                            children: [

                            ])
                    ),


                    Expanded(
                      flex: 8,
                      child: SearchAnchor(
                      builder: (BuildContext context, SearchController controller) {
                        return SearchBar(
                          controller: controller,
                          padding: const MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 16)),
                          onTap: (){
                            controller.openView();
                          },
                          onChanged: (_){
                            controller.openView();
                          },
                          leading: const Icon(Icons.search),
                          /*trailing: <Widget>[
                              Tooltip(
                                message: ,
                              )
                            ],*/
                        );
                      },
                      suggestionsBuilder: (BuildContext context, SearchController controller){
                        return List<ListTile>.generate(5, (int index) {
                          final String item = 'item $index';
                          return ListTile(
                            title: Text(item),
                            onTap: (){
                              setState(() {
                                controller.closeView(item);
                              });
                            },
                          );
                        });
                      }
                  ),
                  ),


                  Expanded(
                    flex: 2,
                    child:
                    GestureDetector(
                        onTap: () async {
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
                          child: const Icon(
                          Icons.settings_applications, // Replace "e" with Icons.search
                          color: Colors.white,
                        ),
                        )),
                  )


                  ]
              ),
            ),
          ),

          //FILTRO
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            child:
              Scrollbar(
                thickness: 9.0,
                radius: Radius.circular(5.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      children: [

                        Padding(padding: EdgeInsets.all(5.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: widget.activadoCasa ? widget.botoniconDesactivado : widget.botoniconActivado,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                // Add spacing between icon and text (optional)
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.house, size: 50.0, color: Colors.black),
                                    onPressed: () {
                                      filtro("a");
                                    },
                                  ),
                                  const Text("Casa", style: TextStyle(color: Colors.black)), // Your text
                                  const SizedBox(height: 5.0),
                                ],
                              ),

                            )
                        ),

                        Padding(padding: EdgeInsets.all(5.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: widget.activadoHabitacion ? widget.botoniconDesactivado : widget.botoniconActivado,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                // Add spacing between icon and text (optional)
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.bed, size: 50.0, color: Colors.black),
                                    onPressed: () {
                                      filtro("b");
                                    },
                                  ),
                                  const Text("Habitación", style: TextStyle(color: Colors.black)), // Your text
                                  const SizedBox(height: 5.0),
                                ],
                              ),
                            )
                        ),

                        Padding(padding: EdgeInsets.all(5.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: widget.activadoComunitario ? widget.botoniconDesactivado : widget.botoniconActivado,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                // Add spacing between icon and text (optional)
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.reduce_capacity, size: 50.0, color: Colors.black),
                                    onPressed: () {
                                      filtro("c");
                                    },
                                  ),
                                  const Text("Comunitario", style: TextStyle(color: Colors.black)), // Your text
                                  const SizedBox(height: 5.0),
                                ],
                              ),
                            )
                        ),


                        Padding(padding: EdgeInsets.all(5.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: widget.activadoAlquilados ? widget.botoniconDesactivado : widget.botoniconActivado,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                // Add spacing between icon and text (optional)
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.monetization_on, size: 50.0, color: Colors.black),
                                    onPressed: () {
                                      filtro("d");
                                    },
                                  ),
                                  const Text("Alquilados", style: TextStyle(color: Colors.black)), // Your text
                                  const SizedBox(height: 5.0),
                                ],
                              ),
                            )
                        ),

                        Padding(padding: EdgeInsets.all(5.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: widget.activadoSinAlquilar ? widget.botoniconDesactivado : widget.botoniconActivado,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                // Add spacing between icon and text (optional)
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.access_time, size: 50.0, color: Colors.black),
                                    onPressed: () {
                                      filtro("e");
                                    },
                                  ),
                                  const Text("Sin alquilar", style: TextStyle(color: Colors.black)), // Your text
                                  const SizedBox(height: 5.0),
                                ],
                              ),
                            )
                        ),


                        Padding(padding: EdgeInsets.all(5.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: widget.activadoGaraje ? widget.botoniconDesactivado : widget.botoniconActivado,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                // Add spacing between icon and text (optional)
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.garage, size: 50.0, color: Colors.black),
                                    onPressed: () {
                                      filtro("f");
                                    },
                                  ),
                                  const Text("Garaje", style: TextStyle(color: Colors.black)), // Your text
                                  const SizedBox(height: 5.0),
                                ],
                              ),
                            )
                        ),

                        Padding(padding: EdgeInsets.all(5.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: widget.activadoZonaTuristica ? widget.botoniconDesactivado : widget.botoniconActivado,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                // Add spacing between icon and text (optional)
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.local_play_sharp, size: 50.0, color: Colors.black),
                                    onPressed: () {
                                      filtro("g");
                                    },
                                  ),
                                  const Text("Zona Turistica", style: TextStyle(color: Colors.black)), // Your text
                                  const SizedBox(height: 5.0),
                                ],
                              ),
                            )
                        ),

                      ],
                    ),
                  ],
                ),
              ),


          ),



          //PARTE 3 CUERPO

            Padding(
                padding: const EdgeInsets.only(left: 10), // POR ALGUN MOTIVO NO SE CENTRA ASI QUE PONGO POR EL MOMENTO
                child:
                  SizedBox(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.62,
                  child:
                      widget.listApartamentos.isNotEmpty
                                ? ListView.builder(itemCount: widget.listApartamentos!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  //margin: EdgeInsets.zero,
                                  child: InkWell(
                                    onTap: () {
                                      //IR A DETALLE
                                      Apartamento objaux = Apartamento();
                                      objaux = widget.listApartamentos![index];

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Detalle(objaux)),
                                      );

                                    },
                                    child: ListTile(
                                      title:
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0), // Adjust as desired
                                          child: Image.network(
                                            widget.listApartamentos![index].urlimagen != null
                                                ? widget.listApartamentos![index].urlimagen!
                                                : 'path/to/placeholder_image.jpg',
                                            width: double.maxFinite,
                                            height: 200.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),

                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

                                          Text("${widget.listApartamentos![index].codigoApartamento} Descripción: ${widget.listApartamentos![index].descripcionApartamento}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),

                                          SizedBox(height: 20),

                                          Text(
                                            "Precio: ${widget.listApartamentos![index].precioApartamento}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),

                                          SizedBox(height: 20),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },)
                                : const Text('Aún no hay data para mostrar')

                  ),
            ),
          //PARTE 5 PIE

          Row(
            children: [
              Expanded(
                  flex: 5,
                  child:IconButton(
                      icon: const Icon(Icons.search, color: Colors.black),
                      onPressed: () {
                        logoutFunction();
                      }
                  )
              ),

              Expanded(
                  flex: 5,
                  child:IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.black),
                      onPressed: () {
                        logoutFunction();
                      }
                  )
              ),

              Expanded(
                  flex: 5,
                  child:IconButton(
                      icon: const Icon(Icons.airplanemode_active, color: Colors.black),
                      onPressed: () {
                        logoutFunction();
                      }
                  )
              ),

              Expanded(
                  flex: 5,
                  child:IconButton(
                      icon: const Icon(Icons.message, color: Colors.black),
                      onPressed: () {
                        logoutFunction();
                      }
                  )
              ),

              Expanded(
                  flex: 5,
                  child:IconButton(
                      icon: const Icon(Icons.search, color: Colors.black),
                      onPressed: () {
                        logoutFunction();
                      }
                  )
              ),

              Expanded(
                  flex: 5,
                  child:IconButton(
                      icon: const Icon(Icons.person, color: Colors.black),
                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => usuario()),
                        );

                      }
                  )
              ),

            ],
          ),

        ],),
    );

  }


}
