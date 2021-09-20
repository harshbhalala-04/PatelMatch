// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import './user_modal.dart';

// class Services {
//   final User? user = FirebaseAuth.instance.currentUser;
//   String? userResponse;
//   getUserModel() async {
//     userResponse = await FirebaseFirestore.instance
//         .collection("users")
//         .doc(user!.uid)
//         .get()
//         .then((value) {
//       userModelFromJson(value.data().toString());
//     });
//     print('Here is the full response coming from firebase');
//   }
// }
