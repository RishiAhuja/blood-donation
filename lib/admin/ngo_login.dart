import 'package:blood/admin/admin_login.dart';
import 'package:blood/admin/pending_request.dart';
import 'package:blood/helper/error_ngo_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NgoLogin extends StatefulWidget {
  const NgoLogin({Key key}) : super(key: key);

  @override
  _NgoLoginState createState() => _NgoLoginState();
}

class _NgoLoginState extends State<NgoLogin> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  String status = 'login';
  bool _isLoading = false;
  login()
  async{
    if(_formKey.currentState.validate())
    {
      print('validated!');
      setState(() {
        status = 'loading';
        _isLoading = true;
      });
      await FirebaseFirestore.instance.collection('ngo').where('username', isEqualTo: username.text).where('password', isEqualTo: password.text).get()
          .then((snapshot) {
            if(snapshot.docs.isEmpty){
              print('failed');
              setState(() {
                status = 'failed';
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ErrorLoginNgo()));
              });
            }
            else{
              snapshot.docs.forEach((result) {
                print(result.data());
                setState(() {
                  status = 'success';
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Pending()));
                });
              });
            }
      }).onError((error, stackTrace) {
        print('error');
        setState(() {
          status = 'error';
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      backgroundColor: Colors.deepPurpleAccent[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent[200],
        actions: [
          IconButton(
            icon: Icon(Icons.admin_panel_settings, color: Colors.white),
            onPressed: ()
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminLogin()));
            },
          )
        ],
      ),
      body: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'NGO Login!',
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
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.25,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                  ),
                  child: _isLoading ? Center(child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            'assets/wait.png'
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Loading..',
                            style: GoogleFonts.poppins(fontSize: 30),
                          ),
                        )
                      ],
                    ),
                  )) : Align(
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
                                child: Image.asset('assets/login.png'),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              width: MediaQuery.of(context).size.width/1.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.person, color: Colors.grey, ),
                                  SizedBox(width: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: TextFormField(
                                      validator: (val)
                                      {
                                        return val.length < 4 || val == '' || val == null ? 'Please enter a valid name' : null;
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
                              width: MediaQuery.of(context).size.width/1.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.password, color: Colors.grey, ),
                                  SizedBox(width: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: TextFormField(
                                      validator: (val)
                                      {
                                        return val.length < 6 || val == '' || val == null ? 'Please enter a valid password' : null;
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
                              onTap: ()
                              {
                                login();
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.deepPurpleAccent, width: 2),
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
