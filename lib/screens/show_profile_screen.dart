import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/controllers/report_controller.dart';
import 'package:chat/controllers/show_profile_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/single_user_feed.dart';
import 'package:chat/widgets/feed_button.dart';
import 'package:chat/widgets/profile_feed_button.dart';
import 'package:chat/widgets/report_option.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowProfileScreen extends StatefulWidget {
  final String uid;
  final int profileType;
  ShowProfileScreen({required this.profileType, required this.uid});

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

  void choiceAction(String choice) {
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
                      Get.back();
                      Get.find<ReportController>().option1.value = false;
                      Get.find<ReportController>().option2.value = false;
                      Get.find<ReportController>().option3.value = false;
                      Get.find<ReportController>().option4.value = false;
                      Get.find<ReportController>().option5.value = false;

                      // Get.find<FeedScreenController>()
                      //     .currentIndex
                      //     .value += 1;
                      Get.find<FeedScreenController>()
                          .removeUserFromFeed(widget.uid);
                      Get.back();
                      Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .excludedUsers!
                          .add(widget.uid);

                      DataBaseMethods().addExcludeUser(widget.uid, true);

                      DataBaseMethods().addReport(widget.uid,
                          Get.find<ReportController>().repoartReason.value);
                      Get.find<ReportController>().repoartReason.value = '';
                    },
                    child: Text(
                      'Report',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 85, 115, 1),
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
                      text: showProfileController.currentUser.value.username,
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
                      Get.back();

                      Get.find<FeedScreenController>()
                          .removeUserFromFeed(widget.uid);
                      Get.back();
                      Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .excludedUsers!
                          .add(widget.uid);

                      DataBaseMethods().addExcludeUser(widget.uid, true);

                      DataBaseMethods().addBlock(widget.uid);
                    },
                    child: Text(
                      'Block',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 85, 115, 1),
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
    print("Heree is show profile screen");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                onSelected: choiceAction,
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
                                  color: Color.fromRGBO(51, 51, 51, 1),
                                  thickness: 0.5,
                                )
                              : Container(),
                        ],
                      ),
                      textStyle: TextStyle(
                          color: Color.fromRGBO(51, 51, 51, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    );
                  }).toList();
                },
              ))
        ],
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
                    child: ProfileFeedButton(
                        uid: widget.uid, profileType: widget.profileType))
              ],
            )),
    );
  }
}
