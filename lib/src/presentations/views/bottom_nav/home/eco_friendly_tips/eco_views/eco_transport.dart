import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/models/eco_model.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/eco_image_widget.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/bullet_point.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/title_builder.dart';

class EcoTransportDetailsView extends StatelessWidget {
  final EcoModel ecoModel;
  const EcoTransportDetailsView({super.key, required this.ecoModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose Eco Transport',
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
              boldText: "Reduced Greenhouse Gas (GHG) Emissions: ",
              normalText:
                  "Eco transport significantly cuts down on carbon dioxide and other emissions, which helps mitigate climate change. Transportation is a major source of global emissions, so shifting modes has a large impact.",
            ),

            BulletPoint(
              boldText: "Improved Air Quality: ",
              normalText:
                  "Fewer tailpipe pollutants like nitrogen oxides and particulate matter lead to cleaner air, particularly in urban areas. This directly reduces the incidence of respiratory and cardiovascular diseases in the population.",
            ),

            BulletPoint(
              boldText: "Conservation of Natural Resources: ",
              normalText:
                  "Sustainable transport reduces reliance on finite fossil fuels by using alternative energy sources like electricity (especially when generated from renewables), hydrogen, or biofuels.",
            ),

            BulletPoint(
              boldText: "Less Noise Pollution: ",
              normalText:
                  "Quieter vehicles and fewer cars on the road result in reduced noise pollution, which is beneficial for human well-being and local ecosystems.",
            ),

            BulletPoint(
              boldText: "Efficient Land Use: ",
              normalText:
                  "By reducing car dependency, cities can use less land for roads and parking lots, freeing up space for green areas, parks, and housing. ",
            ),

            TitleBuilder(title: 'Health & Social Benefits'),
            BulletPoint(
              boldText: "Improved Public Health: ",
              normalText:
                  "Active transportation methods like walking and cycling provide direct physical activity benefits, helping to lower obesity rates and boost overall well-being.",
            ),

            BulletPoint(
              boldText: "Enhanced Safety: ",
              normalText:
                  "Public transportation is statistically safer than private vehicle use, and fewer cars on the road generally lead to fewer accidents.",
            ),
            BulletPoint(
              boldText: "Reduced Traffic Congestion: ",
              normalText:
                  "More people using public transit, carpooling, or active transport methods alleviates traffic bottlenecks, leading to fewer wasted hours in traffic.",
            ),

            BulletPoint(
              boldText: "Equitable Mobility: ",
              normalText:
                  "Sustainable transport systems often improve accessibility and affordability, benefiting low-income communities and individuals who may not be able to afford a private car. ",
            ),
            TitleBuilder(title: 'Economic Benefits'),

            BulletPoint(
              boldText: "Cost Savings for Individuals: ",
              normalText:
                  "Individuals can save money on fuel, maintenance, insurance, and parking costs by using eco-friendly options. For example, EV owners can save thousands of dollars over the vehicle's lifetime through reduced energy and maintenance costs.",
            ),

            BulletPoint(
              boldText: "Operational Cost Reduction for Businesses: ",
              normalText:
                  "Companies benefit from increased fuel efficiency, optimized routes, and potential government tax incentives and subsidies for using cleaner fleets.",
            ),
            BulletPoint(
              boldText: "Job Creation: ",
              normalText:
                  "The development and maintenance of sustainable transport infrastructure (e.g., charging stations, bike lanes, public transit systems) creates new job opportunities.",
            ),

            BulletPoint(
              boldText: "Risk Mitigation: ",
              normalText:
                  "Diversifying energy sources helps protect businesses and individuals against the volatility of fossil fuel prices.",
            ),
            TitleBuilder(title: 'For Business and Policy Makers'),

            BulletPoint(
              boldText: "Enhanced Brand Reputation: ",
              normalText:
                  "Demonstrating a commitment to sustainability resonates with environmentally conscious consumers and business partners, improving brand image and competitive advantage.",
            ),

            BulletPoint(
              boldText: "Regulatory Compliance: ",
              normalText:
                  "Adopting green transport methods ensures compliance with increasingly strict environmental regulations, avoiding potential fines and operational disruptions.",
            ),

            BulletPoint(
              boldText: "Attracting Talent: ",
              normalText:
                  "Employees increasingly want to work for organizations that demonstrate environmental responsibility, making sustainable practices an important part of employer branding. ",
            ),
          ],
        ),
      ),
    );
  }
}
