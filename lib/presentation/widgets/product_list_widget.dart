import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontodevenda/common/theme/app_text_styles.dart';
import 'package:pontodevenda/presentation/widgets/product_card_widget.dart';
import 'package:pontodevenda/service/bloc/product/product_bloc.dart';
import 'package:pontodevenda/service/bloc/product/product_state.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductAddUnavailable) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Você atingiu o limite de 10 itens na venda.'),
                duration: Duration(seconds: 2),
              ),
            );
          });
        }

        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductError) {
          return Center(child: Text(state.message, style: AppTextStyles.error));
        }

        final products = context.read<ProductBloc>().products;

        if (products.isEmpty) {
          return const Center(
            child: Text(
              'Nenhum produto encontrado.',
              style: AppTextStyles.body,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.66,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              final productCount =
                  context.watch<ProductBloc>().productCounts[product] ?? 0;

              return ProductCardWidget(product: product, count: productCount);
            },
          ),
        );
      },
    );
  }
}
