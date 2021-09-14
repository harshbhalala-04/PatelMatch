import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Movie { GujaratiCinema, HindiCinema, EnglishCinema, Others }

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  Movie? _reply;
  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('movie')) {
        if (val['movie'] == "Gujarati Cinema") {
          print('This is gujarati');
          setState(() {
            _reply = Movie.GujaratiCinema;
          });
        } else if (val['movie'] == "Hindi Cinema") {
          print('This is hindi');
          setState(() {
            _reply = Movie.HindiCinema;
          });
        } else if (val['movie'] == "English Cinema") {
          print('THis is english');
          setState(() {
            _reply = Movie.EnglishCinema;
          });
        } else if (val['movie'] == "Others") {
          print('This is others');
          setState(() {
            _reply = Movie.Others;
          });
        }
      } else {
         setState(() {
            _reply = Movie.GujaratiCinema;
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
            SizedBox(
              height: 20,
            ),
            Text(
              'What kind of movies do you prefer?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Movie.GujaratiCinema;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Movie.GujaratiCinema,
                    groupValue: _reply,
                    onChanged: (Movie? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Gujarati Cinema'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Movie.HindiCinema;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Movie.HindiCinema,
                    groupValue: _reply,
                    onChanged: (Movie? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Hindi Cinema'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Movie.EnglishCinema;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Movie.EnglishCinema,
                    groupValue: _reply,
                    onChanged: (Movie? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('English Cinema'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Movie.Others;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Movie.Others,
                    groupValue: _reply,
                    onChanged: (Movie? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Others'),
                ],
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
                if (_reply == Movie.GujaratiCinema) {
                  DataBaseMethods().addUserMovie("Gujarati Cinema");
                } else if (_reply == Movie.HindiCinema) {
                  DataBaseMethods().addUserMovie("Hindi Cinema");
                } else if (_reply == Movie.EnglishCinema) {
                  DataBaseMethods().addUserMovie("English Cinema");
                } else if (_reply == Movie.Others) {
                  DataBaseMethods().addUserMovie("Others");
                }

               Navigator.pop(context);
                      Navigator.popAndPushNamed(
                          context, EditProfileScreen.routeName);
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
