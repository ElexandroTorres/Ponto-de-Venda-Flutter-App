import 'package:flutter/material.dart';
import 'package:pontodevenda/common/theme/app_text_styles.dart';

class PaymentOptionTile extends StatelessWidget {
  final String label;

  const PaymentOptionTile({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: AppTextStyles.body),
      leading: Radio<String>(
        value: label,
        groupValue: 'Pagamento',
        onChanged: (value) {},
      ),
    );
  }
}
