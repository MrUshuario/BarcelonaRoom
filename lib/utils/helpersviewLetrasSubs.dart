import 'package:flutter/material.dart';

class HelpersViewLetrasSubs {

  static Widget formItemsDesign(String text) {
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
          flex: 5,
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


  /*
  static Widget formItemsDesignBLUETooltip(String text, bool showText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
      children: [
        ElevatedButton(
          onPressed: () => showText = !showText, // Update the passed-in argument
          child: Text('Notas'),
        ),
        AnimatedOpacity(
          opacity: showText ? 1.0 : 0.0,
          duration: Duration(milliseconds: 300), // Adjust animation duration
          child: Text(
            text, // Use the provided text argument
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ],
    );
  }*/


}






