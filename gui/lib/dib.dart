import 'package:flutter/material.dart';

class Dib {
  late String title;
  late String description;
  late String lat;
  late String long;
  late String category;
  late Image image;

  Dib(
      {required this.title,
      required this.description,
      required this.lat,
      required this.long,
      required this.category,
      required this.image});
}
