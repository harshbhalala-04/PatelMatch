// import '../../helper/constants.dart';
// import 'conversation_screen.dart';
// import 'people_screen.dart';

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../auth_screen.dart';
// import '../profile_screen.dart';
// //import '../helper/helper_function.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   // String? _myName;


//   void initState() {
//     super.initState();
//   }

//   // getUserInfo() async {

//   //   print(Constants.myName);
//   //   print('This is username in home screen');
//   //   setState(() {});
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(
//           primarySwatch: Colors.pink,
//           primaryColor: Colors.pink,
//           accentColor: Colors.purple,
//           accentColorBrightness: Brightness.dark,
//           buttonTheme: ButtonTheme.of(context).copyWith(
//             buttonColor: Colors.pink,
//             textTheme: ButtonTextTheme.primary,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           ),
//         ),
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(

//           appBar: AppBar(
//             backgroundColor: Colors.white,
        
//             elevation: 0.0,
//             automaticallyImplyLeading: false,
//             //backgroundColor: Theme.of(context).primaryColor,
    
//             title: Text('Flutter Chat', style: TextStyle(color: Colors.black),),
    
//             actions: [
//               DropdownButton(
//                   underline: Container(),
//                   icon: Icon(
//                     Icons.more_vert,
//                     color: Colors.pink,
//                   ),
//                   items: [
//                     DropdownMenuItem(
//                       child: Container(
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.account_circle_rounded,
//                               color: Colors.black,
//                             ),
//                             SizedBox(
//                               width: 8,
//                             ),
//                             Text('Profile'),
//                           ],
//                         ),
//                       ),
//                       value: 'Profile',
//                     ),
//                     DropdownMenuItem(
//                       child: Container(
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.exit_to_app,
//                               color: Colors.black,
//                             ),
//                             SizedBox(
//                               width: 8,
//                             ),
//                             Text('Logout'),
//                           ],
//                         ),
//                       ),
//                       value: 'Logout',
//                     ),
                    
//                   ],
//                   onChanged: (itemIndentifier) {
//                     if (itemIndentifier == 'Logout') {
//                       Constants.myName = '';
//                       FirebaseAuth.instance.signOut();
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => AuthScreen()));
//                     } else if (itemIndentifier == 'Profile') {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (ctx) => ProfileScreen()));
//                     }
//                   })
//             ],
//           ),
//           body: DefaultTabController(
//             length: 2,
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   constraints: BoxConstraints(maxHeight: 150.0),
//                   child: Material(
//                     color: Colors.white,
//                     child: TabBar(
//                       labelColor: Colors.black,
//                       automaticIndicatorColorAdjustment: true,
//                       indicatorColor: Colors.black,
//                       unselectedLabelColor: Colors.grey,
//                       tabs: [
//                         Tab(
//                           text: 'Conversations',
//                         ),
//                         Tab(text: 'People'),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                     children: [
//                       ConversationScreen(email: email),
//                       PeopleScreen(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//   }
// }
