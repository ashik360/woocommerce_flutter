import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://heatanimal.s1-tastewp.com/wp-json/wc/v3/products';
  static const String _consumerKey = 'ck_db05dfc8d7627f8f4b85a39783d71398c664788f';
  static const String _consumerSecret = 'cs_181980c50a7f8b2b083010f23c942fca38392bfb';

  // Fetch all products
  static Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('$_baseUrl?consumer_key=$_consumerKey&consumer_secret=$_consumerSecret&per_page=15&page=1'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // WooCommerce returns a list, not an object
    } else {
      throw Exception("Failed to load products");
    }
  }

  // Fetch product details by ID
  static Future<Map<String, dynamic>> fetchProductDetails(int id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$id?consumer_key=$_consumerKey&consumer_secret=$_consumerSecret'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Returns a single product
    } else {
      throw Exception("Failed to load product details");
    }
  }
}
