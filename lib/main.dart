import 'package:blood/ngo/ngo_panel.dart';
import 'package:blood/services/local_notification_service.dart';
import 'package:blood/views/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

Future<void> backgroundHandler(RemoteMessage message) async{

  LocalNotificationService.display(message);
  print("when app is terminated!");
  print(message.data.toString());
  print(message.notification.title);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'Blood4Life',
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            home: Notification(),
          );
        }
    );
  }
}


class Notification extends StatefulWidget {
  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends State<Notification> {
  bool _isNGO = false;
  void initState() {
    // TODO: implement initState
    super.initState();
    getSF();
    LocalNotificationService.initialize(context);
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print('local notification service initialized');
      }
    });

    //foreground work
    FirebaseMessaging.onMessage.listen((message) async {
      if (message.notification != null) {
        print(message.notification.body);
        print(message.notification.title);
      }
      LocalNotificationService.display(message);
      print("when app is on!");
    });

    //When the app is in background but opened and user taps
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      LocalNotificationService.display(message);
      print("when user taps on Notification!");
    });
  }
  getSF()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('isNGO');
    if(prefs.getBool('isNGO') != null){
      setState(() {
        _isNGO = prefs.getBool('isNGO');
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    if(_isNGO){
      return Pending();
    }
    else {
      return Home();
    }
  }

}