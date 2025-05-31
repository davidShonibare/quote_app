import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quote_app/favourite_screen.dart';
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
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Obx(
              () => GestureDetector(
                onTap: ()=>Get.to(()=>FavouriteScreen()),
                child: Icon(
                  !controller.isFav.value
                      ? Icons.star_border_outlined
                      : Icons.star,
                  size: 36,
                  color: controller.isFav.value
                      ? Colors.red
                      : const Color.fromARGB(18, 0, 0, 0),
                ),
              ),
            ),
          ),
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
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '"${controller.quote.value!.quote}"',
                          style: const TextStyle(
                            fontSize: 32,
                          ),
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 60.0),
                      child: GestureDetector(
                        onTap: controller.toggleFavorites,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              !controller.isFav.value
                                  ? 'Add to Favorites'
                                  : 'Remove from Favorites',
                              style: const TextStyle(fontSize: 24),
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
