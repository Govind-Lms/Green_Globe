import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';

class BottleType {
  final String id;
  final String name;
  final double pricePerKg;

  const BottleType({
    required this.id,
    required this.name,
    required this.pricePerKg,
  });
}

class BottlesRecyclingCalculatorView extends StatefulWidget {
  const BottlesRecyclingCalculatorView({super.key});

  @override
  State<BottlesRecyclingCalculatorView> createState() =>
      _BottlesRecyclingCalculatorViewState();
}

class _BottlesRecyclingCalculatorViewState
    extends State<BottlesRecyclingCalculatorView> {
  BottleType? _selectedBottle;
  final TextEditingController _weightController = TextEditingController();

  final FocusNode _weightFocus = FocusNode();

  static const List<BottleType> bottleTypes = [
    BottleType(id: "glass", name: "Glass Bottles", pricePerKg: 0.30),
    BottleType(id: "pet", name: "PET Plastic Bottles (#1)", pricePerKg: 0.27),
    BottleType(id: "hdpe", name: "HDPE Plastic Bottles (#2)", pricePerKg: 0.20),
    BottleType(id: "mixed", name: "Mixed Plastic Bottles", pricePerKg: 0.12),
  ];

  double? get _totalValue {
    if (_selectedBottle == null) return null;
    final weight = double.tryParse(_weightController.text);
    if (weight == null || weight <= 0) return null;
    return _selectedBottle!.pricePerKg * weight;
  }

  @override
  void dispose() {
    _weightController.dispose();
    _weightFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bottles Recycling Calculator",
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Info
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.grey, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Recycling values are estimates and may vary depending on local recycling centers.",
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
            DropdownButtonFormField<BottleType>(
              value: _selectedBottle,
              isExpanded: true,

              decoration: InputDecoration(
                // labelText: "Bottle Type",
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                isDense: true,
              ),
              items: [
                DropdownMenuItem<BottleType>(
                  value: null,
                  child: const Text('-- Select Bottle Type --'),
                ),
                ...bottleTypes.map(
                  (bottle) => DropdownMenuItem<BottleType>(
                    value: bottle,
                    child: Text(
                      '${bottle.name} – \$${bottle.pricePerKg.toStringAsFixed(2)}/kg',
                    ),
                  ),
                ),
              ],
              onChanged: (bottle) => setState(() => _selectedBottle = bottle),
            ),
            const SizedBox(height: 16),
            Text(
              "Weight (kg)",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _weightController,
              focusNode: _weightFocus,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              enabled: _selectedBottle != null,
              decoration: const InputDecoration(
                hintText: "e.g., 30",
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (_) => setState(() {}),
              onEditingComplete: () => FocusScope.of(context).unfocus(),
            ),
            const SizedBox(height: 24),
            Text(
              "Result",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 12),
            Builder(
              builder: (_) {
                final total = _totalValue;
                if (total != null) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.withOpacity(0.08),
                    ),
                    child: Row(
                      children: [
                        const Text("♻️", style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Estimated Recycling Value: \$${total.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      children: [
                        const Text("⚠️", style: TextStyle(fontSize: 18)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Please select a bottle type and enter a valid weight.",
                            style: TextStyle(
                              color: Colors.red[700],
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
