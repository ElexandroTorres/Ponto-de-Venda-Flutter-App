import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontodevenda/common/theme/app_text_styles.dart';
import 'package:pontodevenda/domain/models/user.dart';
import 'package:pontodevenda/presentation/widgets/user_tile.dart';
import 'package:pontodevenda/presentation/widgets/user_tile_shimmer.dart';

import '../../service/bloc/user/user_bloc.dart';
import '../../service/bloc/user/user_event.dart';
import '../../service/bloc/user/user_state.dart';

class SellerListWidget extends StatelessWidget {
  final void Function(User user) onTap;

  const SellerListWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return ListView.builder(
            itemCount: 8,
            padding: const EdgeInsets.only(top: 8),
            itemBuilder: (_, __) => const UserTileShimmer(),
          );
        } else if (state is UserError) {
          return const Center(
            child: Text(
              'Erro ao carregar os vendedores',
              style: AppTextStyles.error,
            ),
          );
        } else if (state is UserLoaded) {
          final users = state.filteredUsers;
          if (users.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum vendedor encontrado.',
                style: AppTextStyles.body,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<UserBloc>().add(LoadUsersEvent());
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(
                top: 8,
                left: 12,
                right: 12,
                bottom: 80,
              ),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return UserTile(user: user, onTap: () => onTap(user));
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
