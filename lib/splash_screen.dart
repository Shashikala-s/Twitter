import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/view/home_page.dart';
import 'package:twitter/view/sign_up.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            var returnData = Center(
              child: _loadingImage(context),
            );
            if (snapshot.connectionState == ConnectionState.waiting) {
              returnData = Center(child: _loadingImage(context));
            } else if (snapshot.hasError) {
              returnData = const Text('Error occurred') as Center;
            } else if (snapshot.hasData) {
              navigateToNext();
            } else {
              navigateToLogin();
            }
            return returnData;
          }),
    );
  }

  Image _loadingImage(BuildContext context) {
    return Image.asset(
      'assets/images/twitter_icon.png',
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.height * 0.1,
      fit: BoxFit.cover,
    );
  }

  void navigateToNext() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  void navigateToLogin() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const SignUp()));
    });
  }
}
