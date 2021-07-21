import 'dart:io';

import 'package:blood/helper/image_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

class Donate extends StatefulWidget {

  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController altPhone = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController aadhar = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  String imagePath = '';
  String imageName = '';
  String bloodGroup;
  String _state;
  String _district;
  String _city;
  bool isUploading = false;
  List<String> districtList = [];
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  sendRequest()
  async{
    if(_formKey.currentState.validate())
    {
      print('validated!');
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: Text('Please wait!', style: GoogleFonts.poppins(),),
            content: Container(
              height: MediaQuery.of(context).size.height/2.5,
              child: Column(
                children: [
                  Image.asset('assets/uploading.png'),
                  Text("Please wait while we are uploading!", style: GoogleFonts.poppins(),)
                ],
              ),
            ),
          )
      );
      try {
        if(imagePath != '' || imagePath != null){
          print(imageName);
          setState(() {
            isUploading = true;
          });
          await firebase_storage.FirebaseStorage.instance
              .ref('donate_img/$imageName')
              .putFile(File(imagePath)).whenComplete(() async{
            String downloadURL = await firebase_storage.FirebaseStorage.instance
                .ref('donate_img/$imageName')
                .getDownloadURL();

            await FirebaseFirestore.instance.collection('donate_pending').add({
              'name': name.text,
              'blood': bloodGroup,
              'age': age.text,
              'phone': phone.text,
              'altPhone': altPhone.text,
              'state': _state,
              'district': _district,
              'city': _city,
              'aadhar': aadhar.text,
              'image': downloadURL,
              'pending': true
            })
                .then((value) {
              _scaffold.currentState.showSnackBar(SnackBar(content: Text('Submitted Successfully', style: GoogleFonts.poppins(),),));
                  setState(() {
                    isUploading = false;
                    Navigator.pop(context);
                  });
            });

          });
        }

        if(imagePath == null || imagePath == ''){
          setState(() {
            isUploading = true;
          });
          await FirebaseFirestore.instance.collection('donate_pending').add({
            'name': name.text,
            'blood': bloodGroup,
            'age': age.text,
            'phone': phone.text,
            'altPhone': altPhone.text,
            'state': _state,
            'district': _district,
            'city': _city,
            'pending': true
          })
              .then((value)  {
                setState(() {
                  isUploading = false;
                });
                Navigator.pop(context);

                _scaffold.currentState.showSnackBar(SnackBar(content: Text('Submitted Successfully', style: GoogleFonts.poppins(),),));
          });

        }
      } catch (e) {
        print(e);
        _scaffold.currentState.showSnackBar(SnackBar(content: Text('Submission Failed', style: GoogleFonts.poppins(),),));
      }
    }
  }

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepPurpleAccent[200],
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Donate Blood',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 25,
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
                                                  controller: name,
                                                  style: GoogleFonts.poppins(),
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: 'Your name',
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
                                                    value: bloodGroup,
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
                                                        bloodGroup = value;
                                                        print(bloodGroup);
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
                                              Icon(Icons.person_add, color: Colors.grey, ),
                                              SizedBox(width: 10,),
                                              Container(
                                                width: MediaQuery.of(context).size.width/1.6,
                                                child: TextFormField(
                                                  controller: age,
                                                  validator: (val)
                                                  {
                                                    return val.length < 1 || val.length > 2 || val == null || val == "" ? 'Please enter a valid number' : null;
                                                  },
                                                  keyboardType: TextInputType.phone,
                                                  style: GoogleFonts.poppins(),
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: 'Age',
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
                                                  controller: phone,
                                                  validator: (val)
                                                  {
                                                    return val.length < 10 || val.length > 10 || val == null || val == "" ? 'Please enter a valid number' : null;
                                                  },
                                                  keyboardType: TextInputType.phone,
                                                  style: GoogleFonts.poppins(),
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: 'Contact no.',
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
                                                  controller: altPhone,
                                                  validator: (val)
                                                  {
                                                    return val.length < 10 || val.length > 10 || val == null || val == "" ? 'Please enter a valid number' : null;
                                                  },
                                                  keyboardType: TextInputType.phone,
                                                  style: GoogleFonts.poppins(),
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: 'Alternate no.',
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
                                              Icon(Icons.password, color: Colors.grey, ),
                                              SizedBox(width: 10,),
                                              Container(
                                                width: MediaQuery.of(context).size.width/1.6,
                                                child: TextFormField(
                                                  controller: aadhar,
                                                  validator: (val)
                                                  {
                                                    return val.length < 12 || val.length > 12 || val == null || val == "" ? 'Please enter a valid number' : null;
                                                  },
                                                  keyboardType: TextInputType.phone,
                                                  style: GoogleFonts.poppins(),
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: 'Aadhar number',
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
                                        GestureDetector(
                                          onTap: (){
                                            showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                  title: Text('Please select one!', style: GoogleFonts.poppins(),),
                                                  content: Container(
                                                    height: MediaQuery.of(context).size.height/4,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                       GestureDetector(
                                                         onTap: () async{
                                                           final XFile image = await _picker.pickImage(source: ImageSource.camera);
                                                           if(image!=null){
                                                             print(image.name);
                                                             print(image.path);
                                                             Navigator.pop(context);
                                                             setState(() {
                                                               imagePath = image.path;
                                                               imageName = image.name;
                                                             });
                                                           }
                                                         },
                                                         child: Material(
                                                           elevation: 7,
                                                          borderRadius: BorderRadius.circular(15),
                                                          color: Colors.white,
                                                          child: Container(
                                                            padding: EdgeInsets.all(10),
                                                            height: 50,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.camera_alt,
                                                                  color: Colors.black,
                                                                ),
                                                                SizedBox(width: 10,),
                                                                Text(
                                                                  'Camera',
                                                                  style: GoogleFonts.poppins(
                                                                    color: Colors.black
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            ),
                                                          ),
                                                       ),
                                                        SizedBox(height: 15,),

                                                        GestureDetector(
                                                          onTap: () async{
                                                            final XFile image = await _picker.pickImage(source: ImageSource.gallery);
                                                            if(image!=null){
                                                              print(image.name);
                                                              print(image.path);
                                                              Navigator.pop(context);
                                                              setState(() {
                                                                imagePath = image.path;
                                                                imageName = image.name;
                                                              });
                                                            }
                                                          },
                                                          child: Material(
                                                            elevation: 7,
                                                            borderRadius: BorderRadius.circular(15),
                                                            color: Colors.white,
                                                            child: Container(
                                                              padding: EdgeInsets.all(10),

                                                              height: 50,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.photo,
                                                                    color: Colors.black,
                                                                  ),
                                                                  SizedBox(width: 10,),
                                                                  Text(
                                                                    'Photo',
                                                                    style: GoogleFonts.poppins(
                                                                        color: Colors.black
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
                                                )
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 30),
                                            width: MediaQuery.of(context).size.width/1.3,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(color: Colors.grey)
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(width: 10,),
                                                Icon(Icons.photo, color: Colors.grey, ),
                                                SizedBox(width: 10,),
                                                Container(
                                                  padding: EdgeInsets.symmetric(vertical: 15),
                                                  width: MediaQuery.of(context).size.width/1.6,
                                                  child: imagePath == '' ? Text(
                                                      'Your picture (optional)',
                                                      style: GoogleFonts.poppins(
                                                          color: Colors.grey
                                                      )
                                                  ) : Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                          'Image Added!',
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.black
                                                          ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 10),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(width: 10,),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(path: imagePath)));
                                                              },
                                                                child: Icon(Icons.remove_red_eye, color: Colors.black)
                                                            ),
                                                            SizedBox(width: 10,),
                                                            GestureDetector(onTap: () {
                                                              setState(() {
                                                                imagePath = '';
                                                              });
                                                            },
                                                                child: Icon(Icons.clear, color: Colors.black)
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ),
                                              ],
                                            ),
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

                                        SizedBox(height: 20,),
                                        SingleChildScrollView(
                                          child: InkWell(
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
