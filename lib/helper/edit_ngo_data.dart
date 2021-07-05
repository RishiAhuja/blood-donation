import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditNgoData extends StatefulWidget {
  final String dataName;
  final String dataUser;
  final String dataPass;
  final String dataCity;
  final String dataState;
  final String dataNumber;
  final String doc;

  EditNgoData({
    @required this.dataName,
    @required this.dataCity,
    @required this.dataNumber,
    @required this.dataPass,
    @required this.dataState,
    @required this.dataUser,
    @required this.doc,
});

  @override
  _EditNgoDataState createState() => _EditNgoDataState();
}

class _EditNgoDataState extends State<EditNgoData> {
  String name;
  String user;
  String pass;
  String city;
  String state;
  String number;
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      name = widget.dataName;
      user = widget.dataUser;
      pass = widget.dataPass;
      city = widget.dataCity;
      state = widget.dataState;
      number = widget.dataNumber;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.0),
              child: Table(
                border: TableBorder.all(color: Colors.white),
                children: [
                  TableRow(
                      children: [
                        Text(
                          'Name',
                          style: GoogleFonts.poppins(
                              fontSize: 19
                          ),
                        ),
                        TextFormField(
                          // controller: widget.name,
                          initialValue: widget.dataName,
                          onChanged: (val){
                            setState(() {
                              name = val;
                              print(name);
                            });
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none
                          ),
                          style: GoogleFonts.poppins(
                              fontSize: 19
                          ),
                        ),
                      ]),
                  TableRow(
                      children: [
                        Text(
                          'Username',
                          style: GoogleFonts.poppins(
                              fontSize: 19
                          ),
                        ),
                        TextFormField(
                          // controller: widget.user,
                          initialValue: widget.dataUser,
                          onChanged: (val){
                            setState(() {
                              user = val;
                            });
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none
                          ),
                          style: GoogleFonts.poppins(
                              fontSize: 19
                          ),
                        ),

                      ]),
                  TableRow(
                      children: [
                        Text(
                          'Password',
                          style: GoogleFonts.poppins(
                              fontSize: 19
                          ),
                        ),
                        TextFormField(
                          initialValue: widget.dataPass,
                          onChanged: (val){
                            setState(() {
                              pass = val;
                            });
                          },
                          // controller: widget.pass,
                          decoration: InputDecoration(
                              border: InputBorder.none
                          ),
                          style: GoogleFonts.poppins(
                              fontSize: 19
                          ),
                        ),
                      ]),
                  TableRow(
                      children: [
                        Text(
                          'City',
                          style: GoogleFonts.poppins(
                              fontSize: 19
                          ),
                        ),
                        // TextFormField(
                        //   initialValue: widget.dataCity,
                        //   onChanged: (val){
                        //     setState(() {
                        //       city = val;
                        //     });
                        //   },
                        //   // controller: widget.city,
                        //   decoration: InputDecoration(
                        //       border: InputBorder.none
                        //   ),
                        //   style: GoogleFonts.poppins(
                        //       fontSize: 19
                        //   ),
                        // ),


                      ]),
                  TableRow(
                      children: [
                        Text(
                          'State',
                          style: GoogleFonts.poppins(
                              fontSize: 19
                          ),
                        ),
                        TextFormField(
                          initialValue: widget.dataState,
                          onChanged: (val){
                            setState(() {
                              state = val;
                            });
                          },
                          // controller: widget.state,
                          decoration: InputDecoration(
                              border: InputBorder.none
                          ),
                          style: GoogleFonts.poppins(
                              fontSize: 19
                          ),
                        ),
                      ]),

                  TableRow(
                      children: [
                        Text(
                          'Number',
                          style: GoogleFonts.poppins(
                              fontSize: 19
                          ),
                        ),
                        GestureDetector(
                          // },
                          child: TextFormField(
                            initialValue: widget.dataNumber,
                            onChanged: (val){
                              setState(() {
                                number = val;
                              });
                            },
                            // controller: widget.number,
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                            style: GoogleFonts.poppins(
                              fontSize: 19,
                              // color: Colors.blue,
                              // decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ]),

                ],

              ),
            ),
            InkWell(
              onTap: ()
              async{
                print(number);
                await FirebaseFirestore.instance.collection('ngo').doc('${widget.doc}')
                    .update({
                      'name': name,
                      'username': user,
                      'password': pass,
                      'city': city.toLowerCase(),
                      'state': state.toLowerCase(),
                      'phone': number
                    })
                    .then((value) {

                  _scaffold.currentState.showSnackBar(SnackBar(content: Text('Submitted Successfully', style: GoogleFonts.poppins(),),));

                  Navigator.pop(context);
                })
                    .catchError((error) {
                  print(error);
                  _scaffold.currentState.showSnackBar(SnackBar(content: Text('Submission Failed', style: GoogleFonts.poppins(),),));
                });

              },
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 100),
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                width: MediaQuery.of(context).size.width/1.4,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurpleAccent, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Save Changes',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.deepPurpleAccent
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 200,)
          ],
        ),
      ),
    );
  }
}
