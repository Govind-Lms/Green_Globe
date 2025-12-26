import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:iconsax/iconsax.dart';

class RankWidget extends StatelessWidget {
  final String? email;
  final String? image;
  final int points;
  final double radius;
  final String rank;
  const RankWidget({
    super.key,
    required this.email,
    required this.image,
    required this.points,
    required this.radius,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        rank == "1" ? Icon(Iconsax.crown5, color: primaryGreen) : Container(),
        SizedBox(
          height: radius * 2 + 20,
          child: Stack(
            children: [
              Container(
                width: radius * 2,
                height: radius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: primaryGreen, // or any color you prefer
                    width: 5,
                  ),
                  color: primaryGreen,
                ),
                child: CircleAvatar(
                  radius: radius,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: (image.toString().trim().isNotEmpty)
                      ? CachedNetworkImageProvider(image.toString().trim())
                      : null,
                  child: (image.toString().trim().isEmpty)
                      ? Image.asset('assets/icons/logo.png', height: 22)
                      : null,
                ),
              ),
              Positioned(
                bottom: 10,
                left: rank == "1" ? 27 : 22,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: primaryGreen,
                  child: Center(
                    child: Text(rank, style: CustomStyle.twelveWhite),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Text(
              email != null ? email.toString().split('@')[0] : 'Unknown',
              style: CustomStyle.twelve.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Rank $rank • $points pts',
              style: CustomStyle.twelve.copyWith(color: primaryGreen),
            ),
          ],
        ),
      ],
    );
  }
}
