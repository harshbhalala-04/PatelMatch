import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/controllers/report_controller.dart';
import 'package:chat/widgets/report_option.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import '../../widgets/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../database/database.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  late final String username;
  late final String imageUrl;
  //late final String myName;
  late final String chatRoomId;
  late final String otherUserUid;

  ChatScreen({
    required this.username,
    required this.imageUrl,
    //required this.myName,
    required this.chatRoomId,
    required this.otherUserUid,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  dynamic messageStream;

  getAndSetMessage() async {
    messageStream =
        await DataBaseMethods().getChatRoomMessages(widget.chatRoomId);
    setState(() {});
  }

  doThisOnLaunch() {
    getAndSetMessage();
  }

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  Widget chatMessageTile(
    String message,
    bool sendByMe,
    String time,
  ) {
    return Column(
      children: [
        Row(
            mainAxisAlignment:
                sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: sendByMe ? Colors.grey[300] : Colors.pink.shade300,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft:
                        !sendByMe ? Radius.circular(0) : Radius.circular(12),
                    bottomRight:
                        sendByMe ? Radius.circular(0) : Radius.circular(12),
                  ),
                ),
                width: 160,
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  crossAxisAlignment: sendByMe
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        color: sendByMe ? Colors.black : Colors.white,
                        fontSize: 15,
                      ),
                      textAlign: sendByMe ? TextAlign.end : TextAlign.start,
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: sendByMe
                            ? Colors.black
                            : Theme.of(context).colorScheme.secondary,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ]),
      ],
    );
  }

  Widget chatMessages() {
    return StreamBuilder(
        stream: messageStream,
        builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: 0,
            );
          }
          final chatDocs = snapshot.data!.docs;
          return Expanded(
            child: ListView.builder(
                //padding: EdgeInsets.only(bottom: 40, top: 16),
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  String? time =
                      DateFormat('hh:mm a').format(ds["ts"].toDate());

                  return chatMessageTile(
                    ds["message"],
                    ds["sendBy"] ==
                        Get.find<GlobalController>().currentAppuser.value.uid,
                    time,
                  );
                }),
          );
        });
  }

  Widget bodyWidget() {
    return Column(
      children: [
        chatMessages(),
        NewMessage(
          chatRoomId: widget.chatRoomId,
          myUsername:
              Get.find<GlobalController>().currentAppuser.value.username,
          otherUsername: widget.username,
          otherUserUid: widget.otherUserUid,
        ),
      ],
    );
  }

  final reportController = Get.put(ReportController());
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
                          .removeUserFromFeed(widget.otherUserUid);
                      Get.back();
                      Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .excludedUsers!
                          .add(widget.otherUserUid);

                      DataBaseMethods()
                          .addExcludeUser(widget.otherUserUid, true);

                      DataBaseMethods().addReport(widget.otherUserUid,
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
                      text: widget.username,
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
                          .removeUserFromFeed(widget.otherUserUid);
                      Get.back();
                      Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .excludedUsers!
                          .add(widget.otherUserUid);

                      DataBaseMethods()
                          .addExcludeUser(widget.otherUserUid, true);

                      DataBaseMethods().addBlock(widget.otherUserUid);
                      DataBaseMethods().addBlockInChat(widget.chatRoomId);
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        flexibleSpace: Container(
          margin: EdgeInsets.only(top: 28),
          child: Row(
            children: [
              InkWell(
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 22,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              SizedBox(width: 10),
              CircleAvatar(
                backgroundColor: Color.fromRGBO(196, 196, 196, 1),
                backgroundImage: NetworkImage(widget.imageUrl),
                radius: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.username,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: bodyWidget(),
    );
  }
}
