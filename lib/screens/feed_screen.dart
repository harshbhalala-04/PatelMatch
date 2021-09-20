import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/constants.dart';
import 'package:chat/helper/services.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:chat/screens/single_user_feed.dart';
import 'package:chat/widgets/feed_button.dart';
import 'package:chat/widgets/info_title.dart';
import 'package:chat/widgets/user_image_card.dart';
import 'package:chat/widgets/user_info_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  //bool isRequest = false;
  bool fromFeed = false;
  List<Map<String, dynamic>> userData = [];
  List<dynamic> sentProfilesFeed = [];
  int temp = 0;
  bool isLoading = false;
  final scrollController = ScrollController();
  int itemLimit = 3;
  int currentItemLength = 0;
  int previousItemLength = 0;
  int index = 0;
  int currentIndex = 0;
  List<dynamic> friendRequest = [];
  bool? declineListExist;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  fetchUserGender() async {
    setState(() {
      isLoading = true;
    });

    await firestore.collection("users").doc(user!.uid).get().then((val) {
      Constants.gender = val['gender'];

      //declineListExist = val['decline'];
      // if (val.data()!.containsKey('declineUsers')) {
      //   declineFriends = val['declineUsers'];
      // }
    });

    // await firestore
    //     .collection("users")
    //     .doc(user!.uid)
    //     .get()
    //     .then((val) {
    //   if (val.data()!.containsKey('friendRequest')) {
    //     List<dynamic> myMap = val['friendRequest'];
    //     myMap.forEach((element) {
    //       if (element['sent'] != '') {
    //         if (!Constants.userProfileUrls.contains(element['image'])) {
    //           Constants.userProfileUrls.add(element['image']);
    //           Constants.userProfileIds.add(element['id']);
    //         }
    //       }
    //     });
    //   }
    // });

    //Services().getUserModel();

    setState(() {
      temp = 1;
      isLoading = false;
    });
  }

  void scrollListner() {
    print('This is scroll listner function');
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent - 100 &&
        !scrollController.position.outOfRange) {
      if (previousItemLength != currentItemLength) {
        setState(() {
          print('Here scroll controller active');
          previousItemLength = currentItemLength;
          itemLimit += 3;
          // userData = [];
          // index = 0;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListner);
    fetchUserGender();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    print('This is value of item limit');
    print(itemLimit);

    return temp == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : StreamBuilder(
            stream: firestore
                .collection("users")
                .orderBy("uid")
                .where("gender",
                    isEqualTo: Constants.gender == "Female" ? "Male" : "Female")
                .orderBy("createdAt", descending: true)
                /*.where("uid", whereNotIn: friendRequest)*/
                .limit(itemLimit)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
              currentItemLength = snapshot.data!.docs.length;
              print('This is current Item length : $currentItemLength');
              return ListView(
                  controller: scrollController,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot<Map<String, dynamic>> document) {
                    //Constants().getUserDetails(document.data());
                    setUserModelValue(document.data());
                    final currentUserData = Constants.userDataValue[0];
                    final userImagesLength = currentUserData.imageUrls.length;
                    return isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleUserFeed(
                            currentUserData: currentUserData,
                            userImagesLength: userImagesLength);
                  }).toList());
            });
  }
}
