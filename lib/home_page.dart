import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quote_app/quote_controller.dart';

class MyHomePage extends StatelessWidget {
   MyHomePage({super.key});
   final QuoteController controller = Get.put(QuoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quotes')),
      body: Obx((){
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.quote.value==null) {
            return const Center(child: Text('Error: Failed to load quote'));
          } else {
            
            return Obx(
              ()=> Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '"${controller.quote.value!.quote}"',
                    style: const TextStyle(
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding:const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "- ${controller.quote.value!.writer}",
                          style: const TextStyle(fontStyle: FontStyle.italic,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
     
    ));
  }
}
