import 'package:flutter/material.dart';

class HelpersViewLetrasSubs {

  static Widget formItemsDesignBig(String text) {
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
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                //color: Colors.white,
              ),
            ),
          ),
        ),

      ],
    );
  }

  static Widget formItemsDesignSub(String text) {
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
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                //color: Colors.white,
              ),
            ),
          ),
        ),

      ],
    );
  }

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
                    color: Colors.black,
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

  static Widget formItemsDesign2(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center the Row
      children: [
        // No SizedBox needed for left padding here (optional)

        Flexible( // Wrap container in Flexible with flex: 2
          flex: 13, // Set the flex factor to 2
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 200.0, // Set minimum width
              maxWidth: double.infinity, // Allow container to grow horizontally
            ),
            decoration: const BoxDecoration(
              //color: Colors.red, // Add a background color if needed
            ),
            child: Text(
              text,
              textAlign: TextAlign.center, // Maintain center alignment
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),

        const Expanded( // Add an Expanded widget for remaining space
          child: SizedBox(), // Empty SizedBox to consume remaining space
        ),
      ],
    );
  }

  static Widget formItemsDesignLineaGris() {
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
                    color: Colors.black54,
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






