import 'package:flutter/material.dart';

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
          IconButton(icon:  Icon(Icons.home,color: Theme.of(context).primaryColor,size: 30,), onPressed: () {},),
          IconButton(icon:  Icon(Icons.mic,color: Theme.of(context).disabledColor,size: 20,), onPressed: () {}),
          IconButton(icon:  Icon(Icons.notifications_active,color: Theme.of(context).disabledColor,size: 20,), onPressed: () {}),
          IconButton(icon:  Icon(Icons.mail,color: Theme.of(context).disabledColor,size: 20,), onPressed: () {}),
        ],
      ),
    );
  }
}