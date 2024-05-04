import 'package:flutter/material.dart';
import 'package:list_pagination/src/model/product_model.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({super.key, required this.product,});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey,
            width: 0.3
          ),
        ),
      ),
      child: Row(
        children: [
          Image.network(
            product.thumbnail,
            height: 100,
            width: 200,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Text(product.description, maxLines: 3,),
                Text("\$${product.price}",style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ],
            ),
          )
        ],
      ),
    );
  }
}