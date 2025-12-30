import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:lottie/lottie.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Marketplace",
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Center(
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
                  'assets/lotties/implementing.json',
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'This page is in under development.',
                textAlign: TextAlign.center,
                style: CustomStyle.twenty.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'We will notify you as soon as this page is available!',
                textAlign: TextAlign.center,
                style: CustomStyle.fourteen.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF4F7F5),
    );
  }
}
