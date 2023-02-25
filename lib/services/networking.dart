import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:cane_9_app/constants.dart';

class Networking {
  late final url;

  Networking({required path}) {
    url = '$apiurl$path';
  }

  Future httpGet() async {
    debugPrint("Getting to $url...");
    final response = await http.get(Uri.parse('$url'));
    if (response.statusCode == 200) {
      debugPrint("Get Req Successful");
      final data = jsonDecode(response.body);
      return data;
    } else {
      debugPrint("Get Req Error with ${response.statusCode}");
      return null;
    }
  }

  Future httpPost(data) async {
    debugPrint("Posting to $url...");
    final requestBody = jsonEncode(data);
    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: requestBody);
    if (response.statusCode == 200) {
      debugPrint("Post Req Successful");
      final data = jsonDecode(response.body);
      return data;
    } else {
      debugPrint("Post Req Error with ${response.statusCode}");
      return null;
    }
  }
}
