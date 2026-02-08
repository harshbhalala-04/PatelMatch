import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../edit_profile_screen.dart';

class SiblingScreen extends StatefulWidget {
  @override
  _SiblingScreenState createState() => _SiblingScreenState();
}

class _SiblingScreenState extends State<SiblingScreen> {
  TextEditingController totalBrothers = new TextEditingController();

  TextEditingController marriedBrothers = new TextEditingController();

  TextEditingController totalSisters = new TextEditingController();

  TextEditingController marriedSisters = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    print(
        "Here in init state : ${Get.find<GlobalController>().currentAppuser.value.totalSisters}");
    print(Get.find<GlobalController>().currentAppuser.value.totalSisters);
    if (Get.find<GlobalController>().currentAppuser.value.totalSisters != "" &&
        Get.find<GlobalController>().currentAppuser.value.totalSisters !=
            null) {
      totalSisters.text =
          Get.find<GlobalController>().currentAppuser.value.totalSisters!;
    }
    if (Get.find<GlobalController>().currentAppuser.value.totalBrothers != "" &&
        Get.find<GlobalController>().currentAppuser.value.totalBrothers !=
            null) {
      totalBrothers.text =
          Get.find<GlobalController>().currentAppuser.value.totalBrothers!;
    }
    if (Get.find<GlobalController>().currentAppuser.value.marriedBrothers !=
            "" &&
        Get.find<GlobalController>().currentAppuser.value.marriedBrothers !=
            null) {
      marriedBrothers.text =
          Get.find<GlobalController>().currentAppuser.value.marriedBrothers!;
    }
    if (Get.find<GlobalController>().currentAppuser.value.marriedSisters !=
            "" &&
        Get.find<GlobalController>().currentAppuser.value.marriedSisters !=
            null) {
      marriedSisters.text =
          Get.find<GlobalController>().currentAppuser.value.marriedSisters!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'PM',
          style:
              TextStyle(color: Color.fromRGBO(255, 85, 115, 1), fontSize: 24),
        ),
        centerTitle: true,
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
              'Siblings?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Brothers',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromRGBO(141, 141, 141, 1)),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Color.fromRGBO(255, 85, 115, 1),
                                            width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    width: 50,
                                    child: TextFormField(
                                      controller: totalBrothers,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Married',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromRGBO(141, 141, 141, 1)),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Color.fromRGBO(255, 85, 115, 1),
                                            width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    width: 50,
                                    child: TextFormField(
                                      controller: marriedBrothers,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                    height: 120,
                    child: VerticalDivider(
                      color: Colors.grey,
                      thickness: 2,
                      indent: 5,
                      endIndent: 0,
                      width: 10,
                    )),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Sisters',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromRGBO(141, 141, 141, 1)),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Color.fromRGBO(255, 85, 115, 1),
                                            width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    width: 50,
                                    child: TextFormField(
                                      controller: totalSisters,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Married',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromRGBO(141, 141, 141, 1)),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Color.fromRGBO(255, 85, 115, 1),
                                            width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    width: 50,
                                    child: TextFormField(
                                      controller: marriedSisters,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
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
                print("Total bro: ${totalBrothers.text}");
                print("Total sis: ${totalSisters.text}");
                print("married bro: ${marriedBrothers.text}");
                print("married sis: ${marriedSisters.text}");

                Get.find<GlobalController>()
                    .currentAppuser
                    .value
                    .totalBrothers = totalBrothers.text;
                Get.find<GlobalController>().currentAppuser.value.totalSisters =
                    totalSisters.text;
                Get.find<GlobalController>()
                    .currentAppuser
                    .value
                    .marriedBrothers = marriedBrothers.text;
                Get.find<GlobalController>()
                    .currentAppuser
                    .value
                    .marriedSisters = marriedSisters.text;
                print(totalBrothers.text.isEmpty);
                DataBaseMethods().addUserSiblings(
                    totalBrothers.text,
                    totalSisters.text,
                    marriedBrothers.text,
                    marriedSisters.text);
                //  Navigator.pop(context);
                Get.off(EditProfileScreen());
              },
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(255, 85, 115, 0.89),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
