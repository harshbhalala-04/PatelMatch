import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAssitant {
  static Future<dynamic> getRequest(String url) async {
    try {
      var myUri = Uri.parse(url);
      http.Response response = await http.get(myUri);
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decodeData = json.decode(jsonData);
        return decodeData;
      } else {
        return "failed";
      }
    } catch (err) {
      print("$err");
    }
  }
}
