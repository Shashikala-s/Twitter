import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final user=FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(title: const Text('Home page'),
      ),
      body: Column(children: [
        Text(user.email??'-'),
        ElevatedButton(
          onPressed: () {
           FirebaseAuth.instance.signOut();
          },
          child: const Text('Submit'),
        )
      ],),
    );
  }
}
