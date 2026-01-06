import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WasteImpactCalculator extends StatefulWidget {
  const WasteImpactCalculator({super.key});

  @override
  State<WasteImpactCalculator> createState() => _WasteImpactCalculatorState();
}

class _WasteImpactCalculatorState extends State<WasteImpactCalculator> {
  final TextEditingController tonsController = TextEditingController();
  final FocusNode tonsFocusNode = FocusNode();

  static const int characterLimit = 8;

  double get tons {
    final text = tonsController.text;
    return double.tryParse(text) ?? 0.0;
  }

  double get greenhouseGases => tons * 2.4;
  double get kWhGenerated => tons * 550;
  double get homesPowered => kWhGenerated / 893;
  double get tonsOfCoalReduced => tons / 3;
  double get gallonsOfFuelOilSaved => tons * 42;
  double get metalRecycled => tons * 50;

  @override
  void dispose() {
    tonsController.dispose();
    tonsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Waste Impact Calculator"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => tonsFocusNode.unfocus(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                "Estimate the environmental impact of recycling your waste.\n"
                "All results are approximations for educational purposes.",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            // Input Section
            Card(
              margin: const EdgeInsets.only(bottom: 24),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Input",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: tonsController,
                            focusNode: tonsFocusNode,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,3}'),
                              ),
                              LengthLimitingTextInputFormatter(characterLimit),
                            ],
                            decoration: const InputDecoration(
                              labelText: "Tons of Waste",
                              hintText: "0",
                              suffixText: "tons",
                              // hint: Text("0"),
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                            onChanged: (value) {
                              if (value.length > characterLimit) {
                                // Truncate extra characters
                                tonsController.text = value.substring(
                                  0,
                                  characterLimit,
                                );
                                tonsController.selection =
                                    TextSelection.fromPosition(
                                      TextPosition(offset: characterLimit),
                                    );
                              }
                              setState(() {});
                            },
                            onFieldSubmitted: (_) => tonsFocusNode.unfocus(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Result Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Result",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _ResultRow(
                      emoji: "🌱",
                      title: "Greenhouse Gases Avoided",
                      value: greenhouseGases,
                      suffix: "kg CO₂-eq",
                    ),
                    _ResultRow(
                      emoji: "⚡️",
                      title: "Renewable Energy Generated",
                      value: kWhGenerated,
                      suffix: "kWh",
                    ),
                    _ResultRow(
                      emoji: "🏠",
                      title: "Power for Homes (monthly)",
                      value: homesPowered,
                      suffix: "homes",
                      decimalPlaces: 2,
                    ),
                    _ResultRow(
                      emoji: "⛏️",
                      title: "Tons of Coal Offset",
                      value: tonsOfCoalReduced,
                      suffix: "tons",
                      decimalPlaces: 2,
                    ),
                    _ResultRow(
                      emoji: "🛢️",
                      title: "Gallons of Fuel Oil Saved",
                      value: gallonsOfFuelOilSaved,
                      suffix: "gal",
                    ),
                    _ResultRow(
                      emoji: "🔩",
                      title: "Pounds of Metal Recycled",
                      value: metalRecycled,
                      suffix: "lbs",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            Text(
              "Estimates are based on typical material conversions. Actual environmental impact may vary.",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String emoji;
  final String title;
  final double value;
  final String suffix;
  final int decimalPlaces;

  const _ResultRow({
    required this.emoji,
    required this.title,
    required this.value,
    required this.suffix,
    this.decimalPlaces = 0,
  });

  @override
  Widget build(BuildContext context) {
    String displayVal = value.toStringAsFixed(decimalPlaces);
    // For making sure really tiny values still show '0'
    if (value == 0) displayVal = '0';
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            "$displayVal $suffix",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
