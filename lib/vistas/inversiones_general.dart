import 'package:barcelonaroom/obj/OBJinversion.dart';
import 'package:barcelonaroom/utils/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Inversiondetalle extends StatefulWidget {

    Inversion? formData;
    Inversiondetalle(this.formData, {super.key});


  @override
  State<StatefulWidget> createState() => _Inversiondetalle();
}

class _Inversiondetalle extends State<Inversiondetalle> {

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

          /*
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
          ), */

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

          Text("${widget.formData?.codigoInversion} Nombre: ${widget.formData?.montoInversion}",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.020,),

          Text(
            "Monto Invertido: ${widget.formData?.montoInversion}",
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
