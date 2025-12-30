import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/QR/map_view.dart';
import 'package:iconsax/iconsax.dart';

class ScannedPage extends StatelessWidget {
  final String code;

  const ScannedPage({super.key, required this.code});

  Map<String, String?> parseBarcode(String code) {
    // Expected format: "ID:BIN_UCSMDY001_RECYCLABLES\n21.790834, 96.116327"
    String? id, lat, long, binType;

    // Find 'ID:' and get text after until newline or end
    final idIndex = code.indexOf('ID:');
    if (idIndex != -1) {
      // id part is after BIN_ up to newline or end
      final newlineIndex = code.indexOf('\n', idIndex);
      if (newlineIndex != -1) {
        id = code.substring(idIndex + 3, newlineIndex);
      } else {
        id = code.substring(idIndex + 3);
      }

      // Extract bin type (the part after the last underscore)
      if (id.contains('_')) {
        final parts = id.split('_');
        if (parts.isNotEmpty) {
          binType = parts.last;
        }
      }
    }

    // Now parse latitude and longitude after the newline
    final lines = code.split('\n');
    if (lines.length > 1) {
      final coords = lines[1].split(',');
      if (coords.isNotEmpty) {
        lat = coords[0].trim();
      }
      if (coords.length > 1) {
        long = coords[1].trim();
      }
    }

    return {'id': id, 'lat': lat, 'long': long, 'binType': binType};
  }

  @override
  Widget build(BuildContext context) {
    final parsed = parseBarcode(code);
    final id = parsed['id'] ?? 'N/A';
    final lat = parsed['lat'] ?? 'N/A';
    final long = parsed['long'] ?? 'N/A';
    final binType = parsed['binType'] ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QR Details',
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Valid QR Code with checkmark
                      Row(
                        children: [
                          const Icon(
                            Iconsax.verify5,
                            color: primaryGreen,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Valid QR Code',
                            style: CustomStyle.eighteen.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Bin ID
                      Text('Bin ID : $id', style: CustomStyle.sixteen),
                      const SizedBox(height: 20),

                      // Divider
                      Divider(color: Colors.grey[400], thickness: 1),
                      const SizedBox(height: 20),

                      // Bin Location with pin icon
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey[700],
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Bin Location',
                            style: CustomStyle.sixteen.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Latitude
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Latitude : $lat',
                          style: CustomStyle.sixteen,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Longitude
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Longitude : $long',
                          style: CustomStyle.sixteen,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Divider
                      Divider(color: Colors.grey[400], thickness: 1),
                      const SizedBox(height: 20),

                      Container(
                        decoration: BoxDecoration(
                          color: binType == "RECYCLABLES"
                              ? Colors.blue[50]
                              : binType == "BIODEGRADABLE"
                              ? Colors.green[50]
                              : binType == "EWASTE"
                              ? Colors.green[50]
                              : binType == "NONRECYCLABLE"
                              ? Colors.yellow[50]
                              : Colors.red[50],
                          // borderRadius: BorderRadius.circular(0),
                          border: Border(
                            left: BorderSide(
                              color: binType == "RECYCLABLES"
                                  ? Colors.blue
                                  : binType == "BIODEGRADABLE"
                                  ? Colors.green
                                  : binType == "EWASTE"
                                  ? Colors.green
                                  : binType == "NONRECYCLABLE"
                                  ? Colors.yellow
                                  : Colors.red,
                              width: 4,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                binType,
                                style: CustomStyle.sixteen.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Proceed Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle proceed action
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MapView(code: code, binType: binType),
                      ),
                    );
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
                    'Proceed',
                    style: CustomStyle.eighteen.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
