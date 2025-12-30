import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/image_builder.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/quote_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class TyreRecycleMethodDetailsView extends StatelessWidget {
  const TyreRecycleMethodDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tyre Recycling',
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
              image: "assets/icons/Tyre Recycling/tire1.jpeg",
              text:
                  "A tyre is made up of rubber, steel, textiles and other elements that reinforce the resistance of rubber.",
            ),

            Text(
              "The production and disposal of tyres is a problem for the environment due to their chemical composition. A large amount of energy is consumed in the manufacturing process of tyres and, once their useful life is over, they tend to end up in landfill without any type of treatment that produces a high level of pollution. That is why it is so important to encourage their recovery and recycling. In this article, you can find out all you need to know about tyre disposal.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            QuoteView(
              quote:
                  "Burning tires at home is illegal and very harmful to the environment",
              color: Colors.red,
            ),
            TitleBuilder(title: "The Benefits of End-of-life tyre recycling"),
            BulletPoint(
              boldText: "Conservation of ",
              normalText: "end-of-life tyre recycling;",
            ),

            BulletPoint(boldText: "Energy saving;", normalText: ""),

            BulletPoint(
              boldText: "Reduction of the emissions ",
              normalText: "of polluting substances",
            ),
            TitleBuilder(title: "What is tyre recycling?"),
            Text(
              "A tyre is made up of rubber, steel, textiles and other elements that reinforce the resistance of rubber. But how is it recycled?",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "When a tyre can no longer guarantee the mobility of a vehicle, in accordance with safety standards (adherence, stability, traction, steering, shock absorption and load bearing), it has to be recycled and recovered in various ways (in its entirety, in pieces or shredded).",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),

            TitleBuilder(
              title: "Waste tyre disposal in the UK: What are your options?",
            ),
            Text(
              "Tyres that need to be recycled are classed as ‘hazardous waste’. In the UK, the Landfill Regulations Act 2002 banned whole tyres from being taken to landfill sites. In addition,since the 2006 EU Landfill Directive, end-of-life or shredded tyres have also been banned from landfill.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "Private households and businesses must, under law, dispose of their tyres in the correct way. Fortunately there are a number of options such as tyre dealers, garages, car mechanic and waste collection points. As mentioned, there are also groups that exist dedicated to collecting tyres and either taking them to tyre recycling machines to be shredded into rubber or re-used.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            TitleBuilder(title: "The tyre recycling process"),
            Text(
              "Because tyres are made of a mixture of steel, rubber, textiles, oils and other chemicals, they are very difficult to recycle. Some tyres also contain oil and other contaminants having been used over a long period of time and those must also be disposed of.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "Tyres that have reached the end of their useful life are often granulated to ensure that the various materials within the individual tyre can be retrieved and potentially used for other purposes.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "In most cases, however, tyre recycling takes place using one of three methods:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            BulletPoint(
              boldText: "Recycled rubber ",
              normalText:
                  "can be used in refurbishing, e.g. re-treading an old, used tyre;",
            ),

            BulletPoint(
              boldText: "Tyre recycling plants ",
              normalText:
                  "can incinerate the old tyres to produce energy for use in manufacturing;",
            ),

            BulletPoint(
              boldText: "Recycled tyres ",
              normalText:
                  "can be broken down and reconstituted for use in new products.",
            ),

            TitleBuilder(title: "What are recycled tyres used for?"),
            BulletPoint(
              boldText: "Re-treading: ",
              normalText:
                  "Old tyres that still have enough structural integrity can be remoulded using recycled rubber treads, extending their life and creating ‘like-new’ tyres. It is estimated that 50% of truck and bus tyres in the UK have been re-treaded;",
            ),

            BulletPoint(
              boldText: "Re-use: ",
              normalText:
                  "Scrap rubber collected from recycled tyres can be used in construction materials, deployed as a material in roads as well as sound-proof walls, bridge foundations and more;",
            ),

            BulletPoint(
              boldText: "Energy recovery: ",
              normalText:
                  "Through a process called pyrolysis, end-of-life tyres can generate gas and oil, replacing coal in some instances (such as in cement kilns and paper mills) – all helping to reduce greenhouse gas emissions;",
            ),

            BulletPoint(
              boldText: "Recycling: ",
              normalText:
                  "Once all the other materials such as steel have been removed, rubber from tyres can be shredded and ground into a new material called crumb rubber, which is used in a surprising variety of products.",
            ),
            TitleBuilder(title: "Can rubber be recycled?"),

            Text(
              "Rubber from car tyre recycling can be used in a number of different ways. In most cases, the rubber is shredded, reducing it to a fine, granular consistency. This can then be used in a number of different ways, for example:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            BulletPoint(boldText: "Playground flooring;", normalText: ""),

            BulletPoint(boldText: "Carpet underlay;", normalText: ""),

            BulletPoint(
              boldText: "Rubberised asphalt for road surfaces;",
              normalText: "",
            ),

            BulletPoint(boldText: "Speed bumps;", normalText: ""),

            BulletPoint(
              boldText: "Running tracks and sports pitches;",
              normalText: "",
            ),

            BulletPoint(boldText: "Mud guards for vehicles.", normalText: ""),
          ],
        ),
      ),
    );
  }
}
