import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/image_builder.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/quote_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class CardboardRecycleMethodDetailsView extends StatelessWidget {
  const CardboardRecycleMethodDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cardboard Recycling',
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
              image: 'assets/icons/Cardboard Recycling/cardboard1.jpg',
              text:
                  "Newspapers, magazines, cereal boxes, mail, and flattened cardboard boxes (remove staples/tape).",
            ),
            QuoteView(
              quote:
                  "Manufacturing from recycled cardboard uses substantially less energy and water than from raw materials.",
              color: primaryGreen,
            ),
            TitleBuilder(title: 'How is cardboard recycled?'),

            Text(
              "Cardboard is one of the most efficient materials to recycle compared to what is needed to make it from scratch - including wood and using chemicals which could be harmful for our environment.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            BulletPoint(
              boldText: "Cardboard collection: ",
              normalText:
                  "Councils across the country provide recycling bins in which you can separate your recycling - glass, cardboard, organic, etc. Once collected, the recycling process can begin;",
            ),

            BulletPoint(
              boldText: "Storage: ",
              normalText:
                  "Cardboard and paper is taken to a paper mill or recycling centre where it is stored to be sorted later;",
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
              image: 'assets/icons/Cardboard Recycling/cardboard2.jpg',
              text: '',
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

            BulletPoint(boldText: "Cardboard boxes", normalText: ""),

            BulletPoint(boldText: "Cardboard food packets", normalText: ""),

            BulletPoint(boldText: "Greeting Cards", normalText: ""),

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
            ImageBuilder(
              context: context,
              image: 'assets/icons/Cardboard Recycling/cardboard3.jpg',
              text: "",
            ),

            TitleBuilder(title: "Paper and cardboard recycling facts"),
            SizedBox(height: 10),
            Text(
              "As it is one of the easiest items to recycle, it should come as no surprise that in the UK, around 80% of cardboard and paper is recycled, according to data published by Statista. However, here are some other facts you may not have been aware of:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            BulletPoint(
              boldText: "",
              normalText:
                  "In 2021, Statista data showed there were approximately 4.2 billion parcels were sent in the UK. This was an increase of over 1.3 billion parcels from the previous year;",
            ),

            BulletPoint(
              boldText: "",
              normalText:
                  "Paper and card make up 20% of all waste we throw away in the UK every year;",
            ),

            BulletPoint(
              boldText: "",
              normalText:
                  "For every tonne of paper recycled, there is a huge amount of the world’s resources saved, including 380 gallons of oil and 7000 gallons of water;",
            ),

            BulletPoint(
              boldText: "",
              normalText:
                  "UK households throw away 227,000 miles of rolls of wrapping paper every Christmas. That’s enough to cover 11,000 football pitches.",
            ),
          ],
        ),
      ),
    );
  }
}
