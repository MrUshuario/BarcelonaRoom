import 'dart:async';
import 'dart:convert';
import 'package:barcelonaroom/obj/OBJapartamentos.dart';
import 'package:barcelonaroom/utils/HelpersViewAlertaInfo.dart';
import 'package:barcelonaroom/utils/resources.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;





class home extends StatefulWidget {

  List<Apartamento> listApartamentos = List.empty(growable: true);

  @override
  State<StatefulWidget> createState() => _home();
}

class _home extends State<home> {


  @override
  void initState() {
    cargardataprueba();
    super.initState();

  }

  void cargardataprueba()  {

    for (int i = 1; i <= 10; i++) {
      Apartamento objaux = Apartamento();
      objaux.codigoApartamento = i;
      objaux.descripcionApartamento = "Por el momento";
      objaux.precioApartamento = (i+1)*100;
      widget.listApartamentos.add(objaux);
    }

    
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

            /*decoration: ShapeDecoration(
              color: const Color(0xffEDF1F1),
              shape: RoundedRectangleBorder( // Define rounded rectangle shape
                borderRadius: BorderRadius.circular(10.0), // Adjust border radius
                side: const BorderSide( // Add border with desired properties
                  color: Colors.black54, // Set border color to black
                  width: 3.0, // Adjust border width (optional)

                ),
              ),
            ),*/

            margin: const EdgeInsets.only(top: 20.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0), // Add margin here
              child: Column(
                  children: [
                    //BUSCADOR
                    SearchAnchor(
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

                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child:    GestureDetector(
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
                                child: const Text("BOTON EJEMPLO",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              )),
                        ),
                      ],
                    ),
                  ]
              ),
            ),
          ),

          //PARTE 3 CUERPO

          SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.65,
          child:Expanded(
                    child: widget.listApartamentos.isNotEmpty
                        ? ListView.builder(itemCount: widget.listApartamentos!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              //ModificarBorrar(index, widget.listApartamentos![index]);
                            },
                            child: ListTile(
                              title: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.040,
                                child: Text(
                                  "${widget.listApartamentos![index].codigoApartamento}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Descripción: ${widget.listApartamentos![index].descripcionApartamento}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.040,
                                  ),

                                  Text(
                                    "Precio: ${widget.listApartamentos![index].precioApartamento}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );
                      },)
                        : const Text('Aún no hay data para mostrar')
                ),
          ),

          //PARTE 4 PIE

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
                        logoutFunction();
                      }
                  )
              ),

            ],
          ),

        ],),
    );

  }


}
