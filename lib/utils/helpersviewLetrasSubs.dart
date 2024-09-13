import 'package:flutter/material.dart';

class HelpersViewLetrasSubs {

  static Widget formItemsDesign(String text) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
      children: [
       Expanded(
        flex: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  Text(
            text,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              //color: Colors.white,
            ),
          ),
        ),
        ),

      ],
    );
  }

  static Widget formItemsDesignGris(String text) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
      children: [

        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Text(
              text,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black54,
                //color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget formItemsDesignBLUE(String text) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Text(
              text,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget formItemsDesignLinea() {
    return SingleChildScrollView( // Wrap with SingleChildScrollView
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the Row
        children: [
          const SizedBox(width: 0.0), // Maintain left padding
          Flexible( // Wrap container in Flexible
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 400.0, // Set minimum width
                maxWidth: double.infinity, // Allow container to grow horizontally
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 0.0), // Maintain right padding (optional)
        ],
      ),
    );
  }

  static Widget formItemsDesignLineaAmarilla() {
    return SingleChildScrollView( // Wrap with SingleChildScrollView
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the Row
        children: [
          const SizedBox(width: 0.0), // Maintain left padding
          Flexible( // Wrap container in Flexible
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 100.0, // Set minimum width
                maxWidth: 300.0, // Allow container to grow horizontally
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.amber,
                    width: 3.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 0.0), // Maintain right padding (optional)
        ],
      ),
    );
  }


}






