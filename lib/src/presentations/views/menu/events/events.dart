import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/menu/events/event_details.dart';

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

  final List<_EventItem> _events = [
    _EventItem(
      title: 'Community\nCleaning Event',
      date: '1st  May- Sat -2:00 PM',
      image:
          'https://plus.unsplash.com/premium_photo-1681487469745-91d1d8a5836b?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGV2ZW50c3xlbnwwfHwwfHx8MA%3D%3D',
    ),
    _EventItem(
      title: 'Tidy Up\nDay',
      date: '1st  May- Sat -2:00 PM',
      image:
          'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=400&q=80',
    ),
    _EventItem(
      title: 'Fresh Start\nInitiative',
      date: '1st  May- Sat -2:00 PM',
      image:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=80',
    ),
    _EventItem(
      title: 'The Clean\nCollective',
      date: '1st  May- Sat -2:00 PM',
      image:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=400&q=80',
    ),
    _EventItem(
      title: 'Sparkle\nSquad',
      date: '1st  May- Sat -2:00 PM',
      image:
          'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=400&q=80',
    ),
  ];

  String _searchName = '';

  void _onSearchChanged(String value) {
    setState(() {
      _searchName = value.trim().toLowerCase();
    });
  }

  List<_EventItem> get _filteredEvents {
    if (_searchName.isEmpty) return _events;
    return _events.where((event) {
      return event.title.toLowerCase().contains(_searchName);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Events",
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
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
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ).copyWith(bottom: 24),
              itemCount: _filteredEvents.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = _filteredEvents[index];
                return _EventCard(item: item);
              },
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
        // const SizedBox(width: 12),
        // _FilterButton(onPressed: () {}),
      ],
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.item});

  final _EventItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EventDetailsPage(
              imageUrl: item.image,
              eventName: item.title,
              eventTime: item.date,
            ),
          ),
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
                child: CachedNetworkImage(
                  imageUrl: item.image,
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
                    item.title,
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

// class _FilterButton extends StatelessWidget {
//   const _FilterButton({required this.onPressed});

//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         height: kToolbarHeight,
//         decoration: BoxDecoration(
//           color: primaryGreen,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//         child: Row(
//           children: [
//             const Icon(Icons.filter_alt, color: Colors.white, size: 20),
//             const SizedBox(width: 6),
//             Text(
//               'Filters',
//               style: CustomStyle.fourteenWhite.copyWith(
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _EventItem {
  _EventItem({required this.title, required this.date, required this.image});

  final String title;
  final String date;
  final String image;
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
