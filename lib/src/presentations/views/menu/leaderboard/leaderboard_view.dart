import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/menu/leaderboard/rank_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({super.key});

  @override
  State<LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchLeaderboard();
  }

  Future<void> _fetchLeaderboard() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await Supabase.instance.client
          .from('leaderboard')
          .select()
          .order('point', ascending: false);

      final list = data
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
      setState(() {
        _items = list;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _items = [];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // --- Begin Shimmer Code ---
  Widget _buildShimmerItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(26),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 18,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 14,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            height: 18,
            width: 38,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardShimmer() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, index) {
        if (index == 0) {
          // Simulate shimmer for the top 3
          return SizedBox(
            height: 175,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 10,
                  bottom: 0,
                  child: Column(
                    children: [
                      Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 60,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 70,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 0,
                  child: Column(
                    children: [
                      Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 60,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (index == 1 || index == 2) {
          return const SizedBox.shrink();
        }
        return _buildShimmerItem();
      },
    );
  }
  // --- End Shimmer Code ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leaderboard',
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? _buildLeaderboardShimmer()
                : _error != null
                ? Center(
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 220,
                              child: Lottie.asset(
                                'assets/lotties/no_internet.json',
                                fit: BoxFit.contain,
                                repeat: true,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                      Icons.notifications_none,
                                      size: 100,
                                      color: Colors.grey.shade400,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Oops! Please Try Again!',
                              textAlign: TextAlign.center,
                              style: CustomStyle.twenty.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "The internet connection appears to be offline.",
                              textAlign: TextAlign.center,
                              style: CustomStyle.fourteen.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () async {
                                await _fetchLeaderboard();
                              },
                              child: Text(
                                "Retry",
                                style: CustomStyle.twelve.copyWith(
                                  color: primaryGreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : _items.isEmpty
                ? const Center(child: Text('No leaderboard entries'))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: _items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      final image = (item['image']).trim();
                      final email = item['email'] ?? 'Unknown';
                      final points = item['point'] ?? 0;

                      if (index == 0) {
                        return SizedBox(
                          height: 175,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Second Place (Left)
                              if (_items.length > 1)
                                Positioned(
                                  left: 10,
                                  bottom: 0,
                                  child: RankWidget(
                                    email: _items[1]['email'],
                                    image: _items[1]['image'],
                                    points: _items[1]['point'],
                                    radius: 34,
                                    rank: '2',
                                  ),
                                ),
                              // First Place (Middle)
                              Align(
                                alignment: Alignment.topCenter,
                                child: RankWidget(
                                  email: email,
                                  image: image,
                                  points: points,
                                  radius: 40,
                                  rank: '1',
                                ),
                              ),
                              // Third Place (Right)
                              if (_items.length > 2)
                                Positioned(
                                  right: 10,
                                  bottom: 0,
                                  child: RankWidget(
                                    email: _items[2]['email'],
                                    image: _items[2]['image'],
                                    points: _items[2]['point'],
                                    radius: 34,
                                    rank: '3',
                                  ),
                                ),
                            ],
                          ),
                        );
                      } else if (index == 1 || index == 2) {
                        return const SizedBox.shrink();
                      }

                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Colors.white,
                        leading: CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: (image != null && image.isNotEmpty)
                              ? CachedNetworkImageProvider(image)
                              : null,
                          child: (image == null || image.isEmpty)
                              ? Image.asset(
                                  'assets/icons/logo_white.png',
                                  height: 28,
                                )
                              : null,
                        ),
                        title: Text(
                          email,
                          style: CustomStyle.fourteen.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text('Rank ${index + 1}'),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$points pts',
                              style: CustomStyle.fourteen.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
