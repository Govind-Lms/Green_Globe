import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/models/eco_model.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_image_widget.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/image_builder.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class EcoProductDetailsView extends StatelessWidget {
  final EcoModel ecoModel;
  const EcoProductDetailsView({super.key, required this.ecoModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Use Eco-Friendly Products',
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
              text: ecoModel.title,
              shortDesc: ecoModel.shortDesc,
            ),

            TitleBuilder(title: 'Environmental Benefits'),
            BulletPoint(
              boldText: "Reduces Pollution: ",
              normalText:
                  "Less toxic waste in landfills, cleaner water, and lower greenhouse gas emissions.",
            ),
            BulletPoint(
              boldText: "Conserves Resources: ",
              normalText:
                  "Uses renewable materials, less water, and promotes energy efficiency.",
            ),
            BulletPoint(
              boldText: "Decreases Waste: ",
              normalText:
                  "Often features biodegradable or recyclable packaging, reducing landfill burden.",
            ),
            BulletPoint(
              boldText: "Protects Wildlife: ",
              normalText:
                  "Minimizes habitat destruction and pollution that harms ecosystems. ",
            ),

            TitleBuilder(title: 'Personal & Health Benefits'),
            BulletPoint(
              boldText: "Safer Home: ",
              normalText:
                  "Fewer harsh chemicals (like BPA, phthalates) improve indoor air quality and are safer for kids and pets.",
            ),

            BulletPoint(
              boldText: "Healthier Living: ",
              normalText:
                  "Reduces exposure to harmful substances found in conventional cleaners, personal care items, and building materials.",
            ),
            BulletPoint(
              boldText: "Long-Term Savings: ",
              normalText:
                  "Energy-efficient products lower utility bills, and durable goods mean less frequent replacement.",
            ),

            BulletPoint(
              boldText: "Mental Well-being: ",
              normalText:
                  "Living in a healthier, less polluted environment can boost mental health. ",
            ),
            TitleBuilder(title: 'Economic & Social Benefits'),
            BulletPoint(
              boldText: "Supports Ethical Practices: ",
              normalText:
                  "Encourages companies to adopt sustainable and ethical production methods.",
            ),

            BulletPoint(
              boldText: "Drives Innovation: ",
              normalText:
                  "Signals demand for green products, spurring more sustainable design and technology.",
            ),

            BulletPoint(
              boldText: "Builds a Sustainable Future: ",
              normalText:
                  "Helps preserve natural resources and a stable climate for future generations. ",
            ),
          ],
        ),
      ),
    );
  }
}
