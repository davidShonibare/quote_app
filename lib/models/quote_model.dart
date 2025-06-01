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
  QuoteModel({
    required this.quote,
    required this.writer,
    required this.index,
  });
}
