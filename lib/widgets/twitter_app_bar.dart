import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
AppBar TwitterAppBar(BuildContext context, String user,bool status) {
  return AppBar(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.grey[700]),
    backgroundColor: Colors.white,
    leading: Visibility(visible: status,
      child: Padding(
        padding:  EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
        child: CircleAvatar(
          foregroundColor: Theme.of(context).backgroundColor,
          backgroundColor: Colors.amber,
          radius: MediaQuery.of(context).size.height * 0.00,
          child: Text(
            user.isNotEmpty ? user[0] : 'A',
            style: TextStyle(
              color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.025),
          ),
        ),
      ),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          fit: BoxFit.contain,
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.3,
          image: const AssetImage('assets/images/twitter_icon.png'),
        )
      ],
    ),
    actions:  <Widget>[Padding(
      padding:  EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
      child: Visibility(
        visible: status,
          child: GestureDetector(
            onTap: (){
              FirebaseAuth.instance.signOut();
            },

              child: Icon(Icons.logout))),
    )],
  );
}
