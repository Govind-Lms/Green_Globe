import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/models/calculator_model.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/calculators/calculations/bottle_calculator.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/calculators/calculations/carbon_reduction_calculator.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/calculators/calculations/cardbaord_calculator.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/calculators/calculations/e_waste_calculator.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/calculators/calculations/metal_calculator.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/calculators/calculations/plastic_calculator.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/calculators/calculations/scrap_value_calculator.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/calculators/calculations/waste_generation_calculator.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/calculators/calculations/waste_impact_calculator.dart';

class AllCalculatorsPage extends StatelessWidget {
  const AllCalculatorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Calculators",
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
        ),
        itemCount: calculators.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              final pages = [
                CarbonReductionCalculatorPage(),
                WasteGenerationCalculator(),
                ScrapRecyclingValueCalculator(),
                MetalRecyclingCalculatorView(),
                PlasticRecyclingCalculatorView(),
                BottlesRecyclingCalculatorView(),
                CardboardRecyclingCalculatorView(),
                EWasteRecyclingCalculatorView(),
                WasteImpactCalculator(),
              ];

              if (index < pages.length) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pages[index]),
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(calculators[index].icon, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    calculators[index].name,
                    style: CustomStyle.fourteenWhite,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
