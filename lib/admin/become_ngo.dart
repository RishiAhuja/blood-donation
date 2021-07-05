import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BecomeNgo extends StatefulWidget {
   @override
  _BecomeNgoState createState() => _BecomeNgoState();
}

class _BecomeNgoState extends State<BecomeNgo> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController member = TextEditingController();
  TextEditingController desc = TextEditingController();

  String _state;
  String _city;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
  }
  sendRequest()
  async{
    if(_formKey.currentState.validate())
    {
      print('validated!');
      await FirebaseFirestore.instance.collection('ngo_request').add({
        'name': name.text,
        'state': _state.toLowerCase(),
        'city': _city.toLowerCase(),
        'phone': phone.text,
        'desc': desc.text,
        'member': member.text,
        'pending': true
      })
          .then((value) {
        _scaffold.currentState.showSnackBar(SnackBar(content: Text('Submitted Successfully', style: GoogleFonts.poppins(),),));
        Navigator.pop(context);
      })

          .catchError((error) {
        print(error);
        _scaffold.currentState.showSnackBar(SnackBar(content: Text('Submission Failed', style: GoogleFonts.poppins(color: Colors.red),),));
      });
    }
  }


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
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Request to be a NGO!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 20,),
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
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              'Please submit a quick form!',
                              // textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 19,
                                  color: Colors.black
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          child: Form(
                            key: _formKey,
                            child: Container(
                              height: MediaQuery.of(context).size.height/1.45,

                              child: SingleChildScrollView(
                                child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 30),
                                        width: MediaQuery.of(context).size.width/1.3,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.grey)
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Icon(Icons.person, color: Colors.grey, ),
                                            SizedBox(width: 10,),
                                            Container(
                                              width: MediaQuery.of(context).size.width/1.6,
                                              child: TextFormField(
                                                validator: (val)
                                                {
                                                  return val.length < 3 || val == '' || val == null ? 'Please enter a valid name' : null;
                                                },
                                                controller: name,
                                                style: GoogleFonts.poppins(),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'NGO Name',
                                                    hintStyle: GoogleFonts.poppins(
                                                        color: Colors.grey
                                                    )
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15,),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 30),
                                        width: MediaQuery.of(context).size.width/1.3,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.grey)
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Icon(Icons.home, color: Colors.grey, ),
                                            SizedBox(width: 10,),
                                            Container(
                                              width: MediaQuery.of(context).size.width/2,
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField<String>(
                                                  validator: (val){
                                                    return val == null || val == "" ?  'Please enter a value' : null;
                                                  },
                                                  focusColor: Colors.white,
                                                  value: _state,
                                                  elevation: 15,

                                                  style: TextStyle(color: Colors.white),
                                                  iconEnabledColor:Colors.grey,
                                                  items: <String>[
                                                    'Punjab',
                                                  ].map<DropdownMenuItem<String>>((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(
                                                          value,
                                                          style: GoogleFonts.montserrat(
                                                            textStyle: TextStyle(color: Colors.black ),
                                                          )),
                                                    );
                                                  }).toList(),
                                                  hint: Text(
                                                    "State",
                                                    style: GoogleFonts.poppins(textStyle: TextStyle(
                                                      color: Colors.grey,),
                                                    ),),
                                                  onChanged: (String value) {
                                                    setState(() {
                                                      _state = value;
                                                      print(_state);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),


                                      SizedBox(height: 15,),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 30),
                                        width: MediaQuery.of(context).size.width/1.3,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.grey)
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Icon(Icons.home, color: Colors.grey, ),
                                            SizedBox(width: 10,),
                                            Container(
                                              width: MediaQuery.of(context).size.width/2,
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField<String>(
                                                  validator: (val){
                                                    return val == null || val == "" ?  'Please enter a value' : null;
                                                  },
                                                  focusColor: Colors.white,
                                                  value: _city,
                                                  elevation: 15,
                                                  style: TextStyle(color: Colors.white),
                                                  iconEnabledColor:Colors.grey,
                                                  items: <String>[
                                                    'Amritsar',
                                                    'Barnala',
                                                    'Bathinda',
                                                    'Faridkot',
                                                    'Fatehgarh Sahib',
                                                    'Firozpur',
                                                    'Fazilka',
                                                    'Gurdaspur',
                                                    'Hoshiarpur',
                                                    'Jalandhar',
                                                    'Kapurthala',
                                                    'Ludhiana',
                                                    'Malerkotla',
                                                    'Mansa',
                                                    'Moga',
                                                    'Muktsar',
                                                    'Nawanshahr',
                                                    'Pathankot',
                                                    'Patiala',
                                                    'Rupnagar',
                                                    'Mohali',
                                                    'Tarn Taran',
                                                  ].map<DropdownMenuItem<String>>((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(
                                                          value,
                                                          style: GoogleFonts.montserrat(
                                                            textStyle: TextStyle(color: Colors.black ),
                                                          )),
                                                    );
                                                  }).toList(),
                                                  hint: Text(
                                                    "City",
                                                    style: GoogleFonts.poppins(textStyle: TextStyle(
                                                      color: Colors.grey,),
                                                    ),),
                                                  onChanged: (String value) {
                                                    setState(() {
                                                      _city = value;
                                                      print(_city);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 30),
                                        width: MediaQuery.of(context).size.width/1.3,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.grey)
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Icon(Icons.phone, color: Colors.grey, ),
                                            SizedBox(width: 10,),
                                            Container(
                                              width: MediaQuery.of(context).size.width/1.6,
                                              child: TextFormField(
                                                controller: phone,
                                                validator: (val)
                                                {
                                                  return val.length < 10 || val.length > 10 || val == null || val == "" ? 'Please enter a valid number' : null;
                                                },
                                                keyboardType: TextInputType.phone,
                                                style: GoogleFonts.poppins(),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Phone no.',
                                                    hintStyle: GoogleFonts.poppins(
                                                        color: Colors.grey
                                                    )
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      //
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 30),
                                        width: MediaQuery.of(context).size.width/1.3,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.grey)
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Icon(Icons.card_membership, color: Colors.grey, ),
                                            SizedBox(width: 10,),
                                            Container(
                                              width: MediaQuery.of(context).size.width/1.6,
                                              child: TextFormField(
                                                controller: member,
                                                validator: (val)
                                                {
                                                  return val == null || val == "" ? 'Please enter a valid number' : null;
                                                },
                                                keyboardType: TextInputType.phone,
                                                style: GoogleFonts.poppins(),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'No. of members',
                                                    hintStyle: GoogleFonts.poppins(
                                                        color: Colors.grey
                                                    )
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 30),
                                        width: MediaQuery.of(context).size.width/1.3,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.grey)
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(width: 10,),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 18.0),
                                              child: Icon(Icons.description, color: Colors.grey, ),
                                            ),
                                            SizedBox(width: 10,),
                                            Container(
                                              height: 150,
                                              width: MediaQuery.of(context).size.width/1.6,
                                              child: TextFormField(
                                                maxLines: 50,
                                                controller: desc,
                                                validator: (val)
                                                {
                                                  return val.length < 5 || val == '' || val == null ? 'Please enter a valid description' : null;
                                                },
                                                style: GoogleFonts.poppins(),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Describe about your NGO',
                                                    hintStyle: GoogleFonts.poppins(
                                                        color: Colors.grey
                                                    )
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      InkWell(
                                        onTap: ()
                                        {
                                          sendRequest();
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 100),
                                          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.deepPurpleAccent, width: 2),
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'SUBMIT',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20,
                                                  color: Colors.deepPurpleAccent
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 20,),
                                    ]
                                ),
                              ),
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
