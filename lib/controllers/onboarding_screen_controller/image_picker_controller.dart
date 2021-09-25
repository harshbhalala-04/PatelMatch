import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ImagePickerController extends GetxController {
  List<dynamic> tempImage = [].obs;
  final count = 0.obs;
  final isLoading = false.obs;
  String? imgUrl = '';
  File? _pickedImageVar;
  final newIndex = 0.obs;
  List<dynamic> image = [
      "https://firebasestorage.googleapis.com/v0/b/flutter-chat-572c9.appspot.com/o/user_image_picker%2Fadd_img2.png?alt=media&token=ad98c523-9dc7-4df1-b351-10697fc59af3",
      "https://firebasestorage.googleapis.com/v0/b/flutter-chat-572c9.appspot.com/o/user_image_picker%2Fadd_img2.png?alt=media&token=ad98c523-9dc7-4df1-b351-10697fc59af3",
      "https://firebasestorage.googleapis.com/v0/b/flutter-chat-572c9.appspot.com/o/user_image_picker%2Fadd_img2.png?alt=media&token=ad98c523-9dc7-4df1-b351-10697fc59af3",
      "https://firebasestorage.googleapis.com/v0/b/flutter-chat-572c9.appspot.com/o/user_image_picker%2Fadd_img2.png?alt=media&token=ad98c523-9dc7-4df1-b351-10697fc59af3",
      "https://firebasestorage.googleapis.com/v0/b/flutter-chat-572c9.appspot.com/o/user_image_picker%2Fadd_img2.png?alt=media&token=ad98c523-9dc7-4df1-b351-10697fc59af3",
      "https://firebasestorage.googleapis.com/v0/b/flutter-chat-572c9.appspot.com/o/user_image_picker%2Fadd_img2.png?alt=media&token=ad98c523-9dc7-4df1-b351-10697fc59af3",
    ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  
  void showCustomDialog() {
    Get.defaultDialog(
      middleText: "Plese Select At Least 1 Image",
      title: "",
      middleTextStyle: TextStyle(fontSize: 20),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Close'),
                style:
                    TextButton.styleFrom(textStyle: TextStyle(fontSize: 16))),
          ],
        )
      ],
      barrierDismissible: false,
    );
  }

  void pickImage(BuildContext context, int index) async {
    print('This is picked image controller : ${isLoading.value}');
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

    if (imageSource != null) {
      isLoading.toggle();

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
        isLoading.toggle();
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

        String url = await ref.getDownloadURL();
        // setState(() {
        //   _pickedImageVar = file;
        //   print(_pickedImageVar);
        //   _image[index] = url;
        //   newIndex = index;
        //   isLoading = false;
        //   tempImage.add(url);
        // });
        _pickedImageVar = file;
        image[index] = url;
        newIndex.value = index;
        isLoading.toggle();
        tempImage.add(url);
      }
    }
  }
}
