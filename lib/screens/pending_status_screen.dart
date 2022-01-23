import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PendingStatusScreen extends StatelessWidget {
  const PendingStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 5,
              ),
            ]),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: SvgPicture.asset(
                'assets/pending.svg',
              ),
            ),
          ),
          Text(
            "Your profile will be",
            style: TextStyle(
              fontFamily: "Cabin",
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(51, 51, 51, 1),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "approved in 48 hours.",
            style: TextStyle(
              fontFamily: "Cabin",
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(51, 51, 51, 1),
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                "We will review your profile information to make sure it is not a fake profile. We will contact you if we find any error in the information provided. If all the details are up to the mark, you will be able to use this app soon. Thank you for your patience.",
                style: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(51, 51, 51, 1),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
