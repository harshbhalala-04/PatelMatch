import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/controllers/report_controller.dart';
import 'package:chat/controllers/show_profile_controller.dart';
import 'package:chat/database/database.dart';

import 'package:chat/screens/feed_profile.dart';
import 'package:chat/widgets/report_option.dart';

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

  // final showProfileController = Get.put(ShowProfileController());
  final reportController = Get.put(ReportController());

  void choiceAction(String choice, String uid, String username) {
    if (choice == "Report") {
      print('Report');
      Get.dialog(
        AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Report this profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(
                  height: 20,
                ),
                Obx(() => InkWell(
                      onTap: () {
                        Get.find<ReportController>().option1.value = true;
                        Get.find<ReportController>().option2.value = false;
                        Get.find<ReportController>().option3.value = false;
                        Get.find<ReportController>().option4.value = false;
                        Get.find<ReportController>().option5.value = false;
                        Get.find<ReportController>().repoartReason.value =
                            'Fake Profile';
                      },
                      child: Container(
                          width: 230,
                          height: 50,
                          decoration: Get.find<ReportController>().option1.value
                              ? BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromRGBO(255, 85, 115, 1),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))
                              : BoxDecoration(),
                          child: ReportOption(option: 'Fake Profile')),
                    )),
                Obx(() => InkWell(
                      onTap: () {
                        Get.find<ReportController>().option1.value = false;
                        Get.find<ReportController>().option2.value = true;
                        Get.find<ReportController>().option3.value = false;
                        Get.find<ReportController>().option4.value = false;
                        Get.find<ReportController>().option5.value = false;
                        Get.find<ReportController>().repoartReason.value =
                            'Inappropriate images/content';
                      },
                      child: Container(
                          width: 230,
                          height: 50,
                          decoration: Get.find<ReportController>().option2.value
                              ? BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromRGBO(255, 85, 115, 1),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))
                              : BoxDecoration(),
                          child: ReportOption(
                              option: 'Inappropriate images/content')),
                    )),
                Obx(() => InkWell(
                      onTap: () {
                        Get.find<ReportController>().option1.value = false;
                        Get.find<ReportController>().option2.value = false;
                        Get.find<ReportController>().option3.value = true;
                        Get.find<ReportController>().option4.value = false;
                        Get.find<ReportController>().option5.value = false;
                        Get.find<ReportController>().repoartReason.value =
                            'Underage';
                      },
                      child: Container(
                          width: 230,
                          height: 50,
                          decoration: Get.find<ReportController>().option3.value
                              ? BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromRGBO(255, 85, 115, 1),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))
                              : BoxDecoration(),
                          child: ReportOption(option: 'Underage')),
                    )),
                Obx(() => InkWell(
                      onTap: () {
                        Get.find<ReportController>().option1.value = false;
                        Get.find<ReportController>().option2.value = false;
                        Get.find<ReportController>().option3.value = false;
                        Get.find<ReportController>().option4.value = true;
                        Get.find<ReportController>().option5.value = false;
                        Get.find<ReportController>().repoartReason.value =
                            'Not interested';
                      },
                      child: Container(
                          width: 230,
                          height: 50,
                          decoration: Get.find<ReportController>().option4.value
                              ? BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromRGBO(255, 85, 115, 1),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))
                              : BoxDecoration(),
                          child: ReportOption(option: 'Not interested')),
                    )),
                Obx(() => InkWell(
                      onTap: () {
                        Get.find<ReportController>().option1.value = false;
                        Get.find<ReportController>().option2.value = false;
                        Get.find<ReportController>().option3.value = false;
                        Get.find<ReportController>().option4.value = false;
                        Get.find<ReportController>().option5.value = true;
                        Get.find<ReportController>().repoartReason.value =
                            'Other';
                      },
                      child: Container(
                          width: 230,
                          height: 50,
                          decoration: Get.find<ReportController>().option5.value
                              ? BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromRGBO(255, 85, 115, 1),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))
                              : BoxDecoration(),
                          child: ReportOption(option: 'Other')),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 175,
                  child: ElevatedButton(
                    onPressed: () {
                      // Get.back();
                      Get.find<ReportController>().option1.value = false;
                      Get.find<ReportController>().option2.value = false;
                      Get.find<ReportController>().option3.value = false;
                      Get.find<ReportController>().option4.value = false;
                      Get.find<ReportController>().option5.value = false;

                      // Get.find<FeedScreenController>()
                      //     .currentIndex
                      //     .value += 1;
                      Get.find<FeedScreenController>().removeUserFromFeed(uid);
                      Get.back();
                      Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .excludedUsers!
                          .add(uid);

                      DataBaseMethods().addExcludeUser(uid, true);

                      DataBaseMethods().addReport(uid,
                          Get.find<ReportController>().repoartReason.value);
                      Get.find<ReportController>().repoartReason.value = '';
                    },
                    child: Text(
                      'Report',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(255, 85, 115, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (choice == "Block") {
      Get.dialog(
        AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Block this profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: "By blocking ",
                      style: TextStyle(
                          color: Color.fromRGBO(51, 51, 51, 1),
                          fontSize: 14,
                          fontFamily: 'Cabin'),
                    ),
                    TextSpan(
                      text: username,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 85, 115, 1),
                          fontSize: 14,
                          fontFamily: 'Cabin'),
                    ),
                    TextSpan(
                      text:
                          ", you will not be able to send or receive messages by them, view their profile on the feed or in the request's page. They won't be notified that you blocked them.",
                      style: TextStyle(
                          color: Color.fromRGBO(51, 51, 51, 1),
                          fontSize: 14,
                          fontFamily: 'Cabin'),
                    ),
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 175,
                  child: ElevatedButton(
                    onPressed: () {
                      // Get.back();

                      Get.find<FeedScreenController>().removeUserFromFeed(uid);
                      Get.back();
                      Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .excludedUsers!
                          .add(uid);

                      DataBaseMethods().addExcludeUser(uid, true);

                      DataBaseMethods().addBlock(uid);
                    },
                    child: Text(
                      'Block',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(255, 85, 115, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  List<String> choices = ['Report', 'Block'];

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
                print("Email: ${feedScreenController.usersList[index].email}");
                print(
                    "NAme: ${feedScreenController.usersList[index].username}");
                print("Image: ${feedScreenController.usersList[index].imgUrl}");
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
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
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
                                    ),
                                    PopupMenuButton<String>(
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: Colors.black,
                                      ),
                                      onSelected: (val) {
                                        choiceAction(
                                            val,
                                            feedScreenController
                                                .usersList[index].uid!,
                                            feedScreenController
                                                .usersList[index].username!);
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return choices.map((String choice) {
                                          return PopupMenuItem<String>(
                                            value: choice,
                                            child: Column(
                                              children: [
                                                Text(choice),
                                                choice == "Report"
                                                    ? SizedBox(
                                                        height: 10,
                                                      )
                                                    : Container(),
                                                choice == "Report"
                                                    ? Divider(
                                                        color: Color.fromRGBO(
                                                            51, 51, 51, 1),
                                                        thickness: 0.5,
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                            textStyle: TextStyle(
                                                color: Color.fromRGBO(
                                                    51, 51, 51, 1),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          );
                                        }).toList();
                                      },
                                    ),
                                  ],
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
