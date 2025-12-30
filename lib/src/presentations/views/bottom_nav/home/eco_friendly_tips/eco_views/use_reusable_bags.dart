import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/models/eco_model.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/eco_image_widget.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class ReusableBagsDetailsView extends StatelessWidget {
  final EcoModel ecoModel;
  const ReusableBagsDetailsView({super.key, required this.ecoModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Use Reusable Bags',
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

            TitleBuilder(title: 'Environmental Benefits'),
            BulletPoint(
              boldText: "Reduces Plastic Pollution: ",
              normalText:
                  "Less plastic ends up in landfills, streets, and oceans, preventing litter and contamination.",
            ),

            BulletPoint(
              boldText: "Protects Wildlife: ",
              normalText:
                  "Animals (especially marine life like turtles) are less likely to choke on or get tangled in plastic bags.",
            ),

            BulletPoint(
              boldText: "Conserves Resources: ",
              normalText:
                  "Decreases the demand for new plastic production, saving energy and raw materials.",
            ),

            BulletPoint(
              boldText: "Prevents Clogged Drains: ",
              normalText:
                  "Keeps plastic bags out of storm drains, preventing blockages and flooding.",
            ),

            TitleBuilder(title: 'Practical & Personal Benefits'),
            BulletPoint(
              boldText: "Durable & Strong: ",
              normalText:
                  "Can carry heavier loads without ripping, meaning fewer trips from the car.",
            ),

            BulletPoint(
              boldText: "Saves Money: ",
              normalText:
                  "Avoids recurring fees for plastic bags in many areas.",
            ),

            BulletPoint(
              boldText: "Versatile: ",
              normalText:
                  "Can be used for groceries, beach trips, gym bags, or as general totes.",
            ),
            BulletPoint(
              boldText: "Space-Saving: ",
              normalText:
                  "Replaces a large stash of plastic bags with just a few compact reusable ones.",
            ),
            BulletPoint(
              boldText: "Stylish: ",
              normalText: "Available in many designs for personal expression.",
            ),
            TitleBuilder(title: 'Community & Habit Benefits'),

            BulletPoint(
              boldText: "Promotes Sustainability: ",
              normalText:
                  "Encourages broader environmental awareness and sustainable living.",
            ),

            BulletPoint(
              boldText: "Supports Local Businesses: ",
              normalText:
                  "Many stores sell reusable bags, supporting local economies.",
            ),
          ],
        ),
      ),
    );
  }
}
