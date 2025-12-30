import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/menu/events/events.dart';
import 'package:green_globe/src/presentations/views/menu/events/past_event.dart';
import 'package:lottie/lottie.dart';

class EmptyEventsPage extends StatefulWidget {
  const EmptyEventsPage({super.key});

  @override
  State<EmptyEventsPage> createState() => _EmptyEventsPageState();
}

class _EmptyEventsPageState extends State<EmptyEventsPage> {
  int _selectedTab = 0;

  void _onTabChanged(int tabIndex) {
    if (_selectedTab != tabIndex) {
      setState(() {
        _selectedTab = tabIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Events',
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          _SegmentedTabs(
            selectedIndex: _selectedTab,
            onTabChanged: _onTabChanged,
          ),
          const SizedBox(height: 32),
          Expanded(
            child: _selectedTab == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 220,
                        child: Lottie.asset(
                          'assets/lotties/calendar.json',
                          fit: BoxFit.contain,
                          repeat: true,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No Upcoming\nEvent',
                        textAlign: TextAlign.center,
                        style: CustomStyle.twenty.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Search for a particular event.',
                        style: CustomStyle.fourteen.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  )
                : PastEventsPage(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SizedBox(
              width: 300,
              height: kToolbarHeight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => EventsPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 6,
                  shadowColor: primaryGreen.withOpacity(0.35),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'EXPLORE EVENTS',
                      style: CustomStyle.sixteenWhite.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const _SegmentedTabs({
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF4F4F4),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.all(4),
        width: 230,
        height: 36,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onTabChanged(0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: selectedIndex == 0
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: selectedIndex == 0
                        ? [
                            BoxShadow(
                              color: primaryGreen.withOpacity(0.12),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      'UPCOMING',
                      style: CustomStyle.fourteen.copyWith(
                        color: selectedIndex == 0
                            ? primaryGreen
                            : Colors.grey.shade500,
                        fontWeight: selectedIndex == 0
                            ? FontWeight.w700
                            : FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: GestureDetector(
                onTap: () => onTabChanged(1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: selectedIndex == 1
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: selectedIndex == 1
                        ? [
                            BoxShadow(
                              color: primaryGreen.withOpacity(0.12),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      'PAST EVENTS',
                      style: CustomStyle.fourteen.copyWith(
                        color: selectedIndex == 1
                            ? primaryGreen
                            : Colors.grey.shade500,
                        fontWeight: selectedIndex == 1
                            ? FontWeight.w700
                            : FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
