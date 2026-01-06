import 'package:flutter/material.dart';

class Plastic {
  final String id;
  final String name;
  final double pricePerKg;

  const Plastic({
    required this.id,
    required this.name,
    required this.pricePerKg,
  });
}

class PlasticRecyclingCalculatorView extends StatefulWidget {
  const PlasticRecyclingCalculatorView({super.key});

  @override
  State<PlasticRecyclingCalculatorView> createState() =>
      _PlasticRecyclingCalculatorViewState();
}

class _PlasticRecyclingCalculatorViewState
    extends State<PlasticRecyclingCalculatorView> {
  Plastic? selectedPlastic;
  final TextEditingController _weightController = TextEditingController();
  final FocusNode _weightFocusNode = FocusNode();

  static const List<Plastic> plastics = [
    Plastic(id: "pet_1", name: "PET Bottles (#1)", pricePerKg: 0.23),
    Plastic(id: "hdpe_2", name: "HDPE Containers (#2)", pricePerKg: 0.33),
    Plastic(id: "pp_5", name: "PP Containers (#5)", pricePerKg: 0.18),
    Plastic(id: "ldpe_4", name: "LDPE Film (#4)", pricePerKg: 0.12),
    Plastic(id: "mixed_7", name: "Mixed Plastics (#7)", pricePerKg: 0.08),
  ];

  double? get totalValue {
    if (selectedPlastic == null) return null;
    final weightValue = double.tryParse(_weightController.text);
    if (weightValue == null || weightValue <= 0) return null;
    return selectedPlastic!.pricePerKg * weightValue;
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
        title: const Text('Plastic Recycling Calculator'),
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
              DropdownButtonFormField<Plastic>(
                value: selectedPlastic,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                ),
                hint: const Text("-- Select Plastic Type --"),
                items: [
                  const DropdownMenuItem<Plastic>(
                    value: null,
                    enabled: false,
                    child: Text("-- Select Plastic Type --"),
                  ),
                  ...plastics.map(
                    (plastic) => DropdownMenuItem<Plastic>(
                      value: plastic,
                      child: Text(
                        "${plastic.name} – \$${plastic.pricePerKg.toStringAsFixed(2)}/kg",
                      ),
                    ),
                  ),
                ],
                onChanged: (p) {
                  setState(() {
                    selectedPlastic = p;
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
                  hintText: "e.g., 20",
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                onChanged: (_) {
                  setState(() {});
                },
                enabled: selectedPlastic != null,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              const SizedBox(height: 24),

              // Result Section
              Text(
                "Result",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Builder(
                builder: (context) {
                  final total = totalValue;
                  if (total == null) {
                    return Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "⚠️ Please select a plastic type and enter a valid weight.",
                            style: TextStyle(color: Colors.red[700]),
                          ),
                        ),
                      ],
                    );
                  }
                  return Card(
                    color: Colors.green[50],
                    child: ListTile(
                      leading: const Text("💰", style: TextStyle(fontSize: 28)),
                      title: Text(
                        "Estimated Recycling Value: \$${total.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // Done button on keyboard
    );
  }
}
