import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/helper/services.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:chat/screens/feed_profile.dart';
import 'package:chat/screens/single_user_feed.dart';
import 'package:chat/screens/single_user_profile.dart';
import 'package:chat/widgets/feed_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
        feedScreenController.getUsers();
      },
      builder: (controller) {
        return Obx(() => ListView.builder(
              controller: feedScreenController.scrollController,
              itemCount: feedScreenController.hasMoreData
                  ? feedScreenController.usersList.length + 1
                  : feedScreenController.usersList.length,
              itemBuilder: (ctx, index) {
                print(
                    "Here userslist length: ${feedScreenController.usersList.length}");
                if (index == feedScreenController.usersList.length) {
                  return Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(FeedProfile(
                              user: feedScreenController.usersList[index],
                              index: index,
                            ));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  Ink.image(
                                    image: CachedNetworkImageProvider(
                                      feedScreenController
                                          .usersList[index].imgUrl!,
                                    ),
                                    height: 300,
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  "${feedScreenController.usersList[index].username}, ${feedScreenController.usersList[index].age}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    fontFamily: 'Cabin',
                                    letterSpacing: 1,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ));
      },
    );
  }
}
