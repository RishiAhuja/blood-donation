import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class PendingNgoRequest extends StatefulWidget {
  @override
  _PendingNgoRequestState createState() => _PendingNgoRequestState();
}

class _PendingNgoRequestState extends State<PendingNgoRequest> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  @override
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
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => EditNgoData(dataName: data['name'], dataCity: '${data['city']}', dataNumber: '${data['phone']}', dataPass: '${data['password']}', dataState: '${data['state']}', dataUser: '${data['username']}', doc: documentSnapshot.id,)));
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
                      query: FirebaseFirestore.instance.collection('ngo_request').where('pending', isEqualTo: false),
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
