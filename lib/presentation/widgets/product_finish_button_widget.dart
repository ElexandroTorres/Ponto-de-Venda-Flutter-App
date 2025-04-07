import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontodevenda/presentation/widgets/primary_button_widget.dart';
import 'package:pontodevenda/service/bloc/product/product_bloc.dart';
import 'package:pontodevenda/service/bloc/product/product_state.dart';
import '../screens/sale_sumary_screen.dart';

class ProductFinishButtonWidget extends StatelessWidget {
  const ProductFinishButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        final selectedProducts = context.read<ProductBloc>().productsInCartA;
        final totalPrice = context.read<ProductBloc>().totalPrice;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: PrimaryButton(
            text: 'Finalizar Compra (${selectedProducts.length} produtos)',
            onPressed:
                selectedProducts.isNotEmpty
                    ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => SaleSummaryScreen(
                                products: selectedProducts,
                                total: totalPrice,
                              ),
                        ),
                      );
                    }
                    : null,
          ),
        );
      },
    );
  }
}
