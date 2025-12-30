import 'package:flutter/material.dart';

import 'package:green_globe/src/const/constant.dart';

class PhotoView extends StatelessWidget {
  final String image;
  const PhotoView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentGreen,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: InteractiveViewer(
        minScale: .8,
        maxScale: 2.5,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Image.asset(
            image,
            fit: BoxFit.fitWidth,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
          ),
        ),
      ),
    );
  }
}
