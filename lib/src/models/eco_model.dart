// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class EcoModel {
  final String title;
  final String shortDesc;
  final IconData icon;
  EcoModel({
    required this.title,
    required this.shortDesc,
    this.icon = Icons.delete,
  });
}

List<EcoModel> ecoLists = [
  EcoModel(
    title: "Plant a Tree",
    shortDesc:
        "Trees improve air quality and support biodiversity—plant one whenever you can.",
    // icon: "tree",
  ),
  EcoModel(
    title: "Use Reusable Bags",
    shortDesc:
        "Carry cloth or reusable bags to reduce plastic waste during shopping.",
    // icon: "online-shopping",
  ),
  EcoModel(
    title: "Save Water Daily",
    shortDesc:
        "Turn off the tap while brushing and fix leaks to conserve water and lower water bills.",
    // icon: "water-tap",
  ),
  EcoModel(
    title: "Reduce Food Waste",
    shortDesc:
        "Plan meals, store food properly, and compost leftovers to minimize waste.",
    // icon: "fast-food",
  ),
  EcoModel(
    title: "Reuse Before Replacing",
    shortDesc:
        "Reuse jars, bottles, and containers instead of throwing them away.",
    // icon: "recycle-symbol",
  ),
  EcoModel(
    title: "Choose Eco Transport",
    shortDesc:
        "Walk, cycle, or use public transport to reduce air pollution and carbon emissions.",
    // icon: "man",
  ),
  EcoModel(
    title: "Unplug Devices",
    shortDesc:
        "Unplug chargers and devices when not in use to prevent energy loss.",
    // icon: "power-plug",
  ),
  EcoModel(
    title: "Use Eco-Friendly Products",
    shortDesc:
        "Choose biodegradable or natural cleaning products to protect the environment.",
    // icon: "soap",R
  ),
];
