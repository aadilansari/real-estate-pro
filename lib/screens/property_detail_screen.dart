import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/models/property_model.dart';

class PropertyDetailScreen extends StatelessWidget {
  final PropertyModel property;

  const PropertyDetailScreen({super.key, required this.property});

  static const _amber = Color(0xFFE8A020);
  static const _green = Color(0xFF3DBE6C);

  @override
  Widget build(BuildContext context) {
    final List<String> galleryImages = [
      property.image,
      'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400',
      'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=400',
      'https://images.unsplash.com/photo-1565182999561-18d7dc61c393?w=400',
    ];

    final details = [
      {'icon': Icons.bed_outlined, 'label': property.bhk},
      {
        'icon': Icons.balcony_outlined,
        'label': '${property.balcony} Balcony',
      },
      {
        'icon': Icons.bathtub_outlined,
        'label': '${property.bathroom} Bathroom',
      },
      {
        'icon': Icons.currency_rupee,
        'label': 'Deposit - ₹${property.deposit}',
      },
      {
        'icon': Icons.settings_outlined,
        'label': 'Maintenance - ${property.maintenance}/m',
      },
      {'icon': Icons.weekend_outlined, 'label': property.furnishing},
      {'icon': Icons.straighten, 'label': property.sqft},
      {
        'icon': Icons.calendar_today_outlined,
        'label': 'Avail. From - ${property.availFrom}',
      },
      {
        'icon': Icons.person_outline,
        'label': 'Tenant Type - ${property.tenantType}',
      },
      {
        'icon': Icons.percent,
        'label': 'Full Month Brokerage - ₹${property.brokerage}',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            _buildFilterChips(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    _buildMainImage(),
                    const SizedBox(height: 10),
                    _buildGallery(galleryImages),
                    const SizedBox(height: 14),
                    _buildTitleAndActions(),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildActionButtons(),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: _buildDetailsList(details),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, size: 20),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Search by project, property, or location',
                      style: TextStyle(color: Colors.black87, fontSize: 10),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/search.svg',
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      Colors.grey.shade400,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(6),
            child: SvgPicture.asset(
              'assets/cart.svg',
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(_amber, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final chips = ['2 & 3 BHK', '3 & 4 BHK', '4 Bhk +'];
    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          _arrowChip(Icons.chevron_left),
          const SizedBox(width: 6),
          ...chips.map(
            (c) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey.shade300,
                ),
                child: Text(
                  c,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          _arrowChip(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _arrowChip(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon, size: 10, color: Colors.black54),
    );
  }

  Widget _buildMainImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: property.image,
          width: double.infinity,
          height: 220,
          fit: BoxFit.cover,
          placeholder: (_, _) =>
              Container(height: 220, color: Colors.grey.shade200),
          errorWidget: (_, _, _) => Container(
            height: 220,
            color: Colors.grey.shade300,
            child: const Icon(Icons.image_not_supported, size: 40),
          ),
        ),
      ),
    );
  }

  Widget _buildGallery(List<String> images) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: images
            .map(
              (url) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: url,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => Container(
                      width: 64,
                      height: 64,
                      color: Colors.grey.shade200,
                    ),
                    errorWidget: (_, _, _) => Container(
                      width: 64,
                      height: 64,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildTitleAndActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              property.title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chat, color: Color(0xFF25D366), size: 20),
          const SizedBox(width: 10),
          const Icon(Icons.phone, color: Colors.blue, size: 20),
          const SizedBox(width: 10),
          const Icon(Icons.reply, color: Colors.black54, size: 20),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _amber,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: const RoundedRectangleBorder(),
              elevation: 0,
            ),
            child: const Text(
              'Schedule A Visit',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          color: const Color(0xFF29B6C8),
          child: Center(
            child: Text(
              'Rent - ₹${property.price}/m',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: const RoundedRectangleBorder(),
              elevation: 0,
            ),
            child: const Text(
              'Book Now',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsList(List<Map<String, Object>> details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: details.map((d) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 11,
                ),
                child: Row(
                  children: [
                    Icon(
                      d['icon'] as IconData,
                      size: 20,
                      color: Colors.black45,
                    ),
                    const SizedBox(width: 14),
                    Text(
                      d['label'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey.shade200,
                indent: 16,
                endIndent: 16,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
