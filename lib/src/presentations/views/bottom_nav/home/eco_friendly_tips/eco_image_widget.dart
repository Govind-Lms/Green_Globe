import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';

class EcoImageBuilder extends StatelessWidget {
  final String image;
  final String text;
  final String shortDesc;

  const EcoImageBuilder({
    super.key,
    required this.image,
    required this.text,
    required this.shortDesc,
  });

  @override
  Widget build(BuildContext context) {
    // Set a fixed aspect ratio, and ensure consistent sizing/layout
    return Container(
      decoration: BoxDecoration(
        color: accentGreen,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      height: 180,
      child: Stack(
        children: [
          // Background Image
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              image,
              // fit: BoxFit.cover,
              width: 180,
              height: 200,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                ),
              ),
            ),
          ),
          // Caption Text
          Positioned(
            right: 0,
            top: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),

              child: Column(
                children: [
                  Text(
                    text,
                    style: CustomStyle.twenty.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Text(
                  //   shortDesc,
                  //   style: CustomStyle.sixteen,
                  //   maxLines: 20,
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
