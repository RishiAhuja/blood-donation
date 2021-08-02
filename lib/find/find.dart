import 'package:blood/helper/network_image_view.dart';
import 'package:blood/ngo/ngo_panel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Fulfill extends StatefulWidget {
  final String blood;
  final String state;
  final String district;
  final String city;
  Fulfill({@required this.district, @required this.city, @required this.state, @required this.blood});
  @override
  _FulfillState createState() => _FulfillState();
}

class _FulfillState extends State<Fulfill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: PaginateFirestore(
        //item builder type is compulsory.
        itemBuilder: (index, context, documentSnapshot) {
      final data = documentSnapshot.data() as Map;
      data['id'] = documentSnapshot.id;
      print(documentSnapshot.id);
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
                                    'Age',
                                    style: GoogleFonts.poppins(
                                        fontSize: 19
                                    ),
                                  ),
                                  Text(
                                    '${data['age']}',
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
                                    'Phone no.',
                                    style: GoogleFonts.poppins(
                                        fontSize: 19
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async{
                                      if (await canLaunch('tel:+91${data['phone']}')) {
                                        await launch('tel:+91${data['phone']}');
                                      } else {
                                        throw 'Could not launch tel:+91${data['phone']}';
                                      }
                                    },
                                    child: Text(
                                      '+91${data['phone']}',
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
                                    'Alt Phone no.',
                                    style: GoogleFonts.poppins(
                                        fontSize: 19
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async{
                                      if (await canLaunch('tel:+91${data['altPhone']}')) {
                                        await launch('tel:+91${data['altPhone']}');
                                      } else {
                                        throw 'Could not launch tel:+91${data['altPhone']}';
                                      }
                                    },
                                    child: Text(
                                      '+91${data['phone']}',
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
                                    'Aadhar no.',
                                    style: GoogleFonts.poppins(
                                        fontSize: 19
                                    ),
                                  ),
                                  Text(
                                    '${data['aadhar']}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 19
                                    ),
                                  ),
                                ]),
                            data['image'] !=null ? TableRow(
                                children: [
                                  Container(
                                    child: Text(
                                      'Image',
                                      style: GoogleFonts.poppins(
                                          fontSize: 19
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => NetworkImageView(url: data['image'],)));
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: "${data['image']}",
                                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                                            Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ]) : TableRow(
                                children: [
                                  Text(
                                    'Image',
                                    style: GoogleFonts.poppins(
                                        fontSize: 19
                                    ),
                                  ),
                                  Text(
                                    'Not Attached!',
                                    style: GoogleFonts.poppins(
                                        fontSize: 19
                                    ),
                                  ),
                                ])
                          ],

                        ),
                      ),
                      SizedBox(height: 25,),

                      InkWell(
                        onTap: ()
                        {
                          setState(() {
                            donorData = data;
                            print(data['id']);
                            print(data['name']);
                          });

                          Navigator.pop(context);
                          Navigator.pop(context);
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
                              'Select',
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
            );
          },
          child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black
          ),
        ),
        title: data == null ? Text('Error in data', style: GoogleFonts.poppins(),) : Text(data['name'], style: GoogleFonts.poppins()),
        subtitle: Text('Last donated on ${data['donated']}', style: GoogleFonts.poppins(),),
      );
    },
        // orderBy is compulsory to enable pagination
        query: FirebaseFirestore.instance.collection('donors').where('blood', isEqualTo: widget.blood).where('state', isEqualTo: toBeginningOfSentenceCase('${widget.state}')).where('district', isEqualTo: toBeginningOfSentenceCase('${widget.district}')).where('city', isEqualTo: toBeginningOfSentenceCase('${widget.city}')).orderBy('name'),
        //Change types accordingly
        itemBuilderType: PaginateBuilderType.listView,
        // to fetch real-time data
        isLive: true,
      ),
    );
  }
}
