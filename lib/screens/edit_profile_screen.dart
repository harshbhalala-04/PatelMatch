import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/helper/constants.dart';
import 'package:chat/screens/onboarding_screens/birth_date_screen.dart';
import 'package:chat/screens/onboarding_screens/community_screen.dart';
import 'package:chat/screens/user_profile_edit/drink_screen.dart';
import 'package:chat/screens/user_profile_edit/education_screen.dart';
import 'package:chat/screens/onboarding_screens/gender_screen.dart';
import 'package:chat/screens/user_profile_edit/height_screen.dart';
import 'package:chat/screens/user_profile_edit/hometown_screen.dart';
import 'package:chat/screens/user_profile_edit/movie_screen.dart';
import 'package:chat/screens/user_profile_edit/political_screen.dart';
import 'package:chat/screens/user_profile_edit/salary_screen.dart';
import 'package:chat/screens/user_profile_edit/sign_screen.dart';
import 'package:chat/screens/user_profile_edit/smoke_screen.dart';
import 'package:chat/screens/onboarding_screens/user_name_screen.dart';
import 'package:chat/screens/user_profile_edit/work_life_screen.dart';
import 'package:chat/screens/user_profile_edit/workout_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/editprofile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  List<dynamic> tempImage = [];

  int? imgCount;
  var imgUrls = ['', '', '', '', '', ''];

  bool isLoading = false;
  String? imgUrl;

  File? _pickedImageVar;
  var newIndex;

  void _pickImage(int index, String cntInfo) async {
    ImageSource? imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Upload Your Image'),
        actions: [
          MaterialButton(
            child: Text('Camera'),
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            textColor: Theme.of(context).primaryColor,
          ),
          MaterialButton(
            child: Text('Gallery'),
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );

    setState(() {
      isLoading = true;
    });

    final _picker = ImagePicker();

    final PickedFile? pickedImageFile = await _picker.getImage(
      source: imageSource!,
      imageQuality: 25,
    );

    if (pickedImageFile == null) {
      setState(() {
        isLoading = false;
      });
    } else {
      final File file = File(pickedImageFile.path);

      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(user!.uid + 'folder')
          .child(user.uid + index.toString() + '.jpg');

      await ref.putFile(file).whenComplete(() => print('Image Upload'));

      final url = await ref.getDownloadURL();

      if (index == 0) {
        Constants.userImage = url;
        print('This is user image');
        print(Constants.userImage);
      }
      List<String> listUrl = [];
      listUrl.add(url);
      int flag = 0;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get()
          .then((value) {
        int prevImgCount = value['imgCount'];
        for (int i = 0; i < prevImgCount; i++) {
          if (index == i) {
            print('This is url before');
            print(value['imgUrls'][index]);
            value['imgUrls'][index] = url;
            print('This is the url after');
            print(url);
            print(value['imgUrls'][index]);
            flag = 1;
          }
        }
      });

      if (flag == 0) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .update({'imgUrls': FieldValue.arrayUnion(listUrl)});
      }

      if (cntInfo == "IncCount") {
        imgCount = (imgCount!) + 1;
      }

      FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update({'imgCount': imgCount});

      setState(() {
        _pickedImageVar = file;
        print(_pickedImageVar);
        imgUrls[index] = url;
        newIndex = index;
        isLoading = false;
      });
    }
  }

  void fetchUserImage() async {
    print('init state running');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      print('This is the data I got');
      print(val['imgCount']);
      imgCount = val['imgCount'];
      print(imgCount);
    });

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((val) {
      setState(() {
        int i;
        print('This is total image');
        print(imgCount);
        for (i = 0; i < imgCount!; i++) {
          imgUrls[i] = val['imgUrls'][i];
        }
      });
    });
  }

  final firebase = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  fetchUserDetails() {
    firebase.then((val) {
      final map = val.data();

      setState(() {
        Constants.myName = val['username'];
        if (map!.containsKey('birthDate')) {
          Constants.birthdate = val['birthDate'];
        }

        if (map.containsKey('gender')) {
          Constants.gender = val['gender'];
        }

        if (map.containsKey('community')) {
          Constants.community = val['community'];
        }

        if (map.containsKey('height')) {
          Constants.height = val['height'];
        }

        if (map.containsKey('workout')) {
          Constants.workout = val['workout'];
        }

        if (map.containsKey('salary')) {
          Constants.salary = val['salary'];
        }

        if (map.containsKey('drink')) {
          Constants.drink = val['drink'];
        }

        if (map.containsKey('smoke')) {
          Constants.smoke = val['smoke'];
        }

        if (map.containsKey('zodiacSign')) {
          Constants.zodiacSign = val['zodiacSign'];
        }

        if (map.containsKey('movie')) {
          Constants.movies = val['movie'];
        }

        if (map.containsKey('politics')) {
          Constants.politics = val['politics'];
        }
        if (map.containsKey('education')) {
          Constants.education = val['education'];
        }

        if (map.containsKey('worklife')) {
          Constants.worklife = val['worklife'];
        }
      });

      // print(Constants.myName);
      // print(Constants.birthdate);
      // print(Constants.gender);
      // print(Constants.community);
      // print(Constants.height);
      // print(Constants.workout);
      // print(Constants.salary);
      // print(Constants.drink);
      // print(Constants.smoke);
      // print(Constants.zodiacSign);
      //print(Constants.politics);
      //print(Constants.movies);
    });
  }

  fetchUserName() {
    print('This is username by updating!');
    firebase.then((val) {
      setState(() {
        Constants.myName = val['username'];
        print(Constants.myName);
      });
    });
  }

  @override
  void initState() {
    fetchUserImage();
    fetchUserDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    isLoading
                        ? SizedBox(
                            width: 150,
                          )
                        : InkWell(
                            onTap: () {
                              if (imgUrls[0] == '') {
                                _pickImage(0, "IncCount");
                              } else {
                                _pickImage(0, "NotIncCount");
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 90,
                                  height: 90,
                                  child: imgUrls[0] == ''
                                      ? Image(
                                          image:
                                              AssetImage('assets/add_img2.png'),
                                          fit: BoxFit.cover,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: imgUrls[0],
                                          fit: BoxFit.cover,
                                        )),
                            ),
                          ),
                    isLoading
                        ? CircularProgressIndicator()
                        : InkWell(
                            onTap: () {
                              if (imgUrls[1] == '') {
                                _pickImage(1, "IncCount");
                              } else {
                                _pickImage(1, "NotIncCount");
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 90,
                                  height: 90,
                                  child: imgUrls[1] == ''
                                      ? Image(
                                          image:
                                              AssetImage('assets/add_img2.png'),
                                          fit: BoxFit.cover,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: imgUrls[1],
                                          fit: BoxFit.cover,
                                        )),
                            ),
                          ),
                    isLoading
                        ? Container()
                        : InkWell(
                            onTap: () {
                              if (imgUrls[2] == '') {
                                _pickImage(2, "IncCount");
                              } else {
                                _pickImage(2, "NotIncCount");
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 90,
                                  height: 90,
                                  child: imgUrls[2] == ''
                                      ? Image(
                                          image:
                                              AssetImage('assets/add_img2.png'),
                                          fit: BoxFit.cover,
                                        )
                                      :CachedNetworkImage(
                                          imageUrl: imgUrls[2],
                                          fit: BoxFit.cover,
                                        )),
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    isLoading
                        ? Container()
                        : InkWell(
                            onTap: () {
                              if (imgUrls[3] == '') {
                                _pickImage(3, "IncCount");
                              } else {
                                _pickImage(3, "NotIncCount");
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 90,
                                  height: 90,
                                  child: imgUrls[3] == ''
                                      ? Image(
                                          image:
                                              AssetImage('assets/add_img2.png'),
                                          fit: BoxFit.cover,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: imgUrls[3],
                                          fit: BoxFit.cover,
                                        )),
                            ),
                          ),
                    isLoading
                        ? Container()
                        : InkWell(
                            onTap: () {
                              if (imgUrls[4] == '') {
                                _pickImage(4, "IncCount");
                              } else {
                                _pickImage(4, "NotIncCount");
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 90,
                                  height: 90,
                                  child: imgUrls[4] == ''
                                      ? Image(
                                          image:
                                              AssetImage('assets/add_img2.png'),
                                          fit: BoxFit.cover,
                                        )
                                      :CachedNetworkImage(
                                          imageUrl: imgUrls[4],
                                          fit: BoxFit.cover,
                                        )),
                            ),
                          ),
                    isLoading
                        ? Container()
                        : InkWell(
                            onTap: () {
                              if (imgUrls[5] == '') {
                                _pickImage(5, "IncCount");
                              } else {
                                _pickImage(5, "NotIncCount");
                              }
                            },
                            child: Container(
                                width: 90,
                                height: 90,
                                child: imgUrls[5] == ''
                                    ? Image(
                                        image:
                                            AssetImage('assets/add_img2.png'),
                                        fit: BoxFit.cover,
                                      )
                                    : CachedNetworkImage(
                                          imageUrl: imgUrls[5],
                                          fit: BoxFit.cover,
                                        )),
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'People with photos have a higher probability of recieving chat requests!',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    //leading: Text('Name'),
                    title: Text(
                      'Name',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    subtitle: Text(
                      Constants.myName,
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    trailing: Icon(
                      Icons.arrow_right,
                      color: Colors.pink,
                      size: 30,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => UserNameScreen(fromProfile: true)));
                },
              ),
              InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Birthdate',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      subtitle: Constants.birthdate == "--"
                          ? Text('')
                          : Text(
                              Constants.birthdate,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black87),
                            ),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) =>
                                BirthDateScreen(fromProfile: true)));
                  }),
              InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Gender',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      subtitle: Text(
                        Constants.gender,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GenderScreen(fromProfile: true)));
                  }),
              InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Community',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      subtitle: Text(
                        Constants.community,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CommunityScreen(fromProfile: true)));
                  }),
              InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Height',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      subtitle: Text(
                        Constants.height,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => HeightScreen()));
                  }),
              InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Workout',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      subtitle: Text(
                        Constants.workout,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorkoutScreen()));
                  }),
              InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Education',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      subtitle: Text(
                        Constants.education,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EducationScreen()));
                  }),
              InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Worklife',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      subtitle: Text(
                        Constants.worklife,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorkLifeScreen()));
                  }),
              InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Salary',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      subtitle: Text(
                        Constants.salary,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SalaryScreen()));
                  }),
              InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Drink',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      subtitle: Text(
                        Constants.drink,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DrinkScreen()));
                  }),
              InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Smoke',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      subtitle: Text(
                        Constants.smoke,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SmokeScreen()));
                  }),
              InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Zodiac Sign',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      subtitle: Text(
                        Constants.zodiacSign,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignScreen()));
                  }),
              InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Politics',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      subtitle: Text(
                        Constants.politics,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PoliticalScreen()));
                  }),
              InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Movies',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      subtitle: Text(
                        Constants.movies,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MovieScreen()));
                  }),
              InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Hometown',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      subtitle: Text(
                        Constants.hometown,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HometownScreen()));
                  }),
              InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Current location',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      subtitle: Text(
                        Constants.currentLocation,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
