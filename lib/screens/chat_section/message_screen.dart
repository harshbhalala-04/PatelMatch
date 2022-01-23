import 'dart:ui';

import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/helper/services.dart';
import 'package:chat/screens/SubscriptionScreen.dart';
import 'package:chat/widgets/chat_room_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  //final String? email = FirebaseAuth.instance.currentUser!.email;
  final globalController = Get.put(GlobalController());
  String myUid = Get.find<GlobalController>().currentAppuser.value.uid!;
  final feedScreenController = Get.put(FeedScreenController());
  final firestore = FirebaseFirestore.instance;
  Stream? chatRoomsStream;
  bool messageOpenTill = false;
  bool isLoading = true;
  int? chatList;
  String? otherUserId;
  String? otherUserName;
  String? otherUserImgUrl;

  openDialogue() {
    Get.defaultDialog(barrierDismissible: false, content: AlertDialog());
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    Timestamp myTimeStamp = Timestamp.fromDate(time);
    if (Get.find<FeedScreenController>().freeTrial.value &&
        Get.find<FeedScreenController>().messageOpenTill.value != null) {
      if (Get.find<FeedScreenController>()
              .messageOpenTill
              .value
              .compareTo(myTimeStamp) >=
          0) {
        messageOpenTill = true;
      }
    }

    firestore.collection("users").doc(userId).get().then((value) {
      Get.find<FeedScreenController>().freeTrial.value =
          value.data()!['freeTrial'];
    });

    
    
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Conversations',
            style:
                TextStyle(color: Color.fromRGBO(51, 51, 51, 1), fontSize: 24),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ),
        body: Obx(() => Stack(children: [
              SingleChildScrollView(
                child: StreamBuilder(
                    stream: firestore
                        .collection("chatroom")
                        .orderBy("lastMessageTs", descending: true)
                        .where("userIds", arrayContains: myUid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data.docs.length == 0) {
                        chatList = 0;
                        return Container(
                          margin: EdgeInsets.only(top: 300),
                          child: Center(
                            child: Text(
                              'Your Conversations appear Here.',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      }
                      final chatRoomDocs = snapshot.data!.docs;
                      return ListView.builder(
                          itemCount: chatRoomDocs.length,
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            DocumentSnapshot ds = snapshot.data.docs[index];
                            print("Here hidden value: ${ds['hidden'].runtimeType}");
                            if (ds['hidden'] != null) {
                              if (ds['hidden']) {
                                print("Here hidden value is true");
                                return Container();
                              }
                            }
                            return ChatRoomListTile(
                                chatRoomId: ds['chatRoomId'],
                                lastMessage: ds['lastMessage'],
                                lastMessageTs: ds['lastMessageTs'],
                                otherUserName: ds['firstUserUid'] ==
                                        Get.find<GlobalController>()
                                            .currentAppuser
                                            .value
                                            .uid
                                    ? ds['secondUserName']
                                    : ds['firstUserName'],
                                otherUserImg: ds['firstUserUid'] ==
                                        Get.find<GlobalController>()
                                            .currentAppuser
                                            .value
                                            .uid
                                    ? ds['secondUserImg']
                                    : ds['firstUserImg'],
                                otherUserUid: ds['firstUserUid'] ==
                                        Get.find<GlobalController>()
                                            .currentAppuser
                                            .value
                                            .uid
                                    ? ds['secondUserUid']
                                    : ds['firstUserUid'],
                                isClickable:
                                    (Get.find<FeedScreenController>().freeTrial.value &&
                                            Get.find<FeedScreenController>()
                                                    .messageOpenTill
                                                    .value !=
                                                null) ||
                                        (Get.find<FeedScreenController>().messageOpenTill.value != null &&
                                            Get.find<FeedScreenController>()
                                                    .messageOpenTill
                                                    .value
                                                    .compareTo(myTimeStamp) >
                                                0));
                          });
                    }),
              ),
              // isLoading ? Center(child: CircularProgressIndicator(),) : (freeTrial! ? AlertDialog() : Container()),
              (Get.find<FeedScreenController>().freeTrial.value
                  ? Center(
                      // child: Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 6,
                          sigmaY: 6,
                        ),
                        child: Container(
                          height: 300,
                          child: AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            content: Column(
                              children: [
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          blurRadius: 5,
                                        ),
                                      ]),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: Stack(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/clock asset.svg',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Start your free trial!",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    "By clicking below, you’ll start a 24 hour free trial for sending and receiving messages.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(MessageScreen());
                                      Get.find<FeedScreenController>()
                                          .freeTrial
                                          .value = false;
                                      DateTime time = DateTime.now()
                                          .add(Duration(days: 1)); //DateTime
                                      Timestamp myTimeStamp =
                                          Timestamp.fromDate(
                                              time); //To TimeStamp
                                      Get.find<FeedScreenController>()
                                          .messageOpenTill
                                          .value = myTimeStamp;
                                      firestore
                                          .collection("users")
                                          .doc(myUid)
                                          .update({
                                        "freeTrial": false,
                                        "messageOpenTill": myTimeStamp
                                      });
                                    },
                                    child: Text(
                                      'Start Now',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Color.fromRGBO(255, 85, 115, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ) /*)*/
                  : Get.find<FeedScreenController>().messageOpenTill.value ==
                          null
                      ? Container()
                      : (Get.find<FeedScreenController>()
                                  .messageOpenTill
                                  .value
                                  .compareTo(myTimeStamp) <
                              0
                          ? Center(
                              // child: Positioned.fill(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 6,
                                  sigmaY: 6,
                                ),
                                child: Container(
                                  height: 300,
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                    ),
                                    content: Column(
                                      children: [
                                        Container(
                                          width: 65,
                                          height: 65,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.25),
                                                  blurRadius: 5,
                                                ),
                                              ]),
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.white,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                border: Border.all(
                                                  color: Color.fromRGBO(
                                                      255, 85, 115, 1),
                                                  width: 3,
                                                ),
                                              ),
                                              child: Container(
                                                margin: EdgeInsets.all(8),
                                                child: SvgPicture.asset(
                                                  'assets/₹.svg',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Subscribe to view messages!",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                          child: Text(
                                            "Choose a plan and message anyone that you have connected with.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 150,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Get.to(SubscriptionScreen());
                                            },
                                            child: Text(
                                              'View plans',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromRGBO(
                                                    255, 85, 115, 1),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // ),
                              ),
                            )
                          : Container())),
            ])));
  }
}
