import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/screens/onboarding_screens/samaj_screen.dart';
import 'package:chat/screens/onboarding_screens/user_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ProfileCreated { Self, Parents, Sibling, Relative, Friend }

class ProfileCreatedByScreen extends StatefulWidget {
  final bool fromProfile;
  String response;
  ProfileCreatedByScreen({required this.fromProfile, this.response = ''});

  @override
  _ProfileCreatedByScreenState createState() => _ProfileCreatedByScreenState();
}

class _ProfileCreatedByScreenState extends State<ProfileCreatedByScreen> {
  ProfileCreated? _reply;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.response == 'Self') {
      setState(() {
        _reply = ProfileCreated.Self;
      });
    } else if (widget.response == 'Parents') {
      setState(() {
        _reply = ProfileCreated.Parents;
      });
    } else if (widget.response == 'Sibling') {
      setState(() {
        _reply = ProfileCreated.Sibling;
      });
    } else if (widget.response == 'Relative') {
      setState(() {
        _reply = ProfileCreated.Relative;
      });
    } else if (widget.response == 'Friend') {
      setState(() {
        _reply = ProfileCreated.Friend;
      });
    } else {
      setState(() {
        _reply = ProfileCreated.Self;
      });
    }

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
                  Get.find<GlobalController>()
                      .currentAppuser
                      .value
                      .profileCreatedBy = 'Self';
                  DataBaseMethods().addUserProfileCreated("Self");
                } else if (_reply == ProfileCreated.Sibling) {
                  Get.find<GlobalController>()
                      .currentAppuser
                      .value
                      .profileCreatedBy = 'Sibling';
                  DataBaseMethods().addUserProfileCreated("Sibling");
                } else if (_reply == ProfileCreated.Relative) {
                  Get.find<GlobalController>()
                      .currentAppuser
                      .value
                      .profileCreatedBy = 'Relative';
                  DataBaseMethods().addUserProfileCreated("Relative");
                } else if (_reply == ProfileCreated.Parents) {
                  Get.find<GlobalController>()
                      .currentAppuser
                      .value
                      .profileCreatedBy = 'Parents';
                  DataBaseMethods().addUserProfileCreated("Parents");
                } else {
                  Get.find<GlobalController>()
                      .currentAppuser
                      .value
                      .profileCreatedBy = 'Friend';
                  DataBaseMethods().addUserProfileCreated("Friend");
                }

                if (widget.fromProfile) {
                  // Navigator.pop(context);
                  Get.off(EditProfileScreen());
                } else {
                  Get.to(SamajScreen(fromProfile: false,));
                }
              },
              child: widget.fromProfile
                  ? Text(
                      'Submit',
                      style: TextStyle(fontSize: 17),
                    )
                  : Text(
                      'Continue',
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
