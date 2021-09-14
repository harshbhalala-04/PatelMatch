import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/constants.dart';
import 'package:chat/screens/single_user_feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  //bool isRequest = false;
  bool fromFeed = false;
  List<Map<String, dynamic>> userData = [];
  List<dynamic> sentProfilesFeed = [];
  int temp = 0;
  bool isLoading = false;
  final scrollController = ScrollController();
  int itemLimit = 3;
  int currentItemLength = 0;
  int previousItemLength = 0;
  int index = 0;
  int currentIndex = 0;
  List<dynamic> declineFriends = [];
  bool? declineListExist;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  fetchUserGender() async {
    setState(() {
      isLoading = true;
    });

    await firestore.collection("users").doc(user!.uid).get().then((val) {
      Constants.gender = val['gender'];
      declineListExist = val['decline'];
      if (val.data()!.containsKey('declineUsers')) {
        declineFriends = val['declineUsers'];
      }
    });

    // await firestore
    //     .collection("users")
    //     .doc(user!.uid)
    //     .get()
    //     .then((val) {
    //   if (val.data()!.containsKey('friendRequest')) {
    //     List<dynamic> myMap = val['friendRequest'];
    //     myMap.forEach((element) {
    //       if (element['sent'] != '') {
    //         if (!Constants.userProfileUrls.contains(element['image'])) {
    //           Constants.userProfileUrls.add(element['image']);
    //           Constants.userProfileIds.add(element['id']);
    //         }
    //       }
    //     });
    //   }
    // });

    setState(() {
      temp = 1;
      isLoading = false;
    });
  }

  void scrollListner() {
    print('This is scroll listner function');
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent - 100 &&
        !scrollController.position.outOfRange) {
      if (previousItemLength != currentItemLength) {
        setState(() {
          print('Here scroll controller active');
          previousItemLength = currentItemLength;
          itemLimit += 3;
          // userData = [];
          // index = 0;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListner);
    fetchUserGender();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    print('This is value of item limit');
    print(itemLimit);

    return temp == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : StreamBuilder(
            stream: firestore
                .collection("users")
                .orderBy("createdAt", descending: true)
                /*where("gender",
                        isEqualTo:
                            Constants.gender == "Female" ? "Male" : "Female")*/
                /*.where("uid", arrayContains: declineFriends)*/
                .limit(itemLimit)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return AlertDialog(
                  content: Text('Network Not available'),
                  actions: [
                    TextButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
              final userDocs =
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                int flag = 0;
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                if (!Constants.userProfileIds.contains(data['uid'])) {
                  if (Constants.dataAdd == 0) {
                    userData.add(data);
                  } else {
                    for (int i = 0; i < userData.length; i++) {
                      if (userData[i]['uid'] == data['uid']) {
                        flag = 1;
                      }
                    }
                    if (flag == 0) {
                      userData.add(data);
                    } else {}
                  }
                }
              }).toList();
              Constants.dataAdd = 1;
              currentItemLength = snapshot.data!.docs.length;
              print('This is current item length : $currentItemLength');
              if (currentIndex >= userData.length) {
                currentIndex = 0;
              }
              return SafeArea(
                child: Scaffold(
                  body: isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          height: screenSize.height,
                          width: screenSize.width,
                          child: Card(
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    height: screenSize.height,
                                    width: screenSize.width,
                                    fit: BoxFit.cover,
                                    imageUrl: userData[currentIndex]['imgUrl'],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 23.0,
                                      top: 12,
                                      bottom: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${userData[currentIndex]['username']}, ${userData[currentIndex]['age']}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 23,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_sharp,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Surat, India',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12,
                                        left: 23,
                                        right: 22,
                                        bottom: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Personal Information',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          'Ex - Zerodha, Ex - Grant Thornton. I used to crunch numbers and value companies for a living, now I’m trying to build one.',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      children: [
                                        userData[currentIndex]
                                                .containsKey('height')
                                            ? Container(
                                                width: 150,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: ListTile(
                                                    title: Text(
                                                      'Height',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 10),
                                                    ),
                                                    subtitle: Text(
                                                      userData[currentIndex]
                                                          ['height'],
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 0,
                                              ),
                                        userData[currentIndex]
                                                .containsKey('height')
                                            ? SizedBox(width: 20)
                                            : SizedBox(
                                                width: 0,
                                              ),
                                        userData[currentIndex]
                                                .containsKey('community')
                                            ? Container(
                                                width: 150,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: ListTile(
                                                    title: Text(
                                                      'Community',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 10),
                                                    ),
                                                    subtitle: Text(
                                                      userData[currentIndex]
                                                          ['community'],
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 0,
                                              ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      children: [
                                        userData[currentIndex]
                                                .containsKey('gender')
                                            ? Container(
                                                width: 150,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: ListTile(
                                                    title: Text(
                                                      'Gender',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 10),
                                                    ),
                                                    subtitle: Text(
                                                      userData[currentIndex]
                                                              .containsKey(
                                                                  'gender')
                                                          ? userData[
                                                                  currentIndex]
                                                              ['gender']
                                                          : '',
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 0,
                                              ),
                                        userData[currentIndex]
                                                .containsKey('height')
                                            ? SizedBox(width: 20)
                                            : SizedBox(
                                                width: 0,
                                              ),
                                        userData[currentIndex]
                                                .containsKey('workout')
                                            ? Container(
                                                width: 150,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: ListTile(
                                                    title: Text(
                                                      'Workout',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 10),
                                                    ),
                                                    subtitle: Text(
                                                      userData[currentIndex]
                                                              .containsKey(
                                                                  'workout')
                                                          ? userData[
                                                                  currentIndex]
                                                              ['workout']
                                                          : '',
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 0,
                                              ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  //imgUrls![1] == ''
                                  userData[currentIndex]['imgUrls'].length < 2
                                      ? Container(
                                          height: 0,
                                        )
                                      : Container(
                                          height: 569,
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            fit: BoxFit.cover,
                                            //imageUrl: imgUrls![1],
                                            imageUrl: userData[currentIndex]
                                                ['imgUrls'][1],
                                          ),
                                        ),
                                  userData[currentIndex]
                                              .containsKey('education') ||
                                          userData[currentIndex]
                                              .containsKey('worklife') ||
                                          userData[currentIndex]
                                              .containsKey('salary')
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              top: 12,
                                              left: 23,
                                              right: 22,
                                              bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Professional Information',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: 0,
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      children: [
                                        userData[currentIndex]
                                                .containsKey('education')
                                            ? Container(
                                                width: 150,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: ListTile(
                                                    title: Text(
                                                      'Education',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 10),
                                                    ),
                                                    subtitle: Text(
                                                      userData[currentIndex]
                                                              .containsKey(
                                                                  'education')
                                                          ? userData[
                                                                  currentIndex]
                                                              ['education']
                                                          : '',
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 0,
                                              ),
                                        userData[currentIndex]
                                                .containsKey('education')
                                            ? SizedBox(width: 20)
                                            : SizedBox(
                                                width: 0,
                                              ),
                                        userData[currentIndex]
                                                .containsKey('worklife')
                                            ? Container(
                                                width: 150,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: ListTile(
                                                    title: Text(
                                                      'Worklife',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 10),
                                                    ),
                                                    subtitle: Text(
                                                      userData[currentIndex]
                                                              .containsKey(
                                                                  'worklife')
                                                          ? userData[
                                                                  currentIndex]
                                                              ['worklife']
                                                          : '',
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 0,
                                              ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      children: [
                                        userData[currentIndex]
                                                .containsKey('salary')
                                            ? Container(
                                                width: 150,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: ListTile(
                                                    title: Text(
                                                      'Salary',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 10),
                                                    ),
                                                    subtitle: Text(
                                                      userData[currentIndex]
                                                              .containsKey(
                                                                  'salary')
                                                          ? userData[
                                                                  currentIndex]
                                                              ['salary']
                                                          : '',
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 0,
                                              ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  //imgUrls![2] == ''
                                  userData[currentIndex]['imgUrls'].length < 3
                                      ? Container(
                                          height: 0,
                                        )
                                      : Container(
                                          height: 569,
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            fit: BoxFit.cover,
                                            //imageUrl: imgUrls![2],
                                            imageUrl: userData[currentIndex]
                                                ['imgUrls'][2],
                                          ),
                                        ),
                                  userData[currentIndex].containsKey('drink') ||
                                          userData[currentIndex]
                                              .containsKey('smoke')
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              top: 12,
                                              left: 23,
                                              right: 22,
                                              bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Social Life',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: 0,
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      children: [
                                        userData[currentIndex]
                                                .containsKey('drink')
                                            ? Container(
                                                width: 150,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: ListTile(
                                                    title: Text(
                                                      'Drinking',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 10),
                                                    ),
                                                    subtitle: Text(
                                                      userData[currentIndex]
                                                              .containsKey(
                                                                  'drink')
                                                          ? userData[
                                                                  currentIndex]
                                                              ['drink']
                                                          : '',
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 0,
                                              ),
                                        userData[currentIndex]
                                                .containsKey('drink')
                                            ? SizedBox(width: 20)
                                            : SizedBox(
                                                width: 0,
                                              ),
                                        userData[currentIndex]
                                                .containsKey('smoke')
                                            ? Container(
                                                width: 150,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: ListTile(
                                                    title: Text(
                                                      'Smoking',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 10),
                                                    ),
                                                    subtitle: Text(
                                                      userData[currentIndex]
                                                              .containsKey(
                                                                  'smoke')
                                                          ? userData[
                                                                  currentIndex]
                                                              ['smoke']
                                                          : '',
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 0,
                                              ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  //imgUrls![3] == ''
                                  userData[currentIndex]['imgUrls'].length < 4
                                      ? Container(
                                          height: 0,
                                        )
                                      : Container(
                                          height: 569,
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            fit: BoxFit.cover,
                                            //imageUrl: imgUrls![3],
                                            imageUrl: userData[currentIndex]
                                                ['imgUrls'][3],
                                          ),
                                        ),
                                  userData[currentIndex]
                                              .containsKey('zodiacSign') ||
                                          userData[currentIndex]
                                              .containsKey('politics') ||
                                          userData[currentIndex]
                                              .containsKey('movies')
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              top: 12,
                                              left: 23,
                                              right: 22,
                                              bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Others',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: 0,
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      children: [
                                        userData[currentIndex]
                                                .containsKey('zodiacSign')
                                            ? Container(
                                                width: 150,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: ListTile(
                                                    title: Text(
                                                      'Zodiac Sign',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 10),
                                                    ),
                                                    subtitle: Text(
                                                      userData[currentIndex]
                                                              .containsKey(
                                                                  'zodiacSign')
                                                          ? userData[
                                                                  currentIndex]
                                                              ['zodiacSign']
                                                          : '',
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 0,
                                              ),
                                        userData[currentIndex]
                                                .containsKey('zodiacSign')
                                            ? SizedBox(width: 20)
                                            : SizedBox(
                                                width: 0,
                                              ),
                                        userData[currentIndex]
                                                .containsKey('politics')
                                            ? Container(
                                                width: 150,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: ListTile(
                                                    title: Text(
                                                      'Political inclination',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 10),
                                                    ),
                                                    subtitle: Text(
                                                      userData[currentIndex]
                                                              .containsKey(
                                                                  'politics')
                                                          ? userData[
                                                                  currentIndex]
                                                              ['politics']
                                                          : '',
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 0,
                                              ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      children: [
                                        userData[currentIndex]
                                                .containsKey('movies')
                                            ? Container(
                                                width: 150,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: ListTile(
                                                    title: Text(
                                                      'Movies',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 10),
                                                    ),
                                                    subtitle: Text(
                                                      userData[currentIndex]
                                                              .containsKey(
                                                                  'movies')
                                                          ? userData[
                                                                  currentIndex]
                                                              ['movies']
                                                          : '',
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 0,
                                              ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  //imgUrls![4] == ''
                                  userData[currentIndex]['imgUrls'].length < 5
                                      ? Container(
                                          height: 0,
                                        )
                                      : Container(
                                          height: 569,
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            fit: BoxFit.cover,
                                            //imageUrl: imgUrls![4],
                                            imageUrl: userData[currentIndex]
                                                ['imgUrls'][4],
                                          ),
                                        ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  //imgUrls![5] == ''
                                  userData[currentIndex]['imgUrls'].length < 6
                                      ? Container(
                                          height: 0,
                                        )
                                      : Container(
                                          height: 569,
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            fit: BoxFit.cover,
                                            //imageUrl: imgUrls![5],
                                            imageUrl: userData[currentIndex]
                                                ['imgUrls'][5],
                                          ),
                                        ),
                                  SizedBox(
                                    height: 80,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                  floatingActionButton: userData.length == 0
                      ? Container()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromRGBO(255, 71, 104, 1),
                                          Color.fromRGBO(255, 115, 140, 1)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Image(
                                      image: AssetImage('assets/bokay.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: 130,
                                  height: 45,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      setState(() {
                                        currentIndex += 1;
                                        if (currentIndex == 3) {
                                          userData = [];
                                          // currentIndex = 0;
                                          itemLimit += 3;
                                        }

                                        //List<String> tempUid = [];
                                        // tempUid
                                        //     .add(userData[currentIndex]['uid']);
                                        // firestore
                                        //     .collection("users")
                                        //     .doc(user!.uid)
                                        //     .update({
                                        //   "declineUsers": FieldValue.arrayUnion(
                                        //     tempUid,
                                        //   )
                                        // });
                                        // firestore
                                        //     .collection("users")
                                        //     .doc(user!.uid)
                                        //     .update({"decline": true});
                                      });
                                    },
                                    child: Text(
                                      'Decline',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromRGBO(184, 184, 184, 1)),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 130,
                                  height: 45,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      setState(() {
                                        currentIndex += 1;
                                        if (currentIndex == 3) {
                                          // currentIndex = 0;
                                          userData = [];
                                          itemLimit += 3;
                                        }
                                      });
                                      // DataBaseMethods().addFriendRequest(
                                      //     userData[currentIndex]['uid']);
                                      // DataBaseMethods().addRequestMethod(myUsername, otherUsername, temp, otherUserImageUrl, otherUserId)
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color.fromRGBO(255, 71, 104, 1),
                                            Color.fromRGBO(255, 115, 140, 1)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Container(
                                        width: 130,
                                        height: 45,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Connect',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
              );
            });
  }
}
