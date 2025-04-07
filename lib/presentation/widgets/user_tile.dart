import 'package:flutter/material.dart';
import 'package:pontodevenda/common/theme/app_colors.dart';
import 'package:pontodevenda/domain/models/user.dart';

class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const UserTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final fullName = '${user.firstName} ${user.lastName}';
    final city = user.address.city;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderBlue, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                fullName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.title,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.email, size: 18, color: AppColors.primaryBlue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    user.email,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.subtitle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.phone, size: 18, color: AppColors.primaryBlue),
                const SizedBox(width: 8),
                Text(
                  user.phone,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.subtitle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(
                  Icons.location_city,
                  size: 18,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(width: 8),
                Text(
                  city[0].toUpperCase() + city.substring(1),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.subtitle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
