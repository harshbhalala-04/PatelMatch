import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/single_item_people.dart';

class PeopleScreen extends StatefulWidget {
  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  //final User user = auth.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .orderBy(
              'createdAt',
              descending: true,
            )
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final userDocs = snapshot.data!.docs;
          
          return ListView.builder(
              itemCount: userDocs.length,
              itemBuilder: (_, index) {
                if (auth.currentUser!.uid == userDocs[index]['uid']) {
                  return Container(height: 0.0,);
                }
                return SingleItemPeople(
                    username: userDocs[index]['username'],
                    imageUrl: userDocs[index]['imgUrl'] );
              });
        });
  }
}
