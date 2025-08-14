import 'package:flutter/material.dart';

/// Simple placeholder gallery using [PageView].
class PackageGallery extends StatelessWidget {
  const PackageGallery({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(4),
            color: Colors.blueGrey,
            child: Center(child: Text(images[index])),
          );
        },
      ),
    );
  }
}
