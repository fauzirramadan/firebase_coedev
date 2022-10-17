import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  final double? height, width;
  const Skeleton({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
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
          width: 50,
          height: 50,
        ),
        title: Skeleton(
          width: double.infinity,
          height: 30,
        ),
        subtitle: Align(
          alignment: Alignment.centerLeft,
          child: Skeleton(
            width: 200,
            height: 30,
          ),
        ),
      ),
    );
  }
}
