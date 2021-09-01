import 'package:chat/helper/constants.dart';
import 'package:chat/screens/single_user_feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  //bool isRequest = false;
  String? currentUserGender;
  bool fromFeed = false;
  List<Map<String, dynamic>> userData = [];
  List<dynamic> sentProfilesFeed = [];
  int temp = 0;

  fetchUserGender() async {
    
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((val) {
      Constants.gender = val['gender'];
      
    });

    

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('friendRequest')) {
        List<dynamic> myMap = val['friendRequest'];
        myMap.forEach((element) {
          if (element['sent'] != '') {
            if (!Constants.userProfileUrls.contains(element['image'])) {
              Constants.userProfileUrls.add(element['image']);
              Constants.userProfileIds.add(element['id']);
            }

           
          }
        });
      }
    });

    setState(() {
      temp = 1;
    });

   
  }

  @override
  void initState() {
    
    fetchUserGender();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return temp == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                    .collection("users")
                    .orderBy("createdAt", descending: true)
                    .where("gender", isNotEqualTo: Constants.gender)
                    .where("friendRequest", whereNotIn: [])
                    .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return AlertDialog(
                  content: Text('Network Not available'),
                  actions: [
                    TextButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
              final userDocs =
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                int flag = 0;
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                if (!Constants.userProfileIds.contains(data['uid'])) {
                  if (Constants.dataAdd == 0) {
                    userData.add(data);
                  } else {
                    for (int i = 0; i < userData.length; i++) {
                      if (userData[i]['uid'] == data['uid']) {
                        flag = 1;
                      }
                    }
                    if (flag == 0) {
                      userData.add(data);
                    } else {
                      
                    }
                  }
                  // } else {
                  //   print('This is else part of removing element');
                  //   int len = Constants.userProfileUrls.length;
                  //   String removeImg = Constants.userProfileUrls[len - 1];
                  //   for (int i = 0; i < userData.length; i++) {
                  //     if (userData[i]['imgUrl'] == removeImg) {
                  //       Map<String, dynamic> removeVal = userData.removeAt(i);
                  //       print('THis is removed val: $removeVal');
                  //       break;
                  //     }
                  //   }
                  // }
                }
              }).toList();

              Constants.dataAdd = 1;

              

              return SingleUserFeed(
                userData: userData,
              );
            });
  }
}
