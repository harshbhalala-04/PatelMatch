import 'dart:math';

import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ShowProfileController extends GetxController {
  final isLoading = false.obs;
  final currentUser = UserModel().obs;
  String? chatRoomId;
  String myUserName =
      Get.find<GlobalController>().currentAppuser.value.username!;
  String myUserId = Get.find<GlobalController>().currentAppuser.value.uid!;
  String otherUserId = '';

  String? messageId = '';

  fetchCurrentUser(String uid) async {
    isLoading.toggle();
   
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((val) {
     
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
    List<String> userIds = [myUserId, currentUser.value.uid!];


    // List<String> usersSort = users;
    // usersSort.sort();

    chatRoomId = getChatRoomId(myUserId, currentUser.value.uid!);

    Map<String, dynamic> chatRoomMap = {
      "chatRoomId": chatRoomId,
      "userIds": userIds,
      "firstUserName": users[0],
      "secondUserName": users[1],
      "firstUserImg": Get.find<GlobalController>().currentAppuser.value.imgUrl,
      "secondUserImg": currentUser.value.imgUrl, 
      "firstUserUid": Get.find<GlobalController>().currentAppuser.value.uid,
      "secondUserUid": currentUser.value.uid,
      "hidden": false
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
      "sendBy": myUserId,
      "ts": lastMessageTs,
      "otherUserUid": currentUser.value.uid,
    };

    //message ID
    if (messageId == '') {
      messageId = getMessageId();
    }

    DataBaseMethods()
        .addMessageMethod(
            chatRoomId!, messageId!, messageInfoMap,)
        .then((val) {
      Map<String, dynamic> lastMessageInfoMap = {
        "lastMessage": message,
        "lastMessageTs": lastMessageTs,
      };

      DataBaseMethods().updateLastMessageSend(chatRoomId!, lastMessageInfoMap);
      messageId = '';
    });
  }
}
