import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const _items = [
    {'svg': 'assets/home.svg', 'label': 'Home'},
    {'svg': 'assets/star.svg', 'label': 'Rating'},
    {'svg': 'assets/refer.svg', 'label': 'Refer & Earn'},
    {'svg': 'assets/shortlist.svg', 'label': 'Shortlist'},
    {'svg': 'assets/profile.svg', 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final selected = selectedIndex == i;
              final color = selected ? const Color(0xFFE8A020) : Colors.black;
              final textColor = selected
                  ? const Color(0xFFE8A020)
                  : Color(0xFF717171);
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        _items[i]['svg']!,
                        width: 22,
                        height: 22,
                        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _items[i]['label']!,
                        style: TextStyle(
                          fontSize: 12,

                          color: textColor,
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
