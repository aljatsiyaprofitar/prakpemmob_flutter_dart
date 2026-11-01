import 'package:flutter/material.dart';

import 'package:flutter_dart/ui/produk_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Flutter Pertama',
      theme: ThemeData(useMaterial3: false, primarySwatch: Colors.blue),
      home: const ProdukPage(),
    );
  }
}
