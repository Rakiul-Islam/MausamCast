import 'package:flutter/material.dart';
import 'package:my_weather_app/modules/data_model.dart';
import 'package:my_weather_app/screens/decider_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MausamCast',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DeciderScreen(),
      ),
    );
  }
}
