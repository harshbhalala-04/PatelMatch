import 'package:chat/helper/constants.dart';
import 'package:chat/screens/onboarding_screens/birth_date_screen.dart';
import 'package:chat/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  List<dynamic> _image = [
    "https://icons-for-free.com/iconfiles/png/512/add+photo+instagram+upload+icon-1320184027593509107.png",
    "https://icons-for-free.com/iconfiles/png/512/add+photo+instagram+upload+icon-1320184027593509107.png",
    "https://icons-for-free.com/iconfiles/png/512/add+photo+instagram+upload+icon-1320184027593509107.png",
    "https://icons-for-free.com/iconfiles/png/512/add+photo+instagram+upload+icon-1320184027593509107.png",
    "https://icons-for-free.com/iconfiles/png/512/add+photo+instagram+upload+icon-1320184027593509107.png",
    "https://icons-for-free.com/iconfiles/png/512/add+photo+instagram+upload+icon-1320184027593509107.png",
  ];
  List<dynamic> tempImage = [];
  int count = 0;

  bool isLoading = false;
  String? imgUrl;

  File? _pickedImageVar;
  var newIndex;

  @override
  void initState() {
    super.initState();
  }

  void _pickImage(int index) async {
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

    print(imageSource);
    print('This is imageSource i got');

    if (imageSource != null) {
      setState(() {
        isLoading = true;
      });

      final _picker = ImagePicker();

      final PickedFile? pickedImageFile = await _picker.getImage(
        source: imageSource,
        imageQuality: 50,
        maxWidth: 1400,
        maxHeight: 1400,
      );

      print(pickedImageFile.toString());
      print('This is picked image file');

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

        print(ref);
        print('This is image reference');

        await ref.putFile(file).whenComplete(() => print('Image Upload'));

        String url = await ref.getDownloadURL();
        // List<String>? listUrl;
        // listUrl!.add(url);
        // if (count == 0) {
        //   FirebaseFirestore.instance
        //       .collection("users")
        //       .doc(user.uid)
        //       .update({count.toString(): url});
        // } else {
        //   FirebaseFirestore.instance
        //       .collection("users")
        //       .doc(user.uid)
        //       .update({count.toString(): url});
        // }

        // if (count == 0) {
        //   DataBaseMethods().addUserImage(url);
        // }
        // FirebaseFirestore.instance
        //     .collection("users")
        //     .doc(user.uid)
        //     .update({'imgUrls': FieldValue.arrayUnion(listUrl)});

        // count = count + 1;
        // FirebaseFirestore.instance
        //     .collection("users")
        //     .doc(user.uid)
        //     .update({'imgCount': count});

        setState(() {
          _pickedImageVar = file;
          print(_pickedImageVar);
          _image[index] = url;
          newIndex = index;
          isLoading = false;
          tempImage.add(url);
        });
      }
    }
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              'Hi, add some photos of yourself!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'People with photos get 2x more interactions!',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Minimum 1 photo is required!',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              height: 10,
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: GridView.builder(
                      itemCount: _image.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            _pickImage(index);
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  _image[index],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                if (tempImage.length < 1) {
                  // Fluttertoast.showToast(
                  //     msg: "Please Select at least 1 photo.",
                  //     toastLength: Toast.LENGTH_SHORT,
                  //     gravity: ToastGravity.SNACKBAR,
                  //     timeInSecForIosWeb: 1,
                  //     backgroundColor: Colors.white,
                  //     textColor: Colors.black,
                  //     fontSize: 16.0);

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Please Select At least 1 photo'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Okay')),
                          ],
                        );
                      });
                } else {
                  imgUrl = tempImage[0];

                  Constants.userImage = imgUrl!;
                  DataBaseMethods().addUserImage(imgUrl!);
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final User? user = auth.currentUser;
                  for (int i = 0; i < tempImage.length; i++) {
                    List<String>? temp = [];
                    temp.add(tempImage[i]);
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(user!.uid)
                        .update(
                            {'imgUrls': FieldValue.arrayUnion(temp)});
                  }
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(user!.uid)
                      .update({'imgCount': tempImage.length});
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => BirthDateScreen(
                                fromProfile: false,
                              )));
                }
              },
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 17),
              ),
              style: ButtonStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
