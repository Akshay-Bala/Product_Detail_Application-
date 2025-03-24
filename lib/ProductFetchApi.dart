import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:product_detail_application/ProductModel.dart';

class ApiService {
  static const String apiUrl = "https://dummyjson.com/products";

  Future<Product?> fetchProduct() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Product.fromJson(data);
      } else {
        print("Failed to load product: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching product: $e");
      return null;
    }
  }
}
