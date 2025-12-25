import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';

class QuoteView extends StatelessWidget {
  final String quote;
  final Color color;

  const QuoteView({super.key, required this.quote, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withOpacity(0.2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 4,
            height: quote.length < 100 ? kToolbarHeight : 100,
            color: color,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              quote,
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
              // maxLines: 2,
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
