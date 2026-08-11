import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'tv_sidebar_item.dart';

/// Expandable Smart TV Navigation Sidebar Menu with App Icon asset
class TvSidebarMenu extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const TvSidebarMenu({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  State<TvSidebarMenu> createState() => _TvSidebarMenuState();
}

class _TvSidebarMenuState extends State<TvSidebarMenu> {
  bool _isExpanded = false;

  final List<Map<String, dynamic>> _menuItems = const [
    {'icon': Icons.home_rounded, 'label': 'Trang Chủ'},
    {'icon': Icons.grid_view_rounded, 'label': 'Danh Mục'},
    {'icon': Icons.bookmark_rounded, 'label': 'Tủ Phim'},
    {'icon': Icons.search_rounded, 'label': 'Tìm Kiếm'},
  ];

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isExpanded = true),
      onExit: (_) => setState(() => _isExpanded = false),
      child: FocusScope(
        onFocusChange: (focused) {
          setState(() => _isExpanded = focused);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          width: _isExpanded ? 180 : 70,
          color: AppColors.cardBackground,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/app_icon.jpg',
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.play_circle_fill_rounded,
                          color: AppColors.primaryFocusGlow,
                          size: 32,
                        ),
                      ),
                    ),
                    if (_isExpanded) ...[
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'PhimFlux',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  itemCount: _menuItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = _menuItems[index];
                    return TvSidebarItem(
                      icon: item['icon'] as IconData,
                      label: item['label'] as String,
                      isSelected: widget.selectedIndex == index,
                      isExpanded: _isExpanded,
                      autoFocus: index == 0,
                      onTap: () => widget.onItemSelected(index),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
