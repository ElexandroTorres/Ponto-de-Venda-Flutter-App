import 'package:flutter/material.dart';
import 'package:pontodevenda/domain/models/product.dart';
import 'package:pontodevenda/presentation/widgets/sumary_product_cart_widget.dart';

class SumaryProductListWidget extends StatelessWidget {
  final List<Product> products;

  const SumaryProductListWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (_, index) {
        final product = products[index];
        return SumaryProductCartWidget(product: product);
      },
    );
  }
}
