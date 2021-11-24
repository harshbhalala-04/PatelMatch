import 'package:chat/controllers/feedProfileController.dart';
import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:chat/screens/custom_tab_bar.dart';
import 'package:chat/screens/feed_screen.dart';
import 'package:chat/screens/single_user_feed.dart';
import 'package:chat/widgets/feed_button.dart';
import 'package:chat/widgets/profile_feed_button.dart';
import 'package:chat/widgets/req_receive_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedProfile extends StatefulWidget {
  final UserModel user;
  final int index;

  FeedProfile({
    required this.user,
    required this.index,
  });

  @override
  _FeedProfileState createState() => _FeedProfileState();
}

class _FeedProfileState extends State<FeedProfile> {
  bool isLoading = false;
  bool reqRecieve = false;
  int profileType = 0;

  final GlobalController globalController = Get.put(GlobalController());
  final feedProfileController = Get.put(FeedProfileController());

  checkUserExistInRequest(String userid) async {
    print("Here in check user");
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(Get.find<GlobalController>().currentAppuser.value.uid)
        .get()
        .then((val) {
      Map<String, dynamic> tmpMap = val.data()!;
      List<dynamic> friendRequest = tmpMap['friendRequest'];
      for (int i = 0; i < friendRequest.length; i++) {
        print("here value: ${friendRequest[i]['id']}");
        if (friendRequest[i]['id'] == userid) {
          reqRecieve = true;
          if (friendRequest[i]["bookay"] > 0) {
            profileType = 1;
          }

          print("Here req is true");
        }
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    checkUserExistInRequest(widget.user.uid!);
    print("Here init of feed profile");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.user.imgUrls!.length);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Positioned(
                  child: SingleUserFeed(
                    reqRecieve: feedProfileController.reqRecieve.value,
                    currentUser: widget.user,
                    index: 0,
                    userImagesLength: widget.user.imgUrls!.length,
                  ),
                ),
                reqRecieve
                    ? Positioned(
                        top: MediaQuery.of(context).size.height - 250,
                        left: 0,
                        right: 0,
                        child: ReqRecieveButton(
                          uid: widget.user.uid!,
                          userProfileUrl: widget.user.imgUrl!,
                          profileType: profileType,
                          user: widget.user,
                        ))
                    : Positioned(
                        top: MediaQuery.of(context).size.height - 250,
                        left: 0,
                        right: MediaQuery.of(context).size.width - 350,
                        child: FeedButton(
                          fromDynamicLink: false,
                          index: 0,
                          otherImageUrl: widget.user.imgUrl!,
                          otherUserId: widget.user.uid!,
                          otherUsername: widget.user.username!,
                        ))
              ],
            ),
    );
  }
}
