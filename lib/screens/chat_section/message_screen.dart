import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/widgets/chat_room_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'conversation_screen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final String? email = FirebaseAuth.instance.currentUser!.email;
  String myName = Get.find<GlobalController>().currentAppuser.value.username!;
  final firestore = FirebaseFirestore.instance;
  Stream? chatRoomsStream;
  // getChatRooms() async {
  //   chatRoomsStream = await DataBaseMethods().getChatRooms();
  //   setState(() {});
  // }

  @override
  void initState() {
    print("Init state of conversation screen works here");
    DataBaseMethods().getUserByEmailId(email!);

    //getChatRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Conversations',
          style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1), fontSize: 24),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: StreamBuilder(
          stream: firestore
              .collection("chatroom")
              .orderBy("lastMessageTs", descending: true)
              .where("users", arrayContains: myName)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text('Your Conversations appear Here.'),
              );
            }
            final chatRoomDocs = snapshot.data!.docs;
            return ListView.builder(
                itemCount: chatRoomDocs.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  print(ds['chatRoomId']);
                  print('This is chat Room Id');
                  print(ds['lastMessage']);
                  print('This is last message');
                  return ChatRoomListTile(
                    chatRoomId: ds['chatRoomId'],
                    lastMessage: ds['lastMessage'],
                    lastMessageTs: ds['lastMessageTs'],
                  );
                });
          }),
    );
  }
}
