import 'package:chat/controllers/show_profile_controller.dart';
import 'package:chat/screens/single_user_feed.dart';
import 'package:chat/widgets/feed_button.dart';
import 'package:chat/widgets/profile_feed_button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowProfileScreen extends StatefulWidget {
  final String uid;
  final int profileType;
  ShowProfileScreen({required this.profileType,required this.uid});

  @override
  _ShowProfileScreenState createState() => _ShowProfileScreenState();
}

class _ShowProfileScreenState extends State<ShowProfileScreen> {
  final showProfileController = Get.put(ShowProfileController());

  @override
  void initState() {
    // TODO: implement initState
    showProfileController.fetchCurrentUser(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() => showProfileController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Obx(() => SingleUserFeed(
                    currentUser: showProfileController.currentUser.value,
                    userImagesLength:
                        showProfileController.currentUser.value.imgCount!,
                    index: 0)),
                Positioned(
                    top: MediaQuery.of(context).size.height - 250,
                    left: 0,
                    right: 0,
                    child: ProfileFeedButton(uid: widget.uid, profileType: widget.profileType))
              ],
            )),
    );
  }
}
