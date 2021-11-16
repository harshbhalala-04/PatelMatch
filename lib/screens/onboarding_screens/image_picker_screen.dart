import 'package:chat/controllers/onboarding_screen_controller/image_picker_controller.dart';

import 'package:chat/screens/onboarding_screens/birth_date_screen.dart';
import 'package:chat/database/database.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';



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
        title: Text('PM', style: TextStyle(color: Color.fromRGBO(255, 85, 115, 1), fontSize: 24),),
          centerTitle: true,
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
                                image: imagePickerController
                                        .isUploadedImage[index]
                                    ? DecorationImage(
                                        image: FileImage(imagePickerController
                                            .choosenImage[index]),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: AssetImage(
                                            imagePickerController.image[index]),
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
                  Get.to(BirthDateScreen(fromProfile: false));
                  DataBaseMethods()
                      .uploadUserImages(imagePickerController.tempImage,);
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
