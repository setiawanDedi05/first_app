import 'package:flutter/material.dart';
import 'package:myproject/pages/add_Barang_page.dart';
import 'package:myproject/pages/detail_barang_page.dart';
import 'package:myproject/pages/searching_page.dart';
import 'package:myproject/pages/splash.dart';
import 'package:myproject/providers/barang.dart';
import 'package:provider/provider.dart';
import './pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            return ChangeNotifierProvider(
              create: (context) => Barangs(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: HomePage(),
                routes: {
                  AddBarang.routeName: (context) => AddBarang(),
                  DetailBarang.routeName: (context) => DetailBarang(),
                  SearchingPage.routeName: (context) => SearchingPage(),
                },
              ),
            );
          }
        });
  }
}
