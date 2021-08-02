import 'package:blood/admin/admin.dart';
import 'package:blood/ngo/ngo_login.dart';
import 'package:blood/ngo/ngo_panel.dart';
import 'package:blood/views/about.dart';
import 'package:blood/views/donate.dart';
import 'package:blood/views/find.dart';
import 'package:blood/views/request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.red,
        ),
      ),
      body: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [            
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Blood',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 30.sp
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    '4',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 45.sp,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                  Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 1.0,
                                    color: Colors.white,
                                  ),
                                ],
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    'Life',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 30.sp
                    ),

                  ),
                  Opacity(
                    opacity: 0,
                    child: Text(
                      'x',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20.sp
                      ),

                    ),
                  ),
                ],
              ),
            ),            
            SizedBox(height: 5,),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              elevation: 15,
              child: Container(
                width: MediaQuery.of(context).size.width/1.1,
                height: MediaQuery.of(context).size.height/1.35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 19,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: InkResponse(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Request()));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/2.5,
                                  height: 19.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2.5,
                                        offset: Offset(4, 8), // Shadow position
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/phone-survey.png', height: 8.45.h, width: 8.45.h,),
                                      SizedBox(height: 10,),
                                      Text(
                                        'Request for',
                                        style: GoogleFonts.poppins(
                                          fontSize: 13.5.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        'Blood',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12.5.sp,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Flexible(
                              child: InkResponse(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Donate()));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/2.5,
                                  height: 19.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2.5,
                                        offset: Offset(4, 8), // Shadow position
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/blood.png', height: 8.45.h, width: 8.45.h,),
                                      SizedBox(height: 10,),
                                      Text(
                                        'Register as',
                                        style: GoogleFonts.poppins(
                                            fontSize: 13.5.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        'Donor',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12.5.sp,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 19,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Container(
                                width: MediaQuery.of(context).size.width/2.5,
                                height: 19.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.5,
                                      offset: Offset(4, 8), // Shadow position
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/blood-bank.png', height: 8.45.h, width: 8.45.h,),
                                    SizedBox(height: 10,),
                                    Text(
                                      'Blood',
                                      style: GoogleFonts.poppins(
                                          fontSize: 13.5.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      'Banks',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12.5.sp,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Find()));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/2.5,
                                  height: 19.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2.5,
                                        offset: Offset(4, 8), // Shadow position
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/locksmith.png', height: 8.45.h, width: 8.45.h,),
                                      SizedBox(height: 10,),
                                      Text(
                                        'NGOs &',
                                        style: GoogleFonts.poppins(
                                            fontSize: 13.5.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        'organization',
                                        style: GoogleFonts.poppins(
                                            fontSize: 11.7.sp,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),



                        SizedBox(height: 19,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: InkWell(
                                onTap: () async{
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  if(prefs.getBool('isNGO') != null){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Pending()));
                                  }else{
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => NgoLogin()));
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/2.5,
                                  height: 19.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2.5,
                                        offset: Offset(4, 8), // Shadow position
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/shelter.png', height: 8.45.h, width: 8.45.h,),
                                      SizedBox(height: 10,),
                                      Text(
                                        'NGOs',
                                        style: GoogleFonts.poppins(
                                            fontSize: 13.5.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        'Login',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12.5.sp,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Flexible(
                              child: InkWell(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => About())),
                                child: Container(
                                  width: MediaQuery.of(context).size.width/2.5,
                                  height: 19.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2.5,
                                        offset: Offset(4, 8), // Shadow position
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/information.png', height: 8.45.h, width: 8.45.h,),
                                      SizedBox(height: 10,),
                                      Text(
                                        'About',
                                        style: GoogleFonts.poppins(
                                            fontSize: 13.5.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        'US',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12.5.sp,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
