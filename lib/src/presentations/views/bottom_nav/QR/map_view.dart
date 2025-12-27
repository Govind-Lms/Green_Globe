import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/core/auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MapView extends StatefulWidget {
  final String binType;
  final String code;

  const MapView({super.key, required this.code, required this.binType});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? _mapController;
  final MapType _mapType = MapType.hybrid;
  late LatLng _binLocation;
  late String _binId;
  Set<Marker> _markers = {};
  late String _locationString; // Format: "lat,long"

  @override
  void initState() {
    super.initState();
    _parseBarcode();
    _loadNearbyBins();
  }

  void _parseBarcode() {
    final code = widget.code;
    String? id, lat, long;

    final idReg = RegExp(r'ID:([^\n]+)');
    final coordsReg = RegExp(
      r'^([0-9\.\-\+]+)\s*,\s*([0-9\.\-\+]+)$',
      multiLine: true,
    );

    var idMatch = idReg.firstMatch(code);
    id = idMatch?.group(1)?.trim();

    final lines = code.split('\n');
    if (lines.length > 1) {
      final coordsMatch = coordsReg.firstMatch(lines[1].trim());
      if (coordsMatch != null) {
        lat = coordsMatch.group(1);
        long = coordsMatch.group(2);
      } else {
        // fallback, split by comma still
        final coords = lines[1].split(',');
        if (coords.isNotEmpty) lat = coords[0].trim();
        if (coords.length > 1) long = coords[1].trim();
      }
    }

    _binId = id ?? 'N/A';
    final latitude = double.tryParse(lat ?? '') ?? 21.790834;
    final longitude = double.tryParse(long ?? '') ?? 96.116327;
    _binLocation = LatLng(latitude, longitude);
    _locationString = '$latitude, $longitude';

    _markers = {
      Marker(
        markerId: MarkerId(_binId),
        position: _binLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: 'Bin', snippet: _binId),
      ),
    };
  }

  void _loadNearbyBins() {
    final Set<Marker> newMarkers = {..._markers};
    for (final barcode in barcodeLists) {
      if (barcode == widget.code) continue;

      final idMatch = RegExp(r'ID:([^\n]+)').firstMatch(barcode);
      final id = idMatch?.group(1)?.trim();
      final lines = barcode.split('\n');
      if (id == null || lines.length < 2) continue;

      final coordsReg = RegExp(r'^([0-9\.\-\+]+)\s*,\s*([0-9\.\-\+]+)$');
      var coordsMatch = coordsReg.firstMatch(lines[1].trim());
      double? lat, long;
      if (coordsMatch != null) {
        lat = double.tryParse(coordsMatch.group(1)!);
        long = double.tryParse(coordsMatch.group(2)!);
      } else {
        final coords = lines[1].split(',');
        if (coords.length >= 2) {
          lat = double.tryParse(coords[0].trim());
          long = double.tryParse(coords[1].trim());
        }
      }
      if (lat == null || long == null) continue;

      newMarkers.add(
        Marker(
          markerId: MarkerId(id),
          position: LatLng(lat, long),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: InfoWindow(title: 'Bin', snippet: id),
        ),
      );
    }
    setState(() {
      _markers = newMarkers;
    });
  }

  Future<void> _submitReport(String message) async {
    try {
      final session = AuthService.getCurrentSession();
      if (session == null) {
        return;
      }
      final userEmail = session.user.email ?? '';
      final client = Supabase.instance.client;

      final pendingReportsData = await client
          .from('reports_admin')
          .select()
          .eq('bin_id', _binId)
          .eq('status', "0");

      final hasExistingReport = pendingReportsData.isNotEmpty;

      if (hasExistingReport) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              titleTextStyle: CustomStyle.eighteen.copyWith(
                fontWeight: FontWeight.bold,
              ),
              contentTextStyle: CustomStyle.fourteen,
              title: const Text('Report Already Exists'),
              content: const Text(
                'You already have a pending report for this bin. Please wait for it to be processed.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
        return;
      }

      await client.from('reports_admin').insert({
        'bin_id': _binId,
        'location': _locationString,
        'message': message,
        'reporter': userEmail,
        'status': 0,
      });

      if (mounted) {
        final currentUser = AuthService.getCurrentUser();
        if (currentUser != null) {
          final userEmail = currentUser.email;

          final userData = await client
              .from('users')
              .select('points_history')
              .eq('email', userEmail!)
              .single();

          List<dynamic> pointHistory = [];
          if (userData['points_history'] != null) {
            pointHistory = List.from(userData['points_history']);
          }

          pointHistory.add({
            "time": DateTime.now().toIso8601String(),
            "message": message,
            "points_earned": 0,
          });

          await client
              .from('users')
              .update({'points_history': pointHistory})
              .eq('email', userEmail);
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            titleTextStyle: CustomStyle.eighteen.copyWith(
              fontWeight: FontWeight.bold,
            ),
            contentTextStyle: CustomStyle.fourteen,
            title: const Text('Success'),
            content: const Text(
              'Your request has been received and will be processed soon.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            titleTextStyle: CustomStyle.eighteen.copyWith(
              fontWeight: FontWeight.bold,
            ),
            contentTextStyle: CustomStyle.fourteen,
            title: const Text('Error'),
            content: Text('Failed to submit report: ${e.toString()}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String getBinAsset(String type) {
      switch (type) {
        case "RECYCLABLES":
          return "assets/icons/bins/blue.png";
        case "BIODEGRADABLE":
        case "EWASTE":
          return "assets/icons/bins/green.png";
        case "NONRECYCLABLE":
          return "assets/icons/bins/yellow.png";
        default:
          return "assets/icons/bins/red.png";
      }
    }

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      height: 120,
                      alignment: Alignment.center,
                      child: Image.asset(
                        getBinAsset(widget.binType),
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Bin ID: $_binId',
                        style: CustomStyle.sixteen.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
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
                                target: _binLocation,
                                zoom: 15,
                              ),
                              mapType: _mapType,
                              markers: _markers,
                              onMapCreated: (GoogleMapController controller) {
                                _mapController = controller;
                              },
                              myLocationButtonEnabled: true,
                              zoomControlsEnabled: true,
                            ),
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.place,
                                      size: 16,
                                      color: Colors.brown[700],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _locationString,
                                      style: CustomStyle.twelve,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (AuthService.getCurrentSession() == null) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      titleTextStyle: CustomStyle.eighteen
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      contentTextStyle: CustomStyle.fourteen,
                                      title: const Text('Please Login'),
                                      content: const Text(
                                        'You need to be logged in to request the garbage truck.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  await _submitReport(
                                    'Request the Garbage Truck',
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryGreen,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'Request the Garbage Truck',
                                style: CustomStyle.sixteen.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: OutlinedButton(
                              onPressed: () async {
                                if (AuthService.getCurrentSession() == null) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      titleTextStyle: CustomStyle.eighteen
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      contentTextStyle: CustomStyle.fourteen,
                                      title: const Text('Please Login'),
                                      content: const Text(
                                        'You need to be logged in to request cleaning.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  await _submitReport(
                                    'Odorous Bins? Request for Cleaning',
                                  );
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black,
                                side: BorderSide(color: Colors.grey[300]!),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor: Colors.grey[100],
                              ),
                              child: Text(
                                'Odorous Bins? Request for Cleaning',
                                style: CustomStyle.sixteen.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
