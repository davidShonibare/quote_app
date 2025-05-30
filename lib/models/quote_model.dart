class QuoteModel {
  final String quote;
  final String index;
  final String writer;
  QuoteModel({
    required this.quote,
    required this.index,
    required this.writer,
  });
  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      quote: json['text'] ?? '',
      writer: json['author'] ?? 'Unknown',
      index: json['id'] ?? '',
    );
  }
}
