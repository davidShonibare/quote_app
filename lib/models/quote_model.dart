class QuoteModel {
  final String quote;
  final int index;
  final String writer;
  QuoteModel({
    required this.quote,
    required this.index,
    required this.writer,
  });
  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      quote: json['quote'] ?? '',
      writer: json['author'] ?? 'Unknown',
      index: json['id'] ?? '',
    );
  }
}

List<QuoteModel> favorites=[];