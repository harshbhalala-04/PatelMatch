import '../database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../helper/constants.dart';
import '../screens/chat_section/chat_screen.dart';
import 'package:intl/intl.dart';

class ChatRoomListTile extends StatefulWidget {
  late final chatRoomId;
  late final lastMessage;
  late final lastMessageTs;

  ChatRoomListTile({
    required this.chatRoomId,
    required this.lastMessage,
    required this.lastMessageTs,
  });

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  dynamic name = '';
  String lastMsg = '';
  int count = 0;

  String imageUrl =
      'https://cencup.com/wp-content/uploads/2019/07/avatar-placeholder.png';

  getThisUserInfo() async {
    String? username =
        widget.chatRoomId.replaceAll(Constants.myName, "").replaceAll("_", "");

    print(username!);
    print('This is other users username!');

    QuerySnapshot querySnapshot = await DataBaseMethods().getUserInfo(username);
    print('This is query snapshot');
    print(querySnapshot.toString());
    print(querySnapshot.docs[0]['username']);

    name = querySnapshot.docs[0]['username'];
    imageUrl = querySnapshot.docs[0]['imgUrl'];

    

    print(name);
    print('This name comes from fb');
    

    setState(() {});
  }

  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lastMessage.length > 25) {
      lastMsg = widget.lastMessage!.substring(0, 25);
      lastMsg += '...';
      count = 1;
    }
    String? time = DateFormat('hh:mm a').format(widget.lastMessageTs.toDate());

    print(time);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      username: name,
                      imageUrl: imageUrl,
                      myName: Constants.myName,
                      chatRoomId: widget.chatRoomId!,
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        child: Image.network(imageUrl),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
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
