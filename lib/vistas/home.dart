import 'dart:async';
import 'dart:convert';
import 'package:barcelonaroom/obj/OBJapartamentos.dart';
import 'package:barcelonaroom/obj/OBJinversion.dart';
import 'package:barcelonaroom/utils/HelpersViewAlertaInfo.dart';
import 'package:barcelonaroom/utils/helpersviewInputs.dart';
import 'package:barcelonaroom/utils/helpersviewLetrasSubs.dart';
import 'package:barcelonaroom/utils/resources.dart';
import 'package:barcelonaroom/vistas/departamento_detalle.dart';
import 'package:barcelonaroom/vistas/inversiones_detalle.dart';
import 'package:barcelonaroom/vistas/inversiones_general.dart';
import 'package:barcelonaroom/vistas/login.dart';
import 'package:barcelonaroom/vistas/usuario.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';





class Home extends StatefulWidget {

  //LISTA QUE SE MUESTRA PRIMERO
  List<Apartamento> listApartamentos = List.empty(growable: true);
  //LISTA QUE SE MUESTRA SEGUNDO
  List<Inversion> listInversiones = List.empty(growable: true);

  //DETALLE
  Apartamento formDetalle = Apartamento();

  //LISTA DE COLORES ICONOS BOTONES
  bool activadoCasa = false;
  bool activadoHabitacion = false;
  bool activadoComunitario = false;
  bool activadoAlquilados = false;
  bool activadoSinAlquilar= false;
  bool activadoGaraje = false;
  bool activadoZonaTuristica = false;

  Color botoniconDesactivado = const Color.fromARGB(255, 255, 191, 0);
  Color botoniconActivado = const Color.fromARGB(255, 164, 181, 236);


  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  int currentPageIndex = 0;
  String? PREFname; //1er nombre 2do nombre apellidos
  String? PREFdni;


  @override
  void initState() {
    cargardataprueba();
    cargardatosiniciales();
    super.initState();

  }

