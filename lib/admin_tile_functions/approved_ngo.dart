import 'package:blood/admin/approve_ngo_request.dart';
import 'package:blood/admin/edit_ngo_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class AdminApprovedNgo extends StatefulWidget {
  @override
  _AdminApprovedNgoState createState() => _AdminApprovedNgoState();
}

class _AdminApprovedNgoState extends State<AdminApprovedNgo> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
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
                'Approved NGO!',
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
                        data['id'] = documentSnapshot.id;
                        return ListTile(
                          leading: CircleAvatar(child: Icon(Icons.person)),
                          trailing: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditNgoData(dataName: data['name'], dataCity: data['city'], dataNumber: data['phone'], dataPass: data['password'], dataState: data['state'], dataUser: data['username'], dataDist: data['district'], doc: data['id'])));
                            },
                            child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black
                            ),
                          ),
                          title: data == null ? Text('Error in data', style: GoogleFonts.poppins(),) : Text(data['name'], style: GoogleFonts.poppins()),
                          subtitle: Text('${toBeginningOfSentenceCase('${data['city']}')} in ${toBeginningOfSentenceCase('${data['district']}')}', style: GoogleFonts.poppins(),),
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
