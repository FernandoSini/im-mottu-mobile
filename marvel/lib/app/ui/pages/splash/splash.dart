import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:marvel/app/controller/marvel_controller.dart';
import 'package:marvel/app/data/repository/marvel_repository.dart';
import 'package:marvel/app/ui/pages/home/home.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  RxBool isCached = false.obs;
  final _repository = MarvelRepository();
  @override
  void didChangeDependencies() async {
    isCached.value = await _repository.readCacheData("marvel_heroes") != null;
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(isCached: isCached.value),
        ),
      ),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: Image.asset("./assets/marvel.png", fit: BoxFit.fitHeight),
            ),
          ],
        ),
      ),
    );
  }
}
