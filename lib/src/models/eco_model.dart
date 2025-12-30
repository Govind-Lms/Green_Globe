class EcoModel {
  final String title;
  final String shortDesc;
  final String image;
  final String icon;
  final String newtitle;

  EcoModel({
    required this.title,
    required this.shortDesc,
    required this.image,
    required this.icon,
    required this.newtitle,
  });
}

List<EcoModel> ecoLists = [
  EcoModel(
    icon: "assets/icons/Icons/tree.png",
    image: "assets/icons/tree_tip.png",
    title: "Plant a Tree",
    newtitle: "Plant\nA\nTree",
    shortDesc:
        "Trees improve air quality and support biodiversity—plant one whenever you can.",
    // icon: "tree",
  ),
  EcoModel(
    icon: "assets/icons/Icons/online-shopping.png",
    image: "assets/icons/reusable_bag.png",
    title: "Use Reusable Bags",
    newtitle: "Use\nReusable\nBags",
    shortDesc:
        "Carry cloth or reusable bags to reduce plastic waste during shopping.",
    // icon: "online-shopping",
  ),
  EcoModel(
    icon: "assets/icons/Icons/water-tap.png",
    image: "assets/icons/water.png",
    title: "Save Water Daily",
    newtitle: "Save\nWater\nDaily",
    shortDesc:
        "Turn off the tap while brushing and fix leaks to conserve water and lower water bills.",
    // icon: "water-tap",
  ),
  EcoModel(
    icon: "assets/icons/Icons/fast-food.png",
    image: "assets/icons/food_waste.png",
    title: "Reduce Food Waste",
    newtitle: "Reduce\nFood\nWaste",
    shortDesc:
        "Plan meals, store food properly, and compost leftovers to minimize waste.",
    // icon: "fast-food",
  ),
  EcoModel(
    icon: "assets/icons/Icons/recycle-symbol.png",
    image: "assets/icons/recycle_bin.png",
    title: "Reuse Before Replacing",
    newtitle: "Reuse\nBefore\nReplacing",
    shortDesc:
        "Reuse jars, bottles, and containers instead of throwing them away.",
    // icon: "recycle-symbol",
  ),
  EcoModel(
    icon: "assets/icons/Icons/man.png",
    image: "assets/icons/walking.png",
    title: "Choose Eco Transport",
    newtitle: "Choose\nEco\nTransport",
    shortDesc:
        "Walk, cycle, or use public transport to reduce air pollution and carbon emissions.",
    // icon: "man",
  ),
  EcoModel(
    icon: "assets/icons/Icons/power-plug.png",
    image: "assets/icons/unplug.png",
    title: "Unplug Devices",
    newtitle: "Unplug\nDevices",
    shortDesc:
        "Unplug chargers and devices when not in use to prevent energy loss.",
    // icon: "power-plug",
  ),
  EcoModel(
    icon: "assets/icons/Icons/soap.png",
    image: "assets/icons/eco_soap.png",
    title: "Use Eco-Friendly Products",
    newtitle: "Use\nEco-Friendly\nProducts",
    shortDesc:
        "Choose biodegradable or natural cleaning products to protect the environment.",
    // icon: "soap",R
  ),
];
