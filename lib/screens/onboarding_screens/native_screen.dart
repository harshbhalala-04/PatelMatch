import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/screens/onboarding_screens/star_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NativeScreen extends StatefulWidget {
  final String relation;
  final bool fromProfile;
   String response;
  NativeScreen(
      {required this.relation,
      required this.fromProfile,
      this.response = ''});

  @override
  _NativeScreenState createState() => _NativeScreenState();
}

class _NativeScreenState extends State<NativeScreen> {
  TextEditingController _nativeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('PM', style: TextStyle(color: Color.fromRGBO(255, 85, 115, 1), fontSize: 24),),
          centerTitle: true,
        actions: [
          widget.fromProfile
              ? Container()
              : TextButton(
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    DataBaseMethods().addUserNative('');
                    Get.to(StarScreen(
                      fromProfile: false,
                    ));
                  },
                )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Add Your${widget.relation} Native Place',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nativeController,
                decoration: InputDecoration(
                  hintText: 'Start Typing...',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(width: 2),
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please Enter Your native place';
                  }
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
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: ElevatedButton(
              onPressed: () {
                if (widget.fromProfile) {
                  if (widget.relation == " Father's") {
                    final globalController = Get.put(GlobalController());
                    Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .fatherNativePlace = _nativeController.text;
                    DataBaseMethods().addFatherNative(_nativeController.text);
                  } else if (widget.relation == " Mother's") {
                    final globalController = Get.put(GlobalController());
                    Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .motherNativePlace = _nativeController.text;
                    DataBaseMethods().addMotherNative(_nativeController.text);
                  }
                  Get.off(EditProfileScreen());
                } else {
                  DataBaseMethods().addUserNative(_nativeController.text);
                  Get.to(StarScreen(
                    fromProfile: false,
                  ));
                }
              },
              child: widget.fromProfile
                  ? Text('Submit',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center)
                  : Text('Continue',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center),
              style: ButtonStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
