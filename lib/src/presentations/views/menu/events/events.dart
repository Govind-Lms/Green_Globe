import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/models/event_model.dart';
import 'package:green_globe/src/presentations/views/menu/events/event_details.dart';
import 'package:lottie/lottie.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  int _selectedTab = 0;

  void _onTabChanged(int tabIndex) {
    if (_selectedTab != tabIndex) {
      setState(() {
        _selectedTab = tabIndex;
      });
    }
  }

  String _searchName = '';

  void _onSearchChanged(String value) {
    setState(() {
      _searchName = value.trim().toLowerCase();
    });
  }

  List<EventModel> get _filteredEvents {
    if (_searchName.isEmpty) return events;
    return events.where((event) {
      return event.name.toLowerCase().contains(_searchName);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Filter events based on tab and search query
    List<EventModel> filteredList;
    if (_selectedTab == 0) {
      filteredList = _filteredEvents;
    } else if (_selectedTab == 1) {
      filteredList = _filteredEvents
          .where((event) => event.type == 'global')
          .toList();
    } else {
      filteredList = _filteredEvents
          .where((event) => event.type == 'local')
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Events",
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_buildSearchRow(context)],
            ),
          ),
          _SegmentedTabs(
            selectedIndex: _selectedTab,
            onTabChanged: _onTabChanged,
          ),
          SizedBox(height: 10),
          Expanded(
            child: filteredList.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ).copyWith(bottom: 24),
                    itemCount: filteredList.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      return _EventCard(item: item);
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 220,
                        child: Lottie.asset(
                          'assets/lotties/calendar.json',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No Events Found',
                        textAlign: TextAlign.center,
                        style: CustomStyle.twenty.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Try searching for another event or change the tab.',
                        style: CustomStyle.fourteen.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE6E6E6)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Icon(Icons.search, color: primaryGreen, size: 24),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: CustomStyle.fourteen.copyWith(
                        color: Colors.grey.shade400,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.item});

  final EventModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => EventDetailsPage(eventModel: item)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                height: 100,
                width: 80,
                child: Image.asset(
                  "assets/icons/Event_Images/${item.image}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.date.toUpperCase(),
                    style: CustomStyle.fourteen.copyWith(
                      color: primaryGreen,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.name,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: CustomStyle.twenty.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(4),
        width: 300,
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
                    borderRadius: BorderRadius.circular(10),
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
                      'All',
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
                    borderRadius: BorderRadius.circular(10),
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
                      'Global',
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
            const SizedBox(width: 6),
            Expanded(
              child: GestureDetector(
                onTap: () => onTabChanged(2),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: selectedIndex == 2
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: selectedIndex == 2
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
                      'Local',
                      style: CustomStyle.fourteen.copyWith(
                        color: selectedIndex == 2
                            ? primaryGreen
                            : Colors.grey.shade500,
                        fontWeight: selectedIndex == 2
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
