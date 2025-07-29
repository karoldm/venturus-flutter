import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final double rating;

  const Rating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(10, (index) {
        return Icon(
          size: 12,
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber[700],
        );
      }),
    );
  }
}
