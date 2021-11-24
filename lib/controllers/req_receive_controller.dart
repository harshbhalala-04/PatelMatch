import 'dart:math';

import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:get/get.dart';

class ReqReceiveController extends GetxController {
  String messageId = '';
  String chatRoomId = '';
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createChatRoom(
    UserModel currentUser,
  ) async {
    String otherUsername = currentUser.username!;
    List<String> users = [
      Get.find<GlobalController>().currentAppuser.value.username!,
      otherUsername
    ];
    List<String> userIds = [
      Get.find<GlobalController>().currentAppuser.value.uid!,
      currentUser.uid!
    ];

    // List<String> usersSort = users;
    // usersSort.sort();

    chatRoomId = getChatRoomId(Get.find<GlobalController>().currentAppuser.value.uid!, currentUser.uid!);

    Map<String, dynamic> chatRoomMap = {
      "chatRoomId": chatRoomId,
      "userIds": userIds,
      "firstUserName": users[0],
      "secondUserName": users[1],
      "firstUserImg": Get.find<GlobalController>().currentAppuser.value.imgUrl,
      "secondUserImg": currentUser.imgUrl,
      "firstUserUid": Get.find<GlobalController>().currentAppuser.value.uid,
      "secondUserUid": currentUser.uid,
    };

    DataBaseMethods().createChatRoom(chatRoomId, chatRoomMap);
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

  addMessage(String enterdMessage, UserModel currentUser) {
    String message = enterdMessage;
    var lastMessageTs = DateTime.now();

    Map<String, dynamic> messageInfoMap = {
      "message": message,
      "sendBy": Get.find<GlobalController>().currentAppuser.value.username,
      "ts": lastMessageTs,
      "otherUserUid": currentUser.uid,
    };

    //message ID
    if (messageId == '') {
      messageId = getMessageId();
    }

    DataBaseMethods()
        .addMessageMethod(
      chatRoomId,
      messageId,
      messageInfoMap,
    )
        .then((val) {
      Map<String, dynamic> lastMessageInfoMap = {
        "lastMessage": message,
        "lastMessageTs": lastMessageTs,
      };

      DataBaseMethods().updateLastMessageSend(chatRoomId, lastMessageInfoMap);
      messageId = '';
    });
  }
}
