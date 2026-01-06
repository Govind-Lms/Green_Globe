import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';

class WasteGenerationCalculator extends StatefulWidget {
  const WasteGenerationCalculator({super.key});

  @override
  State<WasteGenerationCalculator> createState() =>
      _WasteGenerationCalculatorState();
}

enum WasteType { household, commercial, industrial, organic }

extension WasteTypeExtension on WasteType {
  String get label {
    switch (this) {
      case WasteType.household:
        return 'Household Waste';
      case WasteType.commercial:
        return 'Commercial Waste';
      case WasteType.industrial:
        return 'Industrial Waste';
      case WasteType.organic:
        return 'Organic Waste';
    }
  }

  double get factor {
    switch (this) {
      case WasteType.household:
        return 1.0;
      case WasteType.commercial:
        return 1.2;
      case WasteType.industrial:
        return 1.5;
      case WasteType.organic:
        return 0.8;
    }
  }
}

class _WasteGenerationCalculatorState extends State<WasteGenerationCalculator> {
  WasteType _wasteType = WasteType.household;
  final TextEditingController _amountPerPersonController =
      TextEditingController();
  final TextEditingController _peopleCountController = TextEditingController();
  final TextEditingController _collectionFrequencyController =
      TextEditingController();

  final FocusNode _amountFocus = FocusNode();
  final FocusNode _peopleFocus = FocusNode();
  final FocusNode _frequencyFocus = FocusNode();

  @override
  void dispose() {
    _amountPerPersonController.dispose();
    _peopleCountController.dispose();
    _collectionFrequencyController.dispose();
    _amountFocus.dispose();
    _peopleFocus.dispose();
    _frequencyFocus.dispose();
    super.dispose();
  }

  double? get _dailyWaste {
    final amount = double.tryParse(_amountPerPersonController.text);
    final people = double.tryParse(_peopleCountController.text);
    if (amount == null || people == null) return null;
    return amount * people * _wasteType.factor;
  }

  double? get _monthlyWaste {
    final dw = _dailyWaste;
    if (dw == null) return null;
    return dw * 30;
  }

  double? get _yearlyWaste {
    final dw = _dailyWaste;
    if (dw == null) return null;
    return dw * 365;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Waste Generation Calculator',
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(bottom: 26.0),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.grey, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Estimates may vary. Reducing waste starts with awareness.",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),
            // --- Inputs ---
            Text(
              "Input",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 14),
            // Waste Type picker
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text("Waste Type", style: CustomStyle.fourteen),
                ),
                Expanded(
                  child: DropdownButtonFormField<WasteType>(
                    value: _wasteType,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                    ),
                    items: [
                      ...WasteType.values.map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(type.label),
                        ),
                      ),
                    ],
                    onChanged: (type) {
                      if (type != null) {
                        setState(() => _wasteType = type);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Amount per person
            Text(
              "Waste per person (kg/day)",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _amountPerPersonController,
              focusNode: _amountFocus,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                hintStyle: CustomStyle.fourteen.copyWith(
                  color: Color(0xFFB0B0B0),
                ),
                hintText: "e.g., 1.5",
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
                // suffix: Text("kg"),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: secondaryGreen,
                    width: 1.4,
                  ),
                ),
              ),
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            // People count
            Text(
              "Number of people / employees",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _peopleCountController,
              focusNode: _peopleFocus,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintStyle: CustomStyle.fourteen.copyWith(
                  color: Color(0xFFB0B0B0),
                ),
                hintText: "e.g., 20",
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
                // suffix: Text("kg"),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: secondaryGreen,
                    width: 1.4,
                  ),
                ),
              ),

              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              // onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            // Collection frequency (not used in calculation, kept for UI parity)
            Text(
              "Collection frequency (times/month)",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _collectionFrequencyController,
              focusNode: _frequencyFocus,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintStyle: CustomStyle.fourteen.copyWith(
                  color: Color(0xFFB0B0B0),
                ),
                hintText: "e.g., 4",
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
                // suffix: Text("kg"),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: secondaryGreen,
                    width: 1.4,
                  ),
                ),
              ),

              onEditingComplete: () => FocusScope.of(context).unfocus(),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 32),
            // --- Results ---
            Text(
              "Results",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 14),
            Builder(
              builder: (context) {
                final monthly = _monthlyWaste;
                final yearly = _yearlyWaste;
                if (monthly != null && yearly != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("📦", style: TextStyle(fontSize: 22)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Estimated Monthly Waste: ${monthly.toStringAsFixed(1)} kg",
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text("📆", style: TextStyle(fontSize: 22)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Estimated Yearly Waste: ${yearly.toStringAsFixed(1)} kg",
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return Row(
                  children: [
                    const Icon(Icons.warning, color: Colors.redAccent),
                    const SizedBox(width: 8),
                    const Flexible(
                      child: Text(
                        '⚠️ Please fill out all fields with valid numbers.',
                        style: TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
