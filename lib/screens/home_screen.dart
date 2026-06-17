import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/property_card.dart';
import '../widgets/location_card.dart';
import '../widgets/category_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedTab = 0; // 0=Rent, 1=Sell, 2=Upcoming
  int _selectedNav = 0;
  late TabController _tabController;

  final List<Map<String, String>> _locations = [
    {
      'name': 'Delhi',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Lotus_temple_compress.jpg/320px-Lotus_temple_compress.jpg',
    },
    {
      'name': 'Agra',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Taj_Mahal%2C_Agra%2C_India_edit3.jpg/320px-Taj_Mahal%2C_Agra%2C_India_edit3.jpg',
    },
    {
      'name': 'Mumbai',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Mumbai_03-2016_30_Gateway_of_India.jpg/320px-Mumbai_03-2016_30_Gateway_of_India.jpg',
    },
    {
      'name': 'Delhi',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/India_Gate_in_New_Delhi_03-2016.jpg/320px-India_Gate_in_New_Delhi_03-2016.jpg',
    },
  ];

  final List<Map<String, String>> _topProperties = [
    {
      'image':
          'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
      'title': 'Luxury Villa with Pool',
      'price': '₹2.5 Cr',
      'location': 'Sarjapur, Bangalore',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
      'title': 'Modern Apartment',
      'price': '₹85 L',
      'location': 'Whitefield, Bangalore',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTabs(),
                    _buildSearchBar(),
                    const SizedBox(height: 16),
                    _buildCategories(),
                    const SizedBox(height: 16),
                    _buildSelectLocation(),
                    const SizedBox(height: 16),
                    _buildTopProperties(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedNav,
        onTap: (i) => setState(() => _selectedNav = i),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Logo + location
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8A020),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.home, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'REALAURA',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFE8A020),
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Bengaluru',
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                  const Icon(Icons.keyboard_arrow_down, size: 16),
                ],
              ),
            ],
          ),
          const Spacer(),
          // Post Property button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE8A020),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Free',
                    style: TextStyle(
                      fontSize: 8,
                      color: Color(0xFFE8A020),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Post Property',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Stack(
            children: [
              const Icon(Icons.notifications_outlined, size: 26),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    final tabs = ['Rent', 'Sell', 'Upcoming Projects'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final selected = _selectedTab == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = i),
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  Text(
                    tabs[i],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                          selected ? FontWeight.w700 : FontWeight.w500,
                      color: selected
                          ? const Color(0xFFE8A020)
                          : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (selected)
                    Container(
                      height: 2,
                      width: 30,
                      color: const Color(0xFFE8A020),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Icon(Icons.search, color: Colors.grey.shade500),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by project',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            Icon(Icons.tune, color: Colors.grey.shade600, size: 20),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      {'icon': Icons.apartment, 'label': '2 BHK'},
      {'icon': Icons.business, 'label': '3 BHK'},
      {'icon': Icons.king_bed_outlined, 'label': '4 BHK'},
      {'icon': Icons.location_city, 'label': 'APARTMENTS'},
      {'icon': Icons.villa_outlined, 'label': 'SOCIETY'},
    ];

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) => CategoryItem(
          icon: categories[i]['icon'] as IconData,
          label: categories[i]['label'] as String,
        ),
      ),
    );
  }

  Widget _buildSelectLocation() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select Location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _locations.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, i) => LocationCard(
              name: _locations[i]['name']!,
              imageUrl: _locations[i]['image']!,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopProperties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Top Properties in Sarjapur',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _topProperties.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) => PropertyCard(
            imageUrl: _topProperties[i]['image']!,
            title: _topProperties[i]['title']!,
            price: _topProperties[i]['price']!,
            location: _topProperties[i]['location']!,
          ),
        ),
      ],
    );
  }
}
