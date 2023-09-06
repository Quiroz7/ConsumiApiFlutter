import 'package:flutter/material.dart';
import 'package:flutter_application_1/AppBarDolar/dolarAPIConsumo.dart';
import 'package:flutter_application_1/AppBarDolar/dolarAPIGet.dart';



void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Ver Api Dolar',),
                Tab(text: 'Consumir Api Dolar',),
            ],
            ),
            title: const Text('API DOLAR')
          ),
          body: const TabBarView(
              children: [
                DolarApiGet(),
                DolarAPIConsumo()
              
              ],
              )
        )
      )
    );
  }
}
