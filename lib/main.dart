import 'package:flutter/material.dart';
import 'package:restapi/cart_service.dart';
import 'package:restapi/product_grid.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CartService.loadCart(); // Load saved cart
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductGridScreen(),
    );
  }
}

class ProductGridScreen extends StatefulWidget {
  const ProductGridScreen({super.key});
  @override
  ProductGridScreenState createState() => ProductGridScreenState();
}


