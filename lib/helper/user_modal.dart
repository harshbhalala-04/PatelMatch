// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.uid,
        this.username,
        this.age,
        this.height,
        this.community,
        this.gender,
        this.workout,
        this.education,
        this.worklife,
        this.salary,
        this.drink,
        this.smoke,
        this.zodiacSign,
        this.politics,
        this.movie,
        this.imgCount,
        this.imgUrl,
        this.imgUrls,
        this.bookayAvailable,
    });
    String? uid;
    String? username;
    String? age;
    String? height;
    String? community;
    String? gender;
    String? workout;
    String? education;
    String? worklife;
    String? salary;
    String? drink;
    String? smoke;
    String? zodiacSign;
    String? politics;
    String? movie;
    int? imgCount;
    String? imgUrl;
    List<String>? imgUrls;
    int? bookayAvailable;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"] == null ? null : json["uid"],
        username: json["username"] == null ? null : json["username"],
        age: json["age"] == null ? null : json["age"],
        height: json["height"] == null ? null : json["height"],
        community: json["community"] == null ? null : json["community"],
        gender: json["gender"] == null ? null : json["gender"],
        workout: json["workout"] == null ? null : json["workout"],
        education: json["education"] == null ? null : json["education"],
        worklife: json["worklife"] == null ? null : json["worklife"],
        salary: json["salary"] == null ? null : json["salary"],
        drink: json["drink"] == null ? null : json["drink"],
        smoke: json["smoke"] == null ? null : json["smoke"],
        zodiacSign: json["zodiacSign"] == null ? null : json["zodiacSign"],
        politics: json["politics"] == null ? null : json["politics"],
        movie: json["movie"] == null ? null : json["movie"],
        imgCount: json["imgCount"] == null ? null : json["imgCount"],
        imgUrl: json["imgUrl"] == null ? null : json["imgUrl"],
        imgUrls: json["imgUrls"] == null ? null : List<String>.from(json["imgUrls"].map((x) => x)),
        bookayAvailable: json["bookayAvailable"] == null ? null : json["bookayAvailable"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "username": username == null ? null : username,
        "age": age == null ? null : age,
        "height": height == null ? null : height,
        "community": community == null ? null : community,
        "gender": gender == null ? null : gender,
        "workout": workout == null ? null : workout,
        "education": education == null ? null : education,
        "worklife": worklife == null ? null : worklife,
        "salary": salary == null ? null : salary,
        "drink": drink == null ? null : drink,
        "smoke": smoke == null ? null : smoke,
        "zodiacSign": zodiacSign == null ? null : zodiacSign,
        "politics": politics == null ? null : politics,
        "movie": movie == null ? null : movie,
        "imgCount": imgCount == null ? null : imgCount,
        "imgUrl": imgUrl == null ? null : imgUrl,
        "imgUrls": imgUrls == null ? null : List<dynamic>.from(imgUrls!.map((x) => x)),
        "bookayAvailable": bookayAvailable == null ? null : bookayAvailable,
    };
}
