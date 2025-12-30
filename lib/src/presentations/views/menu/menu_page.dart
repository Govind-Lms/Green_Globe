import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/account/about_page.dart';
import 'package:green_globe/src/presentations/views/menu/bins/smart_bins.dart';
import 'package:green_globe/src/presentations/views/menu/events/empty_event.dart';
import 'package:green_globe/src/presentations/views/menu/leaderboard/leaderboard_view.dart';
import 'package:green_globe/src/presentations/views/menu/marketplace/marketplace.dart';
import 'package:green_globe/src/presentations/views/menu/points/redeem_points.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swipe/swipe.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Swipe(
      onSwipeLeft: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: primaryGreen,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 12),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Green Globe',
                        style: CustomStyle.twenty.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Image.asset('assets/icons/logo_white.png', height: 76),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _MenuItem(
                        icon: Icons.shopping_bag_outlined,
                        label: 'Marketplace',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const MarketplacePage(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 24),
                      _MenuItem(
                        icon: Icons.delete_outline,
                        label: 'Smart Bins',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SmartBinsPage(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 24),
                      _MenuItem(
                        icon: Iconsax.medal_star5,
                        label: 'Points',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const RedeemPoints(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 24),
                      _MenuItem(
                        icon: Iconsax.ranking_15,
                        label: 'Leaderboard',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const LeaderboardView(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 24),
                      _MenuItem(
                        icon: Icons.event_note_outlined,
                        label: 'Events',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const EmptyEventsPage(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 24),
                      _MenuItem(
                        icon: Icons.settings_outlined,
                        label: 'Settings',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AboutPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Designed By',
                        style: CustomStyle.twelveWhite.copyWith(
                          fontSize: 11,
                          color: Colors.white70,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Europa'.toUpperCase(),
                        style: CustomStyle.fourteenWhite.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 38,
            width: 38,
            alignment: Alignment.center,
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: CustomStyle.sixteenWhite.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
