import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:quote_app/models/quote_model.dart';

class QuoteController extends GetxController {
  var quote = Rxn<QuoteModel>();
  late Timer _timer;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuotes();
    _timer = Timer.periodic(
      const Duration(minutes: 30), (_) {
      isLoading.value = true;
      fetchQuotes();
    });
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
