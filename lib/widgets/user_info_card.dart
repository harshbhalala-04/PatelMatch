import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  //const UserInfoCard({Key? key}) : super(key: key);
  final title;
  final subTitle;

  UserInfoCard({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return subTitle != null
        ? Container(
            width: 150,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ListTile(
                title: Text(
                  title,
                  style: TextStyle(color: Colors.black54, fontSize: 10),
                ),
                subtitle: Text(
                  subTitle,
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ),
            ),
          )
        : Container(
            width: 0,
          );
  }
}
