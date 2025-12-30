import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/core/auth.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/nav.dart';
import 'package:green_globe/src/presentations/widgets/date_time_parser.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SpecificPointsPage extends StatefulWidget {
  final String message;
  const SpecificPointsPage({super.key, required this.message});

  @override
  State<SpecificPointsPage> createState() => _SpecificPointsPageState();
}

class _SpecificPointsPageState extends State<SpecificPointsPage> {
  // final String _searchMessage = '';
  List<Map<String, dynamic>> pointsHistory = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchPointsHistory();
  }

  Future<void> _fetchPointsHistory() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = AuthService.getCurrentUser();
      if (user == null) {
        setState(() {
          _errorMessage = "No user found.";
          _isLoading = false;
        });
        return;
      }
      final client = Supabase.instance.client;

      final userData = await client
          .from('users')
          .select('points_history')
          .eq('email', user.email!)
          .maybeSingle();

      final allHistory = (userData?['points_history'] as List?) ?? [];

      // Only take entries with matching message, case insensitive
      final filtered = allHistory
          .where((entry) {
            if (entry is Map && entry['message'] != null) {
              return entry['message'].toString().toLowerCase() ==
                  widget.message.toLowerCase();
            }
            return false;
          })
          .cast<Map<String, dynamic>>()
          .toList();

      setState(() {
        pointsHistory = filtered;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to fetch points history.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filtered list by message search
    final filteredPoints = pointsHistory
        .where(
          (entry) =>
              entry['message'] != null &&
              entry['message'].toString().toLowerCase().contains(
                widget.message.toLowerCase(),
              ),
        )
        .toList();

    final user = AuthService.getCurrentUser();

    if (user == null) {
      // Show a placeholder or redirect to sign in page
      // Here let's show a sign in prompt and a button.
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Specific Points',
            style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: 80, color: Colors.grey.shade400),
              const SizedBox(height: 24),
              Text(
                'Sign In Required',
                style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
              Text(
                'You must be signed in to view your points history.',
                style: CustomStyle.fourteen.copyWith(
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => BottomNav()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Specific Points',
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null
                ? Center(
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : filteredPoints.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                      itemCount: filteredPoints.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final entry = filteredPoints[index];
                        final message = entry['message']?.toString() ?? '';
                        final points = entry['points_earned']?.toString() ?? '';
                        final date = entry['time']?.toString() ?? '';
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Use "spacing" argument only if the widget is a Flex,
                          // switch to SizedBox for spacing:
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message,
                              style: CustomStyle.fourteen.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            date_time_parser(date),
                            const SizedBox(height: 10),
                            Text(
                              '+ $points Points',
                              style: CustomStyle.fourteen.copyWith(
                                color: primaryGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 220,
                        child: Lottie.asset(
                          'assets/lotties/EmptyLottie.json',
                          fit: BoxFit.contain,
                          repeat: true,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'No Points Earned',
                        textAlign: TextAlign.center,
                        style: CustomStyle.twenty.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'There is no points earned yet. Keep up the good work!',
                        textAlign: TextAlign.center,
                        style: CustomStyle.fourteen.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
