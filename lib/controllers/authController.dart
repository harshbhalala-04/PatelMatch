import 'package:chat/database/database.dart';
import 'package:chat/helper/constants.dart';
import 'package:chat/screens/custom_tab_bar.dart';
import 'package:chat/screens/onboarding_screens/profile_createdBy_screen.dart';
import 'package:chat/screens/onboarding_screens/user_name_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  String? get user => firebaseUser.value?.email;

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

  void createUser(String? email, String? password) async {
    print('This is create user function of getx');
    UserCredential userCredential;
    isLoading.toggle();
    try {
      Constants.signUpState = true;
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      // final SharedPreferences sharedPreferences =
      //     await SharedPreferences.getInstance();
      // sharedPreferences.setString('email', email);

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('answers', false);

      DateTime time = DateTime.now().add(Duration(days: 1)); //DateTime
      Timestamp myTimeStamp = Timestamp.fromDate(time); //To TimeStamp

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'email': email,
        'freeTrial': false,
        'createdAt': Timestamp.now(),
        'uid': userCredential.user!.uid,
        'bookayAvailable': 5,
        'isFieldAnswered': false,
        'isFilterApplied': false,
        'drink': '',
        'smoke': '',
        'salary': '',
        'friendRequest': FieldValue.arrayUnion([]),
        'excludedUsers': FieldValue.arrayUnion([]),
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
      // Get.off(ProfileCreatedByScreen(
      //   fromProfile: false,
      // ));
    } on FirebaseAuthException catch (error) {
      print(error);
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
      userEmailId.value = email;
      DataBaseMethods().getUserByEmailId();
      loginState.value = true;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(Get.find<AuthController>().firebaseUser.value!.uid)
          .get()
          .then((val) {
        userNri.value = val.data()!['userNRI'];
        print("______________");
        print(userNri);
      });
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('login', true);
      Get.off(CustomTabBar());
    } on FirebaseAuthException catch (error) {
      print(error);
      Get.snackbar("Error Logging in ", error.message!,
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.toggle();
  }
}
