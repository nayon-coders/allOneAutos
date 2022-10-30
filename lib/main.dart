import 'package:car/view/flash-screen.dart';
import 'package:car/view/home-screen.dart';
import 'package:car/view/login-screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import 'notificationservice/notificationservice.dart';

final InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings(defaultFirebaseAppName),
    iOS: DarwinInitializationSettings(),
    macOS: DarwinInitializationSettings()
);

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize(InitializationSettings);

  runApp(const MyApp());
}
// Background service
Future<void> backgroundHandler(RemoteMessage message) async {
  print("Background service is on");
  print(message.data.toString());
  print(message.notification!.title);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? isLogin;
  @override
  void initState(){
    super.initState();
    getLogin();
  }
  getLogin()async{
    SharedPreferences localDatabase = await SharedPreferences.getInstance();
   isLogin = localDatabase.getString("isLogin");
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return  GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "nunito",
          ),
          home:  HomeScreen(),
        );
      }
    );
  }
}
