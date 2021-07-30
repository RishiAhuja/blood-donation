import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        title: Text(
          'About us',
          style: GoogleFonts.poppins(
            color: Colors.white
          ),
        )
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Blood',
                  style: GoogleFonts.poppins(
                      color: Colors.red,
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
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Text(
                  'Life',
                  style: GoogleFonts.poppins(
                      color: Colors.red,
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
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "This app is about making a connection among NGOs, Blood needers and Donors. Our main aim is to have a society where there is no shortage of blood in the most critical situations.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    height: 1.8
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey)
              ),
              child: ListTile(
                title: Text('Rishi Ahuja', style: GoogleFonts.poppins(
                  color: Colors.black
                ),),
                subtitle: Text('Developed By', style: GoogleFonts.poppins(
                  color: Colors.grey[600]
                ),),
              ),
            ),
            ListTile(
              title: Text('Mr. Sonu', style: GoogleFonts.poppins(
                color: Colors.black
              ),),
              subtitle: Text('Idea & Direction By', style: GoogleFonts.poppins(
                color: Colors.grey[600]
              ),),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey)
              ),
              child: ListTile(
                title: Text('1.0.0', style: GoogleFonts.poppins(
                    color: Colors.black
                ),),
                subtitle: Text('Version', style: GoogleFonts.poppins(
                    color: Colors.grey[600]
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
