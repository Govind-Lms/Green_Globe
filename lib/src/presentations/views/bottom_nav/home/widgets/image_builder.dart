import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/home/widgets/photo_view.dart';

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    super.key,
    required this.context,
    required this.image,
    required this.text,
  });

  final BuildContext context;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => PhotoView(image: image)));
      },
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          if (text == '') {
            return Container(
              width: double.infinity,
              height: 250,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 40),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  width: width,
                  height: 200,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.broken_image, size: 40),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        accentGreen.withOpacity(.1),
                        accentGreen.withOpacity(.1),
                        accentGreen.withOpacity(.1),
                        secondaryGreen.withOpacity(.8),
                        primaryGreen.withOpacity(.9),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  height: 50,
                  child: Text(
                    text,
                    style: CustomStyle.twelveWhite,
                    maxLines: 2,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
