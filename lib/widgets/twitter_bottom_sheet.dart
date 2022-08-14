import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter/services/twitter_firebase_client.dart';

class TwitterBottomSheet extends StatefulWidget {
  final String? user;
  final String? userid;
  final Map<String, dynamic>? data;
  final DocumentSnapshot? document;

  const TwitterBottomSheet(
      {Key? key,
      required this.context,
      required this.user,
      this.data,
      this.userid,
      this.document})
      : super(key: key);

  final BuildContext context;

  @override
  State<TwitterBottomSheet> createState() => _TwitterBottomSheetState();
}

class _TwitterBottomSheetState extends State<TwitterBottomSheet> {
  final newTwitterDescription = TextEditingController();
  String text = ""; // empty string to carry what was there before it

  int maxLength = 280;

  @override
  void initState() {
    if (widget.data != null) {
      newTwitterDescription.text = widget.data?['description'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        color: Colors.transparent, //could change this to Color(0xFF737373),
        child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0))),
            child: Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).disabledColor,
                        ),
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0))),
                    alignment: Alignment.topRight,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01),
                      child: TextField(
                          maxLines: 10,

                          inputFormatters: [
                            LengthLimitingTextInputFormatter(280),
                          ],
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "What's happening ?",
                              hintStyle: Theme.of(context).textTheme.overline!),
                          controller: newTwitterDescription,
                          onChanged: (String newVal) {
                            setState(() {
                              if (newVal.length <=280) {
                                maxLength=0;
                                maxLength =   newVal.length;
                              }
                            });
                          }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                      maxLength.toString()+"/280",style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton.extended(
                        elevation: 0,
                        onPressed: () {
                          if (widget.document?.id!=null) {
                            //update
                            TwitterFirebaseClient().editTwitter(
                              widget.document?.id??'',
                              newTwitterDescription.text,
                              context,

                            );
                          } else {
                            TwitterFirebaseClient().createTwitter(
                              newTwitterDescription.text,
                              widget.user ?? '',
                              DateTime.now().toString(),
                              context,
                              widget.userid ?? '',
                            );
                          }
                        },
                        icon: Icon(
                          Icons.post_add,
                          color: Theme.of(context).backgroundColor,
                        ),
                        label: Text(
                          'Tweet'.toUpperCase(),
                          style: Theme.of(context).textTheme.caption?.apply(
                              color: Theme.of(context).backgroundColor,
                              fontWeightDelta: 3),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
