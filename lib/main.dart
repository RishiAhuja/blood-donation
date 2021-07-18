import 'package:blood/views/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Home(),
    );
  }
}
//-----Ngo + Admin------//
// name
// blood group
// age
// contact no
// alternate no
// adhar no (verify)
// picture (optional)
// state
// district
// city

//lAST DONATION STATUS
//TOTAL DONATION

//nGOS - search - via- state-district-city//
//Name
//Contact Number




//New Phone no. (become a ngo0