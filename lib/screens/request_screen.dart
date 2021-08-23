import 'package:chat/screens/single_user_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  bool isSent = false;
  List<dynamic> profiles = [];
  List<String> userIds = [];
  bool isLoading = false;
  List<Map<String, dynamic>> profileData = [];

  fetchUserRequest() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    setState(() {
      isLoading = true;
    });

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('friendRequest')) {
        print(val['friendRequest']);
        List<dynamic> myMap = val['friendRequest'];
        myMap.forEach((element) {
          if (element['recieved'] != '') {
            profiles.add({
              'recieve': element['recieved'],
              'image': element['image'],
              'time': element['time'],
              'email': element['email']
            });
          }
        });
      }
    });

    print('This is profiles');
    print(profiles);
    profiles.sort((a, b) => b["time"].compareTo(a["time"]));
    print("after sorting");
    print(profiles);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchUserRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleUserRequest(profiles: profiles));
  }
}
