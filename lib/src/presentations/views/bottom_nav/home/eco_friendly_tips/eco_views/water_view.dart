import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/models/eco_model.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/eco_image_widget.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class SaveWaterDetailsView extends StatelessWidget {
  final EcoModel ecoModel;
  const SaveWaterDetailsView({super.key, required this.ecoModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Save Water Daily',
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            EcoImageBuilder(
              image: ecoModel.image,
              text: ecoModel.newtitle,
              shortDesc: ecoModel.shortDesc,
            ),
            TitleBuilder(title: 'Key Benifits'),
            BulletPoint(
              boldText: "Massive Savings Per Person: ",
              normalText:
                  "Turning off the tap while brushing for 2 minutes saves about 8 gallons of water daily, adding up to nearly 3,000 gallons yearly.",
            ),
            BulletPoint(
              boldText: "Lower Utility Bills: ",
              normalText:
                  "Less water used means lower water and energy (for heating) bills for your household.",
            ),

            BulletPoint(
              boldText: "Environmental Protection: ",
              normalText:
                  "Conserves precious freshwater resources, reducing stress on rivers, lakes, and groundwater, and decreasing energy needed for water treatment and pumping.",
            ),

            BulletPoint(
              boldText: "Supports Global Water Access: ",
              normalText:
                  "Helps ensure enough clean water for everyone, as many communities lack access to it.",
            ),
            BulletPoint(
              boldText: "Reduces Infrastructure Strain: ",
              normalText:
                  "Less demand lessens the burden on water treatment plants and pipes.",
            ),

            TitleBuilder(title: 'Simple Water-Saving Habits'),
            BulletPoint(
              boldText: "Shorten Showers: ",
              normalText: "Even a minute or two less saves gallons.",
            ),

            BulletPoint(
              boldText: "Fix Leaks: ",
              normalText:
                  "A dripping faucet can waste a surprising amount of water.",
            ),

            BulletPoint(
              boldText: "Full Loads: ",
              normalText:
                  "Only run dishwashers and washing machines when full.",
            ),

            BulletPoint(
              boldText: "Use a Cup for Rinsing: ",
              normalText:
                  "Instead of running the tap, use a cup to rinse your mouth after brushing.",
            ),

            BulletPoint(
              boldText: "Install Aerators: ",
              normalText:
                  "Faucet aerators mix air with water, reducing flow without losing pressure. ",
            ),
          ],
        ),
      ),
    );
  }
}
