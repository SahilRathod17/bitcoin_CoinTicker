import 'package:flutter/material.dart';
import 'price_screen.dart';

void main(List<String> args) {
  runApp(CoinTicker());
}

class CoinTicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: PriceScreen(),
    );
  }
}
