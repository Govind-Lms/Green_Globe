import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:lottie/lottie.dart';

class AuctionPage extends StatelessWidget {
  const AuctionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Auctions",
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
                  'assets/lotties/auction_hammer.json',
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Currently, there is no ongoing auctions',
                textAlign: TextAlign.center,
                style: CustomStyle.twenty.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Green Globe will notify when "Auctions For Waste" are available. Stay tuned',
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
