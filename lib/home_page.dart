import 'package:flutter/material.dart';
import 'package:quote_app/api_call.dart';
import 'package:quote_app/models/quote_model.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Quotes')),
      body: FutureBuilder<QuoteModel>(
        future: fetchQuotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final quotes = snapshot.data!;
            return Text(quotes.quote);
            
            
            /* ListView.builder(
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                final quote = quotes[index];
                return ListTile(
                  title: Text(quote.quote),
                  subtitle: Text('- ${quote.writer}'),
                );
              },
            ); */
          }
        },
      ),
    );
  }
}
