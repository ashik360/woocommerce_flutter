import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://unabletank.s3-tastewp.com/wp-json/wc/v3/products';
  static const String _consumerKey = 'ck_b83c4d632c394dc0e49aad44a9e1450c55782dc3';
  static const String _consumerSecret = 'cs_35bf4173618a2ea5bce3b5a55db68bfbcfdc552f';

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
