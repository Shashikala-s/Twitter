import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:twitter/splash_screen.dart';

void main()  async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {

   MyApp({Key? key}) : super(key: key);
  final navigatorKey=GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey ,
      title: 'Twitter',
      theme: ThemeData(
           primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

