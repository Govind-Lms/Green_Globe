import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Calculation {
  final IconData icon;
  final String name;

  Calculation({required this.icon, required this.name});
}

final List<Calculation> calculators = [
  Calculation(icon: Icons.cloud, name: "Carbon Reduction\nCalculator"),
  Calculation(icon: Icons.delete, name: "Waste Generation\nCalculator"),
  Calculation(
    icon: Iconsax.dollar_circle,
    name: "Scrap Recycling Value\nCalculator",
  ),
  Calculation(icon: Icons.gavel, name: "Metal Recycling\nCalculator"),
  Calculation(icon: Icons.pin_drop, name: "Plastic Recycling\nCalculator"),
  Calculation(icon: Icons.water_damage, name: "Bottles Recycling\nCalculator"),
  Calculation(icon: Iconsax.ship, name: "Cardboard Recycling\nCalculator"),
  Calculation(icon: Icons.laptop, name: "E-Waste Recycling\nCalculator"),
  Calculation(icon: Iconsax.trash, name: "Waste Impact\nCalculator"),
];
