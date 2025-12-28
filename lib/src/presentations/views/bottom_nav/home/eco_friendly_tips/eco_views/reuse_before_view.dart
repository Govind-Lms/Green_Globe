import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/models/eco_model.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/eco_image_widget.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class ReuseBeforeDetailsView extends StatelessWidget {
  final EcoModel ecoModel;
  const ReuseBeforeDetailsView({super.key, required this.ecoModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reuse Before Replacing',
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
              boldText: "Conserves Natural Resources: ",
              normalText:
                  "Reusing items prevents the need to harvest or extract new raw materials from the Earth, such as trees, oil, and metal ores.",
            ),
            BulletPoint(
              boldText: "Saves Energy: ",
              normalText:
                  "Manufacturing new products from virgin materials is energy-intensive. Reusing an item in its current form consumes little to no energy compared to the processing required for recycling or new production.",
            ),

            BulletPoint(
              boldText: "Reduces Pollution and Greenhouse Gas Emissions: ",
              normalText:
                  "By avoiding the manufacturing process for new items, you prevent the associated air, water, and land pollution, including significant reductions in greenhouse gases that contribute to climate change.",
            ),

            BulletPoint(
              boldText: "Minimizes Waste to Landfills: ",
              normalText:
                  "Reusing prevents usable goods from entering the waste stream, reducing the amount of trash sent to landfills and incinerators and allowing products to be used to their fullest extent.",
            ),

            BulletPoint(
              boldText: "Protects Wildlife and Ecosystems: ",
              normalText:
                  "Less demand for raw material extraction means less disruption and damage to natural habitats and a reduction in litter that can harm marine and terrestrial life. ",
            ),

            TitleBuilder(title: 'Economic and Social Benefits'),
            BulletPoint(
              boldText: "Saves Money: ",
              normalText:
                  "Reusing items or purchasing used products is often much cheaper than buying new ones, offering immediate financial savings for individuals and businesses.",
            ),
            BulletPoint(
              boldText: "Lower Disposal Costs: ",
              normalText:
                  "For businesses and municipalities, a reduced waste stream means lower costs for waste collection and disposal fees.",
            ),
            BulletPoint(
              boldText: "Creates Jobs and Boosts the Economy: ",
              normalText:
                  "The reuse industry (including repair shops, thrift stores, and material exchange programs) creates more jobs for every ton of waste than landfill disposal or incineration.",
            ),
            BulletPoint(
              boldText: "Supports Communities: ",
              normalText:
                  "Donating usable goods provides affordable access to necessary items like clothing, furniture, and electronics for people in need, supporting community welfare and social programs.",
            ),

            BulletPoint(
              boldText: "Encourages Innovation and Responsibility: ",
              normalText:
                  "The practice of finding new uses for old items (upcycling) encourages creativity and a mindset of responsibility, moving away from a disposable culture. ",
            ),
          ],
        ),
      ),
    );
  }
}
