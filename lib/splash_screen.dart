import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/view/home_page.dart';
import 'package:twitter/view/sign_up.dart';
import 'package:twitter/view/signin.dart';

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
            print(snapshot);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error occured');
            } else if (snapshot.hasData) {
              navigateToNext();
            } else {
              navigateToLogin();
            }
            return Center(
              child: Image.asset(
                'assets/images/twitter_icon.png',
                fit: BoxFit.cover,
              ),
            );
          }),
    );
  }

  void navigateToNext() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) =>  HomePage()));
    });
  }

  void navigateToLogin() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const SignUp()));
    });
  }
}
