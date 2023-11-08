import 'package:flutter/material.dart';
import 'package:woofpedia/pages/home_page.dart';
import 'package:woofpedia/providers/home_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Woofapedia',
        home: HomeProvider(child: HomePage()));
  }
}
