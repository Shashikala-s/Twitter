import 'package:flutter/material.dart';
import 'package:twitter/view/home_page.dart';

import '../view/profile_page.dart';

class TwitterBottomNavigation extends StatelessWidget {
  const TwitterBottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          IconButton(icon:  Icon(Icons.home,color: Theme.of(context).primaryColor,size: 30,), onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) =>  HomePage()));

          },),
          IconButton(icon:  Icon(Icons.account_circle_rounded,color: Theme.of(context).disabledColor,size: 30,), onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) =>  ProfilePage()));

          },),
          ],
      ),
    );
  }
}