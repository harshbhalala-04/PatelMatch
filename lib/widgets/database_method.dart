import '../helper/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBaseMethods {
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }

  createChatRoom(String chatRoomId, chatRoomMap) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .get();

    //Chat Room Exists.
    if (snapshot.exists) {
      return true;
    }

    //Chat Room doesn't exists so create chat room.
    else {
      return FirebaseFirestore.instance
          .collection("chatroom")
          .doc(chatRoomId)
          .set(chatRoomMap)
          .catchError((e) {
        print(e.toString());
      });
    }
  }

  addDeclineMethod(String username, String email) async {
    // print('This is add decline method');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    List<dynamic> declineUsers = [];
    int flag = 0;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('declineUsers')) {
        // print('Here I fetch data in add decline method');
        declineUsers = val['declineUsers'];
      }
    });

    declineUsers.forEach((element) {
      if(element['email'] == email)
      flag = 1;
    });

    

    if (flag == 0) {
      List<Map<String, dynamic>> myMap = [
        {'name': username, 'email': email}
      ];
      // print('Here I update data in firebase through add decline method');
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update({'declineUsers': FieldValue.arrayUnion(myMap)});
    }

    // print('Here update decline function complete');
  }

  addRequestMethod(String myUsername, String otherUsername, int temp,
      String otherUserImageUrl, String otherEmail) async {
    //print('This is add request method');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    DateTime time = DateTime.now();
    var myData;
    var otherData;
    String? myName;
    String? myEmail;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('declineUsers')) {
        List<dynamic> declineUsers = val['declineUsers'];
        for (int i = 0; i < declineUsers.length; i++) {
          if (declineUsers[i]['email'] == otherEmail) {
            List<Map<String, dynamic>> deleteDecline = [declineUsers[i]];
            FirebaseFirestore.instance.collection("users").doc(user.uid).update(
                {'declineUsers': FieldValue.arrayRemove(deleteDecline)});
          }
        }
      }
    });

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((val) {
      myName = val['username'];
      myEmail = val['email'];
    });
    // print('This is my username : $myName');
    // print('This is other username : $otherUsername');

    String? myUid = user.uid;
    String? otherUid;

    await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: otherEmail)
        .get()
        .then((val) {
      otherUid = val.docs[0]['uid'];
      //print('This is other user id : $otherUid');
    });

    List<Map<String, dynamic>> myMap = [
      {
        'time': time,
        'recieved': '',
        'sent': otherUsername,
        'bookay': 0,
        'image': otherUserImageUrl,
        'email': otherEmail
      }
    ];

    List<Map<String, dynamic>> otherMap = [
      {
        'time': time,
        'recieved': myName,
        'sent': '',
        'bookay': 0,
        'image': Constants.userImage,
        'email': myEmail,
      }
    ];

    Constants.userProfileUrls.add(otherUserImageUrl);
    // Constants.userProfileEmails.add(otherEmail);

    await FirebaseFirestore.instance
        .collection("users")
        .doc(myUid)
        .update({'friendRequest': FieldValue.arrayUnion(myMap)});

    await FirebaseFirestore.instance
        .collection("users")
        .doc(otherUid)
        .update({'friendRequest': FieldValue.arrayUnion(otherMap)});
  }

  Future addMessageMethod(String chatRoomId, String messageId,
      Map<String, dynamic> messageInfo) async {
    return FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfo);
  }

  addUserBio(String text) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({"bio": text});
  }

  addUsername(String username) {
    Constants.myName = username;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({"username": username});
  }

  addUserImage(String imgUrl) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({"imgUrl": imgUrl});
  }

  addUserBirthDate(String day, String month, String year) {
    String birthDate = day + '-' + month + '-' + year;

    //04-09-2002

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({"dd": day, "mm": month, "yyyy": year, "birthDate": birthDate});
  }

  addUserCommunity(String community) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({"community": community});
  }

  addUserZodiacSign(String zodiacSign) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({"zodiacSign": zodiacSign});
  }

  addUserHeight(String height) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update(({'height': height}));
  }

  addUserWorkout(String workout) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update(({'workout': workout}));
  }

  addUserPolitics(String politics) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update(({'politics': politics}));
  }

  addUserMovie(String movie) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update(({'movie': movie}));
  }

  addUserEducation(String education) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update(({'education': education}));
  }

  addUserGender(String gender) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({"gender": gender});
  }

  addUserWorklife(String worklife) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({"worklife": worklife});
  }

  addUserSalary(String salary) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({"salary": salary});
  }

  addUserDrink(String drink) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({"drink": drink});
  }

  addUserSmoke(String smoke) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({"smoke": smoke});
  }

  updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String myName = Constants.myName;
    return FirebaseFirestore.instance
        .collection("chatroom")
        .orderBy("lastMessageTs", descending: true)
        .where("users", arrayContains: myName)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserAllDetails() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    return FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .snapshots();
  }

  int imgCount = 0;

  getUserImageCount() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection("imageCount")
        .doc(user!.uid)
        .get()
        .then((val) {
      imgCount = val['cnt'];
      print(imgCount);
    });
  }

  getUserAllImages() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection("imageURLs")
        .doc(user!.uid)
        .get()
        .then((val) {
      for (int i = 0; i < imgCount; i++) {
        print('This is' + i.toString() + 'time loop running!');
        Constants.userAllImage.add(val[i.toString()]);
        print(val[i].toString());
      }
    });
  }

  updateUserName(String name) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({'username': name});
  }

  getUserByEmailId(String email) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      print('This is the value got from email id');
      print(val.data());
      print(val['username']);
      Constants.myName = val['username'];
      Constants.userImage = val['imgUrl'];
    });
  }

  Future<QuerySnapshot> getUserInfo(String username) async {
    print('THis is get user info function');
    return FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }
}
