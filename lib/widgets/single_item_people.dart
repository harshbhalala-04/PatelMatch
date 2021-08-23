import '../widgets/database_method.dart';
import 'package:flutter/material.dart';
import '../screens/chat_screen.dart';
import '../helper/constants.dart';
//import '../helper/helper_function.dart';

class SingleItemPeople extends StatelessWidget {
  late final String username;
  late final String imageUrl;
  SingleItemPeople({
    required this.username,
    required this.imageUrl,
  });

  String? chatRoomId;

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createChatRoomAndStartConversion(
      BuildContext context, String username) async {

    List<String> users = [Constants.myName, username];
    
    List<String> usersSort = users;
    usersSort.sort();

    if (Constants.myName.substring(0, 1).codeUnitAt(0) ==
        username.substring(0, 1).codeUnitAt(0)) {
      chatRoomId = usersSort[0] + '_' + usersSort[1];
    } else {
      chatRoomId = getChatRoomId(Constants.myName, username);
    }

    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    DataBaseMethods().createChatRoom(chatRoomId!, chatRoomMap);
  }

  @override
  Widget build(BuildContext context) {
    //String? chatRoomId = getChatRoomId(Constants.myName, username);
    return Container(
      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              createChatRoomAndStartConversion(context, username);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            username: username,
                            imageUrl: imageUrl,
                            myName: Constants.myName,
                            chatRoomId: chatRoomId!,
                          )));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 60, right: 10),
          ),
        ],
      ),
    );
  }
}
