import 'package:flutter/cupertino.dart';
import 'package:pontodevenda/common/theme/app_text_styles.dart';

class SaleSubtotalWidget extends StatelessWidget {
  final double total;

  const SaleSubtotalWidget({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Subtotal:', style: AppTextStyles.body),
        Text('R\$${total.toStringAsFixed(2)}', style: AppTextStyles.subtitle),
      ],
    );
  }
}
