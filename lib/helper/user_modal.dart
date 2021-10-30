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
    this.filters,
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
  Filters? filters;

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
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
      imgUrls: json["imgUrls"] == null
          ? null
          : List<String>.from(json["imgUrls"].map((x) => x)),
      bookayAvailable:
          json["bookayAvailable"] == null ? null : json["bookayAvailable"],
      filters:
          json["filters"] == null ? null : Filters?.fromJson(json["filters"]),
    );
  }

  Map<dynamic, dynamic> toJson() => {
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
        "imgUrls":
            imgUrls == null ? null : List<dynamic>.from(imgUrls!.map((x) => x)),
        "bookayAvailable": bookayAvailable == null ? null : bookayAvailable,
        "filters": filters == null ? null : filters?.toJson(),
      };
}

class Filters {
  Filters(
      {this.age,
      this.height,
      this.drink,
      this.incomeRange,
      this.weight,
      this.smoke,
      this.starSign,
      this.rashi,
      this.samaj,
      this.verifiedOnly,
      this.nri});

  List<dynamic>? age;
  List<dynamic>? height;
  List<dynamic>? drink;
  List<dynamic>? incomeRange;
  List<dynamic>? weight;
  List<dynamic>? smoke;
  List<dynamic>? starSign;
  List<dynamic>? rashi;
  List<dynamic>? samaj;
  List<dynamic>? verifiedOnly;
  List<dynamic>? nri;

  factory Filters.fromJson(Map<dynamic, dynamic> json) {
    print("Age: ${json["age"].length}");
    print("Height: ${json["height"].length}");
    print("Drink: ${json["drink"].length}");
    print("Incomse: ${json["incomeRange"].length}");
    print("Weight: ${json["weight"].length}");
    print("Smoke: ${json["smoke"].length}");
    print("Star: ${json["starSign"].length}");
    print("Rashi: ${json["rashi"].length}");
    print("Samaj: ${json["samaj"].length}");
    print("NRI: ${json["NRI"].length}");
    print("Verify: ${json["verifiedOnly"].length}");

    return Filters(
      age: json["age"].length == 0
          ? []
          : List<dynamic>.from(json["age"].map((x) => x)),
      height: json["height"].length == 0
          ? []
          : List<dynamic>.from(json["height"].map((x) => x)),
      drink: json["drink"].length == 0
          ? []
          : List<dynamic>.from(json["drink"].map((x) => x)),
      incomeRange: json["incomeRange"].length == 0
          ? []
          : List<dynamic>.from(json["incomeRange"].map((x) => x)),
      weight: json["weight"].length == 0
          ? []
          : List<dynamic>.from(json["weight"].map((x) => x)),
      smoke: json["smoke"].length == 0
          ? []
          : List<dynamic>.from(json["smoke"].map((x) => x)),
      starSign: json["starSign"].length == 0
          ? []
          : List<dynamic>.from(json["starSign"].map((x) => x)),
      rashi: json["rashi"].length == 0
          ? []
          : List<dynamic>.from(json["rashi"].map((x) => x)),
      samaj: json["samaj"].length == 0
          ? []
          : List<dynamic>.from(json["samaj"].map((x) => x)),
      nri: json["NRI"].length == 0
          ? []
          : List<dynamic>.from(json["NRI"].map((x) => x)),
      verifiedOnly: json["verifiedOnly"].length == 0
          ? []
          : List<dynamic>.from(json["verifiedOnly"].map((x) => x)),
    );
  }

  Map<dynamic, dynamic> toJson() => {
        "age": age == null ? null : List<dynamic>.from(age!.map((x) => x)),
        "height":
            height == null ? null : List<dynamic>.from(height!.map((x) => x)),
        "drink":
            drink == null ? null : List<dynamic>.from(drink!.map((x) => x)),
        "incomeRange": incomeRange == null
            ? null
            : List<dynamic>.from(incomeRange!.map((x) => x)),
        "weight":
            weight == null ? null : List<dynamic>.from(weight!.map((x) => x)),
        "smoke":
            smoke == null ? null : List<dynamic>.from(smoke!.map((x) => x)),
        "starSign": starSign == null
            ? null
            : List<dynamic>.from(starSign!.map((x) => x)),
        "rashi":
            rashi == null ? null : List<dynamic>.from(rashi!.map((x) => x)),
        "samaj":
            samaj == null ? null : List<dynamic>.from(samaj!.map((x) => x)),
        "verifiedOnly": verifiedOnly == null
            ? null
            : List<dynamic>.from(verifiedOnly!.map((x) => x)),
        "NRI": nri == null ? null : List<dynamic>.from(nri!.map((x) => x))
      };
}
