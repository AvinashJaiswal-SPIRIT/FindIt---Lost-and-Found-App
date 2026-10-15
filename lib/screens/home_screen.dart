import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/app_colors.dart';
import '../data/sample_items.dart';
import '../models/item_model.dart';
import '../widgets/app_header.dart';
import '../widgets/app_search_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/category_chip.dart';
import '../widgets/empty_state.dart';
import '../widgets/home_greeting.dart';
import '../widgets/item_card.dart';
import '../widgets/recovery_banner.dart';
import 'item_details_screen.dart';
import 'listings_screen.dart';
import 'profile_screen.dart';
import 'report_item_screen.dart';
import '../services/firestore_service.dart';

class HomeScreen extends StatefulWidget {
  final String initialTypeFilter;
  const HomeScreen({super.key, this.initialTypeFilter = 'All'});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _typeFilter = widget.initialTypeFilter;
  String _categoryFilter = 'All';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    FirestoreService.startRealtimeSync(onUpdate: () {
      if (mounted) setState(() {});
    });
  }

  String get _userName {
    final user = FirebaseAuth.instance.currentUser;
    if (user?.displayName != null && user!.displayName!.trim().isNotEmpty) {
      return user.displayName!.trim();
    }
    if (user?.email != null && user!.email!.contains('@')) {
      final prefix = user.email!.split('@')[0];
      if (prefix.isNotEmpty) {
        return prefix[0].toUpperCase() + prefix.substring(1);
      }
    }
    return 'Avi';
  }

  int get _totalCount => sampleItems.length;
  int get _lostCount =>
      sampleItems.where((i) => i.type.toLowerCase() == 'lost').length;
  int get _foundCount =>
      sampleItems.where((i) => i.type.toLowerCase() == 'found').length;

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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) SystemNavigator.pop();
      },
      child: Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(
        subtitle: 'Home',
        showNotificationsAndAvatar: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          HomeGreeting(
            userName: _userName,
            reportedCount: _totalCount,
          ),
          const SizedBox(height: 16),
          AppSearchBar(
            onChanged: (q) => setState(() => _searchQuery = q),
            onFilterTap: _openFilterModal,
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
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReportItemScreen()),
          );
          setState(() {});
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
        onTap: (index) async {
          final target = index == 1 ? const ListingsScreen() : const ProfileScreen();
          if (index == 1 || index == 2) {
            await Navigator.push(context, MaterialPageRoute(builder: (_) => target));
            setState(() {});
          }
        },
      ),
    ),
  );
  }


  Widget _buildTypeFilterRow() {
    final filters = [
      {'key': 'All', 'label': 'All Items ($_totalCount)'},
      {'key': 'Lost', 'label': 'Lost ($_lostCount)'},
      {'key': 'Found', 'label': 'Found ($_foundCount)'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final key = filter['key']!;
          final isSelected = (_typeFilter == 'All' && key == 'All') ||
              (_typeFilter.contains('Lost') && key == 'Lost') ||
              (_typeFilter.contains('Found') && key == 'Found');

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CategoryChip(
              label: filter['label']!,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  _typeFilter = key;
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

  void _openFilterModal() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter by Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ...[
                {'title': 'All Items', 'key': 'All', 'count': _totalCount},
                {'title': 'Lost Only', 'key': 'Lost', 'count': _lostCount},
                {'title': 'Found Only', 'key': 'Found', 'count': _foundCount},
              ].map((opt) {
                final key = opt['key'] as String;
                final isSelected = (_typeFilter == 'All' && key == 'All') ||
                    (_typeFilter.contains('Lost') && key == 'Lost') ||
                    (_typeFilter.contains('Found') && key == 'Found');
                return ListTile(
                  title: Text('${opt['title']} (${opt['count']})'),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () {
                    setState(() => _typeFilter = key);
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildItemsList() {
    final items = _filteredItems;
    if (items.isEmpty) {
      return [
        EmptyState(
          title: 'No matching items',
          subtitle: 'Try adjusting your search query or category filters.',
          buttonText: 'Reset Filters',
          onButtonTap: () {
            setState(() {
              _searchQuery = '';
              _typeFilter = 'All';
              _categoryFilter = 'All';
            });
          },
        ),
      ];
    }

    return items.map((item) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ItemCard(
        item: item,
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ItemDetailsScreen(item: item)),
          );
          setState(() {});
        },
      ),
    )).toList();
  }
}