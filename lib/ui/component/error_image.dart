import 'package:flutter/material.dart';

class ErrorImage extends StatelessWidget {
  final Color color;

  const ErrorImage({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.error,
        color: color,
        size: 200,
      ),
    );
  }
}
