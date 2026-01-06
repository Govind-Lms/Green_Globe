import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';

class CarbonReductionCalculatorPage extends StatefulWidget {
  const CarbonReductionCalculatorPage({super.key});

  @override
  State<CarbonReductionCalculatorPage> createState() =>
      _CarbonReductionCalculatorPageState();
}

class MaterialType {
  final String name;
  final double original;
  final double recycled;
  final double energy;

  const MaterialType({
    required this.name,
    required this.original,
    required this.recycled,
    required this.energy,
  });
}

class _CarbonReductionCalculatorPageState
    extends State<CarbonReductionCalculatorPage> {
  final Map<String, MaterialType> materials = const {
    "PET Plastic": MaterialType(
      name: "PET Plastic",
      original: 3.5,
      recycled: 0.5,
      energy: 5.8,
    ),
    "HDPE Plastic": MaterialType(
      name: "HDPE Plastic",
      original: 2.5,
      recycled: 0.3,
      energy: 4.9,
    ),
    "Paper": MaterialType(
      name: "Paper",
      original: 1.4,
      recycled: 0.2,
      energy: 3.0,
    ),
    "Aluminum": MaterialType(
      name: "Aluminum",
      original: 12.0,
      recycled: 0.7,
      energy: 14.0,
    ),
    "Steel": MaterialType(
      name: "Steel",
      original: 2.0,
      recycled: 0.3,
      energy: 5.5,
    ),
    "Glass": MaterialType(
      name: "Glass",
      original: 1.1,
      recycled: 0.25,
      energy: 1.1,
    ),
  };

  String materialType = "PET Plastic";
  final TextEditingController weightController = TextEditingController();
  final FocusNode weightFocusNode = FocusNode();

  MaterialType? get selectedMaterial => materials[materialType];

  double? get parsedWeight =>
      double.tryParse(weightController.text.replaceAll(',', '.'));

  double get carbonSaved {
    final m = selectedMaterial;
    final w = parsedWeight;
    if (m == null || w == null) return 0;
    return w * (m.original - m.recycled);
  }

  double get energySaved {
    final m = selectedMaterial;
    final w = parsedWeight;
    if (m == null || w == null) return 0;
    return w * m.energy;
  }

  int get treeEquivalent => (carbonSaved / 22).floor();
  int get kmEquivalent => (carbonSaved / 0.192).floor();

  @override
  void dispose() {
    weightController.dispose();
    weightFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Carbon Reduction',
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              color: Colors.green[50],
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "CO₂ and energy savings are based on estimated averages.\n• 1 tree absorbs ~22 kg CO₂/year\n• 1 car emits ~0.192 kg CO₂/km",
                  style: CustomStyle.twelve,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("Input", style: CustomStyle.fourteen),

            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text("Material Type", style: CustomStyle.fourteen),
                ),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: materialType,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                    ),
                    items: materials.keys
                        .map(
                          (key) =>
                              DropdownMenuItem(value: key, child: Text(key)),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          materialType = val;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: weightController,
              focusNode: weightFocusNode,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                hintStyle: CustomStyle.fourteen.copyWith(
                  color: Color(0xFFB0B0B0),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xFFE5E5E5),
                    width: 1,
                  ),
                ),
                suffix: Text("kg"),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: secondaryGreen,
                    width: 1.4,
                  ),
                ),
              ),

              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 24),
            Text("Results", style: CustomStyle.fourteen),
            Builder(
              builder: (context) {
                if (parsedWeight == null || parsedWeight! <= 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "⚠️ Please enter a valid weight.",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  );
                }
                final mat = selectedMaterial;
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mat?.name ?? "",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _ResultLabel(
                        icon: "🌱",
                        label: "${carbonSaved.toStringAsFixed(2)} kg",
                      ),
                      _ResultLabel(
                        icon: "⚡",
                        label: "${energySaved.toStringAsFixed(2)} kWh",
                      ),
                      _ResultLabel(
                        icon: "🌳",
                        label: "$treeEquivalent tree(s)",
                      ),
                      _ResultLabel(
                        icon: "🚗",
                        label: "$kmEquivalent km driving avoided",
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultLabel extends StatelessWidget {
  final String icon;
  final String label;

  const _ResultLabel({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
