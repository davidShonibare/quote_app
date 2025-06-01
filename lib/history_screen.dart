import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quote_app/quote_controller.dart';

class QuotesHistoryScreen extends StatelessWidget {
  QuotesHistoryScreen({super.key});
  final QuoteController quoteController = Get.find<QuoteController>();

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        appBar: AppBar(
          title: const Text('Daily Quote History'),
        ),
        body: quoteController.quoteHistoryBox.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                 final history=quoteController.quoteHistoryBox.getAt(0)!.history;
                  return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  child: ListTile(
                    title: Text(history[index].quote
                      ,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );},
                itemCount: quoteController.quoteHistoryBox.getAt(0)!.history.length,
              )
            : const Center(
                child: Text('No History'),
              ));
  }
}
