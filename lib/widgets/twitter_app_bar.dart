import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/view/profile_page.dart';

// ignore: non_constant_identifier_names
AppBar TwitterAppBar(BuildContext context, String user,bool status) {
  return AppBar(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.grey[700]),
    backgroundColor: Colors.white,
    leading: Visibility(visible: status,

      child: GestureDetector(
        onTap: (){
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) =>  ProfilePage()));

        },
        child: Container(
          margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
          child: Center(
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.height *
                  0.04, // Image radius
              backgroundImage: const AssetImage(
                'assets/images/person.jpeg',
              ),
            ),
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
