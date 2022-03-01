import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/global.dart';
import 'package:chat/screens/auth_screen.dart';
import 'package:chat/screens/custom_tab_bar.dart';
import 'package:chat/screens/onboarding_screens/profile_createdBy_screen.dart';
import 'package:chat/screens/onboarding_screens/user_name_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  final isLoading = false.obs;
  final isLogin = true.obs;
  final userEmailId = ''.obs;
  final loginState = false.obs;
  final userNri = ''.obs;
  final resetPass = false.obs;
  final isConfirm = false.obs;

  String? get user => firebaseUser.value?.email;

  final isPassVisible = true.obs;
  final isRePassVisible = true.obs;

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  sendPasswordRequest(email) async {
    await _auth.sendPasswordResetEmail(email: email).then((val) {
      Get.snackbar("Password Reset Email link has been sent", "");
    }).catchError((onError) {
      Get.snackbar("Error in email sent", onError.message);
    });
    resetPass.value = false;
    isLogin.value = true;
  }

  void toggleLoginStatus() {
    isLogin.toggle();
  }

  void toggolePasswordVisibility() {
    isPassVisible.toggle();
  }

  void toggoleRePasswordVisibility() {
    isRePassVisible.toggle();
  }

  void toggoleConfrimSwitch() {
    isConfirm.toggle();
  }

  void createUser(
    String? email,
    String? password,
    String? phoneNo,
  ) async {
    print('This is create user function of getx');
    UserCredential userCredential;
    isLoading.toggle();
    try {
      // Constants.signUpState = true;
      isSignup = true;
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('answers', false);
      late final days;
      await FirebaseFirestore.instance
          .collection("messageFreeTrial")
          .doc("7gQKNppDlLEEBEspspOc")
          .get()
          .then((val) {
        days = val.data()!['days'];
      });
      print(days);
      DateTime time = DateTime.now().add(Duration(days: days)); //DateTime
      Timestamp myTimeStamp = Timestamp.fromDate(time); //To TimeStamp

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'email': email,
        'freeTrial': false,
        'phoneNo': phoneNo,
        'createdAt': Timestamp.now(),
        'uid': userCredential.user!.uid,
        'bookayAvailable': 0,
        'isFieldAnswered': false,
        'isFilterApplied': false,
        'drink': '',
        'smoke': '',
        'salary': '',
        'friendRequest': FieldValue.arrayUnion([]),
        'excludedUsers': FieldValue.arrayUnion([]),
        'isRejected': false,
        'isApproved': false,
        'filters': {
          'age': FieldValue.arrayUnion([]),
          'drink': FieldValue.arrayUnion([]),
          'incomeRange': FieldValue.arrayUnion([]),
          'rashi': FieldValue.arrayUnion([]),
          'samaj': FieldValue.arrayUnion([]),
          'smoke': FieldValue.arrayUnion([]),
          'starSign': FieldValue.arrayUnion([]),
          'verifiedOnly': FieldValue.arrayUnion([]),
          'height': FieldValue.arrayUnion([]),
          'NRI': FieldValue.arrayUnion([]),
          'weight': FieldValue.arrayUnion([]),
        }
      });
    } on FirebaseAuthException catch (error) {
      print(error);
      Get.snackbar("Error Creating account", error.message!,
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.toggle();
  }

  void login(String? email, String? password) async {
    isLoading.toggle();
    try {
      isLoginVal = true;
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);

      userEmailId.value = email;
      // DataBaseMethods().getUserByEmailId();
      loginState.value = true;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('answers', true);
    } on FirebaseAuthException catch (error) {
      print(error);
      Get.snackbar("Error Logging in ", error.message!,
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.toggle();
  }

  Future deleteUser(String email, String password) async {
    try {
      User user = await _auth.currentUser!;
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      print(user);
      var result = await user.reauthenticateWithCredential(credentials);
      await DataBaseMethods().deleteuser(); // called from database class
      await result.user!.delete();
      Get.snackbar("Profile Deleted Successfully", "",
          backgroundColor: Color.fromRGBO(255, 85, 115, 1),
          colorText: Colors.white);
      Get.off(AuthScreen());
      return true;
    } catch (e) {
      Get.snackbar("Profile Couldn't Delete", e.toString(),
          backgroundColor: Color.fromRGBO(255, 85, 115, 1),
          colorText: Colors.white);
      print(e.toString());
      return null;
    }
  }
}

mixin FirebaseUser {}
