import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:marvel/app/data/models/model.dart';

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
    if (!isCached.value) {
      characterList.value = await marvelController.fetchDataFromApi();
      isCached.value == true;
    } else {
      characterList.value = await marvelController.fetchDataFromCache();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    marvelController.deleteData();
    marvelController.dispose();
    super.dispose();
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
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      label: const Text("Search"),
                      suffixIcon: IconButton(
                        onPressed: () {},
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
                  ),
                ),
              ),
              GetBuilder<MarvelController>(
                  init: marvelController,
                  initState: (_) {},
                  builder: (_) {
                    return Container(
                      height: Get.height,
                      width: Get.width,
                      color: Colors.red,
                      child: GridView.builder(
                        itemCount: characterList.length + 5,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) => Card(
                          child: Image.network(
                              characterList[index].thumbnail!.path!),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
