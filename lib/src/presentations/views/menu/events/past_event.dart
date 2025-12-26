import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:lottie/lottie.dart';

class PastEventsPage extends StatelessWidget {
  const PastEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Use a Lottie calendar animation
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
                'No Past\nEvents',
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
          ),
        ),
      ],
    );
  }
}
