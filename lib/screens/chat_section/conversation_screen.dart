
import '../../database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/chat_room_list_tile.dart';

class ConversationScreen extends StatefulWidget {
  late final email;
  ConversationScreen({required this.email});
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  Stream? chatRoomsStream;

  Widget chatRoomList() {
    print('This is chat Room list');
    return StreamBuilder(
        stream: chatRoomsStream,
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
        });
  }

  getChatRooms() async {
    chatRoomsStream = await DataBaseMethods().getChatRooms();
    setState(() {});
  }

  @override
  void initState() {
    DataBaseMethods().getUserByEmailId(widget.email);
    getChatRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return chatRoomList();
  }
}
