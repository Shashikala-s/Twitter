import 'package:flutter/material.dart';

class TwitterScaffoldMessenger {
  void errorMsg(BuildContext context, String e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red[400],
      content: Container(
          child: Text(
        e,
        style:
            Theme.of(context).textTheme.subtitle2!.apply(color: Colors.white),
      )),
    ));
  }
  void errorMsgCart(BuildContext context, String e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.red[400],
      content: Container(
          child: Text(
            e,
            style:
            Theme.of(context).textTheme.subtitle2!.apply(color: Colors.white),
          )),
    ));
  }

  void warningMsg(BuildContext context, String e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.blue[400],
      content: Text(
        e,
        style:
        Theme.of(context).textTheme.subtitle2!.apply(color: Colors.white),
      ),
    ));
  }
  void warningMsgAppBarInfo(BuildContext context, String e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 10),
      backgroundColor: Colors.blue[400],
      content: Text(
        e,
        style:
        Theme.of(context).textTheme.subtitle2!.apply(color: Colors.white),
      ),
    ));
  }

  void successMsg(BuildContext context, String e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green[400],
      content: Text(
        e,
        style:
        Theme.of(context).textTheme.subtitle2!.apply(color: Colors.white),
      ),
    ));
  }
  void successMsgCart(BuildContext context, String e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.green[400],
      content: Text(
        e,
        style:
        Theme.of(context).textTheme.subtitle2!.apply(color: Colors.white),
      ),
    ));
  }

  void loadingMsg(BuildContext context, String e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.white,
      content: Text(
        e,
        style:
        Theme.of(context).textTheme.subtitle2!.apply(color: Colors.deepPurple),
      ),
    ));
  }
}
