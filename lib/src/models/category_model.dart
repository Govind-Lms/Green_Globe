import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';

class RecycleModel {
  final IconData image;
  final String title;
  final String tip;
  final Color color;

  RecycleModel({
    this.image = Icons.delete,
    required this.title,
    required this.tip,
    this.color = Colors.white,
  });
}

List<RecycleModel> recycleLists = [
  RecycleModel(
    // image: "plastic",
    title: "Plastics",
    tip:
        "#1 (PET) & #2 (HDPE) bottles, jugs, and tubs (shampoo, detergent, milk jugs) are often accepted; remove caps.",
    color: primaryGreen.withOpacity(.3),
  ),
  RecycleModel(
    // image: "glass-bottle",
    title: "Glasses",
    tip: "Bottles and jars (check local rules for colors).",
    color: Colors.white,
  ),
  RecycleModel(
    // image: "packages",
    title: "Cardboards",
    color: Colors.white,
    tip:
        "Newspapers, magazines, cereal boxes, mail, and flattened cardboard boxes (remove staples/tape).",
  ),
  RecycleModel(
    // image: "tire",
    title: "Tyres",
    color: Colors.white,
    tip:
        "A tyre is made up of rubber, steel, textiles and other elements that reinforce the resistance of rubber.",
  ),
  RecycleModel(
    // image: "jacket",
    title: "Textile",
    color: Colors.white,
    tip:
        "Recycling clothing is necessary to combat global warming. By giving clothing a second life, the environmental impact of textiles is greatly reduced.",
  ),
  RecycleModel(
    // image: "e-waste",
    title: "E-Waste",
    color: Colors.white,
    tip:
        "E-waste, or electronic waste, refers to discarded electrical or electronic items like phones, computers, and appliances, containing valuable materials but also hazardous substances (lead, mercury) that harm health and the environment if not managed properly.",
  ),
  RecycleModel(
    // image: "crucible",
    title: "Metals",
    color: Colors.white,
    tip: "Aluminum (cans), steel/tin (food cans).",
  ),
  RecycleModel(
    // image: "leaf",
    title: "Organics",
    color: Colors.white,
    tip: "Food scraps and yard waste can be composted separately. ",
  ),
  RecycleModel(
    // image: "coke",
    title: "Aluminium",
    color: Colors.white,
    tip: "Aluminium has been widely used for many years now as a container ",
  ),
];
