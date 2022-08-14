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
          IconButton(icon: const Icon(Icons.home), onPressed: () {}),
          IconButton(icon: const Icon(Icons.mic), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications_active), onPressed: () {}),
          IconButton(icon: const Icon(Icons.mail), onPressed: () {}),
        ],
      ),
    );
  }
}