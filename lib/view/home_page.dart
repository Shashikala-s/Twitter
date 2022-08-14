import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/twitter_app_bar.dart';
import '../widgets/twitter_bottom_navigation.dart';
import '../widgets/twitter_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('tweeters').orderBy('date',descending: true).snapshots();
  var user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: const TwitterBottomNavigation(),
      appBar: TwitterAppBar(context, user?.email ?? 'A', true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (builder) {
                return TwitterBottomSheet(
                  context: context,
                  user: user?.email?.split('@')[0],
                  userid: user?.uid,

                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,

          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return (snapshot.data!.docs.isNotEmpty)?ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.001),
                      child: Stack(
                        children: [
                          Card(
                            color: Colors.white,
                            elevation: 0,
                            child: Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.01),
                              child: Column(
                             crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Center(
                                        child: CircleAvatar(
                                          radius: MediaQuery.of(context).size.height *
                                              0.02, // Image radius
                                          backgroundImage: const AssetImage(
                                            'assets/images/person.jpeg',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width * 0.02,
                                      ),
                                      Column(

                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data['user'].toString()=='null'?'':data['user'].toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    ?.apply(fontWeightDelta: 3),
                                              ),
                                              SizedBox(
                                                width:
                                                MediaQuery.of(context).size.width * 0.02,
                                              ),
                                              Text(
                                                data['date'].toString().split('.')[0],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .overline
                                                    ?.apply(fontWeightDelta: 0),
                                              ),

                                            ],
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width *
                                                0.8,
                                            child: Text(data['description'],textAlign: TextAlign.start),

                                          ),

                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.width * 0.02,
                                      ),


                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                    MediaQuery.of(context).size.width * 0.04,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: const [
                                      Icon(Icons.chat_bubble_outline),
                                      Icon(Icons.repeat_rounded),
                                      Icon(Icons.favorite),
                                      Icon(Icons.share),

                                    ],)
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    );
                  })
                  .toList()
                  .cast(),
            ):const Center(child: Text("Let's start journey.."),);
          },
        ),
      ),
    );
  }
}
