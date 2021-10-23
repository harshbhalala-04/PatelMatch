
// import 'package:chat/widgets/filter_pin.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../filter_screen.dart';

// class FilterRashiScreen extends StatefulWidget {
//   const FilterRashiScreen({ Key? key }) : super(key: key);

//   @override
//   _FilterRashiScreenState createState() => _FilterRashiScreenState();
// }

// class _FilterRashiScreenState extends State<FilterRashiScreen> {
//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           'Rashi',
//           style: TextStyle(color: Colors.black, fontSize: 24),
//         ),
//         leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
//             onPressed: () => Get.back()),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Multiple options can be selected.',
//               style:
//                   TextStyle(color: Color.fromRGBO(51, 51, 51, 1), fontSize: 18),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 20, right: 10, bottom: 20),
//               child: Row(
//                 children: [
//                   FilterPin(
//                     keyButton: 'Rashi1',
//                     text: 'Aries',
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   FilterPin(
//                     keyButton: 'Rashi2',
//                     text: 'Taurus',
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 20, bottom: 20),
//               child: Row(
//                 children: [
//                   FilterPin(
//                     keyButton: 'Rashi3',
//                     text: 'Gemini',
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   FilterPin(
//                     keyButton: 'Rashi4',
//                     text: 'Cancer',
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 20, bottom: 20),
//               child: Row(
//                 children: [
//                   FilterPin(
//                     keyButton: 'Rashi5',
//                     text: 'Leo',
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   FilterPin(
//                     keyButton: 'Rashi6',
//                     text: 'Virgo',
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 20, bottom: 20),
//               child: Row(
//                 children: [
//                   FilterPin(
//                     keyButton: 'Rashi7',
//                     text: 'Libra',
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   FilterPin(
//                     keyButton: 'Rashi8',
//                     text: 'Scorpio',
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 20, bottom: 20),
//               child: Row(
//                 children: [
//                   FilterPin(
//                     keyButton: 'Rashi9',
//                     text: 'Saggitarius',
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   FilterPin(
//                     keyButton: 'Rashi10',
//                     text: 'Capricorn',
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 20, bottom: 20),
//               child: Row(
//                 children: [
//                   FilterPin(
//                     keyButton: 'Rashi11',
//                     text: 'Aquarius',
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   FilterPin(
//                     keyButton: 'Rashi12',
//                     text: 'Pisces',
//                   ),
//                 ],
//               ),
//             ),
            
//           ],
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