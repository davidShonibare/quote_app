import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quote_app/quote_controller.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});
  final QuoteController quoteController = Get.find<QuoteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Favourite Quotes'),
        ),
        body: quoteController.favorites.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) => Dismissible(
                  key: ValueKey(quoteController.favorites[index]),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    if (index == quoteController.favorites.length - 1) {
                      quoteController.isFav.value = false;
                    }
                    quoteController.removeFav(index);
                    Get.snackbar('', '',
                        titleText: const Icon(
                          Icons.sentiment_very_dissatisfied,
                          size: 40,
                        ),
                        messageText: const Text(
                          'Removed from favorites',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        snackPosition: SnackPosition.BOTTOM);
                  },
                  child: GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                        titlePadding:const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 30,
                        ),
                        title: quoteController.favorites[index].quote,
                        content: Text(
                          '- ${quoteController.favorites[index].writer}',
                          textAlign: TextAlign.right,style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        trailing: const Icon(Icons.delete_sweep_outlined),
                        title: Text(quoteController.favorites[index].quote),
                      ),
                    ),
                  ),
                )
                /* Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  child: ListTile(
                    title: Text(
                      quoteController.favorites[index].quote,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        quoteController
                            .removeFav(quoteController.favorites[index]);
                        quoteController.update();
                      },
                      child:const Icon(
                        Icons.delete_forever,
                        size: 36,
                        color: const Color.fromARGB(223, 244, 67, 54),
                      ),
                    ),
                  ),
                ), */
                ,
                itemCount: quoteController.favorites.length,
              )
            : const Center(
                child: Text('No favourite'),
              ));
  }
}
