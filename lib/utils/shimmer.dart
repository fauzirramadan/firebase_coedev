import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  final double? height, width;
  const Skeleton({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16)),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.3),
      highlightColor: Colors.grey.withOpacity(0.2),
      child: const ListTile(
        leading: Skeleton(
          width: 60,
          height: 60,
        ),
        title: Skeleton(
          width: double.infinity,
          height: 50,
        ),
        subtitle: Skeleton(
          width: 300,
          height: 50,
        ),
      ),
    );
  }
}
