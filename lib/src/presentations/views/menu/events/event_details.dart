// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/models/event_model.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel eventModel;
  const EventDetailsPage({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Event Details",
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeroSection(
                      imageUrl: "assets/icons/Event_Images/${eventModel.image}",
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eventModel.name,

                            style: CustomStyle.twenty.copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 24),
                          _InfoRow(
                            iconBg: const Color(0xFFE5F4EB),
                            icon: Icons.calendar_today_rounded,
                            iconColor: primaryGreen,
                            title: eventModel.date,
                            subtitle: eventModel.time,
                          ),
                          const SizedBox(height: 16),
                          _InfoRow(
                            iconBg: const Color(0xFFE5F4EB),
                            icon: Icons.location_on_rounded,
                            iconColor: primaryGreen,
                            title: eventModel.locationName,
                            subtitle: eventModel.locationAddress,
                          ),
                          const SizedBox(height: 16),
                          _InfoRow(
                            iconBg: const Color(0xFFFFF2E7),
                            icon: Icons.person,
                            iconColor: Colors.orange,
                            title: eventModel.organizer,
                            subtitle: 'Organizer',
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'About Event',
                            style: CustomStyle.sixteen.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            eventModel.description,
                            style: CustomStyle.fourteen.copyWith(
                              height: 1.5,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SafeArea(
            //   top: false,
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(22, 0, 22, 18),
            //     child: SizedBox(
            //       width: double.infinity,
            //       height: kToolbarHeight,
            //       child: ElevatedButton(
            //         onPressed: () {},
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: primaryGreen,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(16),
            //           ),
            //           elevation: 6,
            //           shadowColor: primaryGreen.withOpacity(0.4),
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               'VOLUNTEER',
            //               style: CustomStyle.sixteenWhite.copyWith(
            //                 fontWeight: FontWeight.w700,
            //                 letterSpacing: 0.5,
            //               ),
            //             ),
            //             const SizedBox(width: 10),
            //             const Icon(Icons.arrow_forward, color: Colors.white),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final String imageUrl;

  const _HeroSection({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 260,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}

class _GoingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const avatars = [
      'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=200&q=80',
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80',
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=200&q=80',
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 96,
            child: Stack(
              children: [
                for (int i = 0; i < avatars.length; i++)
                  Positioned(
                    left: i * 26,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: CachedNetworkImageProvider(avatars[i]),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '+20 Going',
            style: CustomStyle.fourteen.copyWith(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Material(
            color: primaryGreen,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                child: Text(
                  'Invite',
                  style: CustomStyle.fourteenWhite.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.iconBg,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  final Color iconBg;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: iconColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: CustomStyle.sixteen.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: CustomStyle.fourteen.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
