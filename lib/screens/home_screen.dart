import 'dart:io';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late FaceCameraController controller;

  @override
  void initState() {
    controller = FaceCameraController(
      autoCapture: false,
      defaultCameraLens: CameraLens.front,
      onCapture: (File? image) {
      },
      onFaceDetected: (Face? face) {
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Builder(builder: (context) {

            return SmartFaceCamera(
                showControls: false,
                controller: controller,
                messageBuilder: (context, face) {


                  if (face == null) {
                    return _message('Place your face in the camera');
                  }

                  if(face.face != null){
                    final faceDetected = face.face!;
                    double? distance = faceDetected.boundingBox.height;

                    final centimeter = 45 / (distance / 250);
                    final feet = centimeter  / 30;

                    return _message("Centimeter $centimeter Feet $feet ");


                  }
                  if (!face.wellPositioned) {
                    return _message('Center your face in the square');
                  }


                  return const SizedBox.shrink();
                });
          })),
    );
  }

  Widget _message(String msg) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
    child: Text(msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}