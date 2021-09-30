// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FileController extends GetxController {
  
  /// Choose Image File
  Future chooseImageFile(ImageSource source, File pickedImage) async {
    ImagePicker _picker = ImagePicker();
    try {
      final newImage = await _picker
          .getImage(
              imageQuality: 90, source: source, maxWidth: 1000, maxHeight: 1000)
          .then((image) async {
        if (image != null) {
          pickedImage = await cropImage(File(image.path));
          return pickedImage;
        }
      });
      return newImage;
    } catch (e) {
      print(e);
    }
  }

  /// Upload File to Storage
  Future<String> uploadFile(dynamic image, String mimeType, String path) async {
    Reference storageReference = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = storageReference.putFile(image);
    String newFileUrl = '';
    await (await uploadTask).ref.getDownloadURL().then((fileUrl) async {
      newFileUrl = fileUrl;
    });
    return newFileUrl;
  }

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
}
