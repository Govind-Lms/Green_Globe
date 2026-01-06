import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScrapRecyclingValueCalculator extends StatefulWidget {
  const ScrapRecyclingValueCalculator({super.key});

  @override
  State<ScrapRecyclingValueCalculator> createState() =>
      _ScrapRecyclingValueCalculatorState();
}

class Item {
  final String id;
  final String name;
  final double pricePerKg;

  const Item({required this.id, required this.name, required this.pricePerKg});
}

enum Category { metal, plastic, cardboard, bottle }

extension CategoryDetails on Category {
  String get name {
    switch (this) {
      case Category.metal:
        return "Metal";
      case Category.plastic:
        return "Plastic";
      case Category.cardboard:
        return "Cardboard";
      case Category.bottle:
        return "Bottles";
    }
  }

  List<Item> get items {
    switch (this) {
      case Category.metal:
        return const [
          Item(id: "aluminum", name: "Aluminum", pricePerKg: 1.70),
          Item(id: "copper", name: "Copper", pricePerKg: 8.20),
          Item(id: "steel", name: "Steel", pricePerKg: 0.10),
          Item(id: "brass", name: "Brass", pricePerKg: 2.80),
          Item(id: "stainless", name: "Stainless Steel", pricePerKg: 0.80),
        ];
      case Category.plastic:
        return const [
          Item(id: "pet_1", name: "PET Bottles (#1)", pricePerKg: 0.35),
          Item(id: "hdpe_2", name: "HDPE Containers (#2)", pricePerKg: 1.50),
          Item(id: "pp_5", name: "PP Containers (#5)", pricePerKg: 0.18),
          Item(id: "ldpe_4", name: "LDPE Film (#4)", pricePerKg: 0.36),
          Item(id: "mixed_7", name: "Mixed Plastics (#7)", pricePerKg: 0.08),
        ];
      case Category.cardboard:
        return const [
          Item(id: "occ", name: "Corrugated Cardboard (OCC)", pricePerKg: 0.04),
          Item(
            id: "mixedPaperboard",
            name: "Mixed Paperboard",
            pricePerKg: 0.03,
          ),
          Item(id: "whiteCardboard", name: "White Cardboard", pricePerKg: 0.05),
        ];
      case Category.bottle:
        return const [
          Item(id: "glass", name: "Glass Bottles", pricePerKg: 0.12),
          Item(
            id: "pet_bottle_1",
            name: "PET Plastic Bottles (#1)",
            pricePerKg: 0.35,
          ),
          Item(
            id: "hdpe_bottle_2",
            name: "HDPE Plastic Bottles (#2)",
            pricePerKg: 1.50,
          ),
          Item(
            id: "mixedBottle",
            name: "Mixed Plastic Bottles",
            pricePerKg: 0.10,
          ),
        ];
    }
  }
}

class _ScrapRecyclingValueCalculatorState
    extends State<ScrapRecyclingValueCalculator> {
  Category? selectedCategory;
  Item? selectedItem;
  final TextEditingController weightController = TextEditingController();
  final FocusNode weightFocusNode = FocusNode();

  @override
  void dispose() {
    weightController.dispose();
    weightFocusNode.dispose();
    super.dispose();
  }

  double? get totalValue {
    if (selectedItem == null) return null;
    final weightValue = double.tryParse(weightController.text);
    if (weightValue == null || weightValue < 0) return null;
    return selectedItem!.pricePerKg * weightValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recycling Value Calculator"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  "Prices are estimates and may vary by location and market conditions.",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              // Input Section
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Input',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<Category>(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
                        ),
                        value: selectedCategory,
                        items: [
                          DropdownMenuItem<Category>(
                            value: null,
                            child: Text(
                              '-- Select Category --',
                              style: TextStyle(
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                          ),
                          ...Category.values.map(
                            (cat) => DropdownMenuItem<Category>(
                              value: cat,
                              child: Text(cat.name),
                            ),
                          ),
                        ],
                        onChanged: (cat) {
                          setState(() {
                            selectedCategory = cat;
                            selectedItem = null;
                            weightController.clear();
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<Item>(
                        decoration: const InputDecoration(
                          labelText: 'Type',
                          border: OutlineInputBorder(),
                        ),
                        value:
                            selectedItem != null &&
                                (selectedCategory?.items ?? []).contains(
                                  selectedItem,
                                )
                            ? selectedItem
                            : null,
                        items: [
                          DropdownMenuItem<Item>(
                            value: null,
                            child: Text(
                              '-- Select Type --',
                              style: TextStyle(
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                          ),
                          ...((selectedCategory?.items ?? [])).map(
                            (item) => DropdownMenuItem<Item>(
                              value: item,
                              child: Text(
                                '${item.name} – \$${item.pricePerKg.toStringAsFixed(2)}/kg',
                                // Style as enabled; graying out only if necessary, which is not needed here
                              ),
                            ),
                          ),
                        ],
                        onChanged: selectedCategory == null
                            ? null
                            : (item) {
                                setState(() {
                                  selectedItem = item;
                                });
                              },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Weight (kg)",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: weightController,
                        focusNode: weightFocusNode,
                        enabled: selectedItem != null,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}'),
                          ), // allows only numbers and up to 2 decimals
                        ],
                        decoration: const InputDecoration(
                          hintText: "e.g., 50",
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        validator: (value) {
                          if (selectedItem == null) return null;
                          if (value == null || value.isEmpty) {
                            return "Please enter a weight.";
                          }
                          final doubleVal = double.tryParse(value);
                          if (doubleVal == null || doubleVal < 0) {
                            return "Please enter a valid weight.";
                          }
                          return null;
                        },
                        onChanged: (_) {
                          setState(() {});
                        },
                        onFieldSubmitted: (_) => weightFocusNode.unfocus(),
                      ),
                      if (selectedItem == null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Please select a type before entering weight.",
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 12,
                            ),
                          ),
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
                        'Result',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (totalValue != null && totalValue! >= 0)
                        Row(
                          children: [
                            const Text("💰 ", style: TextStyle(fontSize: 24)),
                            Expanded(
                              child: Text(
                                "Estimated Recycling Value: \$${totalValue!.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            const Text("⚠️ ", style: TextStyle(fontSize: 20)),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text(
                                "Please select a valid category, type, and weight.",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
