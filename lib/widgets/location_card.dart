import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LocationCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const LocationCard({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: 76,
            height: 76,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(
              width: 76,
              height: 76,
              color: Colors.grey.shade200,
            ),
            errorWidget: (_, __, ___) => Container(
              width: 76,
              height: 76,
              color: Colors.grey.shade200,
              child: const Icon(Icons.image_not_supported, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
