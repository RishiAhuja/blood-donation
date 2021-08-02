import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController member = TextEditingController();
  TextEditingController desc = TextEditingController();

  String _state;
  String _district;
  String _city;
  List<String> districtList = [];
  bool _userExists = false;
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
      String token = await FirebaseMessaging.instance.getToken();
      await FirebaseFirestore.instance.collection('ngo_request').add({
        'name': name.text,
        'username': user.text,
        'password': password.text,
        'state': _state.toLowerCase(),
        'district': _district.toLowerCase(),
        'city': _city.toLowerCase(),
        'phone': phone.text,
        'desc': desc.text,
        'member': member.text,
        'token': token,
        'pending': true
      })
          .then((value) {
        _scaffold.currentState.showSnackBar(SnackBar(content: Text('Submitted Successfully', style: GoogleFonts.poppins(),),));
        // Navigator.pop(context);
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("You are all set!",style: GoogleFonts.poppins()),
            content: Text("Your request has been sent to admin. You will recieve a notification on the same phone when the admin approves you. After you are approved by the admin you can login from the NGO login screen and you can start your work", style: GoogleFonts.poppins(height: 1.7),),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text("Close", style: GoogleFonts.poppins(),),
              ),
            ],
          ),
        );
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
                                            Icon(Icons.verified_user, color: Colors.grey, ),
                                            SizedBox(width: 10,),
                                            Container(
                                              width: MediaQuery.of(context).size.width/1.6,
                                              child: TextFormField(
                                                validator: (val)
                                                {
                                                  var length;
                                                  FirebaseFirestore.instance.collection('ngo').where('username', isEqualTo: user.text).get().then((value) {
                                                    setState(() {

                                                      print(value.docs.length);
                                                      if(value.docs.length == 0){
                                                        _userExists = false;
                                                        print(_userExists);
                                                        length = 0;
                                                      }else{
                                                        _userExists = true;
                                                        length = 1;
                                                      }
                                                    });
                                                  });
                                                  return val.length < 3 || val == '' || val == null || length == 1 ? 'Please choose another username' : null;
                                                },
                                                controller: user,
                                                style: GoogleFonts.poppins(),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Select a username..',
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
                                            Icon(Icons.password, color: Colors.grey, ),
                                            SizedBox(width: 10,),
                                            Container(
                                              width: MediaQuery.of(context).size.width/1.6,
                                              child: TextFormField(
                                                validator: (val)
                                                {
                                                  return val.length < 6 || val == '' || val == null ? 'Please enter a 6+ password' : null;
                                                },
                                                controller: password,
                                                style: GoogleFonts.poppins(),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Select a password..',
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
          'Mohali'
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





//Phathankot + Mansa
// Multiple no in ngo become
