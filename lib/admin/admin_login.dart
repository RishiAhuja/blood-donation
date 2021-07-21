import 'package:blood/admin/admin.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      backgroundColor: Colors.deepPurpleAccent[200],

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent[200],
      ),
      body: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Admin Login!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 28,),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                elevation: 15,
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 1.25,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30))
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Image.asset('assets/admin.png'),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.person, color: Colors.grey,),
                                  SizedBox(width: 10,),
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 1.6,
                                    child: TextFormField(
                                      validator: (val) {
                                        return val.length < 4 || val == '' ||
                                            val == null
                                            ? 'Please enter a valid name'
                                            : null;
                                      },
                                      controller: username,
                                      style: GoogleFonts.poppins(),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Username...',
                                          hintStyle: GoogleFonts.poppins(
                                              color: Colors.grey
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.password, color: Colors.grey,),
                                  SizedBox(width: 10,),
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 1.6,
                                    child: TextFormField(
                                      validator: (val) {
                                        return val.length < 6 || val == '' ||
                                            val == null
                                            ? 'Please enter a valid password'
                                            : null;
                                      },
                                      controller: password,
                                      style: GoogleFonts.poppins(),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password...',
                                          hintStyle: GoogleFonts.poppins(
                                              color: Colors.grey
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),


                            InkWell(
                              onTap: () {
                                if(_formKey.currentState.validate())
                                  {
                                    if(username.text == 'admin' && password.text == 'adminpass@3456'){
                                      print("validated");
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Admin()));
                                    }
                                    if(username.text != 'admin' || password.text != 'adminpass@3456'){
                                      print('failed');
                                      Fluttertoast.showToast(
                                          msg: "Login Failed!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }
                                 }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 110, vertical: 20),
                                padding: EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 25),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.deepPurpleAccent, width: 2),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'LOGIN',
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        color: Colors.deepPurpleAccent
                                    ),
                                  ),
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
