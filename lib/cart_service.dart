import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static List<Map<String, dynamic>> _cartItems = [];

  // Load cart items from SharedPreferences
  static Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart_items');
    if (cartData != null) {
      _cartItems = List<Map<String, dynamic>>.from(json.decode(cartData));
    }
  }

  // Save cart items to SharedPreferences
  static Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cart_items', json.encode(_cartItems));
  }

  static Future<void> addToCart(Map<String, dynamic> product, int quantity) async {
    final existingIndex = _cartItems.indexWhere((item) => item['id'] == product['id']);

    if (existingIndex != -1) {
      _cartItems[existingIndex]['quantity'] += quantity;
    } else {
      _cartItems.add({
        'id': product['id'],
        'name': product['name'],
        'price': double.tryParse(product['price'].toString()) ?? 0.0,
        'quantity': quantity,
        'color': product['color'] ?? "Unknown",
        'image': (product['images'] != null && product['images'].isNotEmpty)
            ? product['images'][0]['src']
            : null,
      });
    }
    await saveCart(); // Save after updating
  }

  static List<Map<String, dynamic>> get cartItems => _cartItems;

  static double get totalPrice => _cartItems.fold(
      0.0, (sum, item) => sum + ((item['price'] as double) * (item['quantity'] as int)));

  static int get itemCount => _cartItems.length;

  static Future<void> incrementQuantity(int index) async {
    _cartItems[index]['quantity']++;
    await saveCart();
  }

  static Future<void> decrementQuantity(int index) async {
    if (_cartItems[index]['quantity'] > 1) {
      _cartItems[index]['quantity']--;
      await saveCart();
    }
  }

  static Future<void> clearCart() async {
    _cartItems.clear();
    await saveCart();
  }
}
