import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  _SignScreenState createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  List<DropdownMenuItem<String>> zodiacSigns = [
    DropdownMenuItem(
      value: "Aries",
      child: Text('Aries'),
    ),
    DropdownMenuItem(
      value: "Taurus",
      child: Text('Taurus'),
    ),
    DropdownMenuItem(
      value: "Gemini",
      child: Text('Gemini'),
    ),
    DropdownMenuItem(
      value: "Cancer",
      child: Text('Cancer'),
    ),
    DropdownMenuItem(
      value: "Leo",
      child: Text('Leo'),
    ),
    DropdownMenuItem(
      value: "Virgo",
      child: Text('Virgo'),
    ),
    DropdownMenuItem(
      value: "Libra",
      child: Text('Libra'),
    ),
    DropdownMenuItem(
      value: "Scorpio",
      child: Text('Scorpio'),
    ),
    DropdownMenuItem(
      value: "Sagittarius",
      child: Text('Sagittarius'),
    ),
    DropdownMenuItem(
      value: "Capricorn",
      child: Text('Capricorn'),
    ),
    DropdownMenuItem(
      value: "Aquarius",
      child: Text('Aquarius'),
    ),
    DropdownMenuItem(
      value: "Pisces",
      child: Text('Pisces'),
    ),
  ];



  String? reply = '';

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('zodiacSign')) {
        setState(() {
                  reply = val['zodiacSign'];

        });
      }
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'What is your Zodiac Sign?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: SearchableDropdown.single(
                hint: reply == ''
                    ? Text(
                        'Select',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                    : Text(
                        reply!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                //value: reply == '' ? Text('') : Text(reply!),
                displayClearIcon: false,
                isExpanded: true,
                items: zodiacSigns,
                onChanged: (val) {
                  reply = val;
                  print(reply);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                if (reply == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Please Select Your Zodiac Sign.'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close')),
                          ],
                        );
                      });
                } else {
                  DataBaseMethods().addUserZodiacSign(reply!);
      
                  Navigator.pop(context);
                      Navigator.popAndPushNamed(
                          context, EditProfileScreen.routeName);
                }
              },
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 17),
              ),
              style: ButtonStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
