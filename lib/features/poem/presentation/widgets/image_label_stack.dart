import 'package:flutter/material.dart';

class ImageLabelStack extends StatelessWidget {
  const ImageLabelStack({
    super.key,
    required this.imagePath,
    required this.text,
    required this.height,
    required this.width,
  });
  final String imagePath;
  final String text;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: height,
            width: width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                text,
                style: TextStyle(fontSize: 26),
              )),
        )
      ],
    );
  }
}
