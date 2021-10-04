import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BookayController extends GetxController {
  final bookayCount = 0.obs;
  final User? user = FirebaseAuth.instance.currentUser;
  fetchBookayValue() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) async{
      bookayCount.value = await val['bookayAvailable'];
      print('This is bookay Value count function_____________________');
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchBookayValue();
    super.onInit();
  }
}
