import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const domain = "https://coding-is-fun.onrender.com/api/v1";

class API {
  login(String email, password) async {
    try {
      var response = await http.post(
        Uri.parse('$domain/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {'email': email, 'password': password},
        ),
      );
      return response;
    } catch (err) {
      // print(err.toString());
      throw Exception('Failed to connect to the server: $err');
    }
  }

  register(String name, String email, password) async {
    try {
      var response = await http.post(
        Uri.parse('$domain/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {'name': name, 'email': email, 'password': password},
        ),
      );
      return response;
    } catch (err) {
      // print(err.toString());
      throw Exception('Failed to connect to the server: $err');
    }
  }

  getCategoryList() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    try {
      var response = await http.get(
        Uri.parse('$domain/get-all-categories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (err) {
      print(err.toString());
    }
  }

  createCategoryApi(title, description) async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.getString("token");

    try {
      var url = "$domain/create-category";
      var body = jsonEncode({
        'title': title,
        'description': description,
      });
      print(">>>>>>>>>>> create category url $url");
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }
}
