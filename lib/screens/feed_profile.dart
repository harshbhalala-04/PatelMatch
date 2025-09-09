import 'package:chat/controllers/feedProfileController.dart';
import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/controllers/report_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:chat/screens/custom_tab_bar.dart';
import 'package:chat/screens/feed_screen.dart';
import 'package:chat/screens/single_user_feed.dart';
import 'package:chat/widgets/feed_button.dart';
import 'package:chat/widgets/profile_feed_button.dart';
import 'package:chat/widgets/report_option.dart';
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
                          .removeUserFromFeed(widget.user.uid!);
                      Get.back();
                      Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .excludedUsers!
                          .add(widget.user.uid);

                      DataBaseMethods().addExcludeUser(widget.user.uid!, true);

                      DataBaseMethods().addReport(widget.user.uid!,
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
                RichText(text: TextSpan(
                  children: [
                    TextSpan(
                      text: "By blocking ",
                      style: TextStyle(
                        color: Color.fromRGBO(51, 51, 51, 1),
                        fontSize: 14,
                        fontFamily: 'Cabin'
                      ),
                    ),
                    TextSpan(
                      text: widget.user.username,
                      style: TextStyle(
                        color: Color.fromRGBO(255, 85, 115, 1),
                        fontSize: 14,
                        fontFamily: 'Cabin'
                      ),
                    ),
                    TextSpan(
                      text: ", you will not be able to send or receive messages by them, view their profile on the feed or in the request's page. They won't be notified that you blocked them.",
                      style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1), fontSize: 14, fontFamily: 'Cabin'),
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
                          .removeUserFromFeed(widget.user.uid!);
                      Get.back();
                      Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .excludedUsers!
                          .add(widget.user.uid);

                      DataBaseMethods().addExcludeUser(widget.user.uid!, true);

                      DataBaseMethods().addBlock(widget.user.uid!);
                      
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
    print(widget.user.imgUrls!.length);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: TextStyle(color: Colors.black, fontSize: 24),
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
