import 'dart:ffi';
import "dart:io";
import 'package:flutter/material.dart';

class Album {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String name;
  final int age;
  final String address;
  final String image;
  final List<dynamic> languages;
  final List<dynamic> hobbies;
  final String postalCode;
  final String caretakerId;

  const Album({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.age,
    required this.address,
    required this.image,
    required this.languages,
    required this.hobbies,
    required this.postalCode,
    required this.caretakerId,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      name: json['name'],
      age: json['age'],
      address: json['address'],
      image: json['image'],
      languages: json['languages'],
      hobbies: json['hobbies'],
      postalCode: json['postalCode'],
      caretakerId: json['caretakerId'],
    );
  }
}
