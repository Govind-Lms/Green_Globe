import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/image_builder.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/quote_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class PlasticsRecycleMethodDetailsView extends StatelessWidget {
  const PlasticsRecycleMethodDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Plastics Recycling',
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
              image: "assets/icons/plastics1.jpeg",
              text:
                  "#1 (PET) & #2 (HDPE) bottles, jugs, and tubs (shampoo, detergent, milk jugs) are often accepted; remove caps.",
            ),

            Text(
              "Plastic recycling plays a vital role in reducing plastic pollution, conserving resources, and minimizing the environmental impact of plastic production. Here's a closer look at the process, benefits, challenges, and innovations in plastic recycling:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            QuoteView(
              quote:
                  "Decreases the need to extract virgin materials (oil, natural gas) for new plastics.",
              color: primaryGreen,
            ),
            TitleBuilder(title: "Recycled Plastic Types"),
            Text(
              "Plastics are categorized into different types based on their chemical composition, which affects their recyclability:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),

            SizedBox(height: 10),
            ImageBuilder(
              image: "assets/icons/plastics2.png",
              context: context,
              text: '',
            ),

            const BulletPoint(
              boldText: "PET (Polyethylene Terephthalate): ",
              normalText:
                  "Commonly used for beverage bottles and food packaging.",
            ),
            const BulletPoint(
              boldText: "HDPE (High-Density Polyethylene): ",
              normalText:
                  "Used for milk jugs, detergent bottles, and grocery bags.",
            ),
            const BulletPoint(
              boldText: "PVC (Polyvinyl Chloride): ",
              normalText: "Found in pipes, flooring, and window frames.",
            ),
            const BulletPoint(
              boldText: "LDPE (Low-Density Polyethylene): ",
              normalText: "Used for plastic bags and film wraps.",
            ),
            const BulletPoint(
              boldText: "PP (Polypropylene): ",
              normalText:
                  "Found in yogurt containers, bottle caps, and food containers.",
            ),
            const BulletPoint(
              boldText: "PS (Polystyrene): ",
              normalText:
                  "Used for disposable cups, packaging foam, and insulation.",
            ),
            BulletPoint(
              boldText: "PET (Polyethylene Terephthalate): ",
              normalText:
                  "Commonly used for beverage bottles and food packaging.",
            ),

            BulletPoint(
              boldText: "HDPE (High-Density Polyethylene): ",
              normalText:
                  "Used for milk jugs, detergent bottles, and grocery bags.",
            ),

            BulletPoint(
              boldText: "PVC (Polyvinyl Chloride): ",
              normalText: "Found in pipes, flooring, and window frames.",
            ),

            BulletPoint(
              boldText: "LDPE (Low-Density Polyethylene): ",
              normalText: "Used for plastic bags and film wraps.",
            ),

            BulletPoint(
              boldText: "PP (Polypropylene): ",
              normalText:
                  "Found in yogurt containers, bottle caps, and food containers.",
            ),

            BulletPoint(
              boldText: "PS (Polystyrene): ",
              normalText:
                  "Used for disposable cups, packaging foam, and insulation.",
            ),

            ImageBuilder(
              image: "assets/icons/plastics3.png",
              context: context,
              text: '',
            ),

            TitleBuilder(title: "Plastic Recycling Process"),
            BulletPoint(
              boldText: "Collection: ",
              normalText:
                  "Plastic waste is collected from homes, businesses, and recycling centers. This can be through curbside collection, drop-off centers, or specialized collection programs.",
            ),

            BulletPoint(
              boldText: "Sorting: ",
              normalText:
                  "At recycling facilities, plastics are sorted by type and color. Automated and manual sorting methods are used to separate different types of plastics to ensure purity and quality in the recycling process.",
            ),

            BulletPoint(
              boldText: "Cleaning: ",
              normalText:
                  "Plastics are cleaned to remove contaminants such as food residue, labels, and adhesives. Cleanliness improves the quality of recycled plastic materials.",
            ),

            BulletPoint(
              boldText: "Shredding and Melting: ",
              normalText:
                  "After sorting and cleaning, plastics are shredded into small pieces or flakes. These pieces are then melted down and formed into pellets or granules.",
            ),

            BulletPoint(
              boldText: "Pelletizing: ",
              normalText:
                  "The melted plastic is pelletized into small beads or pellets. These pellets can be used as raw materials for manufacturing new plastic products.",
            ),

            BulletPoint(
              boldText: "Manufacturing: ",
              normalText:
                  "Recycled plastic pellets are used to produce a wide range of products, including packaging materials, construction materials, textiles, and consumer goods.",
            ),
            ImageBuilder(
              image: "assets/icons/plastics4.jpg",
              context: context,
              text: '',
            ),

            TitleBuilder(title: "Plastic Recycling Technology"),
            Text(
              "Plastic recycling is more complex due to the variety of plastic types. Advanced technology has made sorting and processing more precise and energy-efficient.Key Machines and Technologies:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),

            Text(
              "1. Plastic Identification & Optical Sorting Machines",
              style: CustomStyle.fourteen.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),

            BulletPoint(
              boldText: "",
              normalText:
                  "Use NIR (Near-Infrared) and AI to identify plastic types (PET, HDPE, LDPE, etc.).",
            ),

            BulletPoint(
              boldText: "",
              normalText:
                  "Automatically sort by resin code, color, or transparency.",
            ),

            const SizedBox(height: 12),
            Text(
              "2. Plastic Shredders & Granulators",
              style: CustomStyle.fourteen.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            BulletPoint(
              boldText: "",
              normalText:
                  "Ideal for bottles, containers, packaging, and industrial scrap.",
            ),

            BulletPoint(
              boldText: "",
              normalText: "Break down plastic waste into flakes or granules.",
            ),

            Text(
              "3. Hot and Cold Washing Systems",
              style: CustomStyle.fourteen.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            BulletPoint(
              boldText: "",
              normalText: "Remove labels, food waste, glue, and oils.",
            ),

            BulletPoint(
              boldText: "",
              normalText: "Hot washing is essential for PET recycling.",
            ),

            Text(
              "4. Extruders and Pelletizers",
              style: CustomStyle.fourteen.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            BulletPoint(
              boldText: "",
              normalText:
                  "Melt and form clean plastic flakes into uniform pellets.",
            ),

            BulletPoint(
              boldText: "",
              normalText:
                  "These pellets are used to manufacture new plastic products.",
            ),

            Text(
              "5. Plastic Agglomerators",
              style: CustomStyle.fourteen.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            Text(
              "For soft or film plastic (LDPE, PP film), agglomerators densify material before extrusion.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "6. AI-Based Quality Control",
              style: CustomStyle.fourteen.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            Text(
              "Machine learning ensures consistent flake quality and automatically rejects contaminated streams.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),

            TitleBuilder(title: "Plastic Recycling Benefits"),

            BulletPoint(
              boldText: "Conservation of Resources: ",
              normalText:
                  "Recycling plastic reduces the demand for virgin plastic resin, conserving natural resources such as crude oil and natural gas.",
            ),

            BulletPoint(
              boldText: "Energy Savings: ",
              normalText:
                  "Recycling plastic requires less energy compared to producing new plastic from raw materials. This reduces greenhouse gas emissions and contributes to climate change mitigation.",
            ),

            BulletPoint(
              boldText: "Reduction of Landfill Waste: ",
              normalText:
                  "By diverting plastic from landfills, recycling helps extend the lifespan of landfills and reduces environmental pollution.",
            ),

            BulletPoint(
              boldText: "Support for Circular Economy: ",
              normalText:
                  "Recycling promotes a circular economy by closing the loop on plastic waste and transforming it into valuable resources for new products.",
            ),
            Text(
              "Plastic recycling is a dynamic field with ongoing advancements in technology, policy, and public engagement. By supporting plastic recycling efforts and adopting sustainable practices, we can all contribute to reducing plastic pollution and creating a cleaner, healthier environment for future generations.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
