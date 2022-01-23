import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BirthDateController extends GetxController {
  final dd = 'DD'.obs;
  final mm = 'MM'.obs;
  final yyyy = 'YYYY'.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('dd')) {
        dd.value = val['dd'];
        mm.value = val['mm'];
        yyyy.value = val['yyyy'];
      }
    });
    super.onInit();
  }

  void showDialog() {
    Get.defaultDialog(
      middleText: "Please Select Your Birth Date.",
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

  void showDatePickerDailog(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime(DateTime.now().year - 21),
            firstDate: DateTime(1940),
            lastDate: DateTime(DateTime.now().year - 21))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        dd.value = pickedDate.day.toString();
        mm.value = pickedDate.month.toString();
        yyyy.value = pickedDate.year.toString();
      }
    });
  }
}
