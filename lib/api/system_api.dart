import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SystemApi {
  String baseUrl = "https://api.qline.app/api";
  String authToken = "1|KnGJGkh96s86XIvDUGXvZb1m5Hy4OTNuhyOjg1qs";
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
      print(e);
      return null;
    }
  }

  signUp(
      {required String username,
      required String password,
      required String name}) async {
    try {
      String apiEndpoint = "$baseUrl/register";
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
      print(e);
      return null;
    }
  }

  Future<List<String>> getTickets() async {
    try {
      String apiEndpoint = "$baseUrl/tickets";
      final Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $authToken';

      var response = await dio.get(apiEndpoint);

      if (response.statusCode == 200) {
        var data = response.data;
        List<String> tickets = [];
        for (var ticket in data['tickets']) {
          tickets.add(ticket['title']);
        }
        return tickets;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<bool> sendTicket(String title, String message, String topic) async {
    try {
      String apiEndpoint = "$baseUrl/tickets";
      final Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $authToken';

      var formData = FormData.fromMap({
        'title': title,
        'message': message,
        'topic': topic,
      });

      var response = await dio.post(
        apiEndpoint,
        data: formData,
      );
      if (response.statusCode == 200) {
        var data = response.data;
        if (data['success']) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
