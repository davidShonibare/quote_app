import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quote_app/home_page.dart';
import 'package:quote_app/models/quote_model.dart';

void main() async{
  

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(QuoteModelAdapter());

  await Hive.openBox<QuoteModel>('favoritesBox');

  //intializing hive
  await  Hive.initFlutter();
  await Hive.openBox<QuoteModel>('favQuotes');
  await Hive.openBox('lastQuote');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
