import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/image_builder.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/quote_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class ClothingRecycleMethodDetailsView extends StatelessWidget {
  const ClothingRecycleMethodDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clothing Recycling',
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
              text:
                  "#1 (PET) & #2 (HDPE) bottles are often accepted; remove caps.",
            ),

            Text(
              "Fast fashion, when clothing brands renew their collections on a more frequent basis, encourages us to fill our cupboards with clothes that we never use, or that we use very rarely, and that we then get rid of. In addition to questioning our clothing buying habits, recycling appears to be an answer to counteract the millions of tonnes of greenhouse gases emitted by the textile industry each year.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            QuoteView(
              quote: "Donate clothes to charity and homeless.",
              color: primaryGreen,
            ),
            SizedBox(height: 10),
            QuoteView(
              quote:
                  "Recycling textile is necessary to combat global warming. By giving clothing a second life, the environmental impact of textiles is greatly reduced.",
              color: Colors.yellow,
            ),
            SizedBox(height: 10),
            Text(
              "The first step to prevent the generation of textile and clothes waste is to make responsible choices:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            BulletPoint(
              boldText: "Choose good materials, ",
              normalText:
                  "such as linen, which require less water and fertilizers to grow, or organic cotton;",
            ),

            BulletPoint(
              boldText: "",
              normalText: "Acquire garments made from recycled fibres;",
            ),

            BulletPoint(
              boldText: "Buy second-hand clothes ",
              normalText:
                  "in second-hand stores on the high street or online and save money at the same time;",
            ),

            BulletPoint(
              boldText: "",
              normalText: "Choose brands committed to the environment;",
            ),

            BulletPoint(
              boldText: "",
              normalText:
                  "Trust the labels that facilitate the recognition of certain characteristics of a product, such as the guarantee of origin.",
            ),
            SizedBox(height: 10),
            QuoteView(
              quote:
                  "You should not put used clothes in your household recycling bin. Instead, contact your local council or take them to your nearest waste recycling centre.",
              color: Colors.red,
            ),

            TitleBuilder(title: "Upcycle used clothes"),
            Text(
              "Another option is to reuse and customise used clothes and textiles: use them as a base for different garments, modify them, etc.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            BulletPoint(
              boldText: "Using the material in another way, ",
              normalText:
                  "for example, wearing a men's shirt as a dress, putting it on with stockings and a belt;",
            ),

            BulletPoint(
              boldText: "Add new details ",
              normalText: "to used garments;",
            ),

            BulletPoint(
              boldText: "Removing parts of clothing ",
              normalText:
                  "to turn a jacket into a vest, for example, or long pants into shorts;",
            ),

            BulletPoint(boldText: "Dyeing clothes", normalText: ""),

            TitleBuilder(
              title:
                  "Knowing the life cycle of clothing is one way to understand the impact of your carbon footprint. All stages of this life cycle have an impact on the environment.",
            ),
            // SizedBox(height: 10),
            // ImageBuilder(
            //   image: "assets/icons/plastic/plastics2.png",
            //   context: context,
            //   text: '',
            // ),
            const SimplePoint(
              boldText: "(1) The production of raw materials: ",
              normalText:
                  "clothes are produced from raw materials such as polyester, cotton, silk or wool. Some of them are sourced from non-renewable resources, such as oil, to produce synthetic fibers, while others come from plant or animal materials and therefore require a lot of water and chemicals.",
            ),
            const SimplePoint(
              boldText: "(2) The manufacture of the clothes: ",
              normalText:
                  "due to the substances it contains, the dye is toxic not only for the workers who make the clothes, but also for the consumers and the aquatic ecosystem that it pollutes.",
            ),
            const SimplePoint(
              boldText: "(3) Transportation of clothing: ",
              normalText:
                  "clothes are normally manufactured in developing countries, where production costs and wages are lower, and are transported and the rest of Europe by air or sea. However, the airplane is the most polluting means of transport.",
            ),
            const SimplePoint(
              boldText: "LDPE (Low-Density Polyethylene): ",
              normalText: "Used for plastic bags and film wraps.",
            ),
            const SimplePoint(
              boldText: "(4) The maintenance of clothes: ",
              normalText:
                  " there is an excessive use of water when washing clothes. In addition, a large number of contaminating microparticles are released.",
            ),
            const SimplePoint(
              boldText: "(5) Recycling clothes: ",
              normalText:
                  " this is a crucial step. Sorting your wardrobe and recycling certain used clothes helps to extend the useful life of clothes, thus avoiding unnecessary steps such as the production of raw materials, the manufacture of products or even transportation.",
            ),
          ],
        ),
      ),
    );
  }
}
