import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:marvel/app/data/models/model.dart';

import 'hero.dart';

class HeroRecommended extends StatelessWidget {
  const HeroRecommended(
      {super.key,
      required this.character,
      required this.recommendedCharacters});
  final Character character;
  final List<Character> recommendedCharacters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        title: Text(character.name!),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: ListView(
          children: [
            SizedBox(
              width: Get.width,
              child: Image.network(
                "${character.thumbnail!.path!}.${character.thumbnail!.extension!}",
                height: 300,
                fit: BoxFit.fill,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10),
                  child: Text(
                    character.name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(character.description!.isEmpty
                      ? 'No data'
                      : character.description!),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Recommended Characters:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 100,
                  width: Get.width,
                  child: recommendedCharacters.isEmpty
                      ? const Text("No data")
                      : ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: recommendedCharacters
                              .where((element) => element.id != character.id)
                              .map(
                                (element) => Container(
                                  height: 100,
                                  width: 100,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: Image.network(
                                          "${element.thumbnail!.path!}.${element.thumbnail!.extension!}",
                                        ).image,
                                        fit: BoxFit.fill),
                                  ),
                                  child: InkWell(
                                    onTap: () => Get.to(
                                      () => HeroPage(
                                          character: element,
                                          recommendedCharacters:
                                              recommendedCharacters),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
