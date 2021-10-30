import 'package:chat/database/database.dart';
import 'package:chat/screens/onboarding_screens/samaj_screen.dart';
import 'package:chat/screens/onboarding_screens/user_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ProfileCreated { Self, Parents, Sibling, Relative, Friend }

class ProfileCreatedByScreen extends StatefulWidget {
  const ProfileCreatedByScreen({Key? key}) : super(key: key);

  @override
  _ProfileCreatedByScreenState createState() => _ProfileCreatedByScreenState();
}

class _ProfileCreatedByScreenState extends State<ProfileCreatedByScreen> {
  ProfileCreated? _reply;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _reply = ProfileCreated.Self;
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Profile Created By',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _reply = ProfileCreated.Self;
                  });
                },
                child: Row(
                  children: [
                    Radio(
                      value: ProfileCreated.Self,
                      groupValue: _reply,
                      onChanged: (ProfileCreated? value) {
                        setState(() {
                          _reply = value!;
                        });
                      },
                    ),
                    Text('Self'),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _reply = ProfileCreated.Parents;
                  });
                },
                child: Row(
                  children: [
                    Radio(
                      value: ProfileCreated.Parents,
                      groupValue: _reply,
                      onChanged: (ProfileCreated? value) {
                        setState(() {
                          _reply = value!;
                        });
                      },
                    ),
                    Text('Parents'),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _reply = ProfileCreated.Sibling;
                  });
                },
                child: Row(
                  children: [
                    Radio(
                      value: ProfileCreated.Sibling,
                      groupValue: _reply,
                      onChanged: (ProfileCreated? value) {
                        setState(() {
                          _reply = value!;
                        });
                      },
                    ),
                    Text('Sibling'),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _reply = ProfileCreated.Relative;
                  });
                },
                child: Row(
                  children: [
                    Radio(
                      value: ProfileCreated.Relative,
                      groupValue: _reply,
                      onChanged: (ProfileCreated? value) {
                        setState(() {
                          _reply = value!;
                        });
                      },
                    ),
                    Text('Relative'),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _reply = ProfileCreated.Friend;
                  });
                },
                child: Row(
                  children: [
                    Radio(
                      value: ProfileCreated.Friend,
                      groupValue: _reply,
                      onChanged: (ProfileCreated? value) {
                        setState(() {
                          _reply = value!;
                        });
                      },
                    ),
                    Text('Friend'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                if (_reply == ProfileCreated.Self) {
                  DataBaseMethods().addUserProfileCreated("Self");
                } else if (_reply == ProfileCreated.Sibling) {
                  DataBaseMethods().addUserProfileCreated("Sibling");
                } else if (_reply == ProfileCreated.Relative) {
                  DataBaseMethods().addUserProfileCreated("Relative");
                } else if (_reply == ProfileCreated.Parents) {
                  DataBaseMethods().addUserProfileCreated("Parents");
                } else {
                  DataBaseMethods().addUserProfileCreated("Friend");
                }

                Get.to(SamajScreen());
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
