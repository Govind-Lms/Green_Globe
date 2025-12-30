import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/models/eco_model.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/eco_image_widget.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class FoodWasteDetailsView extends StatelessWidget {
  final EcoModel ecoModel;
  const FoodWasteDetailsView({super.key, required this.ecoModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reduce Food Waste',
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

            TitleBuilder(title: 'Economic Benefits'),
            BulletPoint(
              boldText: "Saves Money: ",
              normalText:
                  "Households save on groceries, while businesses and farmers see increased profits and efficiency.",
            ),
            BulletPoint(
              boldText: "Drives Innovation: ",
              normalText:
                  "Encourages new solutions in packaging, processing, and distribution.",
            ),

            BulletPoint(
              boldText: "Boosts Resilience: ",
              normalText:
                  "Creates more robust and efficient food systems less prone to shocks. ",
            ),

            TitleBuilder(title: 'Social & Health Benefits'),
            BulletPoint(
              boldText: "Increases Food Security: ",
              normalText:
                  "More food is available for people, improving access to healthy, nutritious diets globally.",
            ),

            BulletPoint(
              boldText: "Supports Communities: ",
              normalText:
                  "Allows for more food redistribution to those in need.",
            ),

            TitleBuilder(title: 'How to Achieve These Benefits?'),

            BulletPoint(
              boldText: "Households: ",
              normalText:
                  "Shop smarter, store food better (like using the freezer!), and repurpose leftovers.",
            ),

            BulletPoint(
              boldText: "Businesses: ",
              normalText:
                  "Implement better inventory, offer smaller portions, sell \"ugly\" produce, and donate surplus.",
            ),

            BulletPoint(
              boldText: "Farms: ",
              normalText:
                  "Reduce loss during harvest, processing, and storage.",
            ),
          ],
        ),
      ),
    );
  }
}
