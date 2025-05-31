

import 'package:hive/hive.dart';

part 'quote_model.g.dart'; // Generated file

@HiveType(typeId: 0)
class QuoteModel extends HiveObject {
  @HiveField(0)
  String quote;

  @HiveField(1)
  String writer;

  @HiveField(2)
  int index;
factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      quote: json['quote'] ?? '',
      writer: json['author'] ?? 'Unknown',
      index: json['id'] ?? '',
    );
  }
  QuoteModel({required this.quote, required this.writer, required this.index});
}