import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontodevenda/common/theme/app_colors.dart';
import 'package:pontodevenda/common/theme/app_text_styles.dart';
import 'package:pontodevenda/domain/models/product.dart';
import 'package:pontodevenda/presentation/screens/payment_screen.dart';
import 'package:pontodevenda/presentation/widgets/sumary_product_list_widget.dart';
import 'package:pontodevenda/service/bloc/product/product_bloc.dart';
import '../widgets/sale_subtotal_widget.dart';

class SaleSummaryScreen extends StatefulWidget {
  final List<Product> products;
  final double total;

  const SaleSummaryScreen({
    super.key,
    required this.products,
    required this.total,
  });

  @override
  State<SaleSummaryScreen> createState() => _SaleSummaryScreenState();
}

class _SaleSummaryScreenState extends State<SaleSummaryScreen> {
  bool showPaymentOptions = false;
  String? selectedPayment;

  void _finalizePurchase() {
    if (selectedPayment != 'Dinheiro') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Atualmente, apenas pagamento em dinheiro está disponível.',
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final cart = context.read<ProductBloc>().productCounts;
    final productList =
        cart.entries.map((entry) {
          return {'productId': entry.key.id, 'quantity': entry.value};
        }).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                PaymentScreen(total: widget.total, products: productList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Resumo da Venda', style: AppTextStyles.title),
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryBlue),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: SumaryProductListWidget(products: widget.products)),
            const SizedBox(height: 16),
            SaleSubtotalWidget(total: widget.total),
            const SizedBox(height: 16),

            GestureDetector(
              onTap: () {
                setState(() {
                  showPaymentOptions = !showPaymentOptions;
                });
              },
              child: Row(
                children: [
                  const Icon(Icons.payment, color: AppColors.primaryBlue),
                  const SizedBox(width: 8),
                  Text(
                    'Escolher forma de pagamento',
                    style: AppTextStyles.subtitle.copyWith(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    showPaymentOptions ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.primaryBlue,
                  ),
                ],
              ),
            ),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child:
                  showPaymentOptions
                      ? Column(
                        key: const ValueKey('options'),
                        children: [
                          const SizedBox(height: 8),
                          _paymentOptionTile('Dinheiro'),
                          _paymentOptionTile('Pix'),
                          _paymentOptionTile('Cartão de Crédito'),
                          _paymentOptionTile('Cartão de Débito'),
                        ],
                      )
                      : const SizedBox.shrink(),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _finalizePurchase,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  textStyle: AppTextStyles.button,
                ),
                child: const Text('Finalizar Compra'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentOptionTile(String label) {
    return ListTile(
      title: Text(label, style: AppTextStyles.body),
      leading: Radio<String>(
        value: label,
        groupValue: selectedPayment,
        onChanged: (value) {
          setState(() {
            selectedPayment = value;
          });
        },
      ),
    );
  }
}
