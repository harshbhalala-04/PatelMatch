import 'package:chat/helper/constants.dart';
import 'package:chat/screens/custom_tab_bar.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


import './screens/auth_screen.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'controllers/bindings/authBinding.dart';
import 'screens/onboarding_screens/user_name_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
              return UserNameScreen(fromProfile: false);
            } else {
              //return HomeScreen();
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
      //home: FeedScreen(false),
      //home: CustomTabs(),
    );
  }
}
