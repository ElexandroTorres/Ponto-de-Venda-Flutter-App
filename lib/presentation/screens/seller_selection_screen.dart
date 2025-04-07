import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontodevenda/common/theme/app_colors.dart';
import 'package:pontodevenda/common/theme/app_text_styles.dart';
import 'package:pontodevenda/domain/models/user.dart';
import 'package:pontodevenda/presentation/screens/product_screen.dart';

import '../../service/bloc/user/user_bloc.dart';
import '../../service/bloc/user/user_event.dart';
import '../widgets/primary_button_widget.dart';
import '../widgets/seller_list_widget.dart';
import '../widgets/seller_search_widget.dart';

class SellerSelectionScreen extends StatefulWidget {
  const SellerSelectionScreen({super.key});

  @override
  State<SellerSelectionScreen> createState() => _SellerSelectionScreenState();
}

class _SellerSelectionScreenState extends State<SellerSelectionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadUsersEvent());
  }

  Future<void> _reloadUsers() async {
    context.read<UserBloc>().add(LoadUsersEvent());
  }

  void _goToProductScreen(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProductScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text('Seleção de Vendedor', style: AppTextStyles.title),
        iconTheme: const IconThemeData(color: AppColors.primaryBlue),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: SellerSearchWidget(),
            ),
            const SizedBox(height: 8),
            Expanded(child: SellerListWidget(onTap: _goToProductScreen)),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: PrimaryButton(
          text: 'Confirmar Seleção',
          onPressed: () {}, // ação futura
        ),
      ),
    );
  }
}
