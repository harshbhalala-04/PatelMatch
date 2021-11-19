import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/global.dart';
import 'package:chat/helper/services.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:chat/screens/SubscriptionScreen.dart';
import 'package:chat/screens/auth_screen.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // String profileImg =
  //     'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';
  // fetchUserImg() {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final User? user = auth.currentUser;
  //   print('Init State');
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((val) {
  //     setState(() {
  //       Constants.userImage = val['imgUrls'][0];
  //       Constants.myName = val['username'];
  //       print(Constants.userImage);
  //       print('User Image');
  //     });
  //   });
  // }

  removeAllSharedPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool('login', false);
    sharedPreferences.setBool('answers', false);
    sharedPreferences.remove('profileCreatedBy');
    sharedPreferences.remove('samaj');
    sharedPreferences.remove('marryToSamaj');
    sharedPreferences.remove('username');
    sharedPreferences.remove('gender');
    sharedPreferences.remove('imgUrl');
    sharedPreferences.remove('birthdate');
    sharedPreferences.remove('weight');
    sharedPreferences.remove('height');
    sharedPreferences.remove('handicapped');
    sharedPreferences.remove('maritalStatus');
    sharedPreferences.remove('NRI');
  }

  @override
  void initState() {
    // fetchUserImg();
    super.initState();
  }

  String privacyPolicyUrl = "https://patelmatch.in/#/privacy-policy/";
  void _launchURL() async => await canLaunch(privacyPolicyUrl)
      ? await launch(privacyPolicyUrl)
      : throw 'Could not launch $privacyPolicyUrl';

  @override
  Widget build(BuildContext context) {
    // Get.find<GlobalController>().currentAppuser.value.imgUrl = imgUrls[0];
    print(
        "This is imgUrl in profile screen: ${Get.find<GlobalController>().currentAppuser.value.imgUrl}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Obx(() => Text(
              Get.find<GlobalController>().currentAppuser.value.username!,
              style: TextStyle(color: Colors.black),
            )),
      ),
      body: SafeArea(
        child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Obx(() => CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(
                            Get.find<GlobalController>()
                                .currentAppuser
                                .value
                                .imgUrl!,
                          ),
                          radius: 60,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(() => Text(
                          Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .username!,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfileScreen()))
                            .then((value) {
                          setState(() {
                            print(Get.find<GlobalController>()
                                .currentAppuser
                                .value
                                .imgUrl);
                            print(Get.find<GlobalController>()
                                .currentAppuser
                                .value
                                .username);
                          });
                        });
                      },
                    ),
                    ListTile(
                      leading: Text(
                        '\u{20B9}',
                        style: TextStyle(fontSize: 24, color: Colors.black87),
                      ),
                      title: Text(
                        'Plans',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onTap: () {
                        Get.to(SubscriptionScreen());
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.share,
                        color: Colors.black87,
                      ),
                      title: Text(
                        'Share this app',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.person_add_alt_1,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Share My Profile',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onTap: () {
                        createDynamicLink();
                      },
                    ),
                    // ListTile(
                    //   leading: Icon(
                    //     Icons.star_border,
                    //     color: Colors.black,
                    //   ),
                    //   title: Text(
                    //     'Rate this app',
                    //     style: TextStyle(
                    //       fontSize: 20,
                    //     ),
                    //   ),
                    //   onTap: () {},
                    // ),
                    ListTile(
                      leading: Icon(
                        Icons.note_alt_rounded,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onTap: () {
                        _launchURL();
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Log Out',
                        style: TextStyle(fontSize: 20),
                      ),
                      onTap: () {
                        // Constants.myName = '';
                        // Get.find<GlobalController>().currentAppuser.value =
                        //     new UserModel();
                        fromLogout = true;
                        isSignup = false;
                        isLoginVal = false;
                        FirebaseAuth.instance.signOut();
                        SystemNavigator.pop();
                        // Get.find<FeedScreenController>().usersList = [];
                        // Get.find<FeedScreenController>().userListLength.value =
                        //     0;
                        // Get.find<FeedScreenController>()
                        //     .friendRequestList
                        //     .value = [];
                        // Get.find<FeedScreenController>().tmpUsersUid = [];
                        // Get.find<FeedScreenController>().endUser.value = false;
                        // Get.find<FeedScreenController>().messageOpenTill.value =
                        //     Timestamp.now();
                        // Get.find<FeedScreenController>().freeTrial.value =
                        //     false;
                        // Get.find<FeedScreenController>().fnTerminate = 0;
                        // Get.find<FeedScreenController>().currentIndex.value = 0;
                        // Get.find<FeedScreenController>().currentItemLength = 0;
                        // Get.find<FeedScreenController>().previousItemLength = 0;
                        // Get.find<FeedScreenController>().hasMoreData = true;
                        // Get.find<FeedScreenController>().lastUser = null;
                        // Get.find<FeedScreenController>().gender = '';

                        // Get.off(AuthScreen());

                        removeAllSharedPreferences();
                      },
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
