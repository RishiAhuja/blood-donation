import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorLoginNgo extends StatefulWidget {
  const ErrorLoginNgo({Key key}) : super(key: key);

  @override
  _ErrorLoginNgoState createState() => _ErrorLoginNgoState();
}

class _ErrorLoginNgoState extends State<ErrorLoginNgo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/login-error.png'),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                "Unfortunately, we can't find your entry in the database!",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  color: Colors.black
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
