import 'package:chat/controllers/global_controller.dart';
import 'package:chat/global.dart';
import 'package:chat/helper/services.dart';
import 'package:chat/screens/SubscriptionScreen.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? appUrl;
  final globalController = Get.put(GlobalController());

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

  fetchLink() async {
    await FirebaseFirestore.instance
        .collection("Links")
        .doc("PlayStoreLink")
        .get()
        .then((val) {
      Map<String, dynamic> linkdata = val.data()!;
      appUrl = linkdata['PlayStore'];
      print(appUrl);
    });
  }

  @override
  void initState() {
    fetchLink();
    super.initState();
  }

  String privacyPolicyUrl = "https://patelmatch.in/#/privacy-policy/";

  // void _launchAppURL() async {
  //   await canLaunch(appUrl!)
  //       ? await launch(appUrl!)
  //       : throw 'Could not launch $appUrl';
  // }
  void shareUrl() async {
    await Share.share(
      appUrl ?? "",
      subject: "Patel Match",
    );
  }

  void _launchURL() async => await canLaunch(privacyPolicyUrl)
      ? await launch(privacyPolicyUrl)
      : throw 'Could not launch $privacyPolicyUrl';

  @override
  Widget build(BuildContext context) {
    // Get.find<GlobalController>().currentAppuser.value.imgUrl = imgUrls[0];
    print(
        "This is imgUrl in profile screen: ${Get.find<GlobalController>().currentAppuser.value.imgUrl}");
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
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
                      Container(
                        width: 275,
                        height: 45,
                        child: FloatingActionButton(
                          heroTag: 'ShareProfile',
                          onPressed: () {
                            createDynamicLink();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Ink(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 85, 115, 1),
                                borderRadius: BorderRadius.circular(50)),
                            child: Container(
                              width: 275,
                              height: 45,
                              alignment: Alignment.center,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/Biodata.svg'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Share My Biodata',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
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
                            color: Color.fromRGBO(51, 51, 51, 1),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditProfileScreen())).then((val) {
                            print("This val from future");
                            print(val);
                            setState(() {});
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
                            color: Color.fromRGBO(51, 51, 51, 1),
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
                            color: Color.fromRGBO(51, 51, 51, 1),
                          ),
                        ),
                        onTap: () {
                          shareUrl();
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.note_alt_rounded,
                          color: Colors.black,
                        ),
                        title: Text(
                          'Privacy Policy',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(51, 51, 51, 1),
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
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(51, 51, 51, 1),
                          ),
                        ),
                        onTap: () {
                          Get.dialog(
                            AlertDialog(
                              title: Text(
                                'Log Out?',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                              content: Text(
                                "Are you sure you want to log out and exit the app?",
                                style: TextStyle(
                                  color: Color.fromRGBO(122, 122, 122, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    fromLogout = true;
                                    isSignup = false;
                                    isLoginVal = false;
                                    removeAllSharedPreferences();
                                    FirebaseAuth.instance.signOut();
                                    SystemNavigator.pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromRGBO(255, 85, 115, 1)),
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
