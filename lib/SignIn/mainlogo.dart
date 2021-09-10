import 'package:flutter/material.dart';

Widget mainLogo() {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Column(
          children: [
            SizedBox(height:30.0,),
           Image(
                 image: AssetImage("images/logo_1.png"),
                 width: 10000.0,
                 height: 200.0,
                alignment: Alignment.center,
    ),

          ]
          ),
        ),
      ],
    ),
  );
}
