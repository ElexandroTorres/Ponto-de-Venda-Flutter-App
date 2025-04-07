import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontodevenda/common/theme/app_colors.dart';
import 'package:pontodevenda/common/theme/app_text_styles.dart';
import 'package:pontodevenda/service/bloc/admin/admin_bloc.dart';
import 'package:pontodevenda/service/bloc/admin/admin_event.dart';
import 'package:pontodevenda/service/bloc/admin/admin_state.dart';
import '../widgets/primary_button_widget.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController _cartIdController = TextEditingController();

  @override
  void dispose() {
    _cartIdController.dispose();
    super.dispose();
  }

  void _onCancelPressed(BuildContext context) {
    final cartId = _cartIdController.text.trim();
    context.read<AdminBloc>().add(CancelSaleRequested(cartId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Administração', style: AppTextStyles.title),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(color: AppColors.primaryBlue),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state is AdminSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.primaryBlue,
                ),
              );
            } else if (state is AdminFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cancelar Venda', style: AppTextStyles.subtitle),
                const SizedBox(height: 16),
                TextField(
                  controller: _cartIdController,
                  keyboardType: TextInputType.number,
                  style: AppTextStyles.body,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.white,
                    labelText: 'ID do Carrinho',
                    labelStyle: const TextStyle(color: AppColors.subtitle),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.primaryBlue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                state is AdminLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        text: 'Cancelar Venda',
                        onPressed: () => _onCancelPressed(context),
                      ),
                    ),
              ],
            );
          },
        ),
      ),
    );
  }
}
