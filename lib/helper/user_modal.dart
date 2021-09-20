// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class UserModel {
  final String name;
  final String age;
  final String height;
  final String community;
  final String userGender;
  final String workout;
  final String education;
  final String worklife;
  final String salary;
  final String drink;
  final String smoke;
  final String zodiacSign;
  final String politics;
  final String movies;
  final String imageUrl;
  final List<dynamic> imageUrls;
  // final String hometown = '';
  // final String currentLocation = '';

  UserModel(
      {required this.name,
      required this.age,
      required this.height,
      required this.community,
      required this.userGender,
      required this.workout,
      required this.education,
      required this.worklife,
      required this.salary,
      required this.drink,
      required this.smoke,
      required this.zodiacSign,
      required this.politics,
      required this.movies,
      required this.imageUrl,
      required this.imageUrls});
}
