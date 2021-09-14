import 'package:chat/screens/custom_tab_bar.dart';

import '../helper/constants.dart';


import '../database/database.dart';
import 'package:flutter/material.dart';
import 'onboarding_screens/user_name_screen.dart';
import '../widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';


class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //9FirebaseAuth _auth = FirebaseAuth.instance;
  var _isLoading = false;
  File? userImage;

  QuerySnapshot? snapShotUserInfo;

  //get password => null;

  //Submit AuthCredential Function

  Future<void> submitLogin(String? email, String? password) async {
    try {
      setState(() {
        _isLoading = true;
      });

      UserCredential userCredential;
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      DataBaseMethods().getUserByEmailId(email);

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CustomTabs()));
    } on FirebaseAuthException catch (error) {
      String? message = 'An error occured, please check your credentials!';

      if (error.message != null) {
        message = error.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message!),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> submitSignup(
      String? email,
      String? password,
      /*String? username,*/
      /*File? image,*/ bool isLogin,
      BuildContext ctx) async {
    try {
      setState(() {
        _isLoading = true;
      });

      Constants.signUpState = true;
      UserCredential userCredential;
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

      

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        /*'username': username,*/
        'email': email,
        /*'imageUrl': url,*/
        'createdAt': Timestamp.now(),
        'uid': userCredential.user!.uid,
        'decline': false,
      });

      

      print(Constants.signUpState);
      print('This is a current state');
      print('Navigate to username screen');

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserNameScreen(fromProfile: false)));
    } on FirebaseAuthException catch (error) {
      String? message = 'An error occured, please check your credentials!';

      if (error.message != null) {
        message = error.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message!),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitSignup, _isLoading, submitLogin),
    );
  }
}
