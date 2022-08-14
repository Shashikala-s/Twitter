import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/services/twitter_firebase_client.dart';

import '../widgets/twitter_app_bar.dart';
import '../widgets/twitter_bottom_navigation.dart';
import '../widgets/twitter_bottom_sheet.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.height *
                    0.1, // Image radius
                backgroundImage: const AssetImage(
                  'assets/images/person.jpeg',
                ),
              ),
            ),
            Expanded(
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

                                Visibility(
                                  visible :user?.uid==data['userid'],
                                  child: Card(
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
                                            MediaQuery.of(context).size.width * 0.02,
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children:  [
                                              GestureDetector(

                                                  child: Icon(Icons.edit_note),
                                              onTap: (){
                                                showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    context: context,
                                                    builder: (builder) {
                                                      return TwitterBottomSheet(
                                                          context: context,
                                                          user: user?.email?.split('@')[0],
                                                          userid: user?.uid,
                                                          data:data,
                                                          document:document
                                                      );
                                                    });
                                              },),
                                              GestureDetector(
                                                child: Icon(Icons.delete),
                                              onTap: (){
TwitterFirebaseClient().deleteTwitter(document.id, context);
                                              },),

                                            ],)
                                        ],
                                      ),
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
          ],
        ),
      ),
    );
  }
}
