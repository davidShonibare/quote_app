import 'package:hive_flutter/hive_flutter.dart';
import 'package:quote_app/models/quote_model.dart';

part 'quote_history_model.g.dart'; // Generated file

@HiveType(typeId: 1)
class QuoteHistoryModel extends HiveObject {
  @HiveField(0)
  List<QuoteModel> history;

  @HiveField(1)
  DateTime lastShownTime;

  QuoteHistoryModel({
    required this.history,
    required this.lastShownTime,
  });
}
