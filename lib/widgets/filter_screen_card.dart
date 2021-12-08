import 'package:flutter/material.dart';

class FilterScreenCard extends StatelessWidget {
  final String title;
  String subtitle;

  FilterScreenCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    if (subtitle.length > 27) {
      subtitle = subtitle.substring(0, 27);
      subtitle += '...';
    }
   
    return Container(
      margin: EdgeInsets.all(5),
      child: Card(
        elevation: 2.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontSize: 18, color: Color.fromRGBO(51, 51, 51, 1),),
          ),
          trailing: Icon(
            Icons.arrow_right,
            color: Colors.pink,
            size: 30,
          ),
        ),
      ),
    );
  }
}
