import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';

// This is a custom painter for @assets/uis/eco_image_part.png without using assets or image.

class EcoImagePartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // A stylized eco leaf/plant abstraction, "part" shape – green graphic
    final Paint paint = Paint()
      ..color = const Color(0xFF85C88A)
      ..style = PaintingStyle.fill;

    // Main leaf body
    final path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.05,
      size.height * 0.3,
      size.width * 0.5,
      size.height * 0.05,
    );
    path.quadraticBezierTo(
      size.width * 0.95,
      size.height * 0.3,
      size.width * 0.8,
      size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.65,
      size.height * 0.98,
      size.width * 0.5,
      size.height * 0.9,
    );
    path.quadraticBezierTo(
      size.width * 0.35,
      size.height * 0.98,
      size.width * 0.2,
      size.height * 0.8,
    );
    canvas.drawPath(path, paint);

    // Stem (simple thin line)
    final stemPaint = Paint()
      ..color = const Color(0xFF4DA060)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04;
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.9),
      Offset(size.width * 0.5, size.height * 1.05),
      stemPaint,
    );

    // Central vein (decorative, thinner)
    final veinPaint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..strokeWidth = size.width * 0.015
      ..style = PaintingStyle.stroke;
    final veinPath = Path();
    veinPath.moveTo(size.width * 0.5, size.height * 0.13);
    veinPath.quadraticBezierTo(
      size.width * 0.52,
      size.height * 0.45,
      size.width * 0.5,
      size.height * 0.91,
    );
    canvas.drawPath(veinPath, veinPaint);

    // Side vein (one decorative side line)
    final sideVeinPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..strokeWidth = size.width * 0.01
      ..style = PaintingStyle.stroke;
    final sideVeinPath = Path();
    sideVeinPath.moveTo(size.width * 0.5, size.height * 0.45);
    sideVeinPath.quadraticBezierTo(
      size.width * 0.37,
      size.height * 0.6,
      size.width * 0.38,
      size.height * 0.78,
    );
    canvas.drawPath(sideVeinPath, sideVeinPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// A widget to use the eco image part vector illustration directly
class EcoImagePartWidget extends StatelessWidget {
  final double width;
  final double height;

  const EcoImagePartWidget({super.key, this.width = 150, this.height = 150});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: EcoImagePartPainter(),
    );
  }
}

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
    return SizedBox(
      height: 160,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryGreen.withOpacity(.3),
                  primaryGreen.withOpacity(.6),
                  primaryGreen,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Spacer(),
                SizedBox(
                  width: 240,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        text,
                        style: CustomStyle.twentyWhite.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        shortDesc,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 10),
              child: SizedBox(
                height: 140,
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
