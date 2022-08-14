import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../widgets/twitter_app_bar.dart';
import '../widgets/twitter_bottom_navigation.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('tweeters').snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TwitterBottomNavigation(),
      appBar: TwitterAppBar(context,'hee'),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _modalBottomSheetMenu();

      }, child: const Icon(Icons.add)),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
                return Padding(
                  padding:  EdgeInsets.all(MediaQuery.of(context).size.height * 0.001),
                  child: Card(
                    elevation: 0,
                    child: ListTile(
                      title: Text(data['user']),
                      subtitle: Text(data['description']),
                    ),
                  ),
                );
              })
                  .toList()
                  .cast(),
            );
          },
        ),
      ),
    );
  }
  void _modalBottomSheetMenu(){
    showModalBottomSheet(
        isScrollControlled:true,
        context: context,
        builder: (builder){
          return  Container(
            height: MediaQuery.of(context).size.height*1,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            child:  Container(
                decoration:  const BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.only(
                        topLeft:  Radius.circular(10.0),
                        topRight:  Radius.circular(10.0))),
                child: const Center(
                  child:  Text("This is a modal sheet"),
                )),
          );
        }
    );
  }
}


