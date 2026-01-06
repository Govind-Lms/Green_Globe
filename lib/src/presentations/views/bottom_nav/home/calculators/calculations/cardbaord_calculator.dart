import 'package:flutter/material.dart';

class CardboardType {
  final String id;
  final String name;
  final double pricePerKg;

  CardboardType({
    required this.id,
    required this.name,
    required this.pricePerKg,
  });
}

class CardboardRecyclingCalculatorView extends StatefulWidget {
  const CardboardRecyclingCalculatorView({super.key});

  @override
  State<CardboardRecyclingCalculatorView> createState() =>
      _CardboardRecyclingCalculatorViewState();
}

class _CardboardRecyclingCalculatorViewState
    extends State<CardboardRecyclingCalculatorView> {
  CardboardType? selectedCardboard;
  String weight = '';
  final FocusNode _weightFocusNode = FocusNode();

  final List<CardboardType> cardboardTypes = [
    CardboardType(
      id: "occ",
      name: "Corrugated Cardboard (OCC)",
      pricePerKg: 0.12,
    ),
    CardboardType(id: "mixed", name: "Mixed Paperboard", pricePerKg: 0.05),
    CardboardType(id: "white", name: "White Cardboard", pricePerKg: 0.09),
  ];

  double? get totalValue {
    if (selectedCardboard != null) {
      final double? weightValue = double.tryParse(weight);
      if (weightValue != null && weightValue > 0) {
        return selectedCardboard!.pricePerKg * weightValue;
      }
    }
    return null;
  }

  @override
  void dispose() {
    _weightFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Assume customStyle is a TextStyle or set of styles provided globally.
    final customStyle = Theme.of(context).textTheme.bodyMedium;

    return Scaffold(
      appBar: AppBar(
        title: Text("Cardboard Recycling Calculator", style: customStyle),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Info Section
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: Text(
                "Recycling values are estimates and may vary depending on local recycling centers.",
                style: customStyle?.copyWith(
                  fontSize: 13,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            // Input Section
            Card(
              margin: const EdgeInsets.only(bottom: 24),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Input',
                      style: customStyle?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Cardboard Type Picker
                    DropdownButtonFormField<CardboardType>(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                      ),
                      isExpanded: true,
                      value: selectedCardboard,
                      onChanged: (CardboardType? newValue) {
                        setState(() {
                          selectedCardboard = newValue;
                        });
                      },
                      items: [
                        DropdownMenuItem<CardboardType>(
                          value: null,
                          child: Text(
                            '-- Select Cardboard Type --',
                            style: customStyle,
                          ),
                        ),
                        ...cardboardTypes.map(
                          (c) => DropdownMenuItem<CardboardType>(
                            value: c,
                            child: Text(
                              "${c.name} – \$${c.pricePerKg.toStringAsFixed(2)}/kg",
                              style: customStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Weight (kg)',
                      style: customStyle?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      focusNode: _weightFocusNode,
                      style: customStyle,
                      decoration: InputDecoration(
                        hintText: 'e.g., 100',
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: selectedCardboard == null
                            ? Colors.grey.shade100
                            : null,
                        enabled: selectedCardboard != null,
                        hintStyle: customStyle,
                        suffixIcon: selectedCardboard != null
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    weight = '';
                                  });
                                },
                              )
                            : null,
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: (value) {
                        setState(() {
                          weight = value;
                        });
                      },
                      enabled: selectedCardboard != null,
                    ),
                    const SizedBox(height: 8),
                    if (selectedCardboard == null)
                      Text(
                        "Please select a cardboard type to enter weight.",
                        style: customStyle?.copyWith(
                          fontSize: 13,
                          color: Colors.orange,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Result Section
            Card(
              margin: const EdgeInsets.only(bottom: 24),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Result',
                      style: customStyle?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (totalValue != null)
                      Row(
                        children: [
                          const Text("📦", style: TextStyle(fontSize: 22)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Estimated Recycling Value: \$${totalValue!.toStringAsFixed(2)}",
                              style: customStyle?.copyWith(
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      Text(
                        "⚠️ Please select a cardboard type and enter a valid weight.",
                        style: customStyle?.copyWith(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
