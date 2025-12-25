import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/image_builder.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/quote_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class GlassRecycleMethodDetailsView extends StatelessWidget {
  const GlassRecycleMethodDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Glass Recycling',
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
              text: "Bottles and jars (check local rules for colors).",
            ),
            TitleBuilder(title: "Step-by-Step: How Glass Is Recycled"),
            Text(
              "Ever wonder what happens to that wine bottle you toss into the recycling bin? Unlike plastic, which often gets downcycled, glass can be recycled endlessly without losing quality. That makes it one of the most eco-friendly materials in the waste stream. We’ll walk you through the entire glass recycling process, from curbside collection to new bottle production—showing how yesterday’s jar becomes tomorrow’s tumbler.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            QuoteView(
              quote:
                  "Reduces the need to mine sand, soda ash, and limestone, preserving ecosystems and finite resources.",
              color: primaryGreen,
            ),
            SizedBox(height: 10),
            ImageBuilder(context: context, image: "assets/", text: ''),
            TitleBuilder(title: "Why to Recycle Glass"),
            Text(
              "Before diving into the steps, here’s why glass recycling matters:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),

            SizedBox(height: 10),

            BulletPoint(
              boldText: "",
              normalText: "100% recyclable with no loss in purity or quality",
            ),

            BulletPoint(
              boldText: "",
              normalText:
                  "Recycling glass saves up to 30% of the energy needed to make new glass",
            ),

            BulletPoint(
              boldText: "",
              normalText:
                  "Every ton of recycled glass saves 315 kg of CO₂ emissions",
            ),

            BulletPoint(
              boldText: "",
              normalText:
                  "Using cullet (recycled glass) in manufacturing reduces raw material usage by 1.2 tons per ton",
            ),

            BulletPoint(
              boldText: "",
              normalText:
                  "Despite its benefits, only 33% of glass is recycled in the U.S., compared to over 70% in Europe. That gap shows huge potential.",
            ),
            SizedBox(height: 10),

            TitleBuilder(title: "What Can and Can't Be Recycled?"),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Table(
                children: [
                  TableRow(
                    children: [
                      _cell("Recyclable Glass", Colors.green, isHeader: true),
                      _cell("Not Accepted", Colors.red, isHeader: true),
                    ],
                  ),
                  for (int i = 0; i < recyclable.length; i++)
                    TableRow(
                      children: [
                        _cell(recyclable[i], Colors.grey[200]!),
                        _cell(notAccepted[i], Colors.grey[200]!),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Tip: Rinse bottles and remove caps—labels are usually OK.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "1. Collection and Drop-Off",
              style: CustomStyle.fourteen.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            BulletPoint(
              boldText: "",
              normalText: "Your glass bottles and jars are collected through:",
            ),

            BulletPoint(
              boldText: "",
              normalText: "Curbside recycling programs",
            ),

            BulletPoint(
              boldText: "",
              normalText: "Bottle banks or drop-off points",
            ),

            BulletPoint(
              boldText: "",
              normalText:
                  "Commercial recycling contracts (e.g., restaurants, hotels)",
            ),

            Text(
              "2. Transportation to a Materials Recovery Facility (MRF)",
              style: CustomStyle.fourteen.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "Once collected, the glass is transported to a Materials Recovery Facility (MRF) where it’s:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            BulletPoint(boldText: "", normalText: "Weighed"),

            BulletPoint(
              boldText: "",
              normalText:
                  "Sorted from other recyclables (plastics, metals, paper)",
            ),
            Text(
              "Some areas collect glass separately to reduce contamination and improve recycling efficiency.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "3. Manual and Automated Sorting",
              style: CustomStyle.fourteen.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "The next step is removing contaminants such as:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            BulletPoint(boldText: "", normalText: "Plastic caps"),

            BulletPoint(boldText: "", normalText: "Labels and foil"),

            BulletPoint(
              boldText: "",
              normalText:
                  "Ceramics or non-recyclable glass (e.g., Pyrex, lightbulbs)",
            ),
            Text(
              "Sorting is done using:",
              style: CustomStyle.fourteen,
              textAlign: TextAlign.justify,
            ),
            BulletPoint(
              boldText: "",
              normalText: "Trommel screens for size separation",
            ),

            BulletPoint(
              boldText: "",
              normalText: "Air classifiers for removing light materials",
            ),

            BulletPoint(
              boldText: "",
              normalText:
                  "Comes in clear (flint), green, and brown (amber) color streams",
            ),

            Text(
              "4. Crushing into Cullet",
              style: CustomStyle.fourteen.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "Clean glass is crushed into small pieces called cullet, which:",
              style: CustomStyle.fourteen,
              textAlign: TextAlign.justify,
            ),
            BulletPoint(
              boldText: "",
              normalText: "Melts at a lower temperature than raw materials",
            ),

            BulletPoint(
              boldText: "",
              normalText: "Saves energy in glass manufacturing",
            ),

            BulletPoint(
              boldText: "",
              normalText:
                  "Comes in clear (flint), green, and brown (amber) color streams",
            ),
            Text(
              "Fun fact: Glass manufacturers prefer cullet because it reduces furnace wear and energy use by up to 20%.",
              style: CustomStyle.fourteen,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),

            Text(
              "5. Melting and Remanufacturing",
              style: CustomStyle.fourteen.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "Cullet is then:",
              style: CustomStyle.fourteen,
              textAlign: TextAlign.justify,
            ),

            BulletPoint(
              boldText: "",
              normalText: "Mixed with sand, soda ash, and limestone",
            ),

            BulletPoint(
              boldText: "",
              normalText: "Fed into a glass furnace at ~1,500°C (2,732°F)",
            ),

            BulletPoint(
              boldText: "",
              normalText:
                  "Formed into new containers like bottles, jars, or even fiberglass",
            ),
            Text(
              "Clear glass must be made from clear cullet only, while colored glass can tolerate more variety.",
              style: CustomStyle.fourteen,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "6. Distribution Back to Market",
              style: CustomStyle.fourteen.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "New glass containers are:",
              style: CustomStyle.fourteen,
              textAlign: TextAlign.justify,
            ),
            BulletPoint(
              boldText: "",
              normalText: "Quality-checked and packaged",
            ),

            BulletPoint(
              boldText: "",
              normalText:
                  "Shipped back to beverage companies, food brands, and retailers",
            ),
            Text(
              "Your recycled bottle might return to store shelves in as little as 30 days—ready for reuse in a closed-loop system.",
              style: CustomStyle.fourteen,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _cell(String text, Color bg, {bool isHeader = false}) => Container(
  padding: const EdgeInsets.all(12),
  color: bg,
  child: Text(
    text,
    style: TextStyle(
      color: isHeader ? Colors.white : Colors.black,
      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
    ),
  ),
);
final List<String> recyclable = [
  "Beverage\nbottles",
  "Food jars (sauces,pickles)",
  "Wine and\nliquor bottles",
];
final List<String> notAccepted = [
  "Mirrors, window glass, ceramics",
  "Light bulbs, Pyrex, Drinking glasses",
  "Heat-resistant or frosted glass",
];
