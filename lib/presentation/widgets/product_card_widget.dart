import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontodevenda/common/theme/app_colors.dart';
import 'package:pontodevenda/common/theme/app_text_styles.dart';
import 'package:pontodevenda/domain/models/product.dart';
import 'package:pontodevenda/service/bloc/product/product_bloc.dart';
import 'package:pontodevenda/service/bloc/product/product_event.dart';

class ProductCardWidget extends StatelessWidget {
  final Product product;
  final int count;

  const ProductCardWidget({
    super.key,
    required this.product,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderBlue, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(product.image, height: 120, fit: BoxFit.fill),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.subtitle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.title,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'R\$ ${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Adicionados: $count',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.subtitle,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.remove,
                        color: AppColors.primaryBlue,
                      ),
                      onPressed:
                          count > 0
                              ? () => context.read<ProductBloc>().add(
                                RemoveProductEvent(product),
                              )
                              : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: AppColors.primaryBlue),
                      onPressed:
                          () => context.read<ProductBloc>().add(
                            AddProductEvent(product),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
