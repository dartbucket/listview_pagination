import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:list_pagination/src/controller/product_list_controller.dart';
import 'package:list_pagination/src/views/widgets/product_list_tile.dart';

class ProductList extends ConsumerStatefulWidget {
  const ProductList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
  final _productListScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _productListScrollController.addListener(() {
      if (_productListScrollController.position.pixels >=
          _productListScrollController.position.maxScrollExtent * 0.9) {
        ref.read(productControllerProvider.notifier).loadProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productListState = ref.watch(productControllerProvider);
    final products = productListState.products;

    if (products.isEmpty) {
      if (productListState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    }

    return ListView.builder(
      controller: _productListScrollController,
      itemCount: products.length + 1,
      itemBuilder: (context, index) {
        if (index == products.length) {
          if (productListState.loading) {
            return const SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const SizedBox.shrink();
        }
        return ProductListTile(
          product: products[index],
        );
      },
    );
  }
}
