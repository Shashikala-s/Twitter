import 'package:flutter/material.dart';
import 'package:twitter/view/sign_up.dart';
import 'package:twitter/view/signin.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin =true;
  @override
  Widget build(BuildContext context) =>isLogin?SignIn():SignUp();
}