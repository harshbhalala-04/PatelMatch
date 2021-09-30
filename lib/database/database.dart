import 'dart:io';

import 'package:chat/helper/user_modal.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../helper/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBaseMethods {
  final FirebaseAuth? auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  getUserByUsername(String username) async {
    try {
      return await firestore
          .collection("users")
          .where("username", isEqualTo: username)
          .get();
    } catch (e) {
      print(e);
    }
  }

  fetchUserName() {
    String? username;
    try {
      firestore.collection("users").doc(user!.uid).get().then((val) {
        if (val.data()!.containsKey('username')) {
          username = val['username'];
        }
      });
    } catch (e) {
      Get.snackbar("Error Fetching username ", "",
          snackPosition: SnackPosition.BOTTOM);
    }

    return username;
  }

  ///Create Chat room if not exists.
  createChatRoom(String chatRoomId, chatRoomMap) async {
    try {
      final snapshot =
          await firestore.collection("chatroom").doc(chatRoomId).get();

      //Chat Room Exists.
      if (snapshot.exists) {
        return true;
      }

      //Chat Room doesn't exists so create chat room.
      else {
        return firestore
            .collection("chatroom")
            .doc(chatRoomId)
            .set(chatRoomMap)
            .catchError((e) {
          print(e.toString());
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  ///Add User to friend request List.
  addFriendRequest(String uid) async {
    List<String> uidList = [];
    uidList.add(uid);
    await firestore
        .collection("users")
        .doc(user!.uid)
        .update({"friendRequest": FieldValue.arrayUnion(uidList)});
  }

  addDeclineMethod(String userID, String userName) async {
    // print('This is add decline method');

    List<dynamic> declineUsers = [];
    int flag = 0;

    try {
      await firestore.collection("users").doc(user!.uid).get().then((val) {
        if (val.data()!.containsKey('declineUsers')) {
          // print('Here I fetch data in add decline method');
          declineUsers = val['declineUsers'];
        }
      });

      declineUsers.forEach((element) {
        if (element['uid'] == userID) flag = 1;
      });

      if (flag == 0) {
        List<Map<String, dynamic>> myMap = [
          {'name': userName, 'id': userID}
        ];
        // print('Here I update data in firebase through add decline method');
        await firestore
            .collection("users")
            .doc(user!.uid)
            .update({'declineUsers': FieldValue.arrayUnion(myMap)});
      }
    } catch (e) {
      print(e.toString());
    }
    // print('Here update decline function complete');
  }

  addRequestMethod(String myUsername, String otherUsername, 
      String otherUserImageUrl, String otherUserId) async {
    DateTime time = DateTime.now();
    var myData;
    var otherData;
    String? myName;
    String? myEmail;

    try {
      await firestore.collection("users").doc(user!.uid).get().then((val) {
        if (val.data()!.containsKey('declineUsers')) {
          List<dynamic> declineUsers = val['declineUsers'];
          for (int i = 0; i < declineUsers.length; i++) {
            if (declineUsers[i]['id'] == otherUserId) {
              List<Map<String, dynamic>> deleteDecline = [declineUsers[i]];
              firestore.collection("users").doc(user!.uid).update(
                  {'declineUsers': FieldValue.arrayRemove(deleteDecline)});
            }
          }
        }
      });

      await firestore.collection("users").doc(user!.uid).get().then((val) {
        myName = val['username'];
      });

      String? myUid = user!.uid;

      List<Map<String, dynamic>> myMap = [
        {
          'time': time,
          'recieved': '',
          'sent': otherUsername,
          'bookay': 0,
          'image': otherUserImageUrl,
          'id': otherUserId
        }
      ];

      List<Map<String, dynamic>> otherMap = [
        {
          'time': time,
          'recieved': myName,
          'sent': '',
          'bookay': 0,
          'image': Constants.userImage,
          'id': myUid,
        }
      ];

      Constants.userProfileUrls.add(otherUserImageUrl);
      // Constants.userProfileEmails.add(otherEmail);

      await firestore
          .collection("users")
          .doc(myUid)
          .update({'friendRequest': FieldValue.arrayUnion(myMap)});

      await firestore
          .collection("users")
          .doc(otherUserId)
          .update({'friendRequest': FieldValue.arrayUnion(otherMap)});
    } catch (e) {
      print(e.toString());
    }
  }

  Future addMessageMethod(String chatRoomId, String messageId,
      Map<String, dynamic> messageInfo) async {
    try {
      return firestore
          .collection("chatroom")
          .doc(chatRoomId)
          .collection("chats")
          .doc(messageId)
          .set(messageInfo);
    } catch (e) {
      print(e.toString());
    }
  }

  addUserBio(String text) {
    try {
      firestore.collection("users").doc(user!.uid).update({"bio": text});
    } catch (e) {
      print(e.toString());
    }
  }

  addUsername(String username) {
    Constants.myName = username;
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update({"username": username});
    } catch (e) {
      print(e.toString());
    }
  }

  addUserBirthDate(String day, String month, String year) {
    String birthDate = day + '-' + month + '-' + year;
    int age;
    DateTime currentDate = DateTime.now();
    age = currentDate.year - int.parse(year);
    int month1 = currentDate.month;
    int month2 = int.parse(month);
    if (month2 > month1) {
      age = age - 1;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = int.parse(day);
      if (day2 > day1) {
        age = age - 1;
      }
    }
    String userAge = age.toString();
    //04-09-2002

    try {
      firestore.collection("users").doc(user!.uid).update({
        "dd": day,
        "mm": month,
        "yyyy": year,
        "birthDate": birthDate,
        "age": userAge
      });
    } catch (e) {
      print(e.toString());
    }
  }

  addUserCommunity(String community) {
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update({"community": community});
    } catch (e) {
      print(e.toString());
    }
  }

  addUserZodiacSign(String zodiacSign) {
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update({"zodiacSign": zodiacSign});
    } catch (e) {
      print(e.toString());
    }
  }

  addUserHeight(String height) {
    try {
      firestore.collection("users").doc(user!.uid).update(({'height': height}));
    } catch (e) {
      print(e.toString());
    }
  }

  addUserWorkout(String workout) {
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update(({'workout': workout}));
    } catch (e) {
      print(e.toString());
    }
  }

  addUserPolitics(String politics) {
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update(({'politics': politics}));
    } catch (e) {
      print(e.toString());
    }
  }

  addUserMovie(String movie) {
    try {
      firestore.collection("users").doc(user!.uid).update(({'movie': movie}));
    } catch (e) {
      print(e.toString());
    }
  }

  addUserEducation(String education) {
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update(({'education': education}));
    } catch (e) {
      print(e.toString());
    }
  }

  addUserGender(String gender) {
    try {
      firestore.collection("users").doc(user!.uid).update({"gender": gender});
    } catch (e) {
      print(e.toString());
    }
  }

  addUserWorklife(String worklife) {
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update({"worklife": worklife});
    } catch (e) {
      print(e.toString());
    }
  }

  addUserSalary(String salary) {
    try {
      firestore.collection("users").doc(user!.uid).update({"salary": salary});
    } catch (e) {
      print(e.toString());
    }
  }

  addUserDrink(String drink) {
    try {
      firestore.collection("users").doc(user!.uid).update({"drink": drink});
    } catch (e) {
      print(e.toString());
    }
  }

  addUserSmoke(String smoke) {
    try {
      firestore.collection("users").doc(user!.uid).update({"smoke": smoke});
    } catch (e) {
      print(e.toString());
    }
  }

  updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    try {
      return firestore
          .collection("chatroom")
          .doc(chatRoomId)
          .update(lastMessageInfoMap);
    } catch (e) {
      print(e.toString());
    }
  }

  getChatRoomMessages(chatRoomId) async {
    try {
      return firestore
          .collection("chatroom")
          .doc(chatRoomId)
          .collection("chats")
          .orderBy("ts", descending: true)
          .snapshots();
    } catch (e) {
      print(e.toString());
    }
  }

  getChatRooms() async {
    String myName = Constants.username;
    try {
      return firestore
          .collection("chatroom")
          .orderBy("lastMessageTs", descending: true)
          .where("users", arrayContains: myName)
          .snapshots();
    } catch (e) {
      print(e.toString());
    }
  }

  getUserAllDetails() {
    try {
      return firestore.collection("users").doc(user!.uid).snapshots();
    } catch (e) {
      print(e.toString());
    }
  }

  int imgCount = 0;

  getUserImageCount() {
    try {
      firestore.collection("users").doc(user!.uid).get().then((val) {
        imgCount = val['imgCount'];
        print(imgCount);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  getUserAllImages() {
    try {
      firestore.collection("users").doc(user!.uid).get().then((val) {
        List<dynamic> imgUrls = val['imgUrls'];
        for (int i = 0; i < imgCount; i++) {
          print('This is' + i.toString() + 'time loop running!');
          Constants.userAllImage.add(imgUrls[i]);
          print(val[i].toString());
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  updateUserName(String name) {
    try {
      firestore.collection("users").doc(user!.uid).update({'username': name});
    } catch (e) {
      print(e.toString());
    }
  }

  getUserByEmailId(String email) async {
    try {
      firestore.collection("users").doc(user!.uid).get().then((val) {
        Constants.myName = val['username'];
        Constants.userImage = val['imgUrl'];
      });
    } catch (e) {
      print(e.toString());
    }
  }

  getUserInfo(String username) async {
    try {
      return firestore
          .collection("users")
          .where("username", isEqualTo: username)
          .get();
    } catch (e) {
      print(e.toString());
    }
  }

  ///Get Current Loggedin user Details

  Future<UserModel?> getCurrentLoggedInUser(String uid) async {
    var doc = await firestore.collection("users").doc(uid).get();
    return UserModel.fromJson(doc.data()!);
  }

  ///Get Details of user
  UserModel getCurrentUser(Map<String, dynamic>? userData) {
    return UserModel.fromJson(userData!);
  }

  uploadUserImages(List<dynamic> userImages) async {
    List<String> urlList = [];
    print('This is user images length: ${userImages.length}');
    for (int i = 0; i < userImages.length; i++) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(user!.uid + 'folder')
          .child(user!.uid + i.toString() + '.jpg');

      await ref
          .putFile(userImages[i])
          .whenComplete(() => print('Image Upload'));

      String url = await ref.getDownloadURL();
      urlList.add(url);
      if (i == 0) {
        await firestore
            .collection("users")
            .doc(user!.uid)
            .update({"imgUrl": url});
        Constants.userImage = url;
      }
    }

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({'imgUrls': FieldValue.arrayUnion(urlList)});

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({'imgCount': urlList.length});
  }
}
