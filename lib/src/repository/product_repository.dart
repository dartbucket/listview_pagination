import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:list_pagination/src/model/product_model.dart';
import 'package:list_pagination/src/network/network.dart';
import 'package:list_pagination/src/res/endpoints.dart';

final productRepositoryProvider = Provider((ref) {
  final networkHandler = ref.watch(networkHandlerProvider);
  return ProductRepository(networkHandler: networkHandler);
});

class ProductRepository {
  final NetworkHandler _networkHandler;

  ProductRepository({
    required NetworkHandler networkHandler,
  }): _networkHandler = networkHandler;

  Future<List<Product>?> getProducts({ required int skip, int limit = 10 }) async {
    log("Products Requested");

    final url = Endpoints.productUrl(skip: skip, limit: limit);
    final response = await _networkHandler.getRequest(url: url);
    if(response!=null){
      final jsonData = jsonDecode(response.body);
      final List productsJson = jsonData['products'];
      final products = productsJson.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      log("Failed to load products");
      return null;
    }
  }
}