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

  Future fetchData() async {
    debugPrint("Polling $url...");
    final response = await http.get(Uri.parse('$url'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }
}
