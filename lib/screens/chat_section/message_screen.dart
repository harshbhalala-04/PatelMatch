import 'package:chat/screens/chat_section/people_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'conversation_screen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  final String? email = FirebaseAuth.instance.currentUser!.email;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Message', style: TextStyle(color: Colors.black),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(maxHeight: 150.0),
                  child: Material(
                    color: Colors.white,
                    child: TabBar(
                      labelColor: Colors.black,
                      automaticIndicatorColorAdjustment: true,
                      indicatorColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          text: 'Conversations',
                        ),
                        Tab(text: 'People'),
                      ],
                    ),
                  ),
                ),
                
                Expanded(
                  child: TabBarView(
                    children: [
                      ConversationScreen(email: email),
                      PeopleScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
