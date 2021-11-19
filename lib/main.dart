import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat/controllers/authController.dart';
import 'package:chat/global.dart';
import 'package:chat/screens/custom_tab_bar.dart';
import 'package:chat/screens/edit_profile_screen.dart';

import 'package:chat/screens/onboarding_screens/profile_createdBy_screen.dart';
import 'package:chat/screens/onboarding_screens/samaj_screen.dart';

import 'package:chat/screens/single_user_profile.dart';

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
import 'screens/onboarding_screens/NRI_screen.dart';
import 'screens/onboarding_screens/birth_date_screen.dart';
import 'screens/onboarding_screens/gender_screen.dart';
import 'screens/onboarding_screens/handicapped_screen.dart';
import 'screens/onboarding_screens/image_picker_screen.dart';
import 'screens/onboarding_screens/marital_screen.dart';
import 'screens/onboarding_screens/user_name_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'notificationHandler.dart';
import 'screens/onboarding_screens/weight_screen.dart';
import 'screens/onboarding_screens/willing_to_marry_screen.dart';
import 'screens/user_profile_edit/height_screen.dart';

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
bool? answer;
bool? loginState;
int flag = 0;
int fnWorks = 0;

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
    // getValidationData();

    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    // print("Future : ${sharedPreferences.getBool('answers')}");

    setState(() {
      loginState = sharedPreferences.getBool('login');
      answer = sharedPreferences.getBool('answers');
      findEmail = sharedPreferences.getString('email');
      profileCreatedBy = sharedPreferences.getString('profileCreatedBy');
      samaj = sharedPreferences.getString('samaj');
      willingToMarryFrom = sharedPreferences.getString('marryToSamaj');
      fullName = sharedPreferences.getString('username');
      gender = sharedPreferences.getString('gender');
      photo = sharedPreferences.getString('imgUrl');
      dob = sharedPreferences.getString('birthdate');
      weight = sharedPreferences.getString('weight');
      height = sharedPreferences.getString('height');
      handicapped = sharedPreferences.getString('handicapped');
      maritalStatus = sharedPreferences.getString('maritalStatus');
      // nri = obNRI;
      flag = 1;
    });
  }

  void initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      uid = deepLink.path.substring(1);

      Get.to(SingleUserProfile(uid: uid, fromDynamic: true));
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        uid = deepLink.path.substring(1);

        Get.to(SingleUserProfile(
          uid: uid,
          fromDynamic: true,
        ));
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
            if (isSignup) {
              return ProfileCreatedByScreen(fromProfile: false,);
            } else {
              return CustomTabBar();
              // if (answer == null || answer == false) {
              //   print("On boarding screens");
              //   if (profileCreatedBy == null) {
              //     return ProfileCreatedByScreen(fromProfile: false);
              //   } else if (samaj == null) {
              //     return SamajScreen(fromProfile: false);
              //   } else if (willingToMarryFrom == null) {
              //     return WillingToMarryScreen();
              //   } else if (fullName == null) {
              //     return UserNameScreen(relation: '', fromProfile: false);
              //   } else if (photo == null) {
              //     return ImagePickerScreen();
              //   } else if (dob == null) {
              //     return BirthDateScreen(fromProfile: false);
              //   } else if (gender == null) {
              //     return GenderScreen(fromProfile: false);
              //   } else if (weight == null) {
              //     return WeightScreen(fromProfile: false);
              //   } else if (height == null) {
              //     return HeightScreen(fromProfile: false);
              //   } else if (handicapped == null) {
              //     return HandicappedScreen(fromProfile: false);
              //   } else if (maritalStatus == null) {
              //     return MaritalScreen(fromProfile: false);
              //   } else {
              //     return NRIScreen(fromProfile: false);
              //   }
              // } else {
              //   return CustomTabBar();
              // }
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
