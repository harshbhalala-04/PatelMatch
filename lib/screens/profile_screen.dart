import 'package:chat/controllers/global_controller.dart';
import 'package:chat/helper/constants.dart';
import 'package:chat/helper/services.dart';
import 'package:chat/screens/SubscriptionScreen.dart';
import 'package:chat/screens/auth_screen.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String profileImg =
      'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';
  fetchUserImg() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    print('Init State');
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      setState(() {
        Constants.userImage = val['imgUrls'][0];
        Constants.myName = val['username'];
        print(Constants.userImage);
        print('User Image');
      });
    });
  }

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
    fetchUserImg();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          Constants.myName,
          style: TextStyle(color: Colors.black),
        ),
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
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        Get.find<GlobalController>()
                            .currentAppuser
                            .value
                            .imgUrl!,
                      ),
                      radius: 60,
                    ),
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
                                builder: (context) => EditProfileScreen()));
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
                    ListTile(
                      leading: Icon(
                        Icons.star_border,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Rate this app',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onTap: () {},
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
                        ),
                      ),
                      onTap: () {},
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
                        Constants.myName = '';
                        FirebaseAuth.instance.signOut();
                        Get.off(AuthScreen());
                        
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
