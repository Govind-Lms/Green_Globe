import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/image_builder.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class PlantATreeDetailsView extends StatelessWidget {
  const PlantATreeDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Plant A Tree',
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
                  "Newspapers, magazines, cereal boxes, mail, and flattened cardboard boxes (remove staples/tape).",
            ),

            TitleBuilder(title: 'Environmental Benefits'),
            BulletPoint(
              boldText: "Combats Climate Change: ",
              normalText:
                  "Trees absorb carbon dioxide (a major greenhouse gas) and store it, helping to cool the planet.",
            ),
            BulletPoint(
              boldText: "Improves Air Quality: ",
              normalText:
                  "They filter dust, pollen, and pollutants like nitrogen oxides and sulfur dioxide, releasing clean oxygen.",
            ),

            BulletPoint(
              boldText: "Manages Water: ",
              normalText:
                  "Roots hold soil, preventing erosion; they slow stormwater, reduce runoff, and filter pollutants before they reach water bodies.",
            ),

            BulletPoint(
              boldText: "Cools Cities: ",
              normalText:
                  "Shade and transpiration cool ambient temperatures, reducing the \"heat island\" effect.",
            ),

            BulletPoint(
              boldText: "Reduces Energy Use: ",
              normalText:
                  "Shade from trees lowers cooling costs for buildings.",
            ),

            TitleBuilder(title: 'Wildlife & Biodiversity Benefits'),
            BulletPoint(
              boldText: "Provides Habitat & Food: ",
              normalText:
                  "Trees offer shelter, nesting sites, and food (fruits, nuts, nectar) for countless species, from insects and birds to mammals.",
            ),
            BulletPoint(
              boldText: "Supports Ecosystems: ",
              normalText:
                  "They form the foundation for diverse habitats, helping to fight biodiversity loss. ",
            ),

            TitleBuilder(title: 'Cummunity & Health Benefits'),
            BulletPoint(
              boldText: "Boosts Mental & Physical Health: ",
              normalText:
                  "Green spaces with trees reduce stress, improve mood, lower blood pressure, and encourage physical activity.",
            ),

            BulletPoint(
              boldText: "Increases Property Value: ",
              normalText:
                  "Mature trees enhance the aesthetic appeal and value of homes and businesses.",
            ),

            BulletPoint(
              boldText: "Reduces Noise Pollution: ",
              normalText:
                  "Trees act as natural buffers against traffic and other urban noise.",
            ),

            BulletPoint(
              boldText: "Fosters Community: ",
              normalText:
                  "Parks and green areas encourage social interaction and build stronger neighborhoods. ",
            ),
          ],
        ),
      ),
    );
  }
}
