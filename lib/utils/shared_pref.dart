import 'dart:developer';
import '../enums/dependencies.dart';

class SharedPref {

  static saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    log(email.toString());
  }

  static getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    return email;
  }

  static saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    log(token.toString());
  }

  static getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  static saveGoogle(bool dismiss) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('google', dismiss);
  }

  static getGoogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? dismiss = prefs.getBool('google');
    return dismiss;
  }

  static saveUserPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('password', password);
  }

  static getUserPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('password');
    return value;
  }

  static saveUserID(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userID', id);
  }

  static getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt('userID');
    return value;
  }

  static saveIsLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }

  static getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool('isLoggedIn');
    return boolValue;
  }



  static saveRememberMe(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('remember_me', value);
  }

  static getRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool('remember_me');
    return boolValue;
  }

}
