import 'package:flutter/material.dart';

class AnimatedBinStatusCard extends StatelessWidget {
  final Color color;
  final String status;
  final String subtitle;
  final double fillLevel;
  final bool isMain;
  final String? iconPath;

  final double scale;
  const AnimatedBinStatusCard({
    super.key,
    required this.color,
    required this.status,
    required this.subtitle,
    required this.fillLevel,
    required this.isMain,
    this.iconPath,
    this.scale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    // Animate size
    final Size screenSize = MediaQuery.of(context).size;
    final double baseWidth = screenSize.width * 0.5;
    final double baseHeight = 150.0;
    final double boxWidth = baseWidth * scale;
    final double boxHeight = baseHeight * scale;
    final double iconSize = 105 + 55 * scale;
    final double marginSize = 20 * (2 - scale);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      margin: EdgeInsets.symmetric(horizontal: marginSize, vertical: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: boxWidth,
            height: boxHeight,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.16),
                  blurRadius: 16,
                  spreadRadius: 2,
                  offset: Offset(0, 8),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 320),
                height: iconSize,
                width: iconSize,
                child: Image.asset(
                  iconPath ?? 'assets/icons/Icons/tree.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.image_not_supported,
                    color: Colors.white.withOpacity(0.7),
                    size: iconSize,
                  ),
                ),
              ),
              // SizedBox(height: 20 * scale),
              // AnimatedOpacity(
              //   opacity: scale > 0.99 ? 1.0 : 0.5,
              //   duration: const Duration(milliseconds: 200),
              //   child: Column(
              //     children: [
              //       Text(
              //         status,
              //         style: CustomStyle.sixteenWhite.copyWith(
              //           fontSize: 12 * scale + 2,
              //           fontWeight: FontWeight.bold,
              //           overflow: TextOverflow.ellipsis,
              //         ),
              //         maxLines: 1,
              //       ),
              //       const SizedBox(height: 4),
              //       Text(
              //         subtitle,
              //         style: CustomStyle.twelveWhite.copyWith(
              //           fontSize: 12 * scale + 2,
              //           color: Colors.white.withOpacity(0.9),
              //           overflow: TextOverflow.ellipsis,
              //         ),
              //         maxLines: 2,
              //         textAlign: TextAlign.center,
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 90 * scale),
              // Optionally, put a fill indicator
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 12.0),
              //   child: LinearProgressIndicator(
              //     value: fillLevel.clamp(0.0, 1.0),
              //     minHeight: 6.0 * scale,
              //     backgroundColor: Colors.white.withOpacity(0.2),
              //     valueColor: AlwaysStoppedAnimation<Color>(
              //       isMain ? Colors.yellow : Colors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
