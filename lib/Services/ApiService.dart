import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  Future<dynamic> fetchData(int step) async {
    var url = Uri.parse(
        "https://sapdos-api-v2.azurewebsites.net/api/Credentials/FeedbackJoiningBot");

    var requestBody = jsonEncode({"step": step});

    try {
      var response = await http.post(
        url,
        body: requestBody,
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);

        String prompt = responseData["type"];
        String initialMsg = responseData["message"];
        return responseData;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print(e);
    }
  }
}
