import 'package:flutter/material.dart';
import 'package:woofpedia/pages/home_page.dart';
import 'package:woofpedia/providers/home_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Woofapedia',
        home: HomeProvider(child: HomePage()));
  }
}
