import 'package:flutter/material.dart';

AppBar TwitterAppBar(BuildContext context, String user) {
  return AppBar(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.grey[700]),
    backgroundColor: Colors.white,
    leading: Padding(
      padding:  EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      child: CircleAvatar(
        foregroundColor: Theme.of(context).backgroundColor,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        radius: MediaQuery.of(context).size.height * 0.00,
        child: Text(
          user.isNotEmpty ? user[0] : 'A',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height * 0.025),
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
    actions: const <Widget>[Icon(Icons.star_border)],
  );
}
