import '../database/database.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:math';


class NewMessage extends StatefulWidget {
  late final myUsername;
  late final chatRoomId;
  late final otherUsername;

  NewMessage(
      {required this.myUsername,
      required this.chatRoomId,
      required this.otherUsername});
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enterdMessage = '';
  String messageId = '';
  

  String getMessageId() {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < 12; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }

  addMessage() {
    String message = _enterdMessage;
    var lastMessageTs = DateTime.now();

    Map<String, dynamic> messageInfoMap = {
      "message": message,
      "sendBy": widget.myUsername,
      "ts": lastMessageTs,
    };

    //message ID
    if (messageId == '') {
      messageId = getMessageId();
    }

    _controller.clear();

    DataBaseMethods()
        .addMessageMethod(widget.chatRoomId, messageId, messageInfoMap)
        .then((val) {
      Map<String, dynamic> lastMessageInfoMap = {
        "lastMessage": message,
        "lastMessageTs": lastMessageTs,
      };

      DataBaseMethods()
          .updateLastMessageSend(widget.chatRoomId, lastMessageInfoMap);  
        messageId = '';
    });
  }

  //

  

  // Widget chatMessages() {
  //   return StreamBuilder(
  //       stream: messageStream,
  //       builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
  //         final chatDocs = snapshot.data!.docs;
  //         return ListView.builder(
  //             itemCount: chatDocs.length,
  //             itemBuilder: (context, index) {
  //               DocumentSnapshot ds = snapshot.data!.docs[index];
  //               return Text(ds["message"]);
  //             });
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 60,),
              child: Scrollbar(
                child: TextField(
                  controller: _controller,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  maxLines: null,
                  enableSuggestions: true,
                  decoration: InputDecoration(hintText: 'Send a message...'),
                  onChanged: (value) {
                    setState(() {
                      _enterdMessage = value;
                    });
                  },
                ),
              ),
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.send,
            ),
            onPressed: _enterdMessage.trim().isEmpty
                ? null
                : () {
                    addMessage();
                  },
          ),
        ],
      ),
      )
      //margin: EdgeInsets.only(top: 8),
      
    );
  }
}
