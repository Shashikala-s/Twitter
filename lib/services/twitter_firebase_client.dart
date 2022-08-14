import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/widgets/twitter_scaffold_messenger.dart';

class TwitterFirebaseClient {
  CollectionReference users = FirebaseFirestore.instance.collection('tweeters');

  Future<void> createTwitter(
      String description, String? user, String date) async {
    try {
      await users
          .add({
            'description': description, // John Doe
            'user': user, // Stokes and Sons
            'date': date // 42
          })
          .then((value) => print("Twitter added"))
          .catchError((error) => print("Failed to add user: $error"));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> editTwitter(String document, String description) async {
    await users
        .doc(document)
        .update({'description': description})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> getTwitter() async {
    final docSnap = await users.get();
    final city = docSnap.docs; // Convert to City object
    if (city.isNotEmpty) {
      print(city[0]);
    } else {
      print("No such document.");
    }
  }

  Future<dynamic> createUser(String email, String password,BuildContext context) async {
    if (email.isNotEmpty & password.isNotEmpty) {
      var dta= await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      print(dta.user);
    } else {
      TwitterScaffoldMessenger().errorMsg(context,'Username or password empty' );
    }
  }
}
