import 'dart:math';

import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/constants.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ShowProfileController extends GetxController {
  final isLoading = false.obs;
  final currentUser = UserModel().obs;
  String? chatRoomId;
  String myUserName =
      Get.find<GlobalController>().currentAppuser.value.username!;
  String? messageId = '';
  
  fetchCurrentUser(String uid) async {
    isLoading.toggle();
    print('This is uid: $uid');
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((val) {
      print('This is data I got: ________________');
      print(val.data());
      Map<String, dynamic> tmpMap = val.data()!;
      currentUser.value = UserModel.fromJson(tmpMap);
    });

    isLoading.toggle();
  }


  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createChatRoom() async {
    String otherUsername = currentUser.value.username!;
    List<String> users = [myUserName, otherUsername];

    List<String> usersSort = users;
    usersSort.sort();

    if (myUserName.substring(0, 1).codeUnitAt(0) ==
        otherUsername.substring(0, 1).codeUnitAt(0)) {
      chatRoomId = usersSort[0] + '_' + usersSort[1];
    } else {
      chatRoomId = getChatRoomId(myUserName, otherUsername);
    }

    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    DataBaseMethods().createChatRoom(chatRoomId!, chatRoomMap);
  }

  String getMessageId() {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < 12; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }

  addMessage(String enterdMessage) {
    String message = enterdMessage;
    var lastMessageTs = DateTime.now();

    Map<String, dynamic> messageInfoMap = {
      "message": message,
      "sendBy": myUserName,
      "ts": lastMessageTs,
    };

    //message ID
    if (messageId == '') {
      messageId = getMessageId();
    }

    DataBaseMethods()
        .addMessageMethod(chatRoomId!, messageId!, messageInfoMap)
        .then((val) {
      Map<String, dynamic> lastMessageInfoMap = {
        "lastMessage": message,
        "lastMessageTs": lastMessageTs,
      };

      DataBaseMethods()
          .updateLastMessageSend(chatRoomId!, lastMessageInfoMap);
      messageId = '';
    });
  }
}
