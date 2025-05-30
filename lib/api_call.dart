
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quote_app/models/quote_model.dart';

Future<QuoteModel> fetchQuotes() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/quotes/1'));

  if (response.statusCode == 200) {
   print(response.body);
   final data = json.decode(response.body);
   print(data['author']); print(data['id']); print(data['quote']);
   return QuoteModel(quote: 'quote', index: 'index', writer: 'writer');
   // return data.map((json) => QuoteModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load quotes');
  }
}