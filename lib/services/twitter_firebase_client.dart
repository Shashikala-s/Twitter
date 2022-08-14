import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/widgets/twitter_scaffold_messenger.dart';

class TwitterFirebaseClient {
  CollectionReference twitter = FirebaseFirestore.instance.collection('tweeters');

  Future<void> createTwitter(
      String description, String user, String date,BuildContext context,String userid) async {
    try {
      if(description.isNotEmpty && user.isNotEmpty && date.isNotEmpty){
        await twitter
            .add({
          'description': description, // John Doe
          'user': user, // Stokes and Sons
          'userid': userid, // Stokes and Sons
          'date': date // 42
        })
            .then((value)  {
              Navigator.pop(context);
          TwitterScaffoldMessenger().successMsg(context, 'Posted');
        })
            .catchError((error) => print("Failed to add user: $error"));
      }else{
        TwitterScaffoldMessenger().errorMsg(context, 'Required values empty');
      }

    } catch (e) {
      TwitterScaffoldMessenger().errorMsg(context, e.toString());
    }
  }

  Future<void> editTwitter(String document, String description,BuildContext context) async {
    if(description.isNotEmpty && document.isNotEmpty) {
      try {
        await twitter
            .doc(document)
            .update({'description': description})
            .then((value) {
          Navigator.pop(context);
          TwitterScaffoldMessenger().successMsg(context, 'Updated');
        })
            .catchError((error) {
          TwitterScaffoldMessenger().errorMsg(context, error.toString());
        });
      }catch(e){
        TwitterScaffoldMessenger().errorMsg(context, e.toString());
      }
    }
  }

  Future<void> deleteTwitter(String document,BuildContext context) async {
    if( document.isNotEmpty) {
      try {
        await twitter
            .doc(document)
            .delete()
            .then((value) {
          Navigator.pop(context);
          TwitterScaffoldMessenger().successMsg(context, 'Deleted');
        })
            .catchError((error) {
          TwitterScaffoldMessenger().errorMsg(context, error.toString());
        });
      }catch(e){
        TwitterScaffoldMessenger().errorMsg(context, e.toString());
      }
    }
  }



  Future<dynamic> createUser(String email, String password,BuildContext context) async {
    try {
      if (email.isNotEmpty & password.isNotEmpty) {
        var dta = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim());
        print(dta.user);
      } else {
        TwitterScaffoldMessenger().errorMsg(
            context, 'Username or password empty');
      }
    }catch(e){
      TwitterScaffoldMessenger().errorMsg(context, e.toString());
    }
  }


}
