import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  final String? imageUrl;
  const BackgroundWidget({super.key, required this.child, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (imageUrl != null && imageUrl!.isNotEmpty)
          SizedBox.expand(
            child: CachedNetworkImage(imageUrl: imageUrl!, fit: BoxFit.cover),
          ),
        child,
      ],
    );
  }
}
