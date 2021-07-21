import 'package:blood/ngo/donation_pending.dart';
import 'package:blood/views/donate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class Pending extends StatefulWidget {
  final String ngoUsername;
  Pending({this.ngoUsername});
  @override
  _PendingState createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DonatePending(ngoUsername: widget.ngoUsername,)));
        },
        child: Icon(Icons.event_available),
      ),
      backgroundColor: Colors.deepPurpleAccent[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent[200],
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'NGO Panel',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 25,),
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
                  child: Column(
                    children: [
                      SizedBox(height: 25,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('request').where('pending', isEqualTo: true).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Column(
                                  children: [
                                    Icon(Icons.error, color: Colors.red),
                                    Text(
                                      'Error Loading Data',
                                      style: GoogleFonts.poppins(),
                                    )
                                  ],
                                ),
                              );
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Column(
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
                              ));
                            }

                            return snapshot.data.docs.length == 0 || snapshot.data.docs == null ? Center(child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Image.asset('assets/no-data.png', width: 270, height: 270,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'No data Available, You are all set!',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize: 22
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            )) : ListView(
                              shrinkWrap: true,
                              children: snapshot.data.docs.map((DocumentSnapshot document) {
                                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                                data['id'] = document.id;
                                return Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      height: 80,
                                      width: MediaQuery.of(context).size.width/1.2,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.deepPurpleAccent[100],
                                            Colors.deepPurpleAccent[200]
                                          ]
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 14.0),
                                                child: Icon(Icons.pending_actions, color: Colors.white, size: 30,),
                                              ),
                                              SizedBox(width: 14,),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${data['attendant']} requested ${data['blood']} blood',
                                                      style: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 15
                                                      ),
                                                    ),
                                                    Text(
                                                      'for ${data['name']}',
                                                      style: GoogleFonts.poppins(
                                                          color: Colors.white,
                                                          fontSize: 15
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: ()
                                            {
                                              showMaterialModalBottomSheet(
                                                context: context,
                                                builder: (context) => SingleChildScrollView(
                                                  controller: ModalScrollController.of(context),
                                                  child: Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          color: Colors.white,
                                                          padding: EdgeInsets.all(20.0),
                                                          child: Table(
                                                            border: TableBorder.all(color: Colors.white),
                                                            children: [
                                                              TableRow(
                                                                  children: [
                                                                Text(
                                                                    'Blood Type',
                                                                  style: GoogleFonts.poppins(
                                                                    fontSize: 19
                                                                  ),
                                                                ),
                                                                Text(
                                                                    '${data['blood']}',
                                                                  style: GoogleFonts.poppins(
                                                                      fontSize: 19
                                                                  ),
                                                                ),
                                                              ]),
                                                              TableRow(
                                                                  children: [
                                                                    Text(
                                                                      'Patient',
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize: 19
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '${data['name']}',
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
                                                                      '${data['state']}',
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
                                                                      '${data['city']}',
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize: 19
                                                                      ),
                                                                    ),
                                                                  ]),
                                                              TableRow(
                                                                  children: [
                                                                    Text(
                                                                      'Hospital',
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize: 19
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '${data['hospital']}',
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize: 19
                                                                      ),
                                                                    ),
                                                                  ]),
                                                              TableRow(
                                                                  children: [
                                                                    Text(
                                                                      'Attendant',
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize: 19
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '${data['attendant']}',
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize: 19
                                                                      ),
                                                                    ),
                                                                  ]),
                                                              TableRow(
                                                                  children: [
                                                                    Text(
                                                                      'Attendant no.',
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize: 19
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap: () async{
                                                                        if (await canLaunch('tel:+91${data['number']}')) {
                                                                          await launch('tel:+91${data['number']}');
                                                                        } else {
                                                                          throw 'Could not launch tel:+91${data['number']}';
                                                                        }
                                                                      },
                                                                      child: Text(
                                                                        '+91${data['number']}',
                                                                        style: GoogleFonts.poppins(
                                                                            fontSize: 19,
                                                                            color: Colors.blue,
                                                                            decoration: TextDecoration.underline,
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
                                                            await FirebaseFirestore.instance.collection('request').doc('${data['id']}').update({'pending': false, 'ngo': '${widget.ngoUsername}'})
                                                            .then((value) {
                                                              _scaffold.currentState.showSnackBar(SnackBar(content: Text('Approved Successfully', style: GoogleFonts.poppins(),),));
                                                              Navigator.of(
                                                                  context)
                                                                  .pop();
                                                            })
                                                                .catchError((error) {
                                                              print(error);
                                                              _scaffold.currentState.showSnackBar(SnackBar(content: Text('Error Approving', style: GoogleFonts.poppins(),),));
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
                                                                'Mark as Approved',
                                                                style: GoogleFonts.poppins(
                                                                    fontSize: 20,
                                                                    color: Colors.deepPurpleAccent
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                         SizedBox(height: 25,)
                                                      ],

                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 14.0),
                                              child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.white, size: 20,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        ),
                    ],
                  ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

