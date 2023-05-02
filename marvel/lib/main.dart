import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel/app/controller/marvel_controller.dart';
import 'package:marvel/app/ui/pages/splash/splash.dart';

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
/* 
[3-D Man, A-Bomb (HAS), A.I.M., Aaron Stack,
 Abomination (Emil Blonsky), Abomination (Ultimate),
  Absorbing Man, Abyss, Abyss (Age of Apocalypse), 
  Adam Destine, Adam Warlock, Aegis (Trey Rollins), Aero (Aero),
 Agatha Harkness, Agent Brand, Agent X (Nijo), 
 Agent Zero, Agents of Atlas, Aginar, Air-Walker (Gabriel Lan)

 */