  Future<void> cargardatosiniciales()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      PREFname = prefs.getString('name') ?? "USUARIO PRUEBA";
      PREFdni = prefs.getString('dni') ?? "00000000";
    });
  }

  void SalirCuenta() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name',"USUARIO PRUEBA");
    await prefs.setString('dni', "");
  }

  void cargardataprueba()  {
    for (int i = 1; i <= 10; i++) {

      Apartamento objaux = Apartamento();
      objaux.codigoApartamento = i;
      objaux.urlimagen = "https://picsum.photos/250?image=3";
      objaux.descripcionApartamento = "Por el momento";
      objaux.precioApartamento = (i+1)*100;
      widget.listApartamentos.add(objaux);

      Inversion objaux2 = Inversion();
      objaux2.codigoInversion = i;
      objaux2.codigoFondo = "A0BC$i";
      objaux2.nombreInversion = "Comprado Habitación";
      objaux2.montoInversion = 1000+(i*100);
      objaux2.porcentajeInteres = 2;
      //objaux2.montoBeneficioTotal = (i+1)*100;
      objaux2.fechaInversion = "12/09/2024";
      widget.listInversiones.add(objaux2);


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

  void showfiltromodal() {

    TextEditingController inversionmin = TextEditingController();
    TextEditingController inversionmax = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          //TALVEZ SIRVA TALVEZ NO
          return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text(
                    'Tipo de Registro:',
                    style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                ),
                ),
                content: SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Column(
                  children: [

                    Row(
                    children: [
                  const Text('Monto mínimo:', style: TextStyle(
                    fontSize: 12.0,
                    //color: Colors.white,
                  ),),

                    HelpersViewInputs.formItemsDesignDNI(
                        TextFormField(
                          controller: inversionmin,
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

                    Row(
                      children: [

                    const Text('Monto máximo:', style: TextStyle(
                    fontSize: 12.0,
                    //color: Colors.white,
                    ),),

                    HelpersViewInputs.formItemsDesignDNI(
                    TextFormField(
                      controller: inversionmax,
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

                    //BOTON FILTRO
                    GestureDetector(
                        onTap: () async {
                          //await aplicar filtros();
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: widget.botoniconDesactivado,
                          ),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: const Text("Aplicar Filtros",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        )),

                    const SizedBox(height: 8.0),

                    GestureDetector(
                        onTap: () async {
                          //await quitar filtros();
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Colors.red,
                          ),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: const Text("Borrar Filtros",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        )),


                  ]),
                ),

                );
          },);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true, //SACA LA BARRA DEBUG
      home: Scaffold(
        body: <Widget>[

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

          //PARTE2
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
                  width: double.infinity,
                  child: Form(
                    //key: widget.keyForm,
                    child: formUI2(),
                  ),
                ),
              ),
              // ),
            ],
          ),

          //PARTE3
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
                  width: double.infinity,
                  child: Form(
                    //key: widget.keyForm,
                    child: formUI3(),
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
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Departamentos',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.monetization_on),
              icon: Icon(Icons.monetization_on_outlined),
              label: 'Inversiones',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.account_box_rounded),
              icon: Icon(Icons.account_box_outlined),
              label: 'Cuenta',
            ),
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

  /*
  void CambiarPagina(Apartamento obj) {
    setState(() {
      widget.formDetalle = obj;
      currentPageIndex = 3;
    });
  } */


  Widget formUI2() {
    return Container(
        child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 8.0, left: 8.0, right: 8.0),
            child:
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color:  Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      // Add spacing between icon and text (optional)
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.account_box_outlined, size: 50.0, color: Colors.black),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Inversiongeneral()),
                            );
                          },
                        ),

                        const Text("Resumen General", style: TextStyle(color: Colors.black)), // Your text
                        const SizedBox(height: 5.0),

                      ],
                    ),
                  ),
                ),

                const Expanded(
                  flex: 1,
                  child: const SizedBox(height: 1.0),
                ),

                Expanded(
                  flex: 4,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color:  Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      // Add spacing between icon and text (optional)
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search, size: 50.0, color: Colors.black),
                          onPressed: () {
                            showfiltromodal();
                          },
                        ),
                        const Text("Filtrar resultados", style: TextStyle(color: Colors.black)), // Your text
                        const SizedBox(height: 5.0),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),

          HelpersViewLetrasSubs.formItemsDesignLineaAmarilla(),
          //
          Padding(
            padding: const EdgeInsets.all(5), // POR ALGUN MOTIVO NO SE CENTRA ASI QUE PONGO POR EL MOMENTO
            child:
            SizedBox(
                width: MediaQuery.of(context).size.height * 0.90,
                height: MediaQuery.of(context).size.height * 0.70,
                child:
                widget.listInversiones.isNotEmpty
                    ? ListView.builder(itemCount: widget.listInversiones!.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: InkWell(
                        onTap: () {
                          //IR A DETALLE
                          Inversion objaux = Inversion();
                          objaux = widget.listInversiones![index];
                          //CambiarPagina(objaux);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Inversiondetalle(objaux)),
                          );
                          },
                            child:

                            Padding(
                            padding: const EdgeInsets.all(5), // POR ALGUN MOTIVO NO SE CENTRA ASI QUE PONGO POR EL MOMENTO
                            child:

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

                                HelpersViewLetrasSubs.formItemsDesign(
                                    "${widget.listInversiones![index].codigoInversion}) Nombre: "
                                        "${widget.listInversiones![index].nombreInversion}"),


                                HelpersViewLetrasSubs.formItemsDesign(
                                    "Inversion: ${widget.listInversiones![index].montoInversion}"),


                                HelpersViewLetrasSubs.formItemsDesign(
                                    "Fecha inversion: ${widget.listInversiones![index].fechaInversion}"),

                              ],
                            ),
                            ),
                        ),
                    );
                  },)
                    : const Text('Aún no hay data para mostrar')

            ),
          ),

        ]),
    );
  }

  Widget formUI3() {
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
                          //color: const Color(0xffEDF1F1),
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
                              icon: const Icon(Icons.account_box_outlined, size: 50.0, color: Colors.black),
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
                          HelpersViewLetrasSubs.formItemsDesign("$PREFname"),
                          const SizedBox(height: 5.0),
                          HelpersViewLetrasSubs.formItemsDesign( "DNI: $PREFdni"),
                        ],),
                    ),
                  ],
                ),
            ),


            Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 8.0, left: 8.0, right: 8.0),
            child:
            Column(
              children: [

                  HelpersViewLetrasSubs.formItemsDesignLinea(),
                  const SizedBox(height: 5.0),

                GestureDetector(
                    onTap: ()   async {

                      SalirCuenta();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => login()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: widget.botoniconDesactivado,
                      ),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text("Cerrar Sesion",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    )),

              ],),
            ),


          ]),
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
                                      //CambiarPagina(objaux);
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
        ],),
    );

  }


}
