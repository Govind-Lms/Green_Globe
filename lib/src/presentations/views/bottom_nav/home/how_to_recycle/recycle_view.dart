import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/models/category_model.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/alluminum_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/cardboard.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/clothing_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/e_waste_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/glass_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/metal_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/organic_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/plastic_view.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/how_to_recycle/recycle_views/tyre_view.dart';

class RecycleView extends StatelessWidget {
  const RecycleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "How To Recycle",
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(recycleLists.length, (index) {
                return InkWell(
                  onTap: () {
                    final pages = [
                      PlasticsRecycleMethodDetailsView(),
                      GlassRecycleMethodDetailsView(),
                      CardboardRecycleMethodDetailsView(),
                      TyreRecycleMethodDetailsView(),
                      ClothingRecycleMethodDetailsView(),
                      EwasteRecycleMethodDetailsView(),
                      MetalRecycleMethodDetailsView(),
                      OrganicRecycleMethodDetailsView(),
                      AluminiumRecyclingDetailsView(
                        recycleModel: recycleLists[index],
                      ),
                    ];

                    if (index < pages.length) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => pages[index]),
                      );
                    }
                  },

                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recycleLists[index].title,
                                style: CustomStyle.sixteen.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                recycleLists[index].tip,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                                style: CustomStyle.fourteen.copyWith(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset(
                            recycleLists[index].image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
