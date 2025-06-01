import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quote_app/home_page.dart';
import 'package:quote_app/models/quote_model.dart';

import 'models/quote_history_model.dart';

void main() async{
  

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(QuoteModelAdapter());
  Hive.registerAdapter(QuoteHistoryModelAdapter());
  
  //intializing hive
  await Hive.openBox<QuoteModel>('favQuotes');
  await Hive.openBox<QuoteHistoryModel>('quoteHistoryBox');
  
  /*await boxx.clear();
 print(boxx.length); */
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
