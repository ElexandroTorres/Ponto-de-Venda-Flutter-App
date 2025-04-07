import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontodevenda/common/theme/app_colors.dart';
import 'package:pontodevenda/common/theme/app_text_styles.dart';
import 'package:pontodevenda/service/bloc/product/product_bloc.dart';
import 'package:pontodevenda/service/bloc/product/product_event.dart';
import '../widgets/product_finish_button_widget.dart';
import '../widgets/product_list_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text('Produtos', style: AppTextStyles.title),
        iconTheme: const IconThemeData(color: AppColors.primaryBlue),
      ),
      body: const SafeArea(child: ProductListWidget()),
      bottomNavigationBar: const ProductFinishButtonWidget(),
    );
  }
}
