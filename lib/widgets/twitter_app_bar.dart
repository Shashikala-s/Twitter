import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
AppBar TwitterAppBar(BuildContext context, String user,bool status) {
  return AppBar(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.grey[700]),
    backgroundColor: Colors.white,
    leading: Visibility(visible: status,
      child: Padding(
        padding:  EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
        child: CircleAvatar(
          foregroundColor: Theme.of(context).backgroundColor,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          radius: MediaQuery.of(context).size.height * 0.00,
          child: Text(
            user.isNotEmpty ? user[0] : 'A',
            style: TextStyle(
              color: Colors.grey[100],
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
    actions:  <Widget>[Visibility(
      visible: status,
        child: Icon(Icons.star_border))],
  );
}
