class BinModel {
  final String title;
  final String caption;
  final String image;

  BinModel({required this.title, required this.caption, required this.image});
}

final binInfoConstants = [
  BinModel(
    title: "Acceptable",
    caption: "Safe to dispose",
    image: "assets/icons/bins/green.png",
  ),
  BinModel(
    title: "Nearly Full",
    caption: "Getting close now",
    image: "assets/icons/bins/yellow.png",
  ),
  BinModel(
    title: "Overflowed",
    caption: "Cannot add more",
    image: "assets/icons/bins/red.png",
  ),
];

enum BinStatus { green, yellow, red }

class Coordinate {
  final double latitude;
  final double longitude;

  Coordinate({required this.latitude, required this.longitude});
}

class WasteBin {
  final Coordinate coordinate;
  final BinStatus status;
  final String title;
  final String area;

  WasteBin({
    required this.coordinate,
    required this.status,
    required this.title,
    required this.area,
  });
}

final List<WasteBin> allBins = [
  // Aungmyethazan
  WasteBin(
    coordinate: Coordinate(latitude: 21.9914, longitude: 96.0912),
    status: BinStatus.green,
    title: "Bin AM-01",
    area: "Aungmyethazan - Residential North",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9876, longitude: 96.0979),
    status: BinStatus.yellow,
    title: "Bin AM-02",
    area: "Aungmyethazan - Local Street",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9831, longitude: 96.1046),
    status: BinStatus.red,
    title: "Bin AM-03",
    area: "Aungmyethazan - Market Area",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9798, longitude: 96.0875),
    status: BinStatus.green,
    title: "Bin AM-04",
    area: "Aungmyethazan - Housing Block",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9752, longitude: 96.1123),
    status: BinStatus.yellow,
    title: "Bin AM-05",
    area: "Aungmyethazan - Main Road",
  ),

  // Downtown Core
  WasteBin(
    coordinate: Coordinate(latitude: 21.9721, longitude: 96.0947),
    status: BinStatus.red,
    title: "Bin DT-01",
    area: "Downtown Mandalay - Commercial Zone",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9694, longitude: 96.1016),
    status: BinStatus.green,
    title: "Bin DT-02",
    area: "Downtown Mandalay - Shopping Street",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9668, longitude: 96.0884),
    status: BinStatus.yellow,
    title: "Bin DT-03",
    area: "Downtown Mandalay - Food Stalls",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9642, longitude: 96.1101),
    status: BinStatus.red,
    title: "Bin DT-04",
    area: "Downtown Mandalay - Bus Stop",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9617, longitude: 96.0969),
    status: BinStatus.green,
    title: "Bin DT-05",
    area: "Downtown Mandalay - Side Street",
  ),

  // Mahaaungmye
  WasteBin(
    coordinate: Coordinate(latitude: 21.9586, longitude: 96.1057),
    status: BinStatus.yellow,
    title: "Bin MA-01",
    area: "Mahaaungmye - Residential",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9561, longitude: 96.0918),
    status: BinStatus.red,
    title: "Bin MA-02",
    area: "Mahaaungmye - Wet Market",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9534, longitude: 96.1139),
    status: BinStatus.green,
    title: "Bin MA-03",
    area: "Mahaaungmye - School Zone",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9512, longitude: 96.0983),
    status: BinStatus.yellow,
    title: "Bin MA-04",
    area: "Mahaaungmye - Apartment Area",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9485, longitude: 96.1074),
    status: BinStatus.red,
    title: "Bin MA-05",
    area: "Mahaaungmye - Local Shops",
  ),

  // Chanmyathazi
  WasteBin(
    coordinate: Coordinate(latitude: 21.9459, longitude: 96.1196),
    status: BinStatus.green,
    title: "Bin CM-01",
    area: "Chanmyathazi - Residential East",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9431, longitude: 96.1268),
    status: BinStatus.yellow,
    title: "Bin CM-02",
    area: "Chanmyathazi - Community Park",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9404, longitude: 96.1142),
    status: BinStatus.red,
    title: "Bin CM-03",
    area: "Chanmyathazi - Street Market",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9378, longitude: 96.1321),
    status: BinStatus.green,
    title: "Bin CM-04",
    area: "Chanmyathazi - Housing Estate",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9352, longitude: 96.1213),
    status: BinStatus.yellow,
    title: "Bin CM-05",
    area: "Chanmyathazi - Main Junction",
  ),

  // Pyigyidagun
  WasteBin(
    coordinate: Coordinate(latitude: 21.9327, longitude: 96.1394),
    status: BinStatus.red,
    title: "Bin PG-01",
    area: "Pyigyidagun - Industrial Zone",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9301, longitude: 96.1256),
    status: BinStatus.green,
    title: "Bin PG-02",
    area: "Pyigyidagun - Residential",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9276, longitude: 96.1428),
    status: BinStatus.yellow,
    title: "Bin PG-03",
    area: "Pyigyidagun - Warehouse Area",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9251, longitude: 96.1309),
    status: BinStatus.red,
    title: "Bin PG-04",
    area: "Pyigyidagun - Roadside Shops",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9225, longitude: 96.1471),
    status: BinStatus.green,
    title: "Bin PG-05",
    area: "Pyigyidagun - Residential East",
  ),

  // Industrial
  WasteBin(
    coordinate: Coordinate(latitude: 21.9198, longitude: 96.1346),
    status: BinStatus.yellow,
    title: "Bin SE-01",
    area: "Southeast Mandalay - Industrial Edge",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9171, longitude: 96.1493),
    status: BinStatus.red,
    title: "Bin SE-02",
    area: "Southeast Mandalay - Logistics Area",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9146, longitude: 96.1381),
    status: BinStatus.green,
    title: "Bin SE-03",
    area: "Southeast Mandalay - Worker Housing",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9122, longitude: 96.1517),
    status: BinStatus.yellow,
    title: "Bin SE-04",
    area: "Southeast Mandalay - Factory Road",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9097, longitude: 96.1412),
    status: BinStatus.red,
    title: "Bin SE-05",
    area: "Southeast Mandalay - Storage Yard",
  ),

  // Residential
  WasteBin(
    coordinate: Coordinate(latitude: 21.9569, longitude: 96.1284),
    status: BinStatus.green,
    title: "Bin ER-01",
    area: "East Mandalay - Residential Block",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9633, longitude: 96.1361),
    status: BinStatus.yellow,
    title: "Bin ER-02",
    area: "East Mandalay - School Vicinity",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9698, longitude: 96.1427),
    status: BinStatus.red,
    title: "Bin ER-03",
    area: "East Mandalay - Local Market",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9756, longitude: 96.1319),
    status: BinStatus.green,
    title: "Bin ER-04",
    area: "East Mandalay - Housing Lane",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9814, longitude: 96.1396),
    status: BinStatus.yellow,
    title: "Bin ER-05",
    area: "East Mandalay - Main Road",
  ),

  // Northeast fringe
  WasteBin(
    coordinate: Coordinate(latitude: 21.9882, longitude: 96.1217),
    status: BinStatus.red,
    title: "Bin NE-01",
    area: "Northeast Mandalay - Outer Road",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9856, longitude: 96.1289),
    status: BinStatus.green,
    title: "Bin NE-02",
    area: "Northeast Mandalay - Residential",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9829, longitude: 96.1348),
    status: BinStatus.yellow,
    title: "Bin NE-03",
    area: "Northeast Mandalay - New Housing",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9803, longitude: 96.1226),
    status: BinStatus.red,
    title: "Bin NE-04",
    area: "Northeast Mandalay - Road Junction",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9777, longitude: 96.1374),
    status: BinStatus.green,
    title: "Bin NE-05",
    area: "Northeast Mandalay - Residential East",
  ),

  // 84th Street + Mandalay University
  WasteBin(
    coordinate: Coordinate(latitude: 21.9728, longitude: 96.1074),
    status: BinStatus.green,
    title: "Bin 84-01",
    area: "84th Street - North Segment",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9709, longitude: 96.1058),
    status: BinStatus.yellow,
    title: "Bin 84-02",
    area: "84th Street - Commercial Strip",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9692, longitude: 96.1091),
    status: BinStatus.red,
    title: "Bin 84-03",
    area: "84th Street - Roadside Shops",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9675, longitude: 96.1066),
    status: BinStatus.green,
    title: "Bin 84-04",
    area: "84th Street - Residential Access",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9657, longitude: 96.1089),
    status: BinStatus.yellow,
    title: "Bin 84-05",
    area: "84th Street - Bus Stop",
  ),

  WasteBin(
    coordinate: Coordinate(latitude: 21.9638, longitude: 96.1052),
    status: BinStatus.red,
    title: "Bin MU-01",
    area: "Mandalay University - Main Gate",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9621, longitude: 96.1096),
    status: BinStatus.green,
    title: "Bin MU-02",
    area: "Mandalay University - Hostel Area",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9603, longitude: 96.1069),
    status: BinStatus.yellow,
    title: "Bin MU-03",
    area: "Mandalay University - Lecture Hall",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9587, longitude: 96.1103),
    status: BinStatus.red,
    title: "Bin MU-04",
    area: "Mandalay University - Canteen",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9594, longitude: 96.1028),
    status: BinStatus.green,
    title: "Bin MU-05",
    area: "Mandalay University - Library",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9586, longitude: 96.1006),
    status: BinStatus.yellow,
    title: "Bin MU-06",
    area: "Mandalay University - Staff Housing",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9573, longitude: 96.1039),
    status: BinStatus.red,
    title: "Bin MU-07",
    area: "Mandalay University - Student Union",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9561, longitude: 96.1014),
    status: BinStatus.green,
    title: "Bin MU-08",
    area: "Mandalay University - Sports Ground",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9552, longitude: 96.1047),
    status: BinStatus.yellow,
    title: "Bin MU-09",
    area: "Mandalay University - South Entrance",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9538, longitude: 96.1022),
    status: BinStatus.red,
    title: "Bin MU-10",
    area: "University South - Residential",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9526, longitude: 96.1056),
    status: BinStatus.green,
    title: "Bin MU-11",
    area: "University South - Local Shops",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9513, longitude: 96.1031),
    status: BinStatus.yellow,
    title: "Bin MU-12",
    area: "University South - Housing Lane",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9501, longitude: 96.1064),
    status: BinStatus.red,
    title: "Bin MU-13",
    area: "University South - Road Junction",
  ),
  WasteBin(
    coordinate: Coordinate(latitude: 21.9489, longitude: 96.1040),
    status: BinStatus.green,
    title: "Bin MU-14",
    area: "University South - Residential Block",
  ),
];
