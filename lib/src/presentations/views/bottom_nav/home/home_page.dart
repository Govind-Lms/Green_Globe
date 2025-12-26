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
import 'package:green_globe/src/presentations/widgets/custom_app_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

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
                  _PointsCard(),
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
                      margin: EdgeInsets.symmetric(vertical: 10),
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
                            PlantATreeDetailsView(),
                            ReusableBagsDetailsView(),
                            SaveWaterDetailsView(),
                            FoodWasteDetailsView(),
                            ReuseBeforeDetailsView(),
                            EcoTransportDetailsView(),
                            UnplugDetailsView(),
                            EcoProductDetailsView(),
                          ];

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
                            Container(
                              height: 100,
                              width: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F7EE),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(
                                ecoLists[index].icon,
                                color: primaryGreen,
                                size: 28,
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

class _PointsCard extends StatelessWidget {
  const _PointsCard();

  Future<Map<String, dynamic>?> _fetchUserStats(BuildContext context) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      final user = AuthService.getCurrentUser();
      if (user == null) {
        return <String, dynamic>{
          'smart_bins_nearby': "?",
          'bins_notified': "?",
          'points_used': "?",
        };
      } else {
        // Dummy values if signed in
        return <String, dynamic>{
          'smart_bins_nearby': "6",
          'bins_notified': "3",
          'points_used': "211",
        };
      }
    } catch (e) {
      // Handle or log the error as needed
      return null;
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
              Text(
                '211 Points',
                style: CustomStyle.twenty.copyWith(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.remove_red_eye, color: Colors.white, size: 18),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Shortcut(icon: Icons.delete_outline, label: 'Smart Bin'),
              _Shortcut(icon: Icons.gavel_outlined, label: 'Auctions'),
              _Shortcut(icon: Iconsax.medal_star5, label: 'Points'),
            ],
          ),
          const SizedBox(height: 18),
          FutureBuilder<Map<String, dynamic>?>(
            future: _fetchUserStats(
              context,
            ), // fetches stats or null if not signed in
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
                    // FIX: Provide the missing _ShimmerStat widget
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: _ShimmerStat(),
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
                              child: _ShimmerStat(),
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
                              child: _ShimmerStat(),
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
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          Colors.grey.shade300,
          Colors.grey.shade100,
          Colors.grey.shade300,
        ],
        stops: [0.1, 0.5, 0.9],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),

      child: Container(
        height: kToolbarHeight,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class _Shortcut extends StatelessWidget {
  const _Shortcut({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          return InkWell(
            onTap: () {
              // You need to create this list/map to match each category with the correct page/link
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
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 26,
                    child: Icon(
                      recycleLists[index].image,
                      color: primaryGreen,
                      size: 26,
                    ),
                  ),
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
