import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PropertyCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String location;
  final String sqft;
  final String floor;
  final String furnishing;
  final String availableDate;
  final VoidCallback? onTap;

  const PropertyCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.location,
    this.sqft = '1080 sqft',
    this.floor = '9th Floor',
    this.furnishing = 'Semi Furnished',
    this.availableDate = '25/12/2025',
    this.onTap,
  });

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  bool _isFav = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Image section ──
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      width: double.infinity,
                      height: 260,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        width: double.infinity,
                        height: 260,
                        color: Colors.grey.shade200,
                      ),
                      errorWidget: (_, __, ___) => Container(
                        width: double.infinity,
                        height: 260,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.image_not_supported, size: 40),
                      ),
                    ),
                    // Bottom gradient + title + location
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(12, 28, 12, 10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.75),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.location_on,
                              color: Colors.white70,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              widget.location,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Favorite
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () => setState(() => _isFav = !_isFav),
                        child: _actionButton(
                          Icon(
                            _isFav ? Icons.favorite : Icons.favorite_border,
                            size: 18,
                            color: _isFav ? Colors.red : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    // Share + Phone + WhatsApp stacked on right
                    Positioned(
                      right: 10,
                      top: 60,
                      child: Column(
                        children: [
                          _actionButton(
                            const Icon(
                              Icons.share,
                              size: 18,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 6),
                          _actionButton(
                            const Icon(
                              Icons.phone,
                              size: 18,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 6),
                          _actionButton(
                            const Icon(
                              Icons.chat,
                              size: 18,
                              color: Color(0xFF25D366),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Schedule a Visit banner ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFB87514),
                      Color(0xFFE8A020),
                      Color(0xFFF5C842),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Schedule a Visit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              // ── Price row ──
              Container(
                color: const Color(0xFF29B6C8),
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹ ${widget.price}/M',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 16,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          widget.availableDate,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Details row ──
              Container(
                color: const Color(0xFFE8F8FA),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _detailChip(Icons.crop_square_outlined, widget.sqft),
                    _detailChip(Icons.layers_outlined, widget.floor),
                    _detailChip(Icons.weekend_outlined, widget.furnishing),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton(Widget icon) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4),
        ],
      ),
      child: icon,
    );
  }

  Widget _detailChip(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.black54),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
