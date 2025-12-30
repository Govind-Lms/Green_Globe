import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/models/category_model.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/image_builder.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/quote_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class AluminiumRecyclingDetailsView extends StatelessWidget {
  final RecycleModel recycleModel;

  const AluminiumRecyclingDetailsView({super.key, required this.recycleModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Aluminium Recycling",
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageBuilder(
              context: context,
              image: "assets/icons/Aluminium Recycling/aluminium.jpg",
              text: recycleModel.tip,
            ),
            const SizedBox(height: 10),
            const QuoteView(
              quote: "Recycling consists of giving a second life to waste...",
              color: Colors.green,
            ),
            TitleBuilder(title: 'How is Aluminium recycled?'),

            Text(
              "Aluminium is one of the most efficient materials to recycle compared to what is needed to make it from scratch - including wood and using chemicals which could be harmful for our environment.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            BulletPoint(
              boldText: "Aluminium collection: ",
              normalText:
                  "Councils across the country provide recycling bins in which you can separate your recycling - glass, cardboard, organic, etc. Once collected, the recycling process can begin;",
            ),

            BulletPoint(
              boldText: "Storage: ",
              normalText:
                  "Aluminium and paper is taken to a paper mill or recycling centre where it is stored to be sorted later;",
            ),

            BulletPoint(
              boldText: "Decontamination and pulp: ",
              normalText:
                  "Via a process in which the cardboard is submerged in water soap, any ink and other substances that can not be recycled are removed. When cardboard and paper are soaking wet and soggy, it is known as pulp;",
            ),

            BulletPoint(
              boldText: "Drying and removing of sludge: ",
              normalText:
                  "The pulp is then put through a drying process and any sludge (waste) removed and disposed of as a by-product;",
            ),

            BulletPoint(
              boldText: "Ironing: ",
              normalText:
                  "A calendar stack irons out the recycled cardboard into paper rolls. Some of this will remain as paper - for newspapers, for example, while some it will go onto to become new cardboard boxes;",
            ),

            BulletPoint(
              boldText: "Measured and prepared: ",
              normalText:
                  "The newly recycled paper or cardboard is measured and prepared, ready for re-use;",
            ),

            BulletPoint(
              boldText: "Finished product: ",
              normalText: "Recycled cardboard boxes can be used again.",
            ),

            ImageBuilder(
              context: context,
              image: 'assets/icons/Aluminium Recycling/aluminium2.png',
              text: "",
            ),
            TitleBuilder(title: 'How to recycle your cardbaord?'),
            Text(
              "One of the most obvious ways is to use the recycling bin provided by your local council.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            Text(
              "Depending on the area of the country in which you live, it may be a different colour, but they are normally blue bins. Likewise, some councils provide bins for cardboard and paper waste only when others collect it as part of the mixed recycling collection. As a starting point, it is best to get in touch with your council to find out what bin you should use and what days it will be collected.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),

            BulletPoint(boldText: "Aluminium boxes", normalText: ""),

            BulletPoint(boldText: "Aluminium food packets", normalText: ""),

            BulletPoint(
              boldText: "Toilet roll tubes and kitchen roll tubes",
              normalText: "",
            ),

            BulletPoint(
              boldText:
                  "Empty food and drink cartons - make sure you remove any liquid beforehand;",
              normalText: "",
            ),

            BulletPoint(boldText: "Tetrapaks", normalText: ""),

            BulletPoint(boldText: "Newspapers and magazines;", normalText: ""),

            BulletPoint(
              boldText:
                  "Catalogues, telephone directories and paperback books;",
              normalText: "",
            ),

            BulletPoint(boldText: "Envelopes and junk mail.", normalText: ""),

            TitleBuilder(title: 'The benefits of recycling cardboard'),
            SizedBox(height: 10),
            Text(
              "By recycling paper and cardboard, we can do our part to improve the environment, protect the planet, and reduce our carbon footprint. These are just some of the many benefits of recycling cardboard:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),

            BulletPoint(
              boldText: "Saves trees: ",
              normalText:
                  "By recycling cardboard, fewer trees need to be cut down, reducing the impact of deforestation. Trees also play an important role in storing carbon dioxide (CO2), so we should do all we can to avoid cutting them down;",
            ),

            BulletPoint(
              boldText: "Saves energy: ",
              normalText:
                  "It takes a lot more energy to use raw materials and make paper or cardboard from scratch compared to recycling it;",
            ),

            BulletPoint(
              boldText: "Reduces landfill: ",
              normalText:
                  "One of the key benefits to recycling cardboard is that it reduces the amount of waste sent to landfill. According to the Department for Environment, Food and Rural Affairs (DEFRA), the average person in the UK sends around 400 kg of waste to landfill every year - around 7 times their body weight. Landfill has a big impact on the local environment, including both air and water pollution, so we should do what we can do to send less items to landfill;",
            ),

            BulletPoint(
              boldText: "Reduces greenhouse gases: ",
              normalText:
                  "Landfill sites are huge producers of greenhouse gases. When cardboard is sent to landfill, as it breaks down it releases methane, one of the most harmful greenhouse gases, into our atmosphere.",
            ),
          ],
        ),
      ),
    );
  }
}
