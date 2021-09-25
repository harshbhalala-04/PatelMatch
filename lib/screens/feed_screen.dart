import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';

import 'package:chat/helper/user_modal.dart';
import 'package:chat/screens/single_user_feed.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final feedScreenController = Get.put(FeedScreenController());
  final globalController = Get.put(GlobalController());
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() => globalController.isLoading.value
        ? Center(child: CircularProgressIndicator())
        : StreamBuilder(
            stream: firestore
                .collection("users")
                .orderBy("createdAt", descending: true)
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
                        Get.back();
                      },
                    ),
                  ],
                );
              }
              snapshot.data!.docs.forEach((element) {
                feedScreenController.potentialUsersList
                    .add(UserModel.fromJson(element.data()));
              });

              feedScreenController.userListLength.value =
                  feedScreenController.potentialUsersList.length;

              return globalController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Obx(() => SingleUserFeed(
                      currentUser: feedScreenController.potentialUsersList[
                          feedScreenController.currentIndex.value],
                      userImagesLength: feedScreenController
                          .potentialUsersList[
                              feedScreenController.currentIndex.value]
                          .imgCount!));
            }));
  }
}
