import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter/services/twitter_firebase_client.dart';

class TwitterBottomSheet extends StatefulWidget {
  final String?  user;
  final Map<String,dynamic>? data;

  const TwitterBottomSheet({
    Key? key,
    required this.context,
    required this.user,  this.data,

  }) : super(key: key);

  final BuildContext context;

  @override
  State<TwitterBottomSheet> createState() => _TwitterBottomSheetState();
}

class _TwitterBottomSheetState extends State<TwitterBottomSheet> {
  final newTwitterDescription=TextEditingController();
  @override
  void initState() {
    if(widget.data!=null){
     newTwitterDescription.text=widget.data?['description'];
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
              padding:  EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),

              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Icon(Icons.arrow_back)],
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    height:MediaQuery.of(context).size.height * 0.2 ,
                    child: Center(
                      child: TextFormField(
                        controller: newTwitterDescription,
                        inputFormatters: [
                           LengthLimitingTextInputFormatter(280),
                        ],
                        autofocus: true,
                        maxLines: 10,
                        textInputAction: TextInputAction.go,
                        keyboardType: TextInputType.multiline,
                        enabled: true,
                        textAlign: TextAlign.start,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "what's hapenning?",
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Max 280'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {

                          TwitterFirebaseClient().createTwitter(newTwitterDescription.text, widget.user, DateTime.now().toString());
                        },
                        child: const Text('Tweet'),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
