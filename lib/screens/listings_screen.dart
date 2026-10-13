import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../data/sample_items.dart';
import '../models/item_model.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/empty_state.dart';
import '../widgets/item_card.dart';
import 'item_details_screen.dart';
import 'report_item_screen.dart';

class ListingsScreen extends StatefulWidget {
  const ListingsScreen({super.key});

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  String _activeTab = 'Active';

  List<ItemModel> get _userItems {
    return sampleItems.where((item) {
      if (_activeTab == 'Active') {
        return item.userId == 'user1' && item.status == 'Active';
      } else {
        return item.status != 'Active' || item.userId == 'user1';
      }
    }).toList();
  }

  void _markAsReturned(ItemModel item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Marked "${item.title}" as returned!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _userItems;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(
        subtitle: 'My Listings',
        showNotificationsAndAvatar: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          _buildCampusPostsHeader(),
          const SizedBox(height: 14),
          _buildTabsRow(),
          const SizedBox(height: 14),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ItemCard(
                item: item,
                isListingView: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ItemDetailsScreen(item: item),
                    ),
                  );
                },
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ReportItemScreen(),
                    ),
                  );
                },
                onMarkReturned: () => _markAsReturned(item),
                onMore: () {},
              ),
            ),
          ),
          const SizedBox(height: 12),
          EmptyState(
            onButtonTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ReportItemScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) Navigator.pushReplacementNamed(context, '/home');
          if (index == 2) Navigator.pushNamed(context, '/profile');
        },
      ),
    );
  }

  Widget _buildCampusPostsHeader() {
    return Row(
      children: [
        const Text(
          'Campus Posts',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            '8 Total',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.swap_vert_rounded, color: AppColors.muted, size: 20),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.tune_rounded, color: AppColors.muted, size: 20),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildTabsRow() {
    return Row(
      children: [
        _buildTabPill('Active', '3', _activeTab == 'Active'),
        const SizedBox(width: 10),
        _buildTabPill('Returned & Resolved', '1', _activeTab != 'Active'),
      ],
    );
  }

  Widget _buildTabPill(String title, String count, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = title),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.text,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.25)
                      : AppColors.borderLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  count,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : AppColors.muted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}