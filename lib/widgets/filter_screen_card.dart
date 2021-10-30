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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontSize: 18, color: Colors.black87),
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
