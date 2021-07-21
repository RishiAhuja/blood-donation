import 'package:blood/helper/network_image_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ApprovedRequest extends StatefulWidget {
  @override
  _ApprovedRequestState createState() => _ApprovedRequestState();
}

class _ApprovedRequestState extends State<ApprovedRequest> {
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Approved Requests',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
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
                  child: SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: PaginateFirestore(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        //item builder type is compulsory.
                        itemBuilder: (index, context, documentSnapshot) {
                          final data = documentSnapshot.data() as Map;
                          data['id'] = documentSnapshot.id;
                          return ListTile(
                            leading: CircleAvatar(child: Icon(Icons.person)),
                            trailing: GestureDetector(
                              onTap: (){
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => ApproveNgoRequest(phone: data['phone'], state: data['state'], name: data['name'], city: data['city'])));
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
                                                        'Name',
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
                                                        'District',
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 19
                                                        ),
                                                      ),
                                                      Text(
                                                        '${data['district']}',
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
                                                        'Phone no.',
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
                                                TableRow(
                                                    children: [
                                                      Text(
                                                        'Approved By',
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 19
                                                        ),
                                                      ),
                                                      Text(
                                                        '${data['ngo']}',
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 19
                                                        ),
                                                      ),
                                                    ]),
                                              ],

                                            ),
                                          ),
                                          InkWell(
                                            onTap: ()
                                            async{
                                              await FirebaseFirestore.instance.collection('request').doc('${data['id']}').update({'pending': true, 'ngo': 'admin'})
                                                  .then((value) {
                                                _scaffold.currentState.showSnackBar(SnackBar(content: Text('Un-Approved Successfully', style: GoogleFonts.poppins(),),));
                                                Navigator.of(
                                                    context)
                                                    .pop();
                                              })
                                                  .catchError((error) {
                                                print(error);
                                                _scaffold.currentState.showSnackBar(SnackBar(content: Text('Error UnApproving', style: GoogleFonts.poppins(),),));
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
                                                  'Un Approve',
                                                  textAlign: TextAlign.center,
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
                        query: FirebaseFirestore.instance.collection('request').where('pending', isEqualTo: false),
                        //Change types accordingly
                        itemBuilderType: PaginateBuilderType.listView,
                        // to fetch real-time data
                        isLive: true,
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
