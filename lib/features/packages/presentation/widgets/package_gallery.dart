import 'package:cached_network_image/cached_network_image.dart';
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
          final url = images[index];
          // Precache first image for smoother experience.
          if (index == 0) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              precacheImage(CachedNetworkImageProvider(url), context);
            });
          }
          return Semantics(
            label: 'Gallery image ${index + 1}',
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (c, _) => const Center(child: CircularProgressIndicator()),
              errorWidget: (c, _, __) => const Icon(Icons.broken_image),
            ),
          );
        },
      ),
    );
  }
}
