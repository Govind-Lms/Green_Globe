import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/core/auth.dart';
import 'package:green_globe/src/models/category_model.dart';
import 'package:green_globe/src/models/eco_model.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_friendly_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_views/eco_product.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_views/eco_transport.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_views/food_waste_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_views/plant_a_tree.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_views/reuse_before_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_views/unplug_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_views/use_reusable_bags.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_views/water_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/alluminum_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/cardboard.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/clothing_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/e_waste_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/glass_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/metal_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/organic_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/plastic_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/tyre_view.dart';
import 'package:green_globe/src/presentations/views/menu/auctions/auction_page.dart';
import 'package:green_globe/src/presentations/widgets/custom_app_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  const _PointsCard(),
                  const SizedBox(height: 24),
                  _SectionHeader(
                    title: 'HOW TO RECYCLE?',
                    onSeeAll: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (_) => RecycleView()));
                    },
                  ),
                  const SizedBox(height: 12),
                  _RecycleCategories(),
                  const SizedBox(height: 22),
                  _SectionHeader(
                    title: 'Eco-Friendly Tips',
                    onSeeAll: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => EcoFriendlyView()),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  // _EcoFriendlyPart(),
                  ...List.generate(
                    ecoLists.length,
                    (index) => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 14,
                            offset: const Offset(-6, -6),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          final pages = [
                            PlantATreeDetailsView(ecoModel: ecoLists[index]),
                            ReusableBagsDetailsView(ecoModel: ecoLists[index]),
                            SaveWaterDetailsView(ecoModel: ecoLists[index]),
                            FoodWasteDetailsView(ecoModel: ecoLists[index]),
                            ReuseBeforeDetailsView(ecoModel: ecoLists[index]),
                            EcoTransportDetailsView(ecoModel: ecoLists[index]),
                            UnplugDetailsView(ecoModel: ecoLists[index]),
                            EcoProductDetailsView(ecoModel: ecoLists[index]),
                          ];
                          // Defensive: avoid out-of-bounds
                          if (index < pages.length) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => pages[index],
                              ),
                            );
                          }
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ecoLists[index].title,
                                    style: CustomStyle.sixteen.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    ecoLists[index].shortDesc,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style: CustomStyle.fourteen.copyWith(
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              height: 100,
                              width: 60,
                              child: Image.asset(
                                ecoLists[index].icon,
                                height: 40,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PointsCard extends StatefulWidget {
  const _PointsCard();

  @override
  State<_PointsCard> createState() => _PointsCardState();
}

class _PointsCardState extends State<_PointsCard> {
  bool _pointsVisible = true;

  // Cache the user stats for cleaner toggling UI
  Future<Map<String, dynamic>?>? _userStatsFuture;

  @override
  void initState() {
    super.initState();
    _userStatsFuture = _fetchUserStats(context);
  }

  Future<Map<String, dynamic>?> _fetchUserStats(BuildContext context) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      final user = AuthService.getCurrentUser();
      if (user == null) {
        return <String, dynamic>{
          'smart_bins_nearby': "-",
          'bins_notified': "-",
          'points_used': "-",
          'points_history': [],
        };
      } else {
        final client = Supabase.instance.client;
        final userEmail = user.email;
        final userData = await client
            .from('users')
            .select('points_history')
            .eq('email', userEmail!)
            .maybeSingle(); // Use maybeSingle to avoid crash when not found
        final pointHistory = (userData?['points_history'] as List?) ?? [];
        final binsNearby = barcodeLists.length;
        return <String, dynamic>{
          'smart_bins_nearby': "$binsNearby",
          'bins_notified': "${pointHistory.length}",
          'points_used': "0",
          'points_history': pointHistory,
        };
      }
    } catch (e, stackTrace) {
      debugPrint('Error in _fetchUserStats: $e\n$stackTrace');
      // Don't show snackbar if context is not mounted
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Failed to fetch user stats. Please try again.',
            ),
            backgroundColor: Colors.red[400],
          ),
        );
      }
      return <String, dynamic>{
        'smart_bins_nearby': "-",
        'bins_notified': "-",
        'points_used': "-",
        'points_history': [],
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            "Total Points You've Earned",
            style: CustomStyle.twelveWhite.copyWith(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Map<String, dynamic>?>(
                future: _userStatsFuture,
                builder: (context, snapshot) {
                  int totalPoints = 0;
                  final userData = snapshot.data;
                  if (userData != null && userData['points_history'] is List) {
                    for (final entry in userData['points_history']) {
                      if (entry is Map && entry['points_earned'] != null) {
                        final earned = entry['points_earned'];
                        try {
                          totalPoints += earned is int
                              ? earned
                              : int.tryParse(earned.toString()) ?? 0;
                        } catch (_) {}
                      }
                    }
                  }
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _pointsVisible ? '$totalPoints Points' : '••••••',
                        style: CustomStyle.twenty.copyWith(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _pointsVisible = !_pointsVisible;
                          });
                        },
                        child: Icon(
                          _pointsVisible
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Shortcut(
                icon: Icons.delete_outline,
                label: 'Smart Bin',
                onTap: () {},
              ),
              _Shortcut(
                icon: Icons.gavel_outlined,
                label: 'Auctions',
                onTap: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => AuctionPage()));
                },
              ),
              _Shortcut(
                icon: Iconsax.medal_star5,
                label: 'Points',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 18),
          FutureBuilder<Map<String, dynamic>?>(
            future: _userStatsFuture,
            builder: (context, snapshot) {
              final isLoading =
                  snapshot.connectionState == ConnectionState.waiting;
              final hasData = snapshot.hasData && snapshot.data != null;

              String smartBinsNearby = '?';
              String binsNotified = '?';
              String pointsUsed = '?';

              if (hasData) {
                final stats = snapshot.data!;
                smartBinsNearby = (stats['smart_bins_nearby'] ?? '?')
                    .toString();
                binsNotified = (stats['bins_notified'] ?? '?').toString();
                pointsUsed = (stats['points_used'] ?? '?').toString();
              }

              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: const _ShimmerStat(),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 36,
                            color: Colors.grey.shade200,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: const _ShimmerStat(),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 36,
                            color: Colors.grey.shade200,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: const _ShimmerStat(),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _Stat(
                            label: 'Smart\nBins Nearby',
                            value: smartBinsNearby,
                          ),
                          Container(
                            width: 1,
                            height: 36,
                            color: Colors.grey.shade300,
                          ),
                          _Stat(
                            label: "Bins\nYou've Notified",
                            value: binsNotified,
                          ),
                          Container(
                            width: 1,
                            height: 36,
                            color: Colors.grey.shade300,
                          ),
                          _Stat(label: 'Points\nUsed', value: pointsUsed),
                        ],
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ShimmerStat extends StatelessWidget {
  const _ShimmerStat();
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: kToolbarHeight * 0.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class _Shortcut extends StatelessWidget {
  const _Shortcut({
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
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: primaryGreen, size: 26),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: CustomStyle.fourteen.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: CustomStyle.eighteen.copyWith(
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: CustomStyle.twelve.copyWith(color: Colors.grey.shade700),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onSeeAll});
  final String title;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: CustomStyle.sixteen.copyWith(
            fontWeight: FontWeight.w700,
            color: primaryGreen,
          ),
        ),
        TextButton(
          onPressed: onSeeAll,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'See All',
            style: CustomStyle.fourteen.copyWith(
              color: primaryGreen,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _RecycleCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // Defensive: stop IndexError for recycled categories
          if (index >= recycleLists.length) return const SizedBox.shrink();
          return InkWell(
            onTap: () {
              final pages = [
                PlasticsRecycleMethodDetailsView(),
                GlassRecycleMethodDetailsView(),
                CardboardRecycleMethodDetailsView(),
                TyreRecycleMethodDetailsView(),
                ClothingRecycleMethodDetailsView(),
                EwasteRecycleMethodDetailsView(),
                MetalRecycleMethodDetailsView(),
                OrganicRecycleMethodDetailsView(),
                AluminiumRecyclingDetailsView(recycleItem: {}),
              ];
              if (index < pages.length) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pages[index]),
                );
              }
            },
            child: Container(
              width: 120,
              decoration: BoxDecoration(
                color: recycleLists[index].color,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(recycleLists[index].image, height: 52),
                  const SizedBox(height: 12),
                  Text(
                    recycleLists[index].title,
                    style: CustomStyle.sixteen.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemCount: recycleLists.length,
      ),
    );
  }
}
