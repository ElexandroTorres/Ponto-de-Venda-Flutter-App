import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontodevenda/common/api/dio_api_client.dart';
import 'package:pontodevenda/common/theme/app_colors.dart';
import 'package:pontodevenda/common/theme/app_text_styles.dart';
import 'package:pontodevenda/repository/payment/payment_repository_impl.dart';
import 'package:pontodevenda/service/bloc/payment/payment_bloc.dart';
import 'package:pontodevenda/service/bloc/payment/payment_event.dart';
import 'package:pontodevenda/service/bloc/payment/payment_state.dart';
import '../widgets/primary_button_widget.dart';

class PaymentScreen extends StatelessWidget {
  final double total;
  final List<Map<String, dynamic>> products;

  const PaymentScreen({super.key, required this.total, required this.products});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = PaymentBloc(PaymentRepositoryImpl(DioApiClient()));
        bloc.add(StartPayment(total));
        return bloc;
      },
      child: _PaymentScreenContent(products: products),
    );
  }
}

class _PaymentScreenContent extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final TextEditingController controller = TextEditingController();

  _PaymentScreenContent({required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text('Pagamento', style: AppTextStyles.title),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryBlue),
      ),
      body: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Pagamento realizado com sucesso!'),
                backgroundColor: AppColors.primaryBlue,
              ),
            );
            Navigator.pushNamed(context, '/seller_selecion');
          } else if (state is PaymentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state) {
              final bloc = context.read<PaymentBloc>();

              double change = 0;
              double total = state.total;
              bool canFinish = false;

              if (state is PaymentValid) {
                change = state.change;
                canFinish = state.paidAmount >= total;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total da venda:',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'R\$ ${total.toStringAsFixed(2)}',
                    style: AppTextStyles.subtitle.copyWith(
                      fontSize: 20,
                      color: AppColors.title,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Valor pago:',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),

                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    style: AppTextStyles.body,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      labelText: 'Digite o valor recebido',
                      labelStyle: const TextStyle(color: AppColors.subtitle),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.primaryBlue,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      bloc.add(PaymentValueChanged(value));
                    },
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Troco:',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'R\$ ${change.toStringAsFixed(2)}',
                    style: AppTextStyles.subtitle.copyWith(
                      fontSize: 18,
                      color: AppColors.primaryBlue,
                    ),
                  ),

                  const Spacer(),

                  state is PaymentSubmitting
                      ? const Center(child: CircularProgressIndicator())
                      : Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            text: 'Finalizar Pagamento',
                            onPressed:
                                canFinish
                                    ? () {
                                      bloc.add(SubmitPayment(products));
                                    }
                                    : null,
                          ),
                        ),
                      ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
