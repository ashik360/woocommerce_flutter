// cart_service.dart
class CartService {
  static final List<Map<String, dynamic>> _cartItems = [];

  static void addToCart(Map<String, dynamic> product, int quantity) {
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
  }

  static List<Map<String, dynamic>> get cartItems => _cartItems;

  static double get totalPrice => _cartItems.fold(
      0.0,
      (sum, item) =>
          sum + ((item['price'] as double) * (item['quantity'] as int)));

  static int get itemCount => _cartItems.length;

  static void incrementQuantity(int index) {
    _cartItems[index]['quantity']++;
  }

  static void decrementQuantity(int index) {
    if (_cartItems[index]['quantity'] > 1) {
      _cartItems[index]['quantity']--;
    }
  }
}
