import 'package:chat/screens/single_user_sent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

class SentScreen extends StatefulWidget {
  // late final isRequest;
  // late final isSent;

  // SentScreen({required this.isRequest, required this.isSent});

  @override
  _SentScreenState createState() => _SentScreenState();
}

class _SentScreenState extends State<SentScreen> {
  bool isLoading = false;
  List<dynamic> sentProfiles = [];

  fetchUserSent() async {
    setState(() {
      isLoading = true;
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
            sentProfiles.add({
              'sent': element['sent'],
              'image': element['image'],
              'time': element['time'],
              'email': element['email']
            });
          }
        });
      }
    });

    print('This is sent profiles');
    print(sentProfiles);
    sentProfiles.sort((a, b) => b["time"].compareTo(a["time"]));
    print("after sorting of sent profiles");
    print(sentProfiles);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchUserSent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleUserSent(
              sentProfiles: sentProfiles,
            ),
    );
  }
}
