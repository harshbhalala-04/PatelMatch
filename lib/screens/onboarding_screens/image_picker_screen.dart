import 'package:chat/controllers/image_picker_controller.dart';
import 'package:chat/helper/constants.dart';
import 'package:chat/screens/onboarding_screens/birth_date_screen.dart';
import 'package:chat/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagePickerScreen extends StatelessWidget {
  final imagePickerController = Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    //print('This is isLoading value: ${controller.isLoading.value}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
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
            Obx(
              () => (imagePickerController.isLoading.value)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: GridView.builder(
                        itemCount: imagePickerController.image.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              imagePickerController.pickImage(context, index);
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    imagePickerController.image[index],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
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
                if (imagePickerController.tempImage.length < 1) {
                  imagePickerController.showCustomDialog();
                } else {
                  imagePickerController.imgUrl =
                      imagePickerController.tempImage[0];
                  Constants.userImage = imagePickerController.imgUrl!;
                  DataBaseMethods().addUserImage(imagePickerController.imgUrl!);
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final User? user = auth.currentUser;
                  for (int i = 0;
                      i < imagePickerController.tempImage.length;
                      i++) {
                    List<String>? temp = [];
                    temp.add(imagePickerController.tempImage[i]);
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(user!.uid)
                        .update({'imgUrls': FieldValue.arrayUnion(temp)});
                  }
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(user!.uid)
                      .update(
                          {'imgCount': imagePickerController.tempImage.length});
                  Get.to(BirthDateScreen(fromProfile: false));
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
