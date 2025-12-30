import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/models/eco_model.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_views/eco_product.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_views/eco_transport.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_views/food_waste_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_views/plant_a_tree.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_views/reuse_before_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_views/unplug_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_views/use_reusable_bags.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/eco_friendly_tips/eco_views/water_view.dart';

class EcoFriendlyView extends StatelessWidget {
  const EcoFriendlyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Eco-Friendly Tips",
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(ecoLists.length, (index) {
                return InkWell(
                  onTap: () {
                    final pages = [
                      PlantATreeDetailsView(ecoModel: ecoLists[index]),
                      ReusableBagsDetailsView(ecoModel: ecoLists[index]),
                      SaveWaterDetailsView(ecoModel: ecoLists[index]),
                      FoodWasteDetailsView(ecoModel: ecoLists[index]),
                      ReuseBeforeDetailsView(ecoModel: ecoLists[index]),
                      EcoTransportDetailsView(ecoModel: ecoLists[index]),
                      UnplugDetailsView(ecoModel: ecoLists[index]),
                      EcoProductDetailsView(ecoModel: ecoLists[index]),
                    ];

                    if (index < pages.length) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => pages[index]),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset(ecoLists[index].icon),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ecoLists[index].title,
                                style: CustomStyle.sixteen.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                ecoLists[index].shortDesc,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                                style: CustomStyle.fourteen.copyWith(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
