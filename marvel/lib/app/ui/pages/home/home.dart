import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:marvel/app/data/models/model.dart';
import 'package:marvel/app/ui/pages/hero/hero.dart';

import '../../../controller/marvel_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.isCached});
  final bool isCached;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final marvelController = Get.find<MarvelController>();
  TextEditingController controller = TextEditingController(text: "");
  RxBool isCached = false.obs;
  RxList<Character> characterList = RxList.empty(growable: true);

  @override
  void initState() {
    isCached.value = widget.isCached;
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    /*  if (!isCached.value) {
      characterList.value = await marvelController.fetchDataFromApi();
      marvelController.refresh();
      isCached.value == true;
    } else {
      characterList.value = await marvelController.fetchDataFromCache();
      marvelController.refresh();
    }
 */
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    marvelController.deleteData();
    marvelController.dispose();
    super.dispose();
  }

  searchData(String value) async {
    var data = await marvelController.fetchDataFromCache();

    characterList.value = data
        .where((element) =>
            element.name!.toLowerCase().contains(value) ||
            element.comics!.items!.any(
                (element) => element.name!.toLowerCase().contains(value)) ||
            element.description!.toLowerCase().contains(value))
        .toList();
    characterList.refresh();
    return characterList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        title: const Text("Marvel list"),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 20, right: 20, bottom: 10),
                child: SizedBox(
                  child: GetBuilder<MarvelController>(
                    init: marvelController,
                    initState: (_) {},
                    builder: (_) {
                      return TextField(
                        controller: controller,
                        onChanged: (text) => marvelController.refresh(),
                        decoration: InputDecoration(
                          label: const Text("Search"),
                          suffixIcon: IconButton(
                            onPressed: () => marvelController.refresh(),
                            icon: const Icon(Icons.search),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              GetBuilder<MarvelController>(
                init: marvelController,
                initState: (_) {},
                builder: (_) {
                  return SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: Column(
                      children: [
                        FutureBuilder(
                          future: !isCached.value
                              ? marvelController.fetchDataFromApi()
                              : marvelController.fetchDataFromCache(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                height: Get.height * 0.6,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            }
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData &&
                                snapshot.data != null &&
                                snapshot.data!.isNotEmpty) {
                              List<List<Character>> characters =
                                  marvelController.search(
                                      snapshot.data!, controller.text);

                              return SizedBox(
                                height: Get.height,
                                child: ListView.builder(
                                    itemCount: characters.length,
                                    itemBuilder: (context, index) {
                                      final int start = index * 5;
                                      final int end = start + 5;
                                      return Wrap(
                                        children: characters[index]
                                            .skip(start)
                                            .take(end - start)
                                            .map((e) => InkWell(
                                                  onTap: () =>
                                                      Get.to(() => HeroPage(
                                                            character: e,
                                                            recommendedCharacters:
                                                                characters[
                                                                    index],
                                                          )),
                                                  child: SizedBox(
                                                    height: Get.height * 0.2,
                                                    width: Get.width * 0.5,
                                                    child: Card(
                                                      child: Image.network(
                                                        "${e.thumbnail!.path!}.${e.thumbnail!.extension!}",
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                      );
                                    }),
                              );
                            } else {
                              return SizedBox(
                                height: Get.height * 0.6,
                                child: const Center(
                                  child: Text("Empty"),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
