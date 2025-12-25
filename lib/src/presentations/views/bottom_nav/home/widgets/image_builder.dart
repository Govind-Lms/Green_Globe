import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    super.key,
    required this.context,
    required this.image,
    required this.text,
  });

  final BuildContext context;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    // Explicitly set the header image's aspect ratio and max width to avoid overflow
    return LayoutBuilder(
      builder: (ctx, constraints) {
        // Use screen width with a fixed height/aspect ratio
        double width = MediaQuery.sizeOf(
          context,
        ).width; // match horizontal page padding
        if (text == '') {
          return LayoutBuilder(
            builder: (context, constraints) {
              // Fixed height (adjust as appropriate), width matches parent
              return Container(
                width: double.infinity,
                height: 180,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.broken_image, size: 40),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                width: width,
                height: 180,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.broken_image, size: 40),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                height: 50,
                child: Text(text, style: CustomStyle.twelveWhite, maxLines: 2),
              ),
            ],
          );
        }
      },
    );
  }
}
