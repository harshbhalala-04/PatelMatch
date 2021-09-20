import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/constants.dart';
import 'package:chat/helper/services.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:chat/screens/single_user_feed.dart';
import 'package:chat/widgets/feed_button.dart';
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
  List<dynamic> friendRequest = [];
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

      //declineListExist = val['decline'];
      // if (val.data()!.containsKey('declineUsers')) {
      //   declineFriends = val['declineUsers'];
      // }
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

    //Services().getUserModel();

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
                .orderBy("uid")
                .where("gender",
                    isEqualTo: Constants.gender == "Female" ? "Male" : "Female")
                .orderBy("createdAt", descending: true)
                /*.where("uid", whereNotIn: friendRequest)*/
                .limit(itemLimit)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
              currentItemLength = snapshot.data!.docs.length;
              print('This is current Item length : $currentItemLength');
              return ListView(
                  controller: scrollController,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot<Map<String, dynamic>> document) {
                    //Constants().getUserDetails(document.data());
                    setUserModelValue(document.data());
                    final currentUserData = Constants.userDataValue[0];
                    //UserModel(height: height, community: community, userGender: userGender, workout: workout, education: education, worklife: worklife, salary: salary, drink: drink, smoke: smoke, zodiacSign: zodiacSign, politics: politics, movies: movies)
                    return isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            height: screenSize.height,
                            width: screenSize.width,
                            child: Card(
                              child: SingleChildScrollView(
                                //controller: scrollController,
                                child: Column(
                                  children: [
                                    CachedNetworkImage(
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      height: screenSize.height,
                                      width: screenSize.width,
                                      fit: BoxFit.cover,
                                      imageUrl: currentUserData.imageUrl,
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
                                            '${currentUserData.name}, ${currentUserData.age}',
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
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: [
                                          currentUserData.height != ' '
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
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 10),
                                                      ),
                                                      subtitle: Text(
                                                        currentUserData.height,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: 0,
                                                ),
                                          currentUserData.height != ' '
                                              ? SizedBox(width: 20)
                                              : SizedBox(
                                                  width: 0,
                                                ),
                                          currentUserData.community != ' '
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
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 10),
                                                      ),
                                                      subtitle: Text(
                                                        currentUserData.community,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
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
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: [
                                         currentUserData.userGender != ' '
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
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 10),
                                                      ),
                                                      subtitle: Text(
                                                        currentUserData.userGender,
                                                           
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: 0,
                                                ),
                                          currentUserData.userGender != ' '
                                              ? SizedBox(width: 20)
                                              : SizedBox(
                                                  width: 0,
                                                ),
                                          currentUserData.workout != ' '
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
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 10),
                                                      ),
                                                      subtitle: Text(
                                                        currentUserData.workout,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
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
                                    currentUserData.imageUrls.length < 2
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
                                              imageUrl: currentUserData.imageUrls[1],
                                            ),
                                          ),
                                    currentUserData.education != ' ' ||
                                           currentUserData.worklife != ' ' ||
                                            currentUserData.salary != ' '
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(
                                            height: 0,
                                          ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: [
                                          currentUserData.education != ' '
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
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 10),
                                                      ),
                                                      subtitle: Text(
                                                        currentUserData.education,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: 0,
                                                ),
                                          currentUserData.education != ' '
                                              ? SizedBox(width: 20)
                                              : SizedBox(
                                                  width: 0,
                                                ),
                                          currentUserData.worklife != ' '
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
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 10),
                                                      ),
                                                      subtitle: Text(
                                                        currentUserData.worklife,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
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
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: [
                                          currentUserData.salary != ' '
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
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 10),
                                                      ),
                                                      subtitle: Text(
                                                       currentUserData.salary,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
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
                                    currentUserData.imageUrls.length < 3
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
                                              imageUrl: currentUserData.imageUrls[2],
                                            ),
                                          ),
                                    currentUserData.drink != ' ' ||
                                            currentUserData.smoke != ' '
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(
                                            height: 0,
                                          ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: [
                                          currentUserData.drink != ' '
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
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 10),
                                                      ),
                                                      subtitle: Text(
                                                       currentUserData.drink,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: 0,
                                                ),
                                         currentUserData.drink != ' '
                                              ? SizedBox(width: 20)
                                              : SizedBox(
                                                  width: 0,
                                                ),
                                          currentUserData.smoke != ' '
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
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 10),
                                                      ),
                                                      subtitle: Text(
                                                        currentUserData.smoke,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
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
                                    currentUserData.imageUrls.length < 4
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
                                              imageUrl: currentUserData.imageUrls[3],
                                            ),
                                          ),
                                   currentUserData.zodiacSign != ' ' ||
                                            currentUserData.politics != ' ' ||
                                            currentUserData.movies != ' '
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(
                                            height: 0,
                                          ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: [
                                          currentUserData.zodiacSign != ' '
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
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 10),
                                                      ),
                                                      subtitle: Text(
                                                        currentUserData.zodiacSign,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: 0,
                                                ),
                                          currentUserData.zodiacSign != ' '
                                              ? SizedBox(width: 20)
                                              : SizedBox(
                                                  width: 0,
                                                ),
                                         currentUserData.politics != ' '
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
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 10),
                                                      ),
                                                      subtitle: Text(
                                                        currentUserData.politics,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
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
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: [
                                          currentUserData.movies != ' '
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
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 10),
                                                      ),
                                                      subtitle: Text(
                                                        currentUserData.movies,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
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
                                    currentUserData.imageUrls.length < 5
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
                                              imageUrl: currentUserData.imageUrls[4],
                                            ),
                                          ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    //imgUrls![5] == ''
                                    currentUserData.imageUrls.length < 6
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
                                              imageUrl: currentUserData.imageUrls[5],
                                            ),
                                          ),
                                    SizedBox(
                                      height: 80,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                    //floatingActionButton: FeedButton()
                    // floatingActionButton: Column(
                    //         mainAxisAlignment: MainAxisAlignment.end,
                    //         children: [
                    //           InkWell(
                    //             onTap: () {},
                    //             child: Align(
                    //               alignment: Alignment.topRight,
                    //               child: Container(
                    //                 width: 50,
                    //                 height: 50,
                    //                 decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.all(
                    //                         Radius.circular(50)),
                    //                     gradient: LinearGradient(
                    //                       colors: [
                    //                         Color.fromRGBO(255, 71, 104, 1),
                    //                         Color.fromRGBO(255, 115, 140, 1)
                    //                       ],
                    //                       begin: Alignment.topLeft,
                    //                       end: Alignment.bottomRight,
                    //                     )),
                    //                 child: CircleAvatar(
                    //                   backgroundColor: Colors.transparent,
                    //                   child: Image(
                    //                     image:
                    //                         AssetImage('assets/bokay.png'),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             height: 20,
                    //           ),
                    //           Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceAround,
                    //             children: [
                    //               SizedBox(
                    //                 width: 15,
                    //               ),
                    //               Container(
                    //                 width: 130,
                    //                 height: 45,
                    //                 child: FloatingActionButton(
                    //                   onPressed: () {
                    //                     setState(() {
                    //                       // if (currentIndex == 3) {
                    //                       //   userData = [];
                    //                       //   // currentIndex = 0;
                    //                       //   itemLimit += 3;
                    //                       // }

                    //                       //List<String> tempUid = [];
                    //                       // tempUid
                    //                       //     .add(userData[currentIndex]['uid']);
                    //                       // firestore
                    //                       //     .collection("users")
                    //                       //     .doc(user!.uid)
                    //                       //     .update({
                    //                       //   "declineUsers": FieldValue.arrayUnion(
                    //                       //     tempUid,
                    //                       //   )
                    //                       // });
                    //                       // firestore
                    //                       //     .collection("users")
                    //                       //     .doc(user!.uid)
                    //                       //     .update({"decline": true});
                    //                     });
                    //                   },
                    //                   child: Text(
                    //                     'Decline',
                    //                     style: TextStyle(
                    //                         fontSize: 18,
                    //                         color: Color.fromRGBO(
                    //                             184, 184, 184, 1)),
                    //                   ),
                    //                   shape: RoundedRectangleBorder(
                    //                       borderRadius: BorderRadius.all(
                    //                           Radius.circular(50))),
                    //                   backgroundColor: Colors.white,
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 width: 10,
                    //               ),
                    //               Container(
                    //                 width: 130,
                    //                 height: 45,
                    //                 child: FloatingActionButton(
                    //                   onPressed: () {
                    //                     setState(() {
                    //                       currentIndex += 1;
                    //                       if (currentIndex == 3) {
                    //                         // currentIndex = 0;
                    //                         userData = [];
                    //                         itemLimit += 3;
                    //                       }
                    //                     });
                    //                     // DataBaseMethods().addFriendRequest(
                    //                     //     userData[currentIndex]['uid']);
                    //                     // DataBaseMethods().addRequestMethod(myUsername, otherUsername, temp, otherUserImageUrl, otherUserId)
                    //                   },
                    //                   shape: RoundedRectangleBorder(
                    //                       borderRadius:
                    //                           BorderRadius.circular(50)),
                    //                   child: Ink(
                    //                     decoration: BoxDecoration(
                    //                         gradient: LinearGradient(
                    //                             colors: [
                    //                               Color.fromRGBO(
                    //                                   255, 71, 104, 1),
                    //                               Color.fromRGBO(
                    //                                   255, 115, 140, 1)
                    //                             ]),
                    //                         borderRadius:
                    //                             BorderRadius.circular(50)),
                    //                     child: Container(
                    //                       width: 130,
                    //                       height: 45,
                    //                       alignment: Alignment.center,
                    //                       child: Text(
                    //                         'Connect',
                    //                         style: TextStyle(
                    //                           fontSize: 18,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                  }).toList());
            });

    // final userDocs =
    //     snapshot.data!.docs.map((DocumentSnapshot document) {
    //   int flag = 0;
    //   Map<String, dynamic> data =
    //       document.data() as Map<String, dynamic>;
    //   if (!Constants.userProfileIds.contains(data['uid'])) {
    //     if (Constants.dataAdd == 0) {
    //       userData.add(data);
    //     } else {
    //       for (int i = 0; i < userData.length; i++) {
    //         if (userData[i]['uid'] == data['uid']) {
    //           flag = 1;
    //         }
    //       }
    //       if (flag == 0) {
    //         userData.add(data);
    //       } else {}
    //     }
    //   }
    // }).toList();
    // Constants.dataAdd = 1;

    // print('This is current item length : $currentItemLength');
    // if (currentIndex >= userData.length) {
    //   currentIndex = 0;
    // }
  }
}
