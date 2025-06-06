import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quote_app/favourite_screen.dart';
import 'package:quote_app/history_screen.dart';
import 'package:quote_app/quote_controller.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final QuoteController controller = Get.put(QuoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Quotes'),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () => Get.to(() => QuotesHistoryScreen()),
                  child: const Icon(
                    Icons.history,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: GestureDetector(
                  onTap: () => Get.to(() => FavouriteScreen()),
                  child: const Icon(
                    Icons.bookmarks,
                    size: 24,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.quote.value == null) {
            return const Center(child: Text('Error: Failed to load quote'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                     padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 190),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '"${controller.quote.value!.quote}"',
                            style: const TextStyle(
                              fontSize: 32,
                            ),overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "- ${controller.quote.value!.writer}",
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 120.0),
                      child: GestureDetector(
                        onTap: controller.toggleFavorites,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Obx(
                                () => Icon(
                                  !controller.isFav.value
                                      ? Icons.star_border_outlined
                                      : Icons.star,
                                  size: 65,
                                  color: controller.isFav.value
                                      ? Colors.red
                                      : const Color.fromARGB(150, 0, 0, 0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
