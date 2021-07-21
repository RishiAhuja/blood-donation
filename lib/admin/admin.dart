import 'package:blood/admin_tile_functions/approved_donations.dart';
import 'package:blood/admin_tile_functions/approved_request.dart';
import 'package:blood/admin_tile_functions/pending_ngo_request.dart';
import 'package:blood/admin/add_new_ngo.dart';
import 'package:blood/admin/edit_ngo_data.dart';
import 'package:blood/admin_tile_functions/donation_requests.dart';
import 'package:blood/admin_tile_functions/pending_request.dart';
import 'package:blood/ngo/ngo_panel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class Admin extends StatefulWidget {
   @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => PendingNgoRequest()));
      //   },
      //   backgroundColor: Colors.deepPurpleAccent[200],
      //   child: Icon(Icons.pending_actions, color: Colors.white),
      // ),
      key: _scaffold,
      backgroundColor: Colors.deepPurpleAccent[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent[200],
        actions: [
          IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewNgo()));}, icon: Icon(Icons.add, color: Colors.white))
        ],
      ),
      body: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Welcome Back!',
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
                    // child: PaginateFirestore(
                    //   //item builder type is compulsory.
                    //   itemBuilder: (index, context, documentSnapshot) {
                    //     final data = documentSnapshot.data() as Map;
                    //     return ListTile(
                    //       leading: CircleAvatar(child: Icon(Icons.person)),
                    //       trailing: GestureDetector(
                    //         onTap: (){
                    //           Navigator.push(context, MaterialPageRoute(builder: (context) => EditNgoData(dataName: data['name'], dataCity: '${data['city']}', dataNumber: '${data['phone']}', dataPass: '${data['password']}', dataState: '${data['state']}', dataUser: '${data['username']}', doc: documentSnapshot.id,)));
                    //         },
                    //         child: Icon(
                    //           Icons.arrow_forward_ios,
                    //           color: Colors.black
                    //         ),
                    //       ),
                    //       title: data == null ? Text('Error in data', style: GoogleFonts.poppins(),) : Text(data['name'], style: GoogleFonts.poppins()),
                    //       subtitle: Text('${toBeginningOfSentenceCase('${data['city']}')} in ${toBeginningOfSentenceCase('${data['state']}')}', style: GoogleFonts.poppins(),),
                    //     );
                    //   },
                    //   // orderBy is compulsory to enable pagination
                    //   query: FirebaseFirestore.instance.collection('ngo'),
                    //   //Change types accordingly
                    //   itemBuilderType: PaginateBuilderType.listView,
                    //   // to fetch real-time data
                    //   isLive: true,
                    // ),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: 25,),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.deepPurpleAccent)
                          ),
                          child: ListTile(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPendingRequest())),
                            title: Text(
                              'Pending Requests',
                              style: GoogleFonts.poppins(),
                            ),
                            subtitle: Text(
                              'All Pending Requests for blood',
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.deepPurpleAccent)
                          ),
                          child: ListTile(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ApprovedRequest())),
                            title: Text(
                              'Approved Requests',
                              style: GoogleFonts.poppins(),
                            ),
                            subtitle: Text(
                              'All approved blood requests',
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.deepPurpleAccent)
                          ),
                          child: ListTile(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDonationRequest())),
                            title: Text(
                              'Donation Requests',
                              style: GoogleFonts.poppins(),
                            ),
                            subtitle: Text(
                              'All Pending blood Donations',
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ),


                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.deepPurpleAccent)
                          ),
                          child: ListTile(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminApprovedDonation())),
                            title: Text(
                              'Approved Donations',
                              style: GoogleFonts.poppins(),
                            ),
                            subtitle: Text(
                              'All Approved blood Donations',
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ),


                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.deepPurpleAccent)
                          ),
                          child: ListTile(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PendingNgoRequest())),
                            title: Text(
                              'NGO Requests',
                              style: GoogleFonts.poppins(),
                            ),
                            subtitle: Text(
                              'All Pending NGO Requests',
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.deepPurpleAccent)
                          ),
                          child: ListTile(
                            title: Text(
                              'Approved NGO',
                              style: GoogleFonts.poppins(),
                            ),
                            subtitle: Text(
                              "All Approved NGO's",
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        )
                      ],
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
