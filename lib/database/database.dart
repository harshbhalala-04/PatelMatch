import 'dart:io';

import 'package:chat/controllers/global_controller.dart';
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

  ///Remove request of another user from profile:
  declineRequest(String otherUid) async {
    List<dynamic> tmpMap = [];
    List<Map<String, dynamic>> removeMap = [];
    List<dynamic> otherTmpMap = [];
    List<Map<String, dynamic>> otherRemoveMap = [];

    try {
      await firestore.collection("users").doc(user!.uid).get().then((val) {
        tmpMap = val['friendRequest'];
      });

      for (int i = 0; i < tmpMap.length; i++) {
        if (tmpMap[i]['id'] == otherUid) {
          Map<String, dynamic> findMap = tmpMap[i];
          removeMap.add(findMap);
          break;
        }
      }

      await firestore
          .collection("users")
          .doc(user!.uid)
          .update({'friendRequest': FieldValue.arrayRemove(removeMap)});

      await firestore.collection("users").doc(otherUid).get().then((val) {
        otherTmpMap = val['friendRequest'];
      });

      for (int i = 0; i < otherTmpMap.length; i++) {
        if (otherTmpMap[i]['id'] == user!.uid) {
          Map<String, dynamic> findMap = otherTmpMap[i];
          otherRemoveMap.add(findMap);
          break;
        }
      }

      await firestore
          .collection("users")
          .doc(otherUid)
          .update({'friendRequest': FieldValue.arrayRemove(otherRemoveMap)});
    } catch (error) {
      print(error.toString());
    }
  }

  ///add user to Exclude Users List
  addExcludeUser(String ohterUid, bool fromConnect) async {
    List<String> uidList = [];
    uidList.add(ohterUid);
    await firestore
        .collection("users")
        .doc(user!.uid)
        .update({"excludedUsers": FieldValue.arrayUnion(uidList)});

    if (fromConnect) {
      List<String> myUidList = [];
      myUidList.add(user!.uid);
      await firestore
          .collection("users")
          .doc(ohterUid)
          .update({"excludedUsers": FieldValue.arrayUnion(myUidList)});
    }
  }

  removeExcludeUser(String otherUid) async {
    List<String> otherUidList = [];
    otherUidList.add(otherUid);
    await firestore
        .collection("users")
        .doc(user!.uid)
        .update({"excludedUsers": FieldValue.arrayRemove(otherUidList)});
  }

  ///Sent request to another user.
  addRequestMethod(String myUsername, String otherUsername,
      String otherUserImageUrl, String otherUserId, int bookay) async {
    DateTime time = DateTime.now();
    var myData;
    var otherData;
    String? myName;
    String? myEmail;
    int bookayAvailable = 0;

    try {
      await firestore.collection("users").doc(user!.uid).get().then((val) {
        Map<String, dynamic> tmpMap = val.data()!;
        bookayAvailable = tmpMap['bookayAvailable'];
        print('In try : $bookayAvailable');
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

      int remaningBookay = bookayAvailable - bookay;

      print('This is remaining bookay : $remaningBookay');

      if (remaningBookay < 0) {
        remaningBookay = 0;
      }

      await firestore.collection("users").doc(user!.uid).get().then((val) {
        myName = val['username'];
      });

      String? myUid = user!.uid;

      List<Map<String, dynamic>> myMap = [
        {
          'time': time,
          'recieved': '',
          'sent': otherUsername,
          'bookay': bookay,
          'image': otherUserImageUrl,
          'id': otherUserId
        }
      ];

      List<Map<String, dynamic>> otherMap = [
        {
          'time': time,
          'recieved': myName,
          'sent': '',
          'bookay': bookay,
          'image': Constants.userImage,
          'id': myUid,
        }
      ];

      Constants.userProfileUrls.add(otherUserImageUrl);
      // Constants.userProfileEmails.add(otherEmail);

      await firestore.collection("users").doc(myUid).update({
        'friendRequest': FieldValue.arrayUnion(myMap),
        'latestConnectionSentUid': otherUserId,
        'bookayAvailable': remaningBookay,
      });

      await firestore
          .collection("users")
          .doc(otherUserId)
          .update({'friendRequest': FieldValue.arrayUnion(otherMap)});
    } catch (e) {
      print(e.toString());
    }
  }

  addUserToMatch(String myUsername, String myImageUrl, String otherUsername,
      String otherUserImageUrl, String otherUserId) async {
    DateTime time = DateTime.now();

    List<Map<String, dynamic>> myMatchMap = [
      {
        "friendname": otherUsername,
        "friendImage": otherUserImageUrl,
        "friendUid": otherUserId
      }
    ];

    List<Map<String, dynamic>> otherMatchMap = [
      {
        "friendname": myUsername,
        "friendImage": myImageUrl,
        "friendUid": user!.uid
      }
    ];

    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update({'matchUsers': FieldValue.arrayUnion(myMatchMap)});

      firestore
          .collection("users")
          .doc(otherUserId)
          .update({'matchUsers': FieldValue.arrayUnion(otherMatchMap)});
    } catch (e) {
      print(e.toString());
    }
  }

  addMessageMethod(
    String chatRoomId,
    String messageId,
    Map<String, dynamic> messageInfo,
  ) async {
    try {
      await firestore
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

  addUserGotra(String gotra) {
    try {
      firestore.collection("users").doc(user!.uid).update({"gotra": gotra});
    } catch (e) {
      print(e.toString());
    }
  }

  addUserCity(String currentCity) {
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update({"currentCity": currentCity});
    } catch (e) {
      print(e.toString());
    }
  }

  addUserNative(String nativeCity) {
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update({"nativeCity": nativeCity});
    } catch (e) {
      print(e.toString());
    }
  }

  addFatherNative(String nativeCity) {
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update({"fatherNative": nativeCity});
    } catch (e) {
      print(e.toString());
    }
  }

  addMotherNative(String nativeCity) {
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update({"motherNative": nativeCity});
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

  addUserSamaj(String samaj) {
    try {
      firestore.collection("users").doc(user!.uid).update({"userSamaj": samaj});
    } catch (e) {
      print(e.toString());
    }
  }

  addUserHandicapped(String handicapped) {
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update({"handicapped": handicapped});
    } catch (e) {
      print(e.toString());
    }
  }

  addUserManglik(String manglik) {
    try {
      firestore.collection("users").doc(user!.uid).update({"manglik": manglik});
    } catch (e) {
      print(e.toString());
    }
  }

  addUserNRI(String userNRI) {
    try {
      firestore.collection("users").doc(user!.uid).update({"userNRI": userNRI});
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

  addUserStar(String star) {
    try {
      firestore.collection("users").doc(user!.uid).update(({'star': star}));
    } catch (e) {
      print(e.toString());
    }
  }

  addUserRashi(String rashi) {
    try {
      firestore.collection("users").doc(user!.uid).update(({'rashi': rashi}));
    } catch (e) {
      print(e.toString());
    }
  }

  addUserWeight(String weight) {
    try {
      firestore.collection("users").doc(user!.uid).update(({'weight': weight}));
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

  addUserProfileCreated(String profileCreatedBy) {
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update(({'profileCreatedBy': profileCreatedBy}));
    } catch (e) {
      print(e.toString());
    }
  }

  addUserMaritalStatus(String maritalStatus) {
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update(({'maritalStatus': maritalStatus}));
    } catch (e) {
      print(e.toString());
    }
  }

  addUserMarryToSamaj(String marryToSamaj) {
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update(({'marryToSamaj': marryToSamaj}));
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

  addFatherWorklife(String worklife) {
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update({"fatherOccupation": worklife});
    } catch (e) {
      print(e.toString());
    }
  }

  addMotherWorklife(String worklife) {
    try {
      firestore
          .collection("users")
          .doc(user!.uid)
          .update({"motherOccupation": worklife});
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

  addFatherSalary(String salary) {
    try {
      firestore.collection("users").doc(user!.uid).update({"fatherAvgAnnualIncome": salary});
    } catch (e) {
      print(e.toString());
    }
  }

  addMotherSalary(String salary) {
    try {
      firestore.collection("users").doc(user!.uid).update({"motherAvgAnnualIncome": salary});
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

  updateFatherName(String name) {
    try {
      firestore.collection("users").doc(user!.uid).update({'fatherName': name});
    } catch (e) {
      print(e.toString());
    }
  }

  updateMotherName(String name) {
    try {
      firestore.collection("users").doc(user!.uid).update({'motherName': name});
    } catch (e) {
      print(e.toString());
    }
  }

  getUserByEmailId() async {
    Constants.myName =
        Get.find<GlobalController>().currentAppuser.value.username!;
    Constants.userImage =
        Get.find<GlobalController>().currentAppuser.value.imgUrl!;
  }

  getUserInfo(String uid) async {
    try {
      return await firestore
          .collection("users")
          .where("uid", isEqualTo: uid)
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

  //Uploading Filter Data for user.
  filterAge(int start, int end) async {
    List<int> age = [];
    age.add(start);
    age.add(end);
    var ref = firestore.collection("users").doc(user!.uid);
    await ref.get().then((val) {
      Map<String, dynamic> myMap = val['filters'];
      myMap['age'] = age;
      ref.update({'isFilterApplied': true, 'filters': myMap});
    });
  }

  filterSamaj(Set<String> samajSet) async {
    var ref = firestore.collection("users").doc(user!.uid);
    List<String> samajList = [];
    for (int i = 0; i < samajSet.length; i++) {
      samajList.add(samajSet.elementAt(i));
    }
    await ref.get().then((val) {
      Map<String, dynamic> myMap = val['filters'];
      myMap['samaj'] = samajList;
      ref.update({'isFilterApplied': true, 'filters': myMap});
    });
  }

  filterDrink(Set<String> drinkSet) async {
    var ref = firestore.collection("users").doc(user!.uid);
    List<String> drinkList = [];
    for (int i = 0; i < drinkSet.length; i++) {
      drinkList.add(drinkSet.elementAt(i));
    }
    await ref.get().then((val) {
      Map<String, dynamic> myMap = val['filters'];
      myMap['drink'] = drinkList;
      ref.update({'isFilterApplied': true, 'filters': myMap});
    });
  }

  filterSmoke(Set<String> smokeSet) async {
    var ref = firestore.collection("users").doc(user!.uid);
    List<String> smokeList = [];
    for (int i = 0; i < smokeSet.length; i++) {
      smokeList.add(smokeSet.elementAt(i));
    }
    await ref.get().then((val) {
      Map<String, dynamic> myMap = val['filters'];
      myMap['smoke'] = smokeList;
      ref.update({'isFilterApplied': true, 'filters': myMap});
    });
  }

  filterStar(Set<String> starSet) async {
    var ref = firestore.collection("users").doc(user!.uid);
    List<String> starList = [];
    for (int i = 0; i < starSet.length; i++) {
      starList.add(starSet.elementAt(i));
    }
    await ref.get().then((val) {
      Map<String, dynamic> myMap = val['filters'];
      myMap['starSign'] = starList;
      ref.update({'isFilterApplied': true, 'filters': myMap});
    });
  }

  filterRashi(Set<String> rashiSet) async {
    var ref = firestore.collection("users").doc(user!.uid);
    List<String> rashiList = [];
    for (int i = 0; i < rashiSet.length; i++) {
      rashiList.add(rashiSet.elementAt(i));
    }
    await ref.get().then((val) {
      Map<String, dynamic> myMap = val['filters'];
      myMap['rashi'] = rashiList;
      ref.update({'isFilterApplied': true, 'filters': myMap});
    });
  }

  filterIncome(Set<String> incomeSet) async {
    var ref = firestore.collection("users").doc(user!.uid);
    List<String> incomeList = [];
    for (int i = 0; i < incomeSet.length; i++) {
      incomeList.add(incomeSet.elementAt(i));
    }
    await ref.get().then((val) {
      Map<String, dynamic> myMap = val['filters'];
      myMap['incomeRange'] = incomeList;
      ref.update({'isFilterApplied': true, 'filters': myMap});
    });
  }

  filterVerified(Set<String> verifiedSet) async {
    var ref = firestore.collection("users").doc(user!.uid);
    List<String> verifiedList = [];
    for (int i = 0; i < verifiedSet.length; i++) {
      verifiedList.add(verifiedSet.elementAt(i));
    }
    await ref.get().then((val) {
      Map<String, dynamic> myMap = val['filters'];
      myMap['verifiedOnly'] = verifiedList;
      ref.update({'isFilterApplied': true, 'filters': myMap});
    });
  }

  filterNRI(Set<String> nriSet) async {
    var ref = firestore.collection("users").doc(user!.uid);
    List<String> nriList = [];
    for (int i = 0; i < nriSet.length; i++) {
      nriList.add(nriSet.elementAt(i));
    }
    await ref.get().then((val) {
      Map<String, dynamic> myMap = val['filters'];
      myMap['verifiedOnly'] = nriList;
      ref.update({'isFilterApplied': true, 'filters': myMap});
    });
  }

  filterHeight(String start, String end) async {
    List<String> height = [];
    height.add(start);
    height.add(end);
    var ref = firestore.collection("users").doc(user!.uid);
    await ref.get().then((val) {
      Map<String, dynamic> myMap = val['filters'];
      myMap['height'] = height;
      ref.update({'isFilterApplied': true, 'filters': myMap});
    });
  }

  filterWeight(int start, int end) async {
    List<int> weight = [];
    weight.add(start);
    weight.add(end);
    var ref = firestore.collection("users").doc(user!.uid);
    await ref.get().then((val) {
      Map<String, dynamic> myMap = val['filters'];
      myMap['weight'] = weight;
      ref.update({'isFilterApplied': true, 'filters': myMap});
    });
  }

  /// Add purchase to database
  addMessaging(Map<dynamic, dynamic> messagePurchase) async {
    List<Map<dynamic, dynamic>> messagePurchaseList = [];
    messagePurchaseList.add(messagePurchase);
    try {
      await firestore
          .collection("users")
          .doc(user!.uid)
          .update({'message': FieldValue.arrayUnion(messagePurchaseList)});
    } catch (e) {
      print(e.toString());
    }
  }

  addBouquts(Map<dynamic, dynamic> bouquePurchase) async {
    List<Map<dynamic, dynamic>> bouquePurchaseList = [];
    bouquePurchaseList.add(bouquePurchase);
    int bookayAvailable = 0;
    int newBookay = bouquePurchase['bookayCount'];
    print(bouquePurchase);
    try {
      await firestore.collection("users").doc(user!.uid).get().then((value) {
        Map<String, dynamic> tmp = value.data()!;
        print(tmp['bookayAvailable']);
        print(tmp['bookayAvailable'].runtimeType);
        bookayAvailable = tmp['bookayAvailable'];
      });
      bookayAvailable = bookayAvailable + newBookay;
      await firestore.collection("users").doc(user!.uid).update({
        'bookayAvailable': bookayAvailable,
        'bouquets': FieldValue.arrayUnion(bouquePurchaseList)
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
