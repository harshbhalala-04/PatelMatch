import 'package:chat/database/database.dart';
import 'package:chat/screens/custom_tab_bar.dart';
import 'package:chat/screens/feed_screen.dart';
import 'package:chat/screens/onboarding_screens/handicapped_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum YesNo { Yes, No }

class ManglicScreen extends StatefulWidget {
  const ManglicScreen({Key? key}) : super(key: key);

  @override
  _ManglicScreenState createState() => _ManglicScreenState();
}

class _ManglicScreenState extends State<ManglicScreen> {
  YesNo? _reply;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              height: 20,
            ),
            Text(
              'Are You Manglik?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = YesNo.No;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: YesNo.No,
                    groupValue: _reply,
                    onChanged: (YesNo? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('No'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = YesNo.Yes;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: YesNo.Yes,
                    groupValue: _reply,
                    onChanged: (YesNo? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Yes'),
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
                if (_reply == YesNo.No) {
                  DataBaseMethods().addUserHandicapped("No");
                } else {
                  DataBaseMethods().addUserHandicapped("Yes");
                }

                Get.to(CustomTabBar());
              },
              child: Text(
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
