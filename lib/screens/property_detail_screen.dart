import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PropertyDetailScreen extends StatelessWidget {
  final Map<String, String> property;

  const PropertyDetailScreen({super.key, required this.property});

  static const _amber = Color(0xFFE8A020);
  static const _green = Color(0xFF3DBE6C);

  @override
  Widget build(BuildContext context) {
    final List<String> galleryImages = [
      property['image']!,
      'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400',
      'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=400',
      'https://images.unsplash.com/photo-1565182999561-18d7dc61c393?w=400',
    ];

    final details = [
      {'icon': Icons.bed_outlined, 'label': property['bhk'] ?? '3 BHK'},
      {'icon': Icons.balcony_outlined, 'label': '2 Balcony'},
      {'icon': Icons.bathtub_outlined, 'label': 'Bathroom'},
      {'icon': Icons.currency_rupee, 'label': 'Deposit - ₹4 Lac'},
      {'icon': Icons.settings_outlined, 'label': 'Maintenance - 6000/m'},
      {'icon': Icons.weekend_outlined, 'label': property['furnishing'] ?? 'Fully Furnished'},
      {'icon': Icons.straighten, 'label': property['sqft'] ?? '1080 sqft'},
      {'icon': Icons.calendar_today_outlined, 'label': 'Avail. From - ${property['availFrom'] ?? '2026-01-15'}'},
      {'icon': Icons.person_outline, 'label': 'Tenant Type - anyone'},
      {'icon': Icons.percent, 'label': 'Full Month Brokerage - B5000'},
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
                    const SizedBox(height: 12),
                    _buildActionButtons(),
                    const SizedBox(height: 16),
                    _buildDetailsList(details),
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
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Search by project, property, or location',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Icon(Icons.search, color: Colors.grey.shade400, size: 20),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _amber.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.shopping_bag_outlined, color: _amber, size: 22),
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
          ...chips.map((c) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Text(c, style: const TextStyle(fontSize: 12)),
                ),
              )),
          _arrowChip(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _arrowChip(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon, size: 16, color: Colors.black54),
    );
  }

  Widget _buildMainImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: property['image']!,
          width: double.infinity,
          height: 220,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            height: 220,
            color: Colors.grey.shade200,
          ),
          errorWidget: (_, __, ___) => Container(
            height: 220,
            color: Colors.grey.shade300,
            child: const Icon(Icons.image_not_supported, size: 40),
          ),
        ),
      ),
    );
  }

  Widget _buildGallery(List<String> images) {
    return SizedBox(
      height: 64,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) => ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: images[i],
            width: 64,
            height: 64,
            fit: BoxFit.cover,
            placeholder: (_, __) =>
                Container(width: 64, height: 64, color: Colors.grey.shade200),
            errorWidget: (_, __, ___) =>
                Container(width: 64, height: 64, color: Colors.grey.shade300),
          ),
        ),
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
              property['title'] ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chat, color: Color(0xFF25D366), size: 26),
          const SizedBox(width: 10),
          const Icon(Icons.phone, color: Colors.blue, size: 24),
          const SizedBox(width: 10),
          const Icon(Icons.reply, color: Colors.black54, size: 24),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Schedule a Visit
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: _amber,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Schedule  A Visit',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Rent row
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'Rent -  ₹${property['price'] ?? '60,000'}/m',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Book Now
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: _green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Book Now',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsList(List<Map<String, Object>> details) {
    return Column(
      children: details.map((d) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              child: Row(
                children: [
                  Icon(d['icon'] as IconData, size: 20, color: Colors.black45),
                  const SizedBox(width: 14),
                  Text(
                    d['label'] as String,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200, indent: 16, endIndent: 16),
          ],
        );
      }).toList(),
    );
  }
}
