import 'package:chat/controllers/screen_controller.dart';
import 'package:chat/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RejectUserScreen extends StatelessWidget {
  final TextEditingController phoneController = new TextEditingController();
  final screenController = Get.put(ScreenController());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/reject.svg"),
            Text(
              "Your profile has been rejected",
              style: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(51, 51, 51, 1)),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Your profile has been temporarily",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontFamily: "Cabin",
                fontSize: 18,
              ),
            ),
            Text(
              "rejected by our team. You will receive a",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontFamily: "Cabin",
                fontSize: 18,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Call on this ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Cabin",
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: screenController.userNumber.value,
                    style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Cabin",
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: " number",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Cabin",
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => screenController.isAlterNumber.value
                ? Text(
                    "Thank You",
                    style: TextStyle(fontSize: 18),
                  )
                : Text(
                    "Alternate number:",
                    style: TextStyle(
                      color: Color.fromRGBO(51, 51, 51, 1),
                      fontSize: 12,
                      fontFamily: "Cabin",
                    ),
                    textAlign: TextAlign.start,
                  )),
            Obx(() => screenController.isAlterNumber.value
                ? Text(
                    "We will contact you soon",
                    style: TextStyle(fontSize: 18),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 90.0),
                    child: TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          hintText: "Phone number",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontFamily: "Cabin",
                          )),
                    ),
                  )),
            SizedBox(
              height: 20,
            ),
            Obx(() => screenController.isAlterNumber.value
                ? Container()
                : Container(
                    width: 130,
                    height: 45,
                    child: FloatingActionButton(
                      heroTag: 'phone Number',
                      onPressed: () {
                        screenController.isAlterNumber.value = true;
                        DataBaseMethods()
                            .addAlternateNumber(phoneController.text);
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      backgroundColor: Color.fromRGBO(255, 85, 115, 1),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
