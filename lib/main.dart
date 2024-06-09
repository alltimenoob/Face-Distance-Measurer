import 'package:face_camera/face_camera.dart';
import 'package:face_distance_measurement/screens/home_screen.dart';
import 'package:flutter/material.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FaceCamera.initialize();

  runApp(const HomeScreen());
}