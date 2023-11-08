import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woofpedia/state/home_state.dart';
import 'package:woofpedia/widgets/base_widget.dart';
import 'package:woofpedia/widgets/dropdown_menu.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // do any setup for state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: BaseWidget<HomeState>(
            state: Provider.of<HomeState>(context),
            builder: (context, state, child) {
              return Scaffold(
                // Create your layout here
                body: Column(children: [
                  SizedBox(
                    height: 100,
                  ),
                  Center(child: Text("hello world"))
                ]),
              );
            }));
  }
}
