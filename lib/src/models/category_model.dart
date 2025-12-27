import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';

class RecycleModel {
  final String image;
  final String title;
  final String tip;
  final Color color;

  RecycleModel({
    required this.image,
    required this.title,
    required this.tip,
    this.color = Colors.white,
  });
}

List<RecycleModel> recycleLists = [
  RecycleModel(
    image: "assets/icons/Icons/plastic.png",
    title: "Plastics",
    tip:
        "#1 (PET) & #2 (HDPE) bottles, jugs, and tubs (shampoo, detergent, milk jugs) are often accepted; remove caps.",
    color: primaryGreen.withOpacity(.3),
  ),
  RecycleModel(
    image: "assets/icons/Icons/glass-bottle.png",
    title: "Glasses",
    tip: "Bottles and jars (check local rules for colors).",
    color: Colors.white,
  ),
  RecycleModel(
    image: "assets/icons/Icons/packages.png",
    title: "Cardboards",
    color: Colors.white,
    tip:
        "Newspapers, magazines, cereal boxes, mail, and flattened cardboard boxes (remove staples/tape).",
  ),
  RecycleModel(
    image: "assets/icons/Icons/tire.png",
    title: "Tyres",
    color: Colors.white,
    tip:
        "A tyre is made up of rubber, steel, textiles and other elements that reinforce the resistance of rubber.",
  ),
  RecycleModel(
    image: "assets/icons/Icons/jacket.png",
    title: "Textile",
    color: Colors.white,
    tip:
        "Recycling clothing is necessary to combat global warming. By giving clothing a second life, the environmental impact of textiles is greatly reduced.",
  ),
  RecycleModel(
    image: "assets/icons/Icons/e-waste.png",
    title: "E-Waste",
    color: Colors.white,
    tip:
        "E-waste, or electronic waste, refers to discarded electrical or electronic items like phones, computers, and appliances, containing valuable materials but also hazardous substances (lead, mercury) that harm health and the environment if not managed properly.",
  ),
  RecycleModel(
    image: "assets/icons/Icons/crucible.png",
    title: "Metals",
    color: Colors.white,
    tip: "Aluminum (cans), steel/tin (food cans).",
  ),
  RecycleModel(
    image: "assets/icons/Icons/leaf.png",
    title: "Organics",
    color: Colors.white,
    tip: "Food scraps and yard waste can be composted separately. ",
  ),
  RecycleModel(
    image: "assets/icons/Icons/coke.png",
    title: "Aluminium",
    color: Colors.white,
    tip: "Aluminium has been widely used for many years now as a container ",
  ),
];
