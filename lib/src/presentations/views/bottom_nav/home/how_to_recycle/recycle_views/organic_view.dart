import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/image_builder.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/quote_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class OrganicRecycleMethodDetailsView extends StatelessWidget {
  const OrganicRecycleMethodDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Organic Recycling',
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
              text: "Food scraps and yard waste can be composted separately.",
            ),
            Text(
              "The main objective of composting is to reduce the volume of organic waste. By recycling domestic waste, carbon footprints and greenhouse gases are also reduced, whilst creating a 100% natural fertiliser. In this guide you will find all the tips you need to make the best compost and to learn how to use it correctly.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            QuoteView(
              quote:
                  "Compost is an essential element for soil fertility. Storing waste and allowing it to decompose slowly is returning to the earth what it has given us and at the same time is a positive gesture for the planet.",
              color: primaryGreen,
            ),
            Text(
              "Composting is the process of fermentation and transformation of organic matter which, thanks to the presence of oxygen, allows for the production of stabilised and topsoil rich fertilising material: compost. It is used often in gardening and agriculture to improve soil quality.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            Text(
              "Waste is a resource which isn’t used. Recycling waste and turning it into compost is a very under-utilised resource. Nevertheless, there are many benefits to composting, including:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),

            SimplePoint(
              boldText: '(1) A positive environmental impact: ',
              normalText:
                  ' giving the earth back part of what was taken from it without chemical fertiliser;',
            ),
            SimplePoint(
              boldText: '(2) Savings in everyday life: ',
              normalText:
                  ' reducing the amount of domestic waste and, therefore, saving rubbish bags and lightening the load of a community by reducing rubbish collections (organic materials are the largest part of a rubbish bag);',
            ),
            SimplePoint(
              boldText: '(3) A quality product: ',
              normalText: ' producing one’s own 100% natural fertiliser.',
            ),
            ImageBuilder(
              context: context,
              image: "assets/icons/plastics3.png",
              text: '',
            ),

            TitleBuilder(title: "How does a composter work?"),
            Text(
              "It is not necessary to live in the countryside to make compost. It is also possible to make compost in the city or even on a window sill in the kitchen for example.There are different types of composters:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),

            BulletPoint(
              boldText: "Garden composters: ",
              normalText:
                  "organic waste is gathered on the ground of an area protected from the wind and in the shade. This technique can be used if there is the space and time necessary, as, since it is not sheltered from natural dangers or animals, it is a process which can be very irregular.",
            ),

            BulletPoint(
              boldText: "Urban composters: ",
              normalText:
                  "this technique requires the use of a bucket. The advantage is that the composting bucket protects against climate and animals and does not take up much room. Nevertheless, its volume is small (as it is limited to 1000 litres) in relation to the quantity of waste to be composted, it is possible to use several composters however.",
            ),

            BulletPoint(
              boldText:
                  "Vermicomposting or worm composting (for balconies or flats): ",
              normalText:
                  "this technique consists of composting waste in buckets using worms. The worms eat the organic waste and, after a period of digestion, emit a substance called vermicompost. Worm compost bins are, in the simplest terms, composting bins with small holes in them to allow for moisture and ventilation.",
            ),
            ImageBuilder(
              context: context,
              image: "assets/icons/plastics2.png",
              text: '',
            ),

            TitleBuilder(title: "The process of composting"),
            Text(
              "In the process of composting various phases of decomposition can be distinguished, keeping in mind the evolution of the temperature:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),

            SimplePoint(
              boldText: '(1) The Mesolithic phase: ',
              normalText:
                  'this is the period of acclimatising of micro-organisms to their new environment and the start of the multiplication and colonising of waste;',
            ),
            SimplePoint(
              boldText: '(2) The thermophilic phase (40ºC): ',
              normalText:
                  'when thermophilic organisms appear and produce the rapid breakdown of the organic matter;',
            ),
            SimplePoint(
              boldText: '(3) The cooling phase (60ºC): ',
              normalText:
                  'during this phase actinobacteria take over the breakdown of wax, protein and hemicellulose;',
            ),
            SimplePoint(
              boldText: '(4) The maturity phase: ',
              normalText:
                  'the period of slow fermentation when part of the less biodegradable organic matter breaks down.',
            ),

            SizedBox(height: 10),

            TitleBuilder(title: "The steps to follow to make good compost:"),
            BulletPoint(
              boldText: "Blend waste (where necessary) ",
              normalText:
                  "to facilitate composting and the actions of micro-organis",
            ),

            BulletPoint(
              boldText: "Ventilating ",
              normalText:
                  "the mix to let the micro-organism’s breath enough for composting to occur (regularly during the first few weeks, then every 1 or 2 months);",
            ),

            BulletPoint(
              boldText: "Mixing waste ",
              normalText:
                  "to inoculate the new waste with micro-organisms and therefore accelerate their breakdown;",
            ),

            BulletPoint(
              boldText: "Control the humidity ",
              normalText:
                  "to avoid compost drying out and allowing waste to decompose adequately;",
            ),

            BulletPoint(
              boldText: "Sift the resulting mixture ",
              normalText:
                  "to recover the waste which has not fully decomposed and which can be reused.",
            ),

            Text(
              "To accelerate the process of decomposing of waste in the topsoil, it is also possible to add a compost activator (chemical or natural, such as nettle, fern or comfrey).",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "Matured compost can be recognised when the waste is no longer recognisable and there are few red worms. Matured compost is odourless, dark and stodgy. This result is usually obtained after about 6 months. Some composters can produce compost at a much faster rate (in a maximum of 4 weeks).",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "The best time to use compost is the autumn and the spring as this is the time when worms are most active, but it is possible to use it throughout the year. Compost is also ideal for interior plants if you live in an apartment or flat.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
