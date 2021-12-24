import 'package:chat/controllers/global_controller.dart';
import 'package:chat/controllers/single_user_profile_controller.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:chat/screens/auth_screen.dart';
import 'package:chat/screens/single_user_feed.dart';
import 'package:chat/widgets/feed_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleUserProfile extends StatefulWidget {
  final String uid;
  final bool fromDynamic;
  SingleUserProfile({required this.uid, required this.fromDynamic});

  @override
  _SingleUserProfileState createState() => _SingleUserProfileState();
}

class _SingleUserProfileState extends State<SingleUserProfile> {
  bool isLoading = false;
  UserModel user = new UserModel();
  final GlobalController globalController = Get.put(GlobalController());
  final SingleUserProfileController singleUserProfileController =
      Get.put(SingleUserProfileController());
  int first = 0;

  buttonVisibility() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(globalController.currentAppuser.value.uid)
        .get()
        .then((val) {
      print(val.data());
      print(val.data()!['gender']);
      print(val.data()!['friendRequest']);
      print(val.data()!['matchUsers']);
    });
  }

  fetchUser(String uid) async {
    setState(() {
      isLoading = true;
      first = 1;
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((value) {
      user = UserModel.fromJson(value.data()!);
      print("Here fetch user happen");
    });
    setState(() {
      isLoading = false;
      first = 1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // buttonVisibility();
    singleUserProfileController.buttonVisibility(widget.uid);
    // singleUserProfileController.fetchUser(widget.uid);

    super.initState();
  }

  bool buttonVisible = true;

  @override
  Widget build(BuildContext context) {
    // if (globalController.currentAppuser.value.uid == widget.uid) {
    //   buttonVisible = false;
    // }
    print(singleUserProfileController.user.value);
    print(singleUserProfileController.user.value.username);
    print(singleUserProfileController.isLoading.value);
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  'User Profile',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                actions: [
                  DropdownButton(
                      icon: Icon(Icons.more_vert),
                      underline: Container(),
                      items: [
                        DropdownMenuItem(
                          child: Container(
                            child: Text('Report'),
                          ),
                          value: 'Report',
                        ),
                        DropdownMenuItem(
                          child: Container(
                            child: Text('Block'),
                          ),
                          value: 'Block',
                        ),
                      ],
                      onChanged: (itemIndentifier) {
                        if (itemIndentifier == 'Report') {
                          print('Report');
                        } else if (itemIndentifier == 'Block') {
                          print('Block');
                        }
                      })
                ],
                centerTitle: true,
                backgroundColor: Colors.white,
                leading: widget.fromDynamic
                    ? Container()
                    : IconButton(
                        icon:
                            Icon(Icons.arrow_back_ios_new, color: Colors.black),
                        onPressed: () => Get.back(),
                      ),
              ),
              body: Obx(() => singleUserProfileController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Stack(
                      children: [
                        SingleUserFeed(
                            currentUser: singleUserProfileController.user.value,
                            userImagesLength: singleUserProfileController
                                .user.value.imgCount!,
                            index: 0),
                        singleUserProfileController.buttonVisible.value
                            ? Positioned(
                                top: MediaQuery.of(context).size.height - 250,
                                left: 0,
                                right: MediaQuery.of(context).size.width - 350,
                                child: FeedButton(
                                  fromDynamicLink: true,
                                  index: 0,
                                  otherImageUrl: singleUserProfileController
                                      .user.value.imgUrl!,
                                  otherUserId: singleUserProfileController
                                      .user.value.uid!,
                                  otherUsername: singleUserProfileController
                                      .user.value.username!,
                                ),
                              )
                            : Container(),
                      ],
                    )));
        } else {
          return AuthScreen();
        }
      },
    );
  }
}
