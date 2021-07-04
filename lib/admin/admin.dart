import 'package:blood/helper/add_new_ngo.dart';
import 'package:blood/helper/edit_ngo_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    child: PaginateFirestore(
                      //item builder type is compulsory.
                      itemBuilder: (index, context, documentSnapshot) {
                        final data = documentSnapshot.data() as Map;
                        return ListTile(
                          leading: CircleAvatar(child: Icon(Icons.person)),
                          trailing: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditNgoData(dataName: data['name'], dataCity: '${data['city']}', dataNumber: '${data['phone']}', dataPass: '${data['password']}', dataState: '${data['state']}', dataUser: '${data['username']}', doc: documentSnapshot.id,)));
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black
                            ),
                          ),
                          title: data == null ? Text('Error in data', style: GoogleFonts.poppins(),) : Text(data['name'], style: GoogleFonts.poppins()),
                          subtitle: Text('${toBeginningOfSentenceCase('${data['city']}')} in ${toBeginningOfSentenceCase('${data['state']}')}', style: GoogleFonts.poppins(),),
                        );
                      },
                      // orderBy is compulsory to enable pagination
                      query: FirebaseFirestore.instance.collection('ngo'),
                      //Change types accordingly
                      itemBuilderType: PaginateBuilderType.listView,
                      // to fetch real-time data
                      isLive: true,
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
