import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../data/sample_items.dart';
import '../models/item_model.dart';
import '../widgets/app_header.dart';
import '../widgets/app_search_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/category_chip.dart';
import '../widgets/item_card.dart';
import '../widgets/recovery_banner.dart';
import 'item_details_screen.dart';
import 'report_item_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _typeFilter = 'All';
  String _categoryFilter = 'All';
  String _searchQuery = '';

  final List<String> _typeFilters = ['All Items (24)', 'Lost (14)', 'Found (10)'];
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Electronics', 'icon': Icons.laptop_mac_rounded},
    {'name': 'ID & Cards', 'icon': Icons.badge_outlined},
    {'name': 'Bikes & Keys', 'icon': Icons.directions_bike_rounded},
  ];

  List<ItemModel> get _filteredItems {
    return sampleItems.where((item) {
      final matchesSearch = _searchQuery.isEmpty ||
          item.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.location.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesType = _typeFilter == 'All' ||
          (_typeFilter.contains('Lost') && item.type.toLowerCase() == 'lost') ||
          (_typeFilter.contains('Found') && item.type.toLowerCase() == 'found');

      final matchesCat = _categoryFilter == 'All' ||
          item.category.toLowerCase().contains(_categoryFilter.toLowerCase());

      return matchesSearch && matchesType && matchesCat;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(
        subtitle: 'Home',
        showNotificationsAndAvatar: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          _buildGreetingSection(),
          const SizedBox(height: 16),
          AppSearchBar(
            onChanged: (q) => setState(() => _searchQuery = q),
            onFilterTap: () {},
          ),
          const SizedBox(height: 14),
          _buildTypeFilterRow(),
          const SizedBox(height: 10),
          _buildCategoryFilterRow(),
          const SizedBox(height: 16),
          ..._buildItemsList(),
          const SizedBox(height: 16),
          const RecoveryBanner(),
          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReportItemScreen()),
          );
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Report Item',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) Navigator.pushNamed(context, '/listings');
          if (index == 2) Navigator.pushNamed(context, '/profile');
        },
      ),
    );
  }

  Widget _buildGreetingSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi Avi 👋',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            SizedBox(height: 2),
            Text(
              '3 new items reported around campus today',
              style: TextStyle(fontSize: 12, color: AppColors.muted),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.explore_outlined,
            color: AppColors.primary,
            size: 22,
          ),
        ),
      ],
    );
  }

  Widget _buildTypeFilterRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _typeFilters.map((filter) {
          final isSelected = (_typeFilter == 'All' && filter.startsWith('All')) ||
              (_typeFilter == 'Lost' && filter.startsWith('Lost')) ||
              (_typeFilter == 'Found' && filter.startsWith('Found'));

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CategoryChip(
              label: filter,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  if (filter.startsWith('All')) _typeFilter = 'All';
                  if (filter.startsWith('Lost')) _typeFilter = 'Lost';
                  if (filter.startsWith('Found')) _typeFilter = 'Found';
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryFilterRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((cat) {
          final name = cat['name'] as String;
          final isSelected = _categoryFilter == name;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CategoryChip(
              label: name,
              icon: cat['icon'] as IconData,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  _categoryFilter = isSelected ? 'All' : name;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  List<Widget> _buildItemsList() {
    final items = _filteredItems;
    if (items.isEmpty) {
      return [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: Text(
              'No items match your search or filter.',
              style: TextStyle(color: AppColors.muted, fontSize: 13),
            ),
          ),
        ),
      ];
    }

    return items
        .map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ItemCard(
              item: item,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ItemDetailsScreen(item: item),
                  ),
                );
              },
            ),
          ),
        )
        .toList();
  }
}