import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/image_builder.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class MetalRecycleMethodDetailsView extends StatelessWidget {
  const MetalRecycleMethodDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Metal Recycling',
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
              image: 'assets/icons/Metal Recycling/metal.jpg',
              text: "Aluminum (cans), steel/tin (food cans).",
            ),

            Text(
              "When it comes to recycling, metal can often find itself as an afterthought. When in reality, metal recycling boasts a range of notable environmental and economic advantages! When getting started with metal recycling, it can be hard to know what’s what and how different types of metal should be recycled.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            TitleBuilder(title: "Types of Metals That Can Be Recycled"),
            Text(
              "The wide variety of metals used in our homes and workplaces can make it tricky to know how each metal variety should be recycled – or whether it can be recycled at all! Below, we outline some key metal types, offering some useful details on how each is processed.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),

            BulletPoint(boldText: "Ferrous Metals", normalText: ""),

            BulletPoint(boldText: "Non-Ferrous Metals", normalText: ""),

            BulletPoint(boldText: "Precious Metals", normalText: ""),
            BulletPoint(boldText: "Hazardous Metals", normalText: ""),

            TitleBuilder(title: "Steps to Recycle Metal Waste"),
            ImageBuilder(
              context: context,
              image: 'assets/icons/Metal Recycling/metal2.png',
              text: "",
            ),

            Text(
              "As mentioned above, the steps required to recycle metal waste can vary from one type of metal to another. However, most metal recycling processes contain some, if not all of the following steps.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            SimplePoint(
              boldText: "(1) Collection",
              normalText:
                  "Metal is gathered in bins or other collection containers. UK legislation requires your business waste to be sorted by type, so you’ll want to make sure you have adequate bins and a proper waste management partner to ensure a smooth process.",
            ),
            SimplePoint(
              boldText: "(2) Sorting",
              normalText:
                  "The sorting stage prioritises quality assurance. First, metals will be separated from non-metals, metals are then separated into subcategories using magnets.",
            ),
            SimplePoint(
              boldText: "(3) Processing",
              normalText:
                  "During this step, metals are compacted and squeezed together so they take up less space and then cut into smaller pieces. It is then shredded into smaller pieces using hammer mills ahead of melting.",
            ),
            SimplePoint(
              boldText: "(4) Melting",
              normalText:
                  "Metals are then melted down in a large furnace, separating them out into individual elements and preparing them for further refinement.",
            ),
            SimplePoint(
              boldText: "(5) Purification",
              normalText:
                  "Metals are then purified to remove contaminants – often using purification methods such as electrolysis.",
            ),
            SimplePoint(
              boldText: "(6) Solidifying",
              normalText:
                  "In this final stage, chemicals are added to the melted metal before it is solidified in a cooling chamber.",
            ),
          ],
        ),
      ),
    );
  }
}
