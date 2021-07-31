import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  TextEditingController patient = TextEditingController();
  TextEditingController hospital = TextEditingController();
  TextEditingController attendant = TextEditingController();
  TextEditingController number = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
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
        String token = await FirebaseMessaging.instance.getToken();
        print('validated!');
        await FirebaseFirestore.instance.collection('request').add({
          'name': patient.text,
          'blood': _chosenValue,
          'state': _state.toLowerCase(),
          'district': _district.toLowerCase(),
          'city': _city.toLowerCase(),
          'hospital': hospital.text.toLowerCase(),
          'attendant': attendant.text,
          'number': number.text,
          'token': token,
          'pending': true
        }).then((value) {
          var randomDoc = FirebaseFirestore.instance.collection("notifications").doc();
          FirebaseFirestore.instance.collection('notifications').doc('${randomDoc.id}').set({
                'topic': 'ngo',
                'name': '${patient.text}',
                'blood': _chosenValue,
                'id': randomDoc.id,
                'token': token,
                'sent': false
              }).then((value) {
                _scaffold.currentState.showSnackBar(SnackBar(content: Text('Submitted Successfully', style: GoogleFonts.poppins(),),));
              });
        })
            .catchError((error) {
              print(error);
              _scaffold.currentState.showSnackBar(SnackBar(content: Text('Submission Failed', style: GoogleFonts.poppins(),),));
        });
      }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _chosenValue;
  String _state;
  String _city;
  String _district;
  List<String> districtList = [];
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
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Request Blood Quickly!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
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
                    child: SingleChildScrollView(
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
                                                  return val.length < 2 || val == '' || val == null ? 'Please enter a valid name' : null;
                                                },
                                                controller: patient,
                                                style: GoogleFonts.poppins(),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Patient Name',
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
                                            Icon(Icons.bloodtype, color: Colors.grey, ),
                                            SizedBox(width: 10,),
                                            Container(
                                              width: MediaQuery.of(context).size.width/2,
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField<String>(
                                                  validator: (val){
                                                    return val == null || val == "" ?  'Please enter a value' : null;
                                                  },
                                                  focusColor: Colors.white,
                                                  value: _chosenValue,
                                                  elevation: 15,

                                                  style: TextStyle(color: Colors.white),
                                                  iconEnabledColor:Colors.grey,
                                                  items: <String>[
                                                    'A+',
                                                    'A-',
                                                    'B+',
                                                    'B-',
                                                    'AB+',
                                                    'AB-',
                                                    'O+',
                                                    'O-',
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
                                                    "Blood Group",
                                                    style: GoogleFonts.poppins(textStyle: TextStyle(
                                                      color: Colors.grey,),
                                                    ),),
                                                  onChanged: (String value) {
                                                    setState(() {
                                                      _chosenValue = value;
                                                      print(_chosenValue);
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
                                                  value: _district,
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
                                                    "District",
                                                    style: GoogleFonts.poppins(textStyle: TextStyle(
                                                      color: Colors.grey,),
                                                    ),),
                                                  onChanged: (String value) {
                                                    city(value);
                                                    setState(() {
                                                      _city = null;
                                                      _district = value;
                                                      print(_district);
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
                                              width: MediaQuery.of(context).size.width/1.8,
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
                                                  items: districtList.map<DropdownMenuItem<String>>((String value) {
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
                                            Icon(Icons.local_hospital, color: Colors.grey, ),
                                            SizedBox(width: 10,),
                                            Container(
                                              width: MediaQuery.of(context).size.width/1.6,
                                              child: TextFormField(
                                                controller: hospital,
                                                validator: (val)
                                                {
                                                  return val.length < 5 || val == '' || val == null ? 'Please enter a valid name' : null;
                                                },
                                                style: GoogleFonts.poppins(),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Hospital',
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
                                          children: [
                                            SizedBox(width: 10,),
                                            Icon(Icons.verified_user, color: Colors.grey, ),
                                            SizedBox(width: 10,),
                                            Container(
                                              width: MediaQuery.of(context).size.width/1.6,
                                              child: TextFormField(
                                                controller: attendant,
                                                validator: (val)
                                                {
                                                  return val.length < 2 || val == '' || val == null ? 'Please enter a valid name' : null;
                                                },
                                                style: GoogleFonts.poppins(),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Attendant',
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
                                          children: [
                                            SizedBox(width: 10,),
                                            Icon(Icons.phone, color: Colors.grey, ),
                                            SizedBox(width: 10,),
                                            Container(
                                              width: MediaQuery.of(context).size.width/1.6,
                                              child: TextFormField(
                                                controller: number,
                                                validator: (val)
                                                {
                                                  return val.length < 10 || val.length > 10 || val == null || val == "" ? 'Please enter a valid number' : null;
                                                },
                                                keyboardType: TextInputType.phone,
                                                style: GoogleFonts.poppins(),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Attendant Phone no.',
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
                                            border: Border.all(color: Colors.red, width: 2),
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'SUBMIT',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20,
                                                  color: Colors.red
                                              ),
                                            ),
                                          ),
                                        ),
                                      )


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
              ),
            ],
          ),
        ),
      ),
    );
  }











  city(district){
    if(district == 'Amritsar'){
      setState(() {
        districtList = [
          'Ajnala',
          'Amritsar',
          'Amritsar Cantonment',
          'Attari',
          'Beas City',
          'Budha Theh',
          'Chheharta Sahib',
          'Jandiala Guru',
          'Majitha',
          'Rajasansi',
          'Ramdass',
          'Rayya',
          'Shariffpura'
        ];
      });
    }
    if(district == 'Barnala'){
      setState(() {
        districtList = [
          'Alkara',
          'Barnala',
          'Barnala district',
          'Bhadaur',
          'Dhanaula',
          'Handiaya',
          'Sehna',
          'Tappa'
        ];
      });
    }

    if(district == 'Bathinda'){
      setState(() {
        districtList = [
          'Bhai Rupa',
          'Bhisiana',
          'Bhucho Mandi',
          'Goniana',
          'Kot Fatta',
          'Maur Mandi',
          'Nathana',
          'Raman',
          'Rampura Phul',
          'Sangat',
          'Talwandi Sabo'
        ];
      });
    }


    if(district == 'Faridkot'){
      setState(() {
        districtList = [
          'Faridkot',
          'Jaitu',
          'Kotkapura',
          'Machaki Mal Singh',
        ];
      });
    }

    if(district == 'Fatehgarh Sahib'){
      setState(() {
        districtList = [
          'Amloh',
          'Bassi Pathana',
          'Fatehgarh Sahib',
          'Khamanon',
          'Mandi Gobindgarh',
          'Nogawan',
          'Sirhind-Fategarh',
        ];
      });
    }


    if(district == 'Firozpur'){
      setState(() {
        districtList = [
          'Firozpur',
          'Firozpur Cantonment',
          'Guru Har Sahai',
          'Hussainiwala',
          'Makhu',
          'Moodkee',
          'Talwandi Bhai',
          'Zira'
        ];
      });
    }

    if(district == 'Fazilka'){
      setState(() {
        districtList = [
          'Abohar',
          'Fazilka',
          'Jalalabad',
          'Kilianwali',
        ];
      });
    }

    if(district == 'Gurdaspur'){
      setState(() {
        districtList = [
          'Batala',
          'Bhaini Mian Khan',
          'Dera Baba Nanak',
          'Dhariwal',
          'Dina Nagar',
          'Dorangla',
          'Fatehgarh Churian',
          'Gurdaspur',
          'Jugial',
          'Kahnuwan',
          'Kalanaur',
          'Naserke',
          'Qadian',
          'Naserke',
          'Ranjit Bagh',
          'Sri Hargobindpur',
        ];
      });
    }


    if(district == 'Hoshiarpur'){
      setState(() {
        districtList = [
          'Bajwara',
          'Bassi Kalan',
          'Bharta',
          'Chabbewal',
          'Chohal',
          'Dandiyan',
          'Dasuya',
          'Ganeshpur Bharta',
          'Ganeshpur',
          'Garhdiwala',
          'Garhshankar',
          'Hajipur',
          'Hariana',
          'Harsi Pind',
          'Jalwehra',
          'Mahilpur',
          'Mukerian',
          'Mahilpur',
          'Nangal Thathal',
          'Ram Colony Camp',
          'Shamchaurasi',
          'Talwara',
          'Unchi Bassi',
          'Urmar Tanda',
        ];
      });
    }

    if(district == 'Jalandhar'){
      setState(() {
        districtList = [
          'Abadi Jallowal',
          'Adampur',
          'Alawalpur',
          'Apra',
          'Bhogpur',
          'Bootan Mandi',
          'Chak Sahbu',
          'Jalandhar',
          'Jalandhar Cantonment',
          'Kartarpur',
          'Lohian Khas',
          'Nakodar',
          'Nurmahal',
          'Phillaur',
          'Sansarpur',
          'Shahkot',
          'Talwan',

        ];
      });
    }

    if(district == 'Kapurthala'){
      setState(() {
        districtList = [
          'Begowal',
          'Bholath',
          'Dhilwan',
          'Hussainpur',
          'Kapurthala',
          'Kapurthala Cantonment',
          'Kuka',
          'Phagwara',
          'Sultanpur Lodhi',
        ];
      });
    }
    if(district == 'Malerkotla'){
      setState(() {
        districtList = [
          'Malerkotla',
          'Ahmedgarh',
          'Amargarh',
        ];
      });
    }


    if(district == 'Mansa'){
      setState(() {
        districtList = [
          'Bareta',
          'Bhikhi',
          'Budhlada',
          'Dalelwala',
          'Sardulgarh',
        ];
      });
    }

    if(district == 'Moga'){
      setState(() {
        districtList = [
          'Badhni Kalan',
          'Bagha Purana',
          'Charik',
          'Dharamkot',
          'Kot Ise Khan',
          'Moga',
          'Nihal Singh Wala',
        ];
      });
    }


    if(district == 'Muktsar'){
      setState(() {
        districtList = [
          'Bariwala',
          'Bhagsar',
          'Charik',
          'Dharamkot',
          'Kot Ise Khan',
          'Moga',
          'Nihal Singh Wala',
        ];
      });
    }

    if(district == 'Nawanshahr'){
      setState(() {
        districtList = [
          'Nawanshahr',
          'Banga',
          'Rahon',
          'Khothran',
          'Saloh',
          'Aur',
        ];
      });
    }

    if(district == 'Pathankot'){
      setState(() {
        districtList = [
          'Not Found'
        ];
      });
    }

    if(district == 'Patiala'){
      setState(() {
        districtList = [
          'Banaur',
          'Banur',
          'Ghagga',
          'Ghanaur',
          'Lehal',
          'Nabha',
          'Pattran',
          'Rajpura',
          'Rurki Kasba',
          'Samana',
          'Sanaur',
          'Shekhpura'
        ];
      });
    }
    if(district == 'Rupnagar'){
      setState(() {
        districtList = [
          'Anandpur Sahib',
          'Bara',
          'Bhabat',
          'Chamkaur',
          'Dher Majra',
          'Kiratpur Sahib',
          'Kotla Nihang Khan',
          'Morinda',
          'Nangal',
          'Naya Nangal',
          'Nehon',
          'Rupnagar'
        ];
      });
    }

    if(district == 'Mohali'){
      setState(() {
        districtList = [
          'Not Found'
        ];
      });
    }

    if(district == 'Tarn Taran'){
      setState(() {
        districtList = [
          'Bhikhiwind',
          'Chohla Sahib',
          'Fatehabad',
          'Kairon',
          'Khadur Sahib',
          'Khemkaran',
          'Mohanpura',
          'Patti',
          'Sarhali',
          'Tarn Taran',
        ];
      });
    }

  }
}

