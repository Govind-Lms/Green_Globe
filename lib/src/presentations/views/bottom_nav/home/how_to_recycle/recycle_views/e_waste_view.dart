import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/image_builder.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/quote_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class EwasteRecycleMethodDetailsView extends StatelessWidget {
  const EwasteRecycleMethodDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'E-Waste Recycling',
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
              image: 'assets/icons/E-Waste Recycling/ewaste.jpg',
              text:
                  "E-waste, or electronic waste, refers to discarded electrical or electronic items like phones, computers, and appliances, containing valuable materials but also hazardous substances (lead, mercury) that harm health and the environment if not managed properly.",
            ),

            Text(
              "Electronic waste, or e-waste produced worldwide, has snowballed in recent years. This is due to constant technological changes, shorter product lifespans, and shifts in how we store media (like moving from CDs to SSDs to the cloud). Electronics have also become more affordable, making them more accessible for people to buy and replace. As a result, e-waste is now the fastest-growing type of waste globally—amounting to 70% of all toxic waste.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),

            QuoteView(
              quote:
                  "We have been getting ready to recycle more e-waste by investing in infrastructure, providing grants to local governments, and working with industry.",
              color: Colors.yellow,
            ),
            SizedBox(height: 10),

            Text(
              "E-waste includes all electronic devices that are no longer usable—broken or outdated. However, not everything labeled as e-waste truly belongs in that category. If still functional or repairable, many old devices can be donated, reused, or refurbished instead of discarded. Still, we all can reduce this waste, and RTS will show you how.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),

            TitleBuilder(title: "The Most Common Types of e-waste"),
            Text(
              "A broken, outdated, or dead keyboard, computer, microwave, phone, and anything that works by electricity is part of e-waste. As technology advances quickly and people upgrade devices more often, the amount of discarded electronics rises.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "Knowing the most common types of e-waste can help individuals and businesses make better decisions about reuse, recycling, or proper disposal. Here are some of the most common types of e-waste:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            BulletPoint(
              boldText: "Small Electronics — ",
              normalText:
                  "These are items small enough to fit your hands and cover only a small space. Examples are smartphones, tablets, cameras, earbuds, small medical devices, and electric toys.",
            ),

            BulletPoint(
              boldText: "Large Appliances — ",
              normalText:
                  "These take up more space and use more electricity. They are refrigerators, washing machines, air conditioners, and other home appliances.",
            ),

            BulletPoint(boldText: "", normalText: "ventilation equipment"),

            BulletPoint(
              boldText: "Computers and Accessories — ",
              normalText: "Laptops, desktops, keyboards, mice, and printers.",
            ),

            BulletPoint(
              boldText: "Televisions and Monitors — ",
              normalText:
                  "Older CRT TVs, computer monitors, and modern flat screens.",
            ),

            BulletPoint(
              boldText: "Kitchen Appliances — ",
              normalText:
                  "Toasters, microwaves, blenders, and similar devices are common in e-waste landfills.",
            ),

            BulletPoint(
              boldText: "Lighting Devices — ",
              normalText:
                  "Items like LED bulbs, lamps, and fluorescent lights also contribute to e-waste.",
            ),

            BulletPoint(
              boldText: "Batteries — ",
              normalText:
                  "From single-use batteries to rechargeable ones, they are a growing part of electronic waste.",
            ),

            QuoteView(
              quote:
                  "Proper disposal or recycling of these items is crucial to reduce their environmental impact.",
              color: primaryGreen,
            ),
            TitleBuilder(title: "The Problems With not Recycling e-waste"),

            Text(
              "When e-waste is not managed properly and ends up in landfills or incinerators, it can release harmful chemicals into the air, water, and soil. Some of the dangerous substances that can come from e-waste include:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            BulletPoint(boldText: "Lead", normalText: ""),

            BulletPoint(boldText: "Barium", normalText: ""),

            BulletPoint(boldText: "Phosphor", normalText: ""),

            BulletPoint(boldText: "Beryllium", normalText: ""),

            BulletPoint(boldText: "Cadmium", normalText: ""),

            BulletPoint(boldText: "Mercury", normalText: ""),

            BulletPoint(boldText: "Brominated dioxins", normalText: ""),

            BulletPoint(
              boldText: "Polycyclic aromatic hydrocarbons",
              normalText: "",
            ),
            Text(
              "Failing to recycle e-waste also increases the need to mine fresh resources to make new electronics. Many of these devices contain precious metals like gold, silver, platinum, and palladium, already in limited supply. Mining these materials harms the environment through deforestation, soil erosion, and pollution from transportation and processing. By recycling electronics, we can reuse these valuable materials and reduce the need for mining, helping to protect the planet.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            ImageBuilder(
              image: "assets/icons/E-Waste Recycling/ewaste2.png",
              context: context,
              text: '',
            ),
            TitleBuilder(title: "Step 1: Collection"),

            Text(
              "The first step is gathering old electronics through designated recycling bins, drop-off centers, or take-back programs. Local governments, businesses, or community events may run these collection points. Some services even offer on-demand pickups to make recycling easier.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "In this step proper separation rules. Many centers use bins for various types of e-waste, such as batteries, phones, or computers, to prevent harmful substances from mixing. Batteries, for instance, require special care because they can cause fires or leak toxic chemicals. We have been able to recycle about 350 lbs of batteries so far.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),

            TitleBuilder(title: "Step 2: Safe Storage"),

            Text(
              "Once collected, e-waste is stored safely until it’s ready for processing. This is especially important for items like old TVs and monitor screens containing lead, which can harm people and the environment if mishandled. In the past, glass from these screens was recycled into new products, but declining demand has left much of it in storage.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),

            TitleBuilder(title: "Step 3: Sorting, Dismantling, and Shredding"),

            Text(
              "Next, the e-waste goes through manual sorting. Workers remove specific items that need special processing, such as batteries or lightbulbs. Some parts, like reusable components or valuable metals, are separated at this stage.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "After sorting, the remaining e-waste is shredded into tiny pieces, usually just a few centimeters in size. This makes separating materials like metals, plastics, and glass more accessible.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),

            TitleBuilder(title: "Step 4: Mechanical Separation"),

            Text(
              "This step uses advanced machines to sort materials based on their properties:",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),

            TitleBuilder(title: "Magnetic Separation"),

            Text(
              "Large magnets pull out metals like steel and iron. Nonferrous metals like aluminum and copper are separated using eddy currents.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),

            TitleBuilder(title: "Water Separation"),

            Text(
              "Plastic and glass pieces are separated using water. Heavy materials sink, while lighter ones float, making it easier to sort and purify each type.These processes ensure that every material is collected and prepared for the next stage.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            TitleBuilder(title: "Step 5: Material Recovery"),

            Text(
              "Finally, the separated materials are cleaned and prepared for reuse. Metals like steel and copper may be used in smelting plants to create new products. Plastics might be melted down and turned into new items, while reusable components can go directly back into production.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "This stage is vital for creating a circular economy. By recovering and reusing materials, we reduce the need for mining raw resources, which helps protect the environment and save energy.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            TitleBuilder(title: "Materials Extracted from E-Waste"),

            Text(
              "When electronic devices like phones, computers, and TVs reach the end of their life, they can be recycled to recover valuable materials. These materials are often crucial for creating new products, and recycling helps reduce the need for mining, which can harm the environment.",
              style: CustomStyle.twelve,
              textAlign: TextAlign.justify,
            ),
            BulletPoint(boldText: "Metals", normalText: ""),

            BulletPoint(boldText: "Rare Earth Elements", normalText: ""),

            BulletPoint(boldText: "Plastics", normalText: ""),

            BulletPoint(boldText: "Glass", normalText: ""),
          ],
        ),
      ),
    );
  }
}
