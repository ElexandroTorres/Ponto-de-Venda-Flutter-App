import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontodevenda/common/theme/app_colors.dart';

import '../../service/bloc/user/user_bloc.dart';
import '../../service/bloc/user/user_event.dart';

class SellerSearchWidget extends StatelessWidget {
  const SellerSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (query) {
        context.read<UserBloc>().add(FilterUsersEvent(query));
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        labelText: 'Pesquisar vendedor...',
        labelStyle: const TextStyle(color: AppColors.subtitle),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: const Icon(Icons.search, color: AppColors.primaryBlue),
      ),
    );
  }
}
