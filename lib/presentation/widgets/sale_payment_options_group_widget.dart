import 'package:flutter/cupertino.dart';
import 'package:pontodevenda/common/theme/app_text_styles.dart';
import 'package:pontodevenda/presentation/widgets/payment_option_tile.dart';

class SalePaymentOptionsGroupWidget extends StatelessWidget {
  const SalePaymentOptionsGroupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Escolha a forma de pagamento:', style: AppTextStyles.body),
        SizedBox(height: 8),
        PaymentOptionTile(label: 'Dinheiro'),
        PaymentOptionTile(label: 'Pix'),
        PaymentOptionTile(label: 'Cartão de Crédito'),
        PaymentOptionTile(label: 'Cartão de Débito'),
      ],
    );
  }
}
