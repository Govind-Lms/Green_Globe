import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/menu/widgets/rank_widget.dart';
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
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                ? Center(child: Text('Error: ${_error!}'))
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
