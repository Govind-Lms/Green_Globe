import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';

class TitleBuilder extends StatelessWidget {
  const TitleBuilder({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
