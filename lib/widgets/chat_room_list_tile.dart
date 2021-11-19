import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:get/get.dart';

import '../database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens/chat_section/chat_screen.dart';
import 'package:intl/intl.dart';

class ChatRoomListTile extends StatefulWidget {
  final String chatRoomId;
  final String lastMessage;
  late final lastMessageTs;
  final String otherUserName;
  final String otherUserImg;
  final String otherUserUid;

  ChatRoomListTile(
      {required this.chatRoomId,
      required this.lastMessage,
      required this.lastMessageTs,
      required this.otherUserName,
      required this.otherUserImg,
      required this.otherUserUid});

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String lastMsg = '';
  int count = 0;
  String myUid = Get.find<GlobalController>().currentAppuser.value.uid!;
  String imageUrl = '';
  bool isLoading = false;
  String name = '';
  String otherUserUid = '';

  getThisUserInfo() async {
    setState(() {
      isLoading = true;
    });
    otherUserUid = widget.chatRoomId.replaceAll(myUid, "").replaceAll("_", "");

    QuerySnapshot querySnapshot =
        await DataBaseMethods().getUserInfo(otherUserUid);
    name = querySnapshot.docs[0]['username'];
    imageUrl = querySnapshot.docs[0]['imgUrl'];
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    //getThisUserInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lastMessage.length > 25) {
      lastMsg = widget.lastMessage.substring(0, 25);
      lastMsg += '...';
      count = 1;
    }
    String? time = DateFormat('hh:mm a').format(widget.lastMessageTs.toDate());
    print("User Image : ${widget.otherUserImg}");
    print("User Name: ${widget.otherUserName}");
    print("UID: ${widget.otherUserUid}");
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      username: widget.otherUserName,
                      imageUrl: widget.otherUserImg,
                      chatRoomId: widget.chatRoomId,
                      otherUserUid: widget.otherUserUid,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      child: isLoading
                          ? CircleAvatar(
                              backgroundColor: Colors.grey,
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: CachedNetworkImageProvider(
                                widget.otherUserImg,
                              ),
                              radius: 25,
                            ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isLoading
                            ? Container()
                            : Text(
                                widget.otherUserName,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                        SizedBox(
                          height: 5,
                        ),
                        isLoading
                            ? Container()
                            : Text(
                                count == 0 ? widget.lastMessage : lastMsg,
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                      ],
                    ),
                  ],
                ),
                Text(time),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 60, right: 10),
            ),
          ],
        ),
      ),
    );
  }
}
