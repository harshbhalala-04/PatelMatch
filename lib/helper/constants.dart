import 'package:chat/helper/user_modal.dart';

class Constants {
  static String myName = '';
  static String email = '';
  static String userImage = '';
  static String username = '';
  static String bio = '';
  static bool signUpState = false;
  static List<String> userAllImage = [];
  static String formUsername = '';
  static String birthdate = '';
  static String gender = '';

  //Other User Details.
  static String height = '';
  static String community = '';
  static String userGender = '';
  static String workout = '';
  static String education = '';
  static String worklife = '';
  static String salary = '';
  static String drink = '';
  static String smoke = '';
  static String zodiacSign = '';
  static String politics = '';
  static String movies = '';
  static String hometown = '';
  static String currentLocation = '';
  //Other User Details.

  static List<String> userProfileUrls = [];
  static List<String> userProfileIds = [];
  static int dataAdd = 0;
  static List<UserModel> userDataValue = [];
}

setUserModelValue(Map<String, dynamic>? userData) {
  Constants.userDataValue = [
  UserModel(
      height: userData!.containsKey('height') ? userData['height'] : ' ',
      name: userData['username'],
      age: userData['age'],
      community: userData.containsKey('community') ? userData['community'] : ' ',
      userGender: userData.containsKey('gender') ? userData['gender'] : ' ',
      workout: userData.containsKey('workout') ? userData['workout'] : ' ',
      education: userData.containsKey('education') ? userData['education'] : ' ',
      worklife: userData.containsKey('worklife') ? userData['worklife'] : ' ',
      salary: userData.containsKey('salary') ? userData['salary'] : ' ',
      drink: userData.containsKey('drink') ? userData['drink'] : ' ',
      smoke: userData.containsKey('smoke') ? userData['smoke'] : ' ',
      zodiacSign: userData.containsKey('zodiacSign') ? userData['zodiacSign'] : ' ',
      politics: userData.containsKey('politics') ? userData['politics'] : ' ',
      movies: userData.containsKey('movies') ? userData['movies'] : ' ',
      imageUrl: userData['imgUrl'],
      imageUrls: userData['imgUrls']
    )
];

}
