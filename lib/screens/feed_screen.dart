import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:chat/screens/single_user_feed.dart';
import 'package:chat/widgets/feed_button.dart';
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
    return GetBuilder<FeedScreenController>(
        initState: (state) {
          feedScreenController.currentItemLength = 0;
          feedScreenController.previousItemLength = 0;
          feedScreenController.getUsers();
        },
        builder: (controller) =>Obx(() => feedScreenController.endUser.value ?  ListView.builder(
            controller: feedScreenController.scrollController,
            itemCount: feedScreenController.usersList.length,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Positioned(
                    child: SingleUserFeed(
                      currentUser: feedScreenController.usersList[index],
                      userImagesLength:
                          feedScreenController.usersList[index].imgUrls!.length,
                      index: index,
                    ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height - 250,
                      left: 0,
                      right: 0,
                      child: FeedButton(
                        index: index,
                        otherImageUrl:
                            feedScreenController.usersList[index].imgUrl!,
                        otherUserId: feedScreenController.usersList[index].uid!,
                        otherUsername:
                            feedScreenController.usersList[index].username!,
                      ))
                ],
              );
            }) 
            : Center(child: Text('No users Found'),)
            ));
  }
}
