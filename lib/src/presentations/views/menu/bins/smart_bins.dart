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

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _loadBins();
  }

  Future<void> _getUserLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are disabled, user needs to enable them in settings
        return;
      }

      // Check current permission status
      LocationPermission permission = await Geolocator.checkPermission();

      // If permission is denied, request it
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        // If still denied after request, return early
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      // If permission is permanently denied, user needs to enable in settings
      if (permission == LocationPermission.deniedForever) {
        return;
      }

      // Permission granted, get current position
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          _userLocation = LatLng(position.latitude, position.longitude);
        });

        // Reload bins to update user location marker
        await _loadBins();

        if (_mapController != null) {
          _mapController!.animateCamera(CameraUpdate.newLatLng(_userLocation));
        }
      }
    } catch (e) {
      // Handle error silently - location might not be available
    }
  }

  Future<void> _loadBins() async {
    final Set<Marker> newMarkers = {};
    newMarkers.add(
      Marker(
        markerId: const MarkerId('user_location'),
        position: _userLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: 'You'),
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
          infoWindow: InfoWindow(title: bin.title, snippet: bin.area),
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
        CameraUpdate.newLatLngZoom(_userLocation, 15),
      );
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryGreen),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Smart Bins',
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Bin Status Cards Section (animated carousel)
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
                    ); // Center scale 1, others ~0.85
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

              // Bins Near You Section
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
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: _userLocation,
                              zoom: 15,
                            ),
                            zoomGesturesEnabled: true,
                            mapType: MapType.normal,
                            markers: _markers,
                            onMapCreated:
                                (GoogleMapController controller) async {
                                  _mapController = controller;
                                  await _loadBins();
                                },
                            myLocationButtonEnabled: false,
                            zoomControlsEnabled: false,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Action Buttons
                    const SizedBox(height: 20),
                    // Progress Bars Section
                    _buildProgressBar(
                      color: Colors.red,
                      label: 'Full Bins',
                      value: 0.3,
                    ),
                    const SizedBox(height: 12),
                    _buildProgressBar(
                      color: primaryGreen,
                      label: 'Available Bins',
                      value: 0.7,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
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
