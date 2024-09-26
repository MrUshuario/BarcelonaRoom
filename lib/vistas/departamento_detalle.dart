import 'dart:async';
import 'dart:convert';
import 'package:barcelonaroom/obj/OBJapartamentos.dart';
import 'package:barcelonaroom/utils/HelpersViewAlertaInfo.dart';
import 'package:barcelonaroom/utils/helpersviewAlertProgressCircle.dart';
import 'package:barcelonaroom/utils/helpersviewInputs.dart';
import 'package:barcelonaroom/utils/helpersviewLetrasSubs.dart';
import 'package:barcelonaroom/utils/resources.dart';
import 'package:barcelonaroom/vistas/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class Detalle extends StatefulWidget {

    TextEditingController inversion = TextEditingController();
    Apartamento? formData;
    Detalle(this.formData, {super.key});


  @override
  State<StatefulWidget> createState() => _Detalle();
}

enum TipoPago { Visa, PayPal}

class _Detalle extends State<Detalle> {
  TipoPago? _TipoPago;
  int currentPageIndex = 0;
  @override
  void initState() {
    funcion();
    super.initState();

  }

  void funcion()  {

  }

  //ALERTDIALGO API
  final _mostrarLoadingStreamController = StreamController<bool>.broadcast();
  void ConfirmarDialog(String monto, String palabra) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [

              Image.asset(Resources.iconInfo),
              SizedBox(width: 4), // Espacio entre el icono y el texto
               Expanded(
                child: Text(
                  '¿Desea confirmar la $palabra de: $monto€?',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 20, // Tamaño de fuente deseado
                  ),
                ),
              ),
            ],
          ),
          actions: [
            OverflowBar(
              alignment: MainAxisAlignment.start, // Alinea los botones a la izquierda
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    SeleccionMetodo();
                  },
                  child: const Text('Sí',
                    style: TextStyle(
                      fontSize: 18, // Tamaño de fuente deseado
                    ),),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Cierra el diálogo
                  },
                  child: const Text('No',
                    style: TextStyle(
                      fontSize: 18, // Tamaño de fuente deseado
                    ),),
                ),
              ],
            ),
          ],
        );
      },
    );

  }

  void SeleccionMetodo(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                'Método de Pago:',
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

                        const Expanded(
                          flex: 3,
                          child: Icon(FontAwesomeIcons.ccVisa, size: 50.0, color: Colors.black),
                        ),

                        HelpersViewLetrasSubs.formItemsDesignGris("VISA"),

                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:  Radio<TipoPago>(
                            value: TipoPago.Visa,
                            groupValue: _TipoPago,
                            onChanged: (TipoPago? value) {
                              setState(() {
                                _TipoPago = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [

                        const Expanded(
                          flex: 3,
                          child: Icon(FontAwesomeIcons.ccPaypal, size: 50.0, color: Colors.black),
                        ),

                        HelpersViewLetrasSubs.formItemsDesignGris("PayPal"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:  Radio<TipoPago>(
                            value: TipoPago.PayPal,
                            groupValue: _TipoPago,
                            onChanged: (TipoPago? value) {
                              setState(() {
                                _TipoPago = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                          CargaDialog();
                          Timer.periodic(Duration(seconds: 3), (time) async {
                            _mostrarLoadingStreamController.add(true);
                            time.cancel();
                          });

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
                          child: const Text("Continuar",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        )),

                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }


  void CargaDialog() {
    bool mostrarLOADING = false;
    showDialog(
      barrierDismissible: mostrarLOADING,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            _mostrarLoadingStreamController.stream.listen((value) {
              setState(() {
                mostrarLOADING = value;
              });
            });

            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    HelpersViewAlertProgressCircle(
                      mostrar: mostrarLOADING,
                      texto: "Inversión realizada",
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
        ),
        body: <Widget>[

          //FORM1 DETALLE
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
              ),
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
            ],
          ),

          //FORM2 OPCIONES.
          Stack(
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
              widget.formData?.imagen != null
                  ? widget.formData!.imagen!
                  : 'path/to/placeholder_image.jpg',
              width: 200.0,
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

          Text("${widget.formData?.codigoApartamento} Descripción: ${widget.formData?.descripcion}",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

          Text(
            "Precio: ${widget.formData?.precio}",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),

          HelpersViewLetrasSubs.formItemsDesignLineaGris(),
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
                          /*
                          decoration: ShapeDecoration(
                            //color: const Color(0xffEDF1F1),
                            shape: RoundedRectangleBorder( // Define rounded rectangle shape
                              borderRadius: BorderRadius.circular(10.0), // Adjust border radius
                              side: const BorderSide( // Add border with desired properties
                                color: Colors.black54, // Set border color to black
                                width: 3.0, // Adjust border width (optional)
                              ),
                            ),
                          ), */
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
                            HelpersViewLetrasSubs.formItemsDesign("Tu inversión actual es:"),
                            const SizedBox(height: 5.0),
                            HelpersViewLetrasSubs.formItemsDesign( "10000 E"),
                          ],),
                      ),
                    ],
                  ),
                ),

          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),
          HelpersViewLetrasSubs.formItemsDesignLineaGris(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),


          Row(
            children: [
              const Text('Agregar Monto:', style: TextStyle(
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
          //BOTON FILTRO
          GestureDetector(
              onTap: () async {
                String monto = widget.inversion!.text;
                String palabra = "Inversión";
                ConfirmarDialog(monto, palabra);
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
