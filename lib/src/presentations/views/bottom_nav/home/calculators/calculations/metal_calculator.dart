import 'package:flutter/material.dart';

class Metal {
  final String id;
  final String name;
  final double pricePerKg;

  const Metal({required this.id, required this.name, required this.pricePerKg});
}

class MetalRecyclingCalculatorView extends StatefulWidget {
  const MetalRecyclingCalculatorView({super.key});

  @override
  State<MetalRecyclingCalculatorView> createState() =>
      _MetalRecyclingCalculatorViewState();
}

class _MetalRecyclingCalculatorViewState
    extends State<MetalRecyclingCalculatorView> {
  Metal? selectedMetal;
  final TextEditingController _weightController = TextEditingController();
  final FocusNode _weightFocusNode = FocusNode();

  static const List<Metal> metals = [
    Metal(id: "aluminum", name: "Aluminum", pricePerKg: 1.70),
    Metal(id: "copper", name: "Copper", pricePerKg: 8.20),
    Metal(id: "steel", name: "Steel", pricePerKg: 0.10),
    Metal(id: "brass", name: "Brass", pricePerKg: 2.80),
    Metal(id: "stainless", name: "Stainless Steel", pricePerKg: 0.80),
  ];

  double? get totalValue {
    if (selectedMetal == null) return null;
    final weightValue = double.tryParse(_weightController.text);
    if (weightValue == null || weightValue <= 0) return null;
    return selectedMetal!.pricePerKg * weightValue;
  }

  @override
  void dispose() {
    _weightController.dispose();
    _weightFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metal Recycling Calculator'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Header
              Card(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "Prices are estimates and may vary by location and market conditions.",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Inputs Section
              Text("Input", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              DropdownButtonFormField<Metal>(
                value: selectedMetal,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                ),
                hint: const Text("-- Select Metal --"),
                items: [
                  const DropdownMenuItem<Metal>(
                    value: null,
                    enabled: false,
                    child: Text("-- Select Metal --"),
                  ),
                  ...metals.map(
                    (metal) => DropdownMenuItem<Metal>(
                      value: metal,
                      child: Text(
                        "${metal.name} – \$${metal.pricePerKg.toStringAsFixed(2)}/kg",
                      ),
                    ),
                  ),
                ],
                onChanged: (m) {
                  setState(() {
                    selectedMetal = m;
                  });
                },
              ),
              const SizedBox(height: 16),
              Text(
                "Weight (kg)",
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _weightController,
                focusNode: _weightFocusNode,
                decoration: const InputDecoration(
                  hintText: "e.g., 50",
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                enabled: selectedMetal != null,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                onChanged: (_) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 32),

              // Results Section
              Text("Result", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              Builder(
                builder: (context) {
                  if (totalValue != null) {
                    return Card(
                      color: Colors.green[50],
                      child: ListTile(
                        leading: const Text(
                          "💰",
                          style: TextStyle(fontSize: 28),
                        ),
                        title: Text(
                          "Estimated Recycling Value: \$${totalValue!.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Card(
                      color: Colors.red[50],
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          "⚠️ Please select a metal and enter a valid weight.",
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
