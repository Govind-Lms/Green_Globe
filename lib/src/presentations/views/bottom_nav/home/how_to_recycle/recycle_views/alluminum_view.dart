import 'package:flutter/material.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/quote_view.dart';

class AluminiumRecyclingDetailsView extends StatelessWidget {
  final Map<String, dynamic>
  recycleItem; // Replace with a proper Model class if available

  const AluminiumRecyclingDetailsView({super.key, required this.recycleItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aluminium Recycling"),
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share),
            onPressed: () {
              // Implementation for Share functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image with Gradient Overlay
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image.asset(
                    'assets/aluminium.png',
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                  ),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.green.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      recycleItem['tip'] ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Aluminium has been widely used for many years now...",
              style: TextStyle(fontSize: 14),
            ),
            const QuoteView(
              quote: "Recycling consists of giving a second life to waste...",
              color: Colors.green,
            ),
            const Text(
              "What is aluminium recycling?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("Aluminium is one of the most desirable metals..."),
            ),
            // Example of BulletPoint usage
            const BulletPoint(
              boldText: "(1) Recycling: ",
              normalText: "You can recycle your cans in various ways...",
            ),
          ],
        ),
      ),
    );
  }
}
