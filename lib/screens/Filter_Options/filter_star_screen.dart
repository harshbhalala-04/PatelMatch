// import 'package:chat/widgets/filter_pin.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../filter_screen.dart';

// class FilterStarScreen extends StatefulWidget {
//   const FilterStarScreen({ Key? key }) : super(key: key);

//   @override
//   _FilterStarScreenState createState() => _FilterStarScreenState();
// }

// class _FilterStarScreenState extends State<FilterStarScreen> {
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           'Star Sign',
//           style: TextStyle(color: Colors.black, fontSize: 24),
//         ),
//         leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
//             onPressed: () => Get.back()),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(15),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Multiple options can be selected.',
//                 style:
//                     TextStyle(color: Color.fromRGBO(51, 51, 51, 1), fontSize: 18),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, right: 10, bottom: 20),
//                 child: Row(
//                   children: [
//                     FilterPin(
//                       keyButton: 'star1',
//                       text: 'Ashwini',
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     FilterPin(
//                       keyButton: 'star2',
//                       text: 'Bharani',
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, bottom: 20),
//                 child: Row(
//                   children: [
//                     FilterPin(
//                       keyButton: 'star3',
//                       text: 'Krittika',
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     FilterPin(
//                       keyButton: 'star4',
//                       text: 'Rohini',
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, bottom: 20),
//                 child: Row(
//                   children: [
//                     FilterPin(
//                       keyButton: 'star5',
//                       text: 'Mrigashirsha',
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     FilterPin(
//                       keyButton: 'star6',
//                       text: 'Ardra',
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, bottom: 20),
//                 child: Row(
//                   children: [
//                     FilterPin(
//                       keyButton: 'star5',
//                       text: 'Punarvasu',
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     FilterPin(
//                       keyButton: 'star6',
//                       text: 'Pushya',
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, bottom: 20),
//                 child: Row(
//                   children: [
//                     FilterPin(
//                       keyButton: 'star5',
//                       text: 'Ashlesha',
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     FilterPin(
//                       keyButton: 'star6',
//                       text: 'Magha',
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, bottom: 20),
//                 child: Row(
//                   children: [
//                     FilterPin(
//                       keyButton: 'star5',
//                       text: 'Purva',
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     FilterPin(
//                       keyButton: 'star6',
//                       text: 'Uttara',
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, bottom: 20),
//                 child: Row(
//                   children: [
//                     FilterPin(
//                       keyButton: 'star7',
//                       text: 'Hasta',
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     FilterPin(
//                       keyButton: 'star8',
//                       text: 'Chitra',
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, bottom: 20),
//                 child: Row(
//                   children: [
//                     FilterPin(
//                       keyButton: 'star9',
//                       text: 'Svati',
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     FilterPin(
//                       keyButton: 'star10',
//                       text: 'Visakha',
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, bottom: 20),
//                 child: Row(
//                   children: [
//                     FilterPin(
//                       keyButton: 'star11',
//                       text: 'Anuradha',
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     FilterPin(
//                       keyButton: 'star12',
//                       text: 'Jyeshtha',
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, bottom: 20),
//                 child: Row(
//                   children: [
//                     FilterPin(
//                       keyButton: 'star13',
//                       text: 'Mula',
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     FilterPin(
//                       keyButton: 'star14',
//                       text: 'Purva Ashadha',
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, bottom: 20),
//                 child: Row(
//                   children: [
//                     FilterPin(
//                       keyButton: 'star15',
//                       text: 'Uttara Ashadha',
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     FilterPin(
//                       keyButton: 'star16',
//                       text: 'Sravana',
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, bottom: 20),
//                 child: Row(
//                   children: [
//                     FilterPin(
//                       keyButton: 'star17',
//                       text: 'Sravistha',
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     FilterPin(
//                       keyButton: 'star18',
//                       text: 'Shatabhisha',
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, bottom: 20),
//                 child: Row(
//                   children: [
//                     FilterPin(
//                       keyButton: 'star19',
//                       text: 'Purva Bhadrapada',
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     FilterPin(
//                       keyButton: 'star20',
//                       text: 'Uttara Bhadrapada',
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, bottom: 20),
//                 child: Row(
//                   children: [
//                     FilterPin(
//                       keyButton: 'star21',
//                       text: 'Revati',
//                     ),
                    
//                   ],
//                 ),
//               ),
              
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Container(
//           width: 325,
//           height: 40,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(50))),
//           child: ElevatedButton(
//             onPressed: () {
//               Get.off(FilterScreen());
//             },
//             child: Text(
//               'Done',
//               style: TextStyle(fontSize: 20),
//             ),
//             style: ElevatedButton.styleFrom(
//                 primary: Color.fromRGBO(255, 85, 115, 0.89),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(25)))),
//           ),
//         ),
//       ),
//     );
//   }
// }