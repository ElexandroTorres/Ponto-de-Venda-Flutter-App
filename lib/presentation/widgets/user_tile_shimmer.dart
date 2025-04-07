import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserTileShimmer extends StatelessWidget {
  const UserTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListTile(
        leading: CircleAvatar(radius: 24, backgroundColor: Colors.white),
        title: Container(height: 12, color: Colors.white, margin: EdgeInsets.only(bottom: 6)),
        subtitle: Container(height: 12, color: Colors.white, width: 100),
      ),
    );
  }
}