import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bloc/location/location_bloc.dart';
import '../bloc/location/location_event.dart';
import '../bloc/location/location_state.dart';
import '../bloc/property/property_bloc.dart';
import '../bloc/property/property_event.dart';
import '../bloc/property/property_state.dart';
import '../data/models/property_model.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/category_item.dart';
import '../widgets/location_card.dart';
import '../widgets/property_card.dart';
import 'property_detail_screen.dart';

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
  final _hintController = PageController();
  int _hintIndex = 0;
  static const _hints = ['Search by project', 'Search by location'];
  static const _tabTypes = ['Rent', 'Sell', 'Upcoming'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Future.delayed(const Duration(seconds: 2), _cycleHint);

    // Dispatch initial loads
    context.read<PropertyBloc>().add(const LoadProperties(type: 'Rent'));
    context.read<LocationBloc>().add(const LoadLocations());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _hintController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    setState(() => _selectedTab = index);
    context
        .read<PropertyBloc>()
        .add(LoadProperties(type: _tabTypes[index]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // AppBar — floats, hides on scroll
            SliverAppBar(
              backgroundColor: Colors.white,
              floating: true,
              snap: true,
              pinned: false,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: _buildAppBar(),
              titleSpacing: 0,
            ),
            // Tabs + Search — always pinned to top
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              floating: false,
              elevation: 0,
              automaticallyImplyLeading: false,
              toolbarHeight: 0,
              expandedHeight: 0,
              collapsedHeight: 0,
              titleSpacing: 0,
              bottom: _StickyTabsBar(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [_buildTabs(), _buildSearchBar()],
                  ),
                ),
              ),
            ),
            // Scrollable content
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo + location
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/applogo.png', width: 46, height: 46),
                  const SizedBox(width: 6),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Bengaluru',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                  const Icon(Icons.keyboard_arrow_down, size: 10),
                ],
              ),
            ],
          ),
          const Spacer(),

          // Post Property button
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFB87514),
                      Color(0xFFE8A020),
                      Color(0xFFF5C842),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 6),
                    Text(
                      'Post Property',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 8,
                top: -7,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      color: const Color(0xFFE8A020),
                      width: 0.5,
                    ),
                  ),
                  child: const Text(
                    'Free',
                    style: TextStyle(
                      fontSize: 8,
                      color: Color(0xFFE8A020),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Stack(
            children: [
              const Icon(Icons.notifications_outlined, size: 35),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 6,
                  height: 6,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final selected = _selectedTab == i;
          return GestureDetector(
            onTap: () => _onTabChanged(i),
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  selected
                      ? ShaderMask(
                          shaderCallback: (bounds) =>
                              const LinearGradient(
                                colors: [
                                  Color(0xFFB87514),
                                  Color(0xFFE8A020),
                                  Color(0xFFF5C842),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds),
                          child: Text(
                            tabs[i],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          tabs[i],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _cycleHint() {
    if (!mounted) return;
    _hintIndex = (_hintIndex + 1) % _hints.length;
    _hintController.animateToPage(
      _hintIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    Future.delayed(const Duration(seconds: 2), _cycleHint);
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            SvgPicture.asset(
              'assets/search.svg',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                Colors.grey.shade500,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    height: 44,
                    child: PageView.builder(
                      controller: _hintController,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _hints.length,
                      itemBuilder: (_, i) => Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _hints[i],
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ],
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: categories
            .map(
              (c) => CategoryItem(
                icon: c['icon'] as IconData,
                label: c['label'] as String,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSelectLocation() {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
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
            if (state is LocationLoading)
              const SizedBox(
                height: 110,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (state is LocationLoaded)
              SizedBox(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.locations.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 10),
                  itemBuilder: (context, i) => LocationCard(
                    name: state.locations[i].name,
                    imageUrl: state.locations[i].imageUrl,
                  ),
                ),
              )
            else if (state is LocationError)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildTopProperties() {
    return BlocBuilder<PropertyBloc, PropertyState>(
      builder: (context, state) {
        List<PropertyModel> properties = [];
        bool isLoading = false;
        String? errorMessage;

        if (state is PropertyLoading) {
          isLoading = true;
        } else if (state is PropertyLoaded) {
          properties = state.properties;
        } else if (state is PropertyRefreshing) {
          properties = state.currentProperties;
        } else if (state is PropertyError) {
          errorMessage = state.message;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Top Properties in Sarjapur',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 10),
            if (isLoading)
              const SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFE8A020),
                  ),
                ),
              )
            else if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Icon(
                      Icons.wifi_off_rounded,
                      size: 40,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      errorMessage,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context
                          .read<PropertyBloc>()
                          .add(LoadProperties(type: _tabTypes[_selectedTab])),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE8A020),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: properties.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final p = properties[i];
                  return PropertyCard(
                    imageUrl: p.image,
                    title: p.title,
                    price: p.price,
                    location: p.location,
                    sqft: p.sqft,
                    floor: p.floor,
                    furnishing: p.furnishing,
                    availableDate: p.availFrom,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PropertyDetailScreen(property: p),
                      ),
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

class _StickyTabsBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  const _StickyTabsBar({required this.child});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) => child;
}
