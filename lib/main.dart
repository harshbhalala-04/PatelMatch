import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat/helper/constants.dart';
import 'package:chat/screens/custom_tab_bar.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/screens/onboarding_screens/NRI_screen.dart';
import 'package:chat/screens/onboarding_screens/birth_date_screen.dart';
import 'package:chat/screens/onboarding_screens/gender_screen.dart';
import 'package:chat/screens/onboarding_screens/handicapped_screen.dart';
import 'package:chat/screens/onboarding_screens/image_picker_screen.dart';
import 'package:chat/screens/onboarding_screens/marital_screen.dart';
import 'package:chat/screens/onboarding_screens/profile_createdBy_screen.dart';
import 'package:chat/screens/onboarding_screens/samaj_screen.dart';
import 'package:chat/screens/onboarding_screens/weight_screen.dart';
import 'package:chat/screens/onboarding_screens/willing_to_marry_screen.dart';
import 'package:chat/screens/single_user_profile.dart';
import 'package:chat/screens/user_profile_edit/height_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'controllers/bindings/authBinding.dart';
import 'screens/onboarding_screens/user_name_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'notificationHandler.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // App is terminated
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // App is closed but not terminated(It is inside RAM)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    await handleNetworkNotification(message);
  });

  // App is opened
  FirebaseMessaging.onMessageOpenedApp.listen((message) async {});

  initializeLocalNotification();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

String? findEmail;
String? profileCreatedBy;
String? samaj;
String? willingToMarryFrom;
String? fullName;
String? gender;
String? photo;
String? dob;
String? weight;
String? height;
String? handicapped;
String? maritalStatus;
String? nri;

class _MyAppState extends State<MyApp> {
  String path = '';
  String uid = '';
  @override
  void initState() {
    // TODO: implement initState
    initDynamicLinks();
    AwesomeNotifications().actionStream.listen((receivedNotification) async {
      await handleNotificationRouting(message: receivedNotification.payload!);
    });
    // getValidationData().whenComplete(() async {
    //   if (findEmail == null) {
    //     Get.to(AuthScreen());
    //   } else if (profileCreatedBy == null) {
    //     Get.to(ProfileCreatedByScreen(fromProfile: false));
    //   } else if (samaj == null) {
    //     Get.to(SamajScreen(fromProfile: false));
    //   } else if (willingToMarryFrom == null) {
    //     Get.to(WillingToMarryScreen());
    //   } else if (fullName == null) {
    //     Get.to(UserNameScreen(
    //       relation: ' ',
    //       fromProfile: false,
    //     ));
    //   } else if (gender == null) {
    //     Get.to(GenderScreen(fromProfile: false));
    //   } else if (photo == null) {
    //     Get.to(ImagePickerScreen());
    //   } else if (dob == null) {
    //     Get.to(BirthDateScreen(fromProfile: false));
    //   } else if (weight == null) {
    //     Get.to(WeightScreen(fromProfile: false));
    //   } else if (height == null) {
    //     Get.to(HeightScreen(fromProfile: false));
    //   } else if (handicapped == null) {
    //     Get.to(HandicappedScreen(fromProfile: false));
    //   } else if (maritalStatus == null) {
    //     Get.to(MaritalScreen(fromProfile: false));
    //   } else if (nri == null) {
    //     Get.to(NRIScreen(fromProfile: false));
    //   } else {
    //     Get.to(CustomTabBar());
    //   }
    // });
    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    var obtainedProfileCreatedBy =
        sharedPreferences.getString('profileCreatedBy');
    var obtainedSamaj = sharedPreferences.getString('samaj');
    var obtainedWillingToMarry = sharedPreferences.getString('marryToSamaj');
    var obtainedName = sharedPreferences.getString('username');
    var obGender = sharedPreferences.getString('gender');
    var obPhoto = sharedPreferences.getString('imgUrl');
    var obDob = sharedPreferences.getString('birthdate');
    var obWeight = sharedPreferences.getString('weight');
    var obHeight = sharedPreferences.getString('height');
    var obHandicapped = sharedPreferences.getString('handicapped');
    var obMaritalStatus = sharedPreferences.getString('maritalStatus');
    var obNRI = sharedPreferences.getString('NRI');
    setState(() {
      findEmail = obtainedEmail;
      profileCreatedBy = obtainedProfileCreatedBy;
      samaj = obtainedSamaj;
      willingToMarryFrom = obtainedWillingToMarry;
      fullName = obtainedName;
      gender = obGender;
      photo = obPhoto;
      dob = obDob;
      weight = obWeight;
      height = obHeight;
      handicapped = obHandicapped;
      maritalStatus = obMaritalStatus;
      nri = obNRI;
    });
  }

  void initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      uid = deepLink.path.substring(1);

      Get.to(SingleUserProfile(uid: uid));
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        uid = deepLink.path.substring(1);

        Get.to(SingleUserProfile(uid: uid));
      }
    }, onError: (OnLinkErrorException e) async {
      print(e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: Colors.pink,
        accentColor: Colors.purple,
        fontFamily: 'Cabin',
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),

    

      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            if (Constants.signUpState) {
              return ProfileCreatedByScreen(
                fromProfile: false,
              );
            } else {
              return CustomTabBar();
            }
          } else {
            return AuthScreen();
          }
        },
      ),
      routes: {
        EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
      },
    );
  }
}
