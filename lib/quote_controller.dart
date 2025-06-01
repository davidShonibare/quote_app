import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:quote_app/models/quote_model.dart';

import 'models/quote_history_model.dart';

class QuoteController extends GetxController {
  var quote = Rxn<QuoteModel>();

  late Timer _timer;
  late Box<QuoteModel> storedFavoritesBox;
  late Box<QuoteHistoryModel> quoteHistoryBox;
  late String lastQuote;
  var isLoading = true.obs;
  RxList<QuoteModel> favorites = <QuoteModel>[].obs;
  RxList<QuoteHistoryModel> quoteHistory = <QuoteHistoryModel>[].obs;
  var isFav = false.obs;

  @override
  void onInit() {
    super.onInit();
    quoteHistoryBox = Hive.box('quoteHistoryBox');
    storedFavoritesBox = Hive.box('favQuotes');
    assignFav();
    loadQuote();
    
  }

  void assignFav() {
    favorites.assignAll(storedFavoritesBox.values.toList());
  }

  void removeFav(int currentQuoteId) {
    //favorites.removeAt(currentQuoteId);
    final key = storedFavoritesBox.keyAt(currentQuoteId);
    storedFavoritesBox.delete(key);
    refresh();
    assignFav();
  }

  void deleteFromFav(currentQuote) {
    final indexToRemove =
        favorites.indexWhere((q) => q.index == currentQuote.index);
    final key = storedFavoritesBox.keyAt(indexToRemove);
    storedFavoritesBox.delete(key);
    assignFav();
  }

  void toggleFavorites() {
    final currentQuote = quote.value;
    if (currentQuote == null) return;
    final exists = favorites.any((q) => q.index == currentQuote.index);
    if (!exists) {
      favorites.add(currentQuote);
      storedFavoritesBox.add(currentQuote);
      Get.snackbar('', '',
          titleText: const Icon(
            Icons.sentiment_very_satisfied,
            size: 40,
            color: Colors.green,
          ),
          messageText: const Text(
            'Item added to favorites',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          snackPosition: SnackPosition.BOTTOM);
      isFav.value = true;
      refresh();
    } else {
      deleteFromFav(currentQuote);
      Get.snackbar('', '',
          titleText: const Icon(
            Icons.sentiment_very_dissatisfied,
            size: 40,
            color: Colors.redAccent,
          ),
          messageText: const Text(
            'Removed from favorites',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          snackPosition: SnackPosition.BOTTOM);

      isFav.value = false;

    }
    assignFav();
  }

  void loadQuote() {
    final now = DateTime.now();

    if (quoteHistoryBox.isNotEmpty) {
      final stored = quoteHistoryBox.getAt(0)!;
      final elapsed = now.difference(stored.lastShownTime);

      if (elapsed < const Duration(hours: 24)) {

        quote.value = stored.history.last;

        final isAFav = favorites.any((q) => q.index == stored.history.last.index);

        isFav.value = isAFav;
        isLoading.value = false;
        return;
      }
    }

    _fetchNewQuote();
  }

  void _fetchNewQuote() async {

    final response =
        await http.get(Uri.parse('https://dummyjson.com/quotes/random'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final newQuote = QuoteModel(
        quote: data['quote'],
        index: data['id'],
        writer: data['author'],
      );
      final now = DateTime.now();

      if (quoteHistoryBox.isEmpty) {
        quoteHistoryBox
            .add(QuoteHistoryModel(history: [newQuote], lastShownTime: now));
      } else {
        final stored = quoteHistoryBox.getAt(0)!;
     

        stored.history.add(newQuote);
        stored.lastShownTime = now;
        stored.save();
      }
      quote.value = newQuote;
      isLoading.value = false;
    } else {

      isLoading.value = false;
      throw Exception('Failed to load quotes');
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
