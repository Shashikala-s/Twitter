import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:twitter/providers/theme_provider.dart';
import 'package:twitter/splash_screen.dart';
import 'package:twitter/view/home_page.dart';

void main()  async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( MyApp());
}
List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
  ];

class MyApp extends StatelessWidget {


   MyApp({Key? key}) : super(key: key);
  final navigatorKey=GlobalKey<NavigatorState>();

   @override
   Widget build(BuildContext context) => MultiProvider(
     providers: providers,
     builder: (context, _) {
       return MaterialApp(
         theme: MyTheme.lightTheme,
         title: 'Twitter',
         // home:  HomePage(),
         home: const SplashScreen(),
         debugShowCheckedModeBanner: false,
       );
     },
     // ),
   );
}

