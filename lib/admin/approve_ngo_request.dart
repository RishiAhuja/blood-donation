import 'package:blood/helper/network_image_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ApproveNgoRequest extends StatefulWidget {
  final Map data;
  ApproveNgoRequest({this.data});
  @override
  _ApproveNgoRequestState createState() => _ApproveNgoRequestState();
}

class _ApproveNgoRequestState extends State<ApproveNgoRequest> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
  }

  addNgo()
  async{
    if(_formKey.currentState.validate())
    {
    //   print('validated!');
    //   await FirebaseFirestore.instance.collection('ngo').add({
    //     'name': widget.name.trim(),
    //     'username': username.text.trim(),
    //     'password': password.text.trim(),
    //     'city': widget.city.toLowerCase(),
    //     'state': widget.state.toLowerCase(),
    //     'phone': widget.phone.trim()
    //   })
    //       .then((value) {
    //         FirebaseFirestore.instance.collection('ngo_request').doc('${widget.doc}').update({'pending': false}).then((value) {
    //           _scaffold.currentState.showSnackBar(SnackBar(content: Text('Submission Successfully', style: GoogleFonts.poppins(),),));
    //
    //         });
    //   })
    //       .catchError((error) {
    //     print(error);
    //     _scaffold.currentState.showSnackBar(SnackBar(content: Text('Submission Failed', style: GoogleFonts.poppins(),),));
    //   });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Approve NGO!',
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
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Table(
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
                                    Text(
                                      '${widget.data['name']}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 19
                                      ),
                                    ),
                                  ]),
                              TableRow(
                                  children: [
                                    Text(
                                      'State',
                                      style: GoogleFonts.poppins(
                                          fontSize: 19
                                      ),
                                    ),
                                    Text(
                                      '${widget.data['state']}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 19
                                      ),
                                    ),
                                  ]),
                              TableRow(
                                  children: [
                                    Text(
                                      'District',
                                      style: GoogleFonts.poppins(
                                          fontSize: 19
                                      ),
                                    ),
                                    Text(
                                      '${widget.data['district']}',
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
                                    Text(
                                      '${widget.data['city']}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 19
                                      ),
                                    ),
                                  ]),



                              TableRow(
                                  children: [
                                    Text(
                                      'No. of Members',
                                      style: GoogleFonts.poppins(
                                          fontSize: 19
                                      ),
                                    ),
                                    Text(
                                      '${widget.data['member']}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 19,
                                      ),
                                    ),
                                  ]),

                              TableRow(
                                  children: [
                                    Text(
                                      'Phone no.',
                                      style: GoogleFonts.poppins(
                                          fontSize: 19
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async{
                                        if (await canLaunch('tel:+91${widget.data['phone']}')) {
                                          await launch('tel:+91${widget.data['phone']}');
                                        } else {
                                          throw 'Could not launch tel:+91${widget.data['phone']}';
                                        }
                                      },
                                      child: Text(
                                        '+91${widget.data['phone']}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 19,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ]),
                              TableRow(
                                  children: [
                                    Text(
                                      'Description',
                                      style: GoogleFonts.poppins(
                                          fontSize: 19
                                      ),
                                    ),
                                    Text(
                                      '${widget.data['desc']}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 19
                                      ),
                                    ),
                                  ]),


                            ],

                          ),
                          SizedBox(height: 10,),
                          Divider(thickness: 7,),
                          SizedBox(height: 10,),
                          Table(
                            border: TableBorder.all(color: Colors.white),
                            children: [
                              TableRow(
                                  children: [
                                    Text(
                                      'Username',
                                      style: GoogleFonts.poppins(
                                          fontSize: 19
                                      ),
                                    ),
                                    Text(
                                      '${widget.data['username']}',
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
                                    Text(
                                      '${widget.data['password']}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 19,
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                          SizedBox(height: 20,),
                          InkWell(
                            onTap: ()
                            async{
                              await FirebaseFirestore.instance.collection('ngo_request').doc('${widget.data['id']}').update({
                                'pending': false,
                              }).then((value) {
                                var dataSet = widget.data;
                                dataSet['pending'] = false;

                               FirebaseFirestore.instance.collection('ngo').add(dataSet).then((value){
                                 var doc = FirebaseFirestore.instance.collection('ngo_approved_notification').doc();
                                 FirebaseFirestore.instance.collection('ngo_approved_notification').add({
                                   'token': widget.data['token'],
                                   'id': doc.id,
                                   'ngo': widget.data['name'],
                                   'sent': false
                                 }).then((value) {
                                   _scaffold.currentState.showSnackBar(SnackBar(content: Text('Approved Successfully', style: GoogleFonts.poppins())));
                                   Navigator.pop(context);
                                 });
                               });
                              });
                            },
                            child: Container(
                              // margin: EdgeInsets.symmetric(horizontal: 100),
                              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                              width: MediaQuery.of(context).size.width/1.4,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red, width: 2),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Mark as Approved',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: Colors.red
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
