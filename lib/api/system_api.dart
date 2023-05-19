import 'package:dio/dio.dart';

class SystemApi {
  String baseUrl = "https://api.eskanist.com/public/api";
  signIn(String username, String password) async {
    try {
      String apiEndpoint = "$baseUrl/login";
      final Dio dio = Dio();
      var formData = FormData.fromMap({
        'email': username,
        'password': password,
      });
      var response = await dio.post(
        apiEndpoint,
        data: formData,
      );

      if (response.statusCode == 200) {
        if (response.data["success"]) {
          var res = response.data;
          return res;
        } else {
          return null;
        }
      } else if (response.statusCode == 404) {
        // wrong user password
        return null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  signUp(
      {required String username,
      required String password,
      required String name}) async {
    try {
      String apiEndpoint = "$baseUrl/register";

      print(username);
      print(name);
      print(password);
      final Dio dio = Dio();
      var formData = FormData.fromMap({
        'email': username,
        'password': password,
        'name': name,
        'confirm_password': password,
      });
      var response = await dio.post(
        apiEndpoint,
        data: formData,
      );

      if (response.statusCode == 200) {
        print("status code 200");
        print(response);
        if (response.data["success"]) {
          print("success");
          var res = response.data;
          return res;
        } else {
          return null;
        }
      } else if (response.statusCode == 404) {
        print(" // wrong user password");
        // wrong user password
        return null;
      } else {
        print("no idea");
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
