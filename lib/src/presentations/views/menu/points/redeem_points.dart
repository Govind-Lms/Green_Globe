import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/core/auth.dart';
import 'package:green_globe/src/presentations/views/menu/points/specific_points_page.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RedeemPoints extends StatefulWidget {
  const RedeemPoints({super.key});

  @override
  State<RedeemPoints> createState() => _RedeemPointsState();
}

class _RedeemPointsState extends State<RedeemPoints> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = AuthService.getCurrentUser();
      if (user != null) {
        await Supabase.instance.client
            .from('users')
            .select()
            .eq('user_id', user.id)
            .maybeSingle();

        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<Map<String, int>> getTotalPointsByMessage() async {
    final user = AuthService.getCurrentUser();
    final client = Supabase.instance.client;
    final userEmail = user?.email;

    if (userEmail == null) return {};

    final userData = await client
        .from('users')
        .select('points_history')
        .eq('email', userEmail)
        .maybeSingle();

    final pointHistory = (userData?['points_history'] as List?) ?? [];

    // Map to store message -> total points
    final Map<String, int> pointsByMessage = {};

    for (final entry in pointHistory) {
      if (entry is Map) {
        final String message = (entry['message'] ?? '').toString();
        final earned = entry['points_earned'];
        int earnedPoints = 0;
        try {
          earnedPoints = earned is int
              ? earned
              : int.tryParse(earned.toString()) ?? 0;
        } catch (_) {}
        if (message.isNotEmpty) {
          pointsByMessage[message] =
              (pointsByMessage[message] ?? 0) + earnedPoints;
        }
      }
    }

    return pointsByMessage;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Rewards',
            style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // final eventPoints = _getEventPoints();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Rewards',
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Green Banner
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: accentGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Earn Points For Discarded Trash',
                              style: CustomStyle.eighteen.copyWith(
                                color: primaryGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'with your cooperation we can change the world.',
                              style: CustomStyle.fourteen.copyWith(
                                color: secondaryGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Recycling Bin Illustration
                      Image.asset(
                        'assets/icons/recycle_bin.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Exchange Points Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Exchange Points',
                                style: CustomStyle.sixteen.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'The points you earn, the rewards you deserve!',
                                style: CustomStyle.fourteen.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // POINTS Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'POINTS',
                style: CustomStyle.eighteen.copyWith(
                  color: primaryGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Points Cards
            FutureBuilder(
              future: getTotalPointsByMessage(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (AuthService.isSignedIn() == false) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: accentGreen,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'You are not signed in.\nPlease Sign In First',
                          textAlign: TextAlign.center,
                          style: CustomStyle.sixteen.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: accentGreen,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Error loading points',
                          style: CustomStyle.sixteen.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (!snapshot.hasData ||
                    snapshot.data == null ||
                    (snapshot.data is Map && snapshot.data.isEmpty)) {
                  final entries = [
                    {
                      'message': 'Request the Garbage Truck',
                      "points_earned": 0,
                    },
                    {
                      'message': 'Odorous Bins? Request for Cleaning',
                      "points_earned": 0,
                    },
                  ];
                  return Column(
                    children: entries.map((entry) {
                      final message = entry['message'] ?? '';
                      final points = entry['points_earned'] ?? 0;

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => SpecificPointsPage(
                                message: message.toString(),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 12,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: accentGreen,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                // Star Icon
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow[300],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow[800],
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Points Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '$points Points Earned!',
                                        style: CustomStyle.sixteen.copyWith(
                                          color: primaryGreen,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        message.toString(),
                                        style: CustomStyle.fourteen.copyWith(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Arrow Icon
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                  // return Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Container(
                  //     padding: const EdgeInsets.all(20),
                  //     decoration: BoxDecoration(
                  //       color: accentGreen,
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         'No points earned yet',
                  //         style: CustomStyle.sixteen.copyWith(
                  //           color: Colors.grey[600],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // );
                }

                final pointsHistory = snapshot.data;
                // If pointsHistory is a Map<String, int> or List<Map<String, dynamic>>
                // Adjust accordingly to your getTotalPointsByMessage() return type
                // Let's assume it's Map<String, int> as per "byMessage"
                if (pointsHistory is Map<String, int>) {
                  final entries = pointsHistory.entries.toList();

                  return Column(
                    children: entries.map((entry) {
                      final message = entry.key;
                      final points = entry.value;

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  SpecificPointsPage(message: message),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 12,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: accentGreen,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                // Star Icon
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow[300],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow[800],
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Points Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '$points Points Earned!',
                                        style: CustomStyle.sixteen.copyWith(
                                          color: primaryGreen,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        message,
                                        style: CustomStyle.fourteen.copyWith(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Arrow Icon
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else if (pointsHistory is List) {
                  if (pointsHistory.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: accentGreen,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'No points earned yet',
                            style: CustomStyle.sixteen.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: pointsHistory.map<Widget>((entry) {
                      final points = entry['points_earned'] ?? 0;
                      final message = entry['message'] ?? 'Points earned';
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 12,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: accentGreen,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              // Star Icon
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.yellow[300],
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow[800],
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Points Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$points Points Earned!',
                                      style: CustomStyle.sixteen.copyWith(
                                        color: primaryGreen,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      message,
                                      style: CustomStyle.fourteen.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Arrow Icon
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
                // Fallback for unexpected data type
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            // POINTS FROM EVENTS Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'POINTS FROM EVENTS',
                style: CustomStyle.eighteen.copyWith(
                  color: primaryGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Event Points Horizontal List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 220,
                      child: Lottie.asset(
                        'assets/lotties/calendar.json',
                        fit: BoxFit.contain,
                        repeat: true,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'No Point from Events',
                      textAlign: TextAlign.center,
                      style: CustomStyle.twenty.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Earn points by participating in environmental initiatives and activities.',
                      textAlign: TextAlign.center,
                      style: CustomStyle.fourteen.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // else
            //   SizedBox(
            //     height: 120,
            //     child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       padding: const EdgeInsets.symmetric(horizontal: 20),
            //       itemCount: eventPoints.length,
            //       itemBuilder: (context, index) {
            //         final entry = eventPoints[index];
            //         final points = entry['points_earned'] ?? 0;
            //         final timeStr = entry['time'] as String? ?? '';

            //         DateTime? date;
            //         if (timeStr.isNotEmpty) {
            //           try {
            //             date = DateTime.parse(timeStr);
            //           } catch (_) {}
            //         }
            //         final formattedDate = date != null
            //             ? DateFormat('d/M/yyyy').format(date)
            //             : 'N/A';

            //         // Cycle through colors
            //         final colors = [
            //           Colors.yellow,
            //           Colors.grey,
            //           Colors.brown[300]!,
            //         ];
            //         final color = colors[index % colors.length];

            //         return Container(
            //           width: 100,
            //           margin: const EdgeInsets.only(right: 12),
            //           padding: const EdgeInsets.all(12),
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(12),
            //             border: Border.all(color: Colors.grey[200]!),
            //           ),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Container(
            //                 width: 40,
            //                 height: 40,
            //                 decoration: BoxDecoration(
            //                   color: color,
            //                   shape: BoxShape.circle,
            //                 ),
            //               ),
            //               const SizedBox(height: 12),
            //               Text(
            //                 formattedDate,
            //                 style: CustomStyle.twelve.copyWith(
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //                 textAlign: TextAlign.center,
            //               ),
            //               const SizedBox(height: 4),
            //               Text(
            //                 '$points',
            //                 style: CustomStyle.fourteen.copyWith(
            //                   color: color,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         );
            //       },
            //     ),
            //   ),

            // const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
