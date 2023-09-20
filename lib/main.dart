import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mentalo/pages/home_page.dart';

void main() async {
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Wooju',
        scaffoldBackgroundColor: const Color(0xffECF5E6),
        useMaterial3: true,
      ),
      home: const Scaffold(body: SafeArea(child: HomePage())),
    );
  }
}
