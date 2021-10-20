import 'package:chat/database/database.dart';
import 'package:chat/helper/constants.dart';
import 'package:chat/screens/custom_tab_bar.dart';
import 'package:chat/screens/onboarding_screens/profile_createdBy_screen.dart';
import 'package:chat/screens/onboarding_screens/user_name_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  final isLoading = false.obs;
  final isLogin = true.obs;

  String? get user => firebaseUser.value?.email;

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  void toggleLoginStatus() {
    isLogin.toggle();
  }

  void createUser(String? email, String? password) async {
    print('This is create user function of getx');
    UserCredential userCredential;
    isLoading.toggle();
    try {
      Constants.signUpState = true;
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'email': email,
        'createdAt': Timestamp.now(),
        'uid': userCredential.user!.uid,
        'bookayAvailable': 5,
        'isFieldAnswered': false,
        'filters': {
          'age': FieldValue.arrayUnion([]),
          'drink': FieldValue.arrayUnion([]),
          'incomeRange': FieldValue.arrayUnion([]),
          'rashi': '',
          'samaj': '',
          'smoke': '',
          'starSign': '',
          'verifiedOnly': false,
          'weight': FieldValue.arrayUnion([]),
        }
      });
      Get.off(ProfileCreatedByScreen());
    } on FirebaseAuthException catch (error) {
      Get.snackbar("Error Creating account", error.message!,
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.toggle();
    
  }

  void login(String? email, String? password) async {
    print('This is login function of getx');
    isLoading.toggle();
    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      DataBaseMethods().getUserByEmailId(email);
      Get.off(CustomTabBar());
    } on FirebaseAuthException catch (error) {
      Get.snackbar("Error Logging in ", error.message!,
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.toggle();
  }
}
