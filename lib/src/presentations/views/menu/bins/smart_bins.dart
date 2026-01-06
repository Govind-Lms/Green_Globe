import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/models/bin_model.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/QR/qr_scan_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_globe/src/presentations/views/menu/bins/animated_card_builder.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:math';

class SmartBinsPage extends StatefulWidget {
  const SmartBinsPage({super.key});

  @override
  State<SmartBinsPage> createState() => _SmartBinsPageState();
}

class _SmartBinsPageState extends State<SmartBinsPage> {
  GoogleMapController? _mapController;
  LatLng _userLocation = const LatLng(
    21.790834,
    96.116327,
  ); // Default to Mandalay
  Set<Marker> _markers = {};

  int _carouselCurrent = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  // Custom info window fields
  bool _showCustomInfoWindow = false;
  Offset? _customInfoWindowOffset;
  WasteBin? _selectedBin;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          _userLocation = LatLng(position.latitude, position.longitude);
        });
      }
    } catch (e) {
      // ignore
    }
    await _loadBins();
    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(_userLocation));
    }
  }

  // WasteBin? _findBinById(String id) {
  //   for (var bin in allBins) {
  //     if (bin.title == id) return bin;
  //   }
  //   return null;
  // }

  Future<void> _loadBins() async {
    final Set<Marker> newMarkers = {};
    newMarkers.add(
      Marker(
        markerId: const MarkerId('user_location'),
        position: _userLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onTap: () {
          setState(() {
            _showCustomInfoWindow = false;
            _selectedBin = null;
          });
        },
      ),
    );
    for (final bin in allBins) {
      final id = bin.title;
      final lat = bin.coordinate.latitude;
      final long = bin.coordinate.longitude;
      final iconPath = bin.status == BinStatus.green
          ? "assets/icons/bins/green.png"
          : bin.status == BinStatus.yellow
          ? "assets/icons/bins/yellow.png"
          : "assets/icons/bins/red.png";
      final BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(12, 12)),
        iconPath,
      );

      newMarkers.add(
        Marker(
          markerId: MarkerId(id),
          position: LatLng(lat, long),
          icon: customIcon,
          onTap: () async {
            if (_mapController != null) {
              ScreenCoordinate screenCoordinate = await _mapController!
                  .getScreenCoordinate(LatLng(lat, long));
              RenderBox? box = context.findRenderObject() as RenderBox?;
              final double devicePixelRatio = MediaQuery.of(
                context,
              ).devicePixelRatio;
              final Offset widgetOffset = box != null
                  ? box.localToGlobal(Offset.zero)
                  : Offset.zero;
              final Offset markerOffset = Offset(
                screenCoordinate.x / devicePixelRatio + widgetOffset.dx,
                screenCoordinate.y / devicePixelRatio + widgetOffset.dy,
              );

              setState(() {
                _selectedBin = bin;
                _showCustomInfoWindow = true;
                _customInfoWindowOffset = markerOffset;
              });
            }
          },
        ),
      );
    }
    setState(() {
      _markers = newMarkers;
    });
  }

  void _goToUserLocation() async {
    _userLocation = _userLocation;
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(_userLocation, 18),
      );
      setState(() {
        _showCustomInfoWindow = false;
        _selectedBin = null;
      });
    }
  }

  void _goToMandalay() {
    if (_mapController == null || allBins.isEmpty) return;
    double minLat = allBins.first.coordinate.latitude;
    double maxLat = allBins.first.coordinate.latitude;
    double minLng = allBins.first.coordinate.longitude;
    double maxLng = allBins.first.coordinate.longitude;

    for (final bin in allBins) {
      final lat = bin.coordinate.latitude;
      final lng = bin.coordinate.longitude;
      if (lat < minLat) minLat = lat;
      if (lat > maxLat) maxLat = lat;
      if (lng < minLng) minLng = lng;
      if (lng > maxLng) maxLng = lng;
    }
    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
    _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100.0));
    setState(() {
      _showCustomInfoWindow = false;
      _selectedBin = null;
    });
  }

  void _onMapTap(LatLng latLng) {
    setState(() {
      _showCustomInfoWindow = false;
      _selectedBin = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> cardsData = [
      {
        'color': Colors.green,
        'status': 'Nearly Empty',
        'subtitle': 'Plenty of space',
        'fillLevel': 1.0,
        'isMain': true,
        'iconPath': 'assets/icons/bins/green.png',
      },
      {
        'color': Colors.orange,
        'status': 'Nearly Full',
        'subtitle': 'Getting close now',
        'fillLevel': 0.85,
        'isMain': true,
        'iconPath': 'assets/icons/bins/yellow.png',
      },
      {
        'color': Colors.red,
        'status': 'Full',
        'subtitle': 'Needs attention',
        'fillLevel': 1.0,
        'isMain': true,
        'iconPath': 'assets/icons/bins/red.png',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Smart Bins',
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: CarouselSlider.builder(
                      itemCount: cardsData.length,
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        autoPlayCurve: Curves.bounceOut,
                        height: 300,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        viewportFraction: 0.9,
                        initialPage: _carouselCurrent,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _carouselCurrent = index;
                          });
                        },
                      ),
                      itemBuilder: (context, index, realIdx) {
                        double scale = max(
                          0.65,
                          1 - (index - _carouselCurrent).abs() * 0.85,
                        );
                        return AnimatedBinStatusCard(
                          color: cardsData[index]['color'] as Color,
                          status: cardsData[index]['status'] as String,
                          subtitle: cardsData[index]['subtitle'] as String,
                          fillLevel: cardsData[index]['fillLevel'] as double,
                          isMain: cardsData[index]['isMain'] as bool,
                          iconPath: cardsData[index]['iconPath'] as String,
                          scale: scale,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bins Near You',
                          style: CustomStyle.eighteen.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            children: [
                              Listener(
                                behavior: HitTestBehavior.opaque,
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: _userLocation,
                                    zoom: 18,
                                  ),
                                  scrollGesturesEnabled: true,
                                  myLocationButtonEnabled: true,
                                  zoomControlsEnabled: true,
                                  mapType: MapType.normal,
                                  markers: _markers,
                                  onMapCreated:
                                      (GoogleMapController controller) async {
                                        _mapController = controller;
                                        await _loadBins();
                                      },
                                  onTap: _onMapTap,
                                  onCameraMove: (position) async {
                                    if (_showCustomInfoWindow &&
                                        _selectedBin != null &&
                                        _mapController != null) {
                                      // Recalculate the Offset of the InfoWindow based on new camera position
                                      final lat =
                                          _selectedBin!.coordinate.latitude;
                                      final long =
                                          _selectedBin!.coordinate.longitude;
                                      ScreenCoordinate screenCoordinate =
                                          await _mapController!
                                              .getScreenCoordinate(
                                                LatLng(lat, long),
                                              );
                                      RenderBox? box =
                                          context.findRenderObject()
                                              as RenderBox?;
                                      final double devicePixelRatio =
                                          MediaQuery.of(
                                            context,
                                          ).devicePixelRatio;
                                      final Offset widgetOffset = box != null
                                          ? box.localToGlobal(Offset.zero)
                                          : Offset.zero;
                                      final Offset markerOffset = Offset(
                                        screenCoordinate.x / devicePixelRatio +
                                            widgetOffset.dx,
                                        screenCoordinate.y / devicePixelRatio +
                                            widgetOffset.dy,
                                      );

                                      setState(() {
                                        _customInfoWindowOffset = markerOffset;
                                      });
                                    }
                                  },
                                ),
                              ),
                              if (_showCustomInfoWindow &&
                                  _selectedBin != null &&
                                  _customInfoWindowOffset != null)
                                _CustomInfoWindowOverlay(
                                  offset: _customInfoWindowOffset!,
                                  bin: _selectedBin!,
                                  onClose: () {
                                    setState(() {
                                      _showCustomInfoWindow = false;
                                      _selectedBin = null;
                                    });
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _goToUserLocation,
                icon: const Icon(Iconsax.send_1, size: 18),
                label: const Text('Your Location'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _goToMandalay,
                icon: const Icon(Iconsax.location, size: 18),
                label: const Text('Mandalay'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const QRScanPage()));
        },
        backgroundColor: primaryGreen,
        child: const Icon(Icons.qr_code, color: Colors.white, size: 28),
      ),
    );
  }

  /// Old _buildBinStatusCard replaced with AnimatedBinStatusCard below

  Widget _buildProgressBar({
    required Color color,
    required String label,
    required double value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: CustomStyle.fourteen.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            FractionallySizedBox(
              widthFactor: value,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}

class _CustomInfoWindowOverlay extends StatelessWidget {
  final Offset offset;
  final WasteBin bin;

  final VoidCallback onClose;

  const _CustomInfoWindowOverlay({
    required this.offset,
    required this.bin,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    const double infoWindowWidth = 220;
    const double infoWindowHeight = 120;
    Offset finalOffset = Offset(
      offset.dx - infoWindowWidth / 2,
      offset.dy - infoWindowHeight - 40,
    );

    final color = bin.status == BinStatus.green
        ? Colors.green
        : bin.status == BinStatus.yellow
        ? Colors.orange
        : Colors.red;
    final iconPath = bin.status == BinStatus.green
        ? "assets/icons/bins/green.png"
        : bin.status == BinStatus.yellow
        ? "assets/icons/bins/yellow.png"
        : "assets/icons/bins/red.png";
    final statusText = bin.status == BinStatus.green
        ? "Nearly Empty"
        : bin.status == BinStatus.yellow
        ? "Nearly Full"
        : "Full";

    return Positioned(
      left: finalOffset.dx,
      top: finalOffset.dy,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: infoWindowWidth,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.17),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(color: color.withOpacity(0.2), width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(iconPath, height: 34, width: 34),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      bin.title,
                      style: CustomStyle.fourteen.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: onClose,
                  //   child: const Icon(
                  //     Icons.close_rounded,
                  //     size: 18,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: CustomStyle.twelve.copyWith(color: Colors.black54),
                  children: [
                    TextSpan(
                      text: statusText,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: " • ${bin.area}",
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "${bin.coordinate.latitude.toStringAsFixed(6)}, "
                "${bin.coordinate.longitude.toStringAsFixed(6)}",
                style: CustomStyle.twelve.copyWith(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
