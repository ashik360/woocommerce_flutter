import 'package:flutter/material.dart';
import 'package:restapi/api_service.dart';
import 'package:restapi/cart_screen.dart';
import 'package:restapi/homepage.dart';
import 'package:restapi/main.dart';
import 'package:restapi/utils.dart';

class ProductGridScreenState extends State<ProductGridScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFF4F6FD),
        appBar: AppBar(
          centerTitle: true,
          title: Text("WooCommerce Api"),
          backgroundColor: AppColors.textWhite,
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          backgroundColor: AppColors.textWhite,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books_rounded),
              label: '',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    FutureBuilder<List<dynamic>>(
      future: ApiService.fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          return HomePage(products: snapshot.data!);
        }
      },
    ),
    Center(child: Text('Category Page', style: TextStyle(fontSize: 24))),
    CartScreen(),
    Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];
}