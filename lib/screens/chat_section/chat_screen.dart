import 'package:chat/controllers/global_controller.dart';
import 'package:get/get.dart';

import '../../helper/constants.dart';
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
                            : Theme.of(context)
                                .accentTextTheme
                                .headline1
                                ?.color,
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
                    ds["sendBy"] == Constants.myName,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
