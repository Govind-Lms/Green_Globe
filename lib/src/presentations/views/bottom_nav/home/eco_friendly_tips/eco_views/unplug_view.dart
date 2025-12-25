import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/image_builder.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class UnplugDetailsView extends StatelessWidget {
  const UnplugDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Unplug Devices',
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            ImageBuilder(
              context: context,
              image: 'assets/icons/plastics1.jpeg',
              text: "",
            ),

            TitleBuilder(title: 'Benefits of Unplugging'),
            BulletPoint(
              boldText: "Cost Savings: ",
              normalText:
                  "Eliminates standby power (phantom load), leading to lower monthly bills, though individual savings per device are small, they add up significantly over time.",
            ),
            BulletPoint(
              boldText: "Fire & Safety: ",
              normalText:
                  "Reduces fire risk from overheating components and protects against damage from power surges or lightning strikes.",
            ),
            BulletPoint(
              boldText: "Extended Lifespan: ",
              normalText:
                  "Decreases wear and tear on electronics, helping them last longer.",
            ),
            BulletPoint(
              boldText: "Environmental Impact: ",
              normalText:
                  "Lowers overall energy demand, decreasing carbon emissions and conserving resources.",
            ),
            BulletPoint(
              boldText: "Better Habits: ",
              normalText:
                  "Encourages energy awareness and provides a chance to disconnect from technology for improved mental well-being. ",
            ),
            TitleBuilder(title: 'Devics to Focus On'),
            BulletPoint(
              boldText: "",
              normalText: "Chargers (phone, laptop) even when not charging.",
            ),
            BulletPoint(
              boldText: "",
              normalText:
                  "TVs, gaming consoles, and media players (standby modes).",
            ),

            BulletPoint(
              boldText: "",
              normalText: "Printers, coffee makers, and toasters. ",
            ),
          ],
        ),
      ),
    );
  }
}
