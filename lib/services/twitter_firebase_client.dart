import 'package:cloud_firestore/cloud_firestore.dart';

class TwitterFirebaseClient{
  CollectionReference users = FirebaseFirestore.instance.collection('tweeters');

  Future<void> createTwitter( String description, String company, String date) async {
    try {
     await  users
          .add({
        'description': description, // John Doe
        'user': company, // Stokes and Sons
        'date': date // 42
      })
          .then((value) => print("Twitter added"))
          .catchError((error) => print("Failed to add user: $error"));
    }catch(e){
      print(e.toString());
    }
  }


  Future<void> editTwitter(String document , String description) async {
    await users
        .doc(document)
        .update({'description': description})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> getTwitter() async{

    final docSnap = await users.get();
    final city = docSnap.docs; // Convert to City object
    if (city.isNotEmpty) {
      print(city[0]);
    } else {
      print("No such document.");
    }
  }
}