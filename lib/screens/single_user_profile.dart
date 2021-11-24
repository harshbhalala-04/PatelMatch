import 'package:chat/controllers/global_controller.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:chat/screens/auth_screen.dart';
import 'package:chat/screens/single_user_feed.dart';
import 'package:chat/widgets/feed_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  fetchUser(String uid) async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((value) {
      user = UserModel.fromJson(value.data()!);
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchUser(widget.uid);
    super.initState();
  }

  bool buttonVisible = true;

  @override
  Widget build(BuildContext context) {
    if (globalController.currentAppuser.value.uid == widget.uid) {
      buttonVisible = false;
    }
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
              body: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Stack(
                      children: [
                        SingleUserFeed(
                            currentUser: user,
                            userImagesLength: user.imgCount!,
                            index: 0),
                        buttonVisible
                            ? Positioned(
                                top: MediaQuery.of(context).size.height - 250,
                                left: 0,
                                right: MediaQuery.of(context).size.width - 350,
                                child: FeedButton(
                                  fromDynamicLink: true,
                                  index: 0,
                                  otherImageUrl: user.imgUrl!,
                                  otherUserId: user.uid!,
                                  otherUsername: user.username!,
                                ),
                              )
                            : Container(),
                      ],
                    ));
        } else {
          return AuthScreen();
        }
      },
    );
  }
}
