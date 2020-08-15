import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_app/utilities/api_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationAPI {
  Future<bool> login(String email, String password) async {
    String authApi = base_api + authen_api;
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };

    Map<String, String> body = {
      "email": email,
      "password": password,
    };
    var response = await http.patch(authApi, headers: headers, body: body);
    if (response.statusCode == 200) {
      try {
        var jsonData = jsonDecode(response.body);
        var data = jsonData["data"];
        var token = data['token'];
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("token", token);
        print(token);
        return true;
      } catch (Ex) {
        return false;
      }
    }
    return false;
  }
}
