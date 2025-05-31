import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:quote_app/models/quote_model.dart';

class QuoteController extends GetxController {
  var quote = Rxn<QuoteModel>();
  late Timer _timer;
  late Box<QuoteModel> storedFavoritesBox;
  late String lastQuote;
  var isLoading = true.obs;
  RxList<QuoteModel> favorites = <QuoteModel>[].obs;
  var isFav = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuotes();
    storedFavoritesBox = Hive.box('favQuotes');
    final lastQuoteBox = Hive.box('lastQuote');
    final name = lastQuoteBox.get(2);
    print('name: $name');
    assignFav();
    _timer = Timer.periodic(const Duration(minutes: 10), (_) {
      isLoading.value = true;
      isFav.value = false;
      fetchQuotes();
    });
  }

  void assignFav() {
    favorites.assignAll(storedFavoritesBox.values.toList());
  }

  void removeFav(int currentQuoteId) {
    favorites.removeAt(currentQuoteId);
    final key = storedFavoritesBox.keyAt(currentQuoteId);
    storedFavoritesBox.delete(key);
    update();
    assignFav();
  }

  void deleteFromFav(currentQuote) {
    favorites.remove(currentQuote);
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
      print(isFav.value);
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

      print(isFav.value);
    }
    assignFav();
  }

  Future<void> fetchQuotes() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/quotes/random'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      quote.value = QuoteModel(
        quote: data['quote'],
        index: data['id'],
        writer: data['author'],
      );
      isLoading.value = false;
    } else {
      throw Exception('Failed to load quotes');
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
