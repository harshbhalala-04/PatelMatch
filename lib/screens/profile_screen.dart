import 'package:chat/helper/constants.dart';
import 'package:chat/helper/services.dart';
import 'package:chat/screens/auth_screen.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        print(Constants.userImage);
        print('User Image');
      });
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((val) {
      setState(() {
        Constants.myName = val['username'];
      });
    });
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
                        Constants.userImage,
                      ),
                      radius: 60,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      Constants.myName,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Edit Profile'),
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfileScreen()))
                            .then((_) {
                          fetchUserImg();
                        });
                      },
                    ),
                    ListTile(
                      leading: Text(
                        '\u{20B9}',
                        style: TextStyle(fontSize: 24, color: Colors.grey),
                      ),
                      title: Text('Plans'),
                      onTap: () {},
                    ),
                    ListTile(
                        leading: Container(
                          height: 30,
                          child: Image(
                            image: AssetImage('assets/referral_img.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text('Referrals'),
                        onTap: () {}),
                    ListTile(
                      leading: Icon(Icons.share),
                      title: Text('Share this app'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.person_add_alt_1),
                      title: Text('Share My Profile'),
                      onTap: () {
                        createDynamicLink();

                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.star_border),
                      title: Text('Rate this app'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.note_alt_rounded),
                      title: Text('Privacy Policy'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Log Out'),
                      onTap: () {
                        Constants.myName = '';
                        FirebaseAuth.instance.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthScreen()));
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
