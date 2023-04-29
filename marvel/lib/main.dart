import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel/app/controller/marvel_controller.dart';
import 'package:marvel/app/ui/pages/splash.dart';

void main() async{
   Get.put<MarvelController>(MarvelController());
  runApp(
    const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
