import 'dart:convert';

import 'package:ecommerce_app/src/domain/models/category.dart';
import 'package:ecommerce_app/src/domain/models/product.dart';
import 'package:ecommerce_app/src/utils/constants.dart';
import 'package:http/http.dart';

class API {
  // Get Categories
  static getCategories() async {
    try {
      String url = AppStrings.baseUrl + AppStrings.categories;
      Response results = await get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var data = jsonDecode(results.body);
      List<Category> categories = [];
      Category all = Category(id: -1, name: "All Products");
      categories.add(all);
      for (var i in data) {
        Category c = Category.fromMap(i);
        categories.add(c);
      }
      return categories;
      // print(categories.length);
    } catch (e) {
      print(e);
      return [];
      
      
    }
  }

  static getAllProducts() async {
    try {
      String url = '${AppStrings.baseUrl}${AppStrings.products}?offset=0&limit=10';
      Response results = await get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var data = jsonDecode(results.body);
      List<Product> products = [];
      for (var i in data) {
        // print(i);
        Product c = Product.fromMap(i);
        products.add(c);
      }
      return products;
      // print(categories.length);
    } catch (e) {
      print(e);
      return [];
    }
  }

  static getProductsByCategory(int categoryId) async {
    try {
      String url = '${AppStrings.baseUrl}${AppStrings.products}?categoryId=$categoryId&offset=0&limit=10';
      Response results = await get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var data = jsonDecode(results.body);
      List<Product> products = [];
      for (var i in data) {
        print(i);
        Product c = Product.fromMap(i);
        products.add(c);
      }
      return products;
      // print(categories.length);
    } catch (e) {
      print(e);
      return [];
    }
  }
}
