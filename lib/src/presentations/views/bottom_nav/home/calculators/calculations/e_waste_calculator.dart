import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';

class EWasteItem {
  final String id;
  final String name;
  final double pricePerUnit;

  EWasteItem({
    required this.id,
    required this.name,
    required this.pricePerUnit,
  });
}

class EWasteRecyclingCalculatorView extends StatefulWidget {
  const EWasteRecyclingCalculatorView({super.key});

  @override
  State<EWasteRecyclingCalculatorView> createState() =>
      _EWasteRecyclingCalculatorViewState();
}

class _EWasteRecyclingCalculatorViewState
    extends State<EWasteRecyclingCalculatorView> {
  EWasteItem? selectedItem;
  String quantity = '';
  final FocusNode _quantityFocusNode = FocusNode();

  final List<EWasteItem> ewasteItems = [
    EWasteItem(id: "mobile", name: "Mobile Phone", pricePerUnit: 4.0),
    EWasteItem(id: "laptop", name: "Laptop", pricePerUnit: 12.0),
    EWasteItem(id: "tv", name: "Television", pricePerUnit: 9.0),
    EWasteItem(id: "desktop", name: "Desktop Computer", pricePerUnit: 7.0),
    EWasteItem(id: "tablet", name: "Tablet", pricePerUnit: 2.5),
  ];

  double? get totalValue {
    final int? qtyValue = int.tryParse(quantity);
    if (selectedItem != null && qtyValue != null && qtyValue > 0) {
      return selectedItem!.pricePerUnit * qtyValue;
    }
    return null;
  }

  @override
  void dispose() {
    _quantityFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "E-Waste Recycling Calculator",
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Info section
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: Text(
                "Estimated values are averages and may vary by recycler and condition.",
                style: CustomStyle.twelve.copyWith(fontStyle: FontStyle.italic),
              ),
            ),
            // Input Card
            Card(
              margin: const EdgeInsets.only(bottom: 24),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Input',
                      style: CustomStyle.eighteen.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // E-Waste Type Picker
                    DropdownButtonFormField<EWasteItem>(
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
                      value: selectedItem,
                      onChanged: (EWasteItem? newValue) {
                        setState(() {
                          selectedItem = newValue;
                        });
                      },
                      items: [
                        DropdownMenuItem<EWasteItem>(
                          value: null,
                          child: Text(
                            '-- Select E-Waste Type --',
                            style: CustomStyle.twelve,
                          ),
                        ),
                        ...ewasteItems.map(
                          (item) => DropdownMenuItem<EWasteItem>(
                            value: item,
                            child: Text(
                              "${item.name} – \$${item.pricePerUnit.toStringAsFixed(2)}/unit",
                              style: CustomStyle.twelve,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Quantity',
                      style: CustomStyle.sixteen.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      focusNode: _quantityFocusNode,
                      style: CustomStyle.twelve,
                      decoration: InputDecoration(
                        hintText: 'e.g., 10',
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: selectedItem == null
                            ? Colors.grey.shade100
                            : null,
                        enabled: selectedItem != null,
                        hintStyle: CustomStyle.twelve,
                        suffixIcon: selectedItem != null && quantity.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    quantity = '';
                                  });
                                },
                              )
                            : null,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          quantity = value;
                        });
                      },
                      enabled: selectedItem != null,
                    ),
                  ],
                ),
              ),
            ),
            // Result section
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: totalValue != null
                    ? Row(
                        children: [
                          const Text("🔌", style: TextStyle(fontSize: 24)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Estimated Recycling Value: \$${totalValue!.toStringAsFixed(2)} USD",
                              style: CustomStyle.sixteen.copyWith(
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        "⚠️ Please select an item and enter a valid quantity.",
                        style: CustomStyle.twelve.copyWith(
                          color: Colors.red[700],
                          fontWeight: FontWeight.w500,
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
