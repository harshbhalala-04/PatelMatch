import 'package:flutter/material.dart';

class FilterScreenCard extends StatelessWidget {
  final String title;
  final String subtitle;

  FilterScreenCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
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
