import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coursepageapitask/model/Course.dart';

Future<Course> fetchCourse() async {
  final response = await http
      .get('https://run.mocky.io/v3/3a1ec9ff-6a95-43cf-8be7-f5daa2122a34');

  if (response.statusCode == 200) {
    return Course.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load course');
  }
}
