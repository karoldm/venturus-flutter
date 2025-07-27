import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final Function(int rating) onRatingChanged;
  final int initialRating;

  const StarRating(
      {super.key, required this.onRatingChanged, required this.initialRating});

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late int rating;

  @override
  void initState() {
    super.initState();
    rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        10,
        (index) => IconButton(
          icon: Icon(
            Icons.star,
            color: index < rating ? Colors.amber[700] : Colors.grey[300],
          ),
          onPressed: () {
            setState(() {
              rating = index + 1;
            });
            widget.onRatingChanged(index + 1);
          },
        ),
      ),
    );
  }
}
