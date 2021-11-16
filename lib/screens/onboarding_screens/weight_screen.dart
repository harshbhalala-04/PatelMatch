import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/screens/user_profile_edit/height_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeightScreen extends StatefulWidget {
  final bool fromProfile;
  String response;
  WeightScreen({required this.fromProfile, this.response = ''});

  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  TextEditingController _weightController = new TextEditingController();

  @override
  void initState() {
    if (widget.fromProfile) {
      _weightController.text = widget.response;
    }
    super.initState();
  }

  void showDialog() {
    Get.defaultDialog(
      middleText: "Plese Select Your Weight",
      title: "",
      middleTextStyle: TextStyle(fontSize: 20),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Close'),
                style:
                    TextButton.styleFrom(textStyle: TextStyle(fontSize: 16))),
          ],
        )
      ],
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'PM',
          style:
              TextStyle(color: Color.fromRGBO(255, 85, 115, 1), fontSize: 24),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
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
              'Enter Your Weight',
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
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Start Typing...',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(width: 2),
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please Enter Your Weight';
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
                String weight = _weightController.text;
                if (widget.fromProfile) {
                  if (weight.isEmpty) {
                    showDialog();
                  } else {
                    final globalController = Get.put(GlobalController());
                    Get.find<GlobalController>().currentAppuser.value.weight =
                        weight;

                    DataBaseMethods().addUserWeight(weight);
                    Get.off(EditProfileScreen());
                  }
                } else {
                  if (weight.isEmpty) {
                    showDialog();
                  } else {
                    DataBaseMethods().addUserWeight(weight);
                    Get.to(HeightScreen(
                      fromProfile: false,
                    ));
                  }
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
