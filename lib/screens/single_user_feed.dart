import 'package:flutter/material.dart';
import './drink_screen.dart'; 

class SingleUserFeed extends StatefulWidget {
  List<Map<String, dynamic>> userData;

  SingleUserFeed({
    required this.userData,
  });

  @override
  _SingleUserFeedState createState() => _SingleUserFeedState();
}

class _SingleUserFeedState extends State<SingleUserFeed>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Feed Screen'),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
