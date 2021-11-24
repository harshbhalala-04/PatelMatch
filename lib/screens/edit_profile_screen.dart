import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/controllers/authController.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/screens/auth_screen.dart';
import 'package:chat/screens/onboarding_screens/NRI_screen.dart';
import 'package:chat/screens/onboarding_screens/birth_date_screen.dart';
import 'package:chat/screens/onboarding_screens/city_screen.dart';
import 'package:chat/screens/onboarding_screens/gotra_screen.dart';
import 'package:chat/screens/onboarding_screens/handicapped_screen.dart';
import 'package:chat/screens/onboarding_screens/manglic_screen.dart';
import 'package:chat/screens/onboarding_screens/marital_screen.dart';
import 'package:chat/screens/onboarding_screens/native_screen.dart';
import 'package:chat/screens/onboarding_screens/profile_createdBy_screen.dart';
import 'package:chat/screens/onboarding_screens/rashi_screen.dart';
import 'package:chat/screens/onboarding_screens/samaj_screen.dart';
import 'package:chat/screens/onboarding_screens/star_screen.dart';
import 'package:chat/screens/onboarding_screens/weight_screen.dart';
import 'package:chat/screens/user_profile_edit/drink_screen.dart';
import 'package:chat/screens/onboarding_screens/gender_screen.dart';
import 'package:chat/screens/user_profile_edit/height_screen.dart';
import 'package:chat/screens/user_profile_edit/salary_screen.dart';
import 'package:chat/screens/user_profile_edit/siblings_screen.dart';
import 'package:chat/screens/user_profile_edit/smoke_screen.dart';
import 'package:chat/screens/onboarding_screens/user_name_screen.dart';
import 'package:chat/screens/user_profile_edit/work_life_screen.dart';
import 'package:chat/widgets/filter_screen_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/editprofile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  List<dynamic> tempImage = [];

  TextEditingController _passwordController = new TextEditingController();

  int? imgCount;
  var imgUrls = ['', '', '', '', '', ''];

  bool isLoading = false;
  String? imgUrl;

  String? profileUrl = '';
  File? _pickedImageVar;
  var newIndex;

  /// Crop Image
  Future cropImage(File pickedImage) async {
    try {
      File? croppedFile = await ImageCropper.cropImage(
          sourcePath: pickedImage.path,
          aspectRatioPresets: Platform.isAndroid
              ? [
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio16x9
                ]
              : [
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio5x3,
                  CropAspectRatioPreset.ratio5x4,
                  CropAspectRatioPreset.ratio7x5,
                  CropAspectRatioPreset.ratio16x9
                ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              lockAspectRatio: false),
          compressQuality: 50,
          iosUiSettings: IOSUiSettings(
            title: 'Crop Image',
          ));
      if (croppedFile != null) {
        pickedImage = croppedFile;
      }
      return pickedImage;
    } catch (e) {
      print(e);
    }
  }

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

    print("Image source: $imageSource");

    if (imageSource != null) {
      setState(() {
        isLoading = true;
      });
      final _picker = ImagePicker();

      final PickedFile? pickedImageFile = await _picker.getImage(
        source: imageSource,
        imageQuality: 25,
      );
      if (pickedImageFile == null) {
        setState(() {
          isLoading = false;
        });
      } else {
        File file = File(pickedImageFile.path);
        file = await cropImage(file);
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
          Get.find<GlobalController>().currentAppuser.value.imgUrl = url;
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .update({"imgUrl": url});
        }
        List<String> listUrl = [];
        List<dynamic> prevImags = [];
        listUrl.add(url);
        int flag = 0;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get()
            .then((value) {
          prevImags = value.data()!['imgUrls'];
        });

        if (cntInfo == "NotIncCount") {
          prevImags[index] = url;
        } else {
          prevImags.add(url);
        }

        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .update({'imgUrls': prevImags});

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
          // newIndex = index;
          isLoading = false;
        });
      }
    }
  }

  void fetchUserImage() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
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
        // profileUrl = val['imgUrl'];
        for (i = 0; i < imgCount!; i++) {
          imgUrls[i] = val['imgUrls'][i];
          print(imgUrls[i]);
        }
      });
    });
  }

  final firebase = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  @override
  void initState() {
    fetchUserImage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("This is profile url: ${imgUrls[0]}");
    print("This is 2nd img:  ${imgUrls[1]}");
    
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
                                      : CachedNetworkImage(
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
                                      : CachedNetworkImage(
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
                child: FilterScreenCard(
                  title: 'Profile Created By',
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .profileCreatedBy ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .profileCreatedBy!,
                ),
                onTap: () {
                  Get.off(ProfileCreatedByScreen(
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .profileCreatedBy!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: 'Samaj',
                  subtitle:
                      Get.find<GlobalController>().currentAppuser.value.samaj ==
                              null
                          ? ' '
                          : Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .samaj!,
                ),
                onTap: () {
                  Get.off(SamajScreen(
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                                .currentAppuser
                                .value
                                .samaj ==
                            null
                        ? ' '
                        : Get.find<GlobalController>()
                            .currentAppuser
                            .value
                            .samaj!,
                  ));
                },
              ),
              InkWell(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    //leading: Text('Name'),
                    title: Text(
                      'Full Name',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    subtitle: Text(
                      Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .username!,
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
                  Get.off(UserNameScreen(
                    relation: ' ',
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .username!,
                  ));
                },
              ),
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
                        Get.find<GlobalController>()
                            .currentAppuser
                            .value
                            .gender!,
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
                    Get.off(GenderScreen(fromProfile: true));
                  }),
              InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Birthdate',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      subtitle: Get.find<GlobalController>()
                                  .currentAppuser
                                  .value
                                  .birthDate ==
                              "--"
                          ? Text('')
                          : Text(
                              Get.find<GlobalController>()
                                  .currentAppuser
                                  .value
                                  .birthDate!,
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
                    Get.off(BirthDateScreen(fromProfile: true));
                  }),
              InkWell(
                child: FilterScreenCard(
                  title: 'Weight',
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .weight ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .weight!,
                ),
                onTap: () {
                  Get.off(WeightScreen(
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .weight!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: 'Height',
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .height ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .height!,
                ),
                onTap: () {
                  Get.off(HeightScreen(
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .height!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: 'Handicapped',
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .handicapped ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .handicapped!,
                ),
                onTap: () {
                  Get.off(HandicappedScreen(
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .handicapped!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: 'Marital Status',
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .maritalStatus ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .maritalStatus!,
                ),
                onTap: () {
                  Get.off(MaritalScreen(
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .maritalStatus!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: 'NRI Status',
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .userNRI ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .userNRI!,
                ),
                onTap: () {
                  Get.off(NRIScreen(
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .userNRI!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: 'Current City of Residence',
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .currentCity ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .currentCity!,
                ),
                onTap: () {
                  Get.off(CityScreen(fromProfile: true));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: 'Star Sign',
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .star ==
                          null
                      ? ' '
                      : Get.find<GlobalController>().currentAppuser.value.star!,
                ),
                onTap: () {
                  Get.off(StarScreen(
                    fromProfile: true,
                    response:
                        Get.find<GlobalController>().currentAppuser.value.star!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: 'Rashi',
                  subtitle:
                      Get.find<GlobalController>().currentAppuser.value.rashi ==
                              null
                          ? ' '
                          : Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .rashi!,
                ),
                onTap: () {
                  Get.off(RashiScreen(
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .rashi!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: 'Gotra',
                  subtitle:
                      Get.find<GlobalController>().currentAppuser.value.gotra ==
                              null
                          ? ' '
                          : Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .gotra!,
                ),
                onTap: () {
                  Get.off(GotraScreen(
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .gotra!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: 'Manglik',
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .manglik ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .manglik!,
                ),
                onTap: () {
                  print(Get.find<GlobalController>()
                      .currentAppuser
                      .value
                      .manglik);
                  Get.off(ManglicScreen(
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                                .currentAppuser
                                .value
                                .manglik ==
                            null
                        ? ' '
                        : Get.find<GlobalController>()
                            .currentAppuser
                            .value
                            .manglik!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: 'Employment Status',
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .worklife ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .worklife!,
                ),
                onTap: () {
                  Get.off(WorkLifeScreen(
                    relation: ' ',
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                                .currentAppuser
                                .value
                                .worklife ==
                            null
                        ? ' '
                        : Get.find<GlobalController>()
                            .currentAppuser
                            .value
                            .worklife!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: 'Annual Income',
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .salary ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .salary!,
                ),
                onTap: () {
                  Get.off(SalaryScreen(
                    relation: ' ',
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .salary!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: 'Drinking Habits',
                  subtitle:
                      Get.find<GlobalController>().currentAppuser.value.drink ==
                              null
                          ? ' '
                          : Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .drink!,
                ),
                onTap: () {
                  Get.off(DrinkScreen(
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .drink!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: 'Smoking Habits',
                  subtitle:
                      Get.find<GlobalController>().currentAppuser.value.smoke ==
                              null
                          ? ' '
                          : Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .smoke!,
                ),
                onTap: () {
                  Get.off(SmokeScreen(
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .smoke!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: 'Number of Siblings',
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .siblings ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .siblings!,
                ),
                onTap: () {
                  Get.off(SiblingScreen());
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: "Father's Name",
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .fatherName ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .fatherName!,
                ),
                onTap: () {
                  Get.off(UserNameScreen(
                    relation: " Father",
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                                .currentAppuser
                                .value
                                .fatherName ==
                            null
                        ? ' '
                        : Get.find<GlobalController>()
                            .currentAppuser
                            .value
                            .fatherName!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: "Father's Native Place",
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .fatherNativePlace ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .fatherNativePlace!,
                ),
                onTap: () {
                  Get.off(NativeScreen(
                    relation: " Father's",
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                                .currentAppuser
                                .value
                                .fatherNativePlace ==
                            null
                        ? ' '
                        : Get.find<GlobalController>()
                            .currentAppuser
                            .value
                            .fatherNativePlace!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: "Father's Occupation",
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .fatherOccupation ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .fatherOccupation!,
                ),
                onTap: () {
                  Get.off(WorkLifeScreen(
                    relation: "Father's",
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                                .currentAppuser
                                .value
                                .fatherOccupation ==
                            null
                        ? ' '
                        : Get.find<GlobalController>()
                            .currentAppuser
                            .value
                            .fatherOccupation!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: "Father's Average Annual Income",
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .fatherAvgAnnualIncome ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .fatherAvgAnnualIncome!,
                ),
                onTap: () {
                  Get.off(SalaryScreen(
                    relation: "Father's",
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                                .currentAppuser
                                .value
                                .fatherAvgAnnualIncome ==
                            null
                        ? ' '
                        : Get.find<GlobalController>()
                            .currentAppuser
                            .value
                            .fatherAvgAnnualIncome!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: "Mother's Name",
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .motherName ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .motherName!,
                ),
                onTap: () {
                  Get.off(UserNameScreen(
                    relation: " Mother",
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                                .currentAppuser
                                .value
                                .motherName ==
                            null
                        ? ' '
                        : Get.find<GlobalController>()
                            .currentAppuser
                            .value
                            .motherName!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: "Mother's Native Place",
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .motherNativePlace ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .motherNativePlace!,
                ),
                onTap: () {
                  Get.off(NativeScreen(
                    relation: " Mother's",
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                                .currentAppuser
                                .value
                                .motherNativePlace ==
                            null
                        ? ' '
                        : Get.find<GlobalController>()
                            .currentAppuser
                            .value
                            .motherNativePlace!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: "Mother's Occupation",
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .motherOccupation ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .motherOccupation!,
                ),
                onTap: () {
                  Get.off(WorkLifeScreen(
                    relation: "Mother's",
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                                .currentAppuser
                                .value
                                .motherOccupation ==
                            null
                        ? ' '
                        : Get.find<GlobalController>()
                            .currentAppuser
                            .value
                            .motherOccupation!,
                  ));
                },
              ),
              InkWell(
                child: FilterScreenCard(
                  title: "Mother's Average Annual Income",
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .motherAvgAnnualIncome ==
                          null
                      ? ' '
                      : Get.find<GlobalController>()
                          .currentAppuser
                          .value
                          .motherAvgAnnualIncome!,
                ),
                onTap: () {
                  Get.off(SalaryScreen(
                    relation: "Mother's",
                    fromProfile: true,
                    response: Get.find<GlobalController>()
                                .currentAppuser
                                .value
                                .motherAvgAnnualIncome ==
                            null
                        ? ' '
                        : Get.find<GlobalController>()
                            .currentAppuser
                            .value
                            .motherAvgAnnualIncome!,
                  ));
                },
              ),
              TextButton(
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      content: Text(
                          "Do you want to delete your profile permanently?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          )),
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
                            Get.dialog(AlertDialog(
                              content:
                                  // Text('Please Enter Your password'),
                                  TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter Password',
                                ),
                                controller: _passwordController,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (_passwordController.text.isEmpty) {
                                        Get.snackbar(
                                            "Please Enter password", "",
                                            backgroundColor:
                                                Color.fromRGBO(255, 85, 115, 1),
                                            colorText: Colors.white);
                                        return;
                                      }
                                      Get.find<AuthController>().deleteUser(
                                          Get.find<GlobalController>()
                                              .currentAppuser
                                              .value
                                              .email!,
                                          _passwordController.text);
                                      // Get.off(AuthScreen());
                                    },
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ))
                              ],
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(255, 85, 115, 1)),
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
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/delete.svg'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Delete my profile',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 85, 115, 1),
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
