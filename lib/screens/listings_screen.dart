import 'dart:async';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../data/sample_items.dart';
import '../models/item_model.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/empty_state.dart';
import '../widgets/item_card.dart';
import '../widgets/listings_header.dart';
import 'home_screen.dart';
import 'item_details_screen.dart';
import 'profile_screen.dart';
import 'report_item_screen.dart';
import '../services/firestore_service.dart';

class ListingsScreen extends StatefulWidget {
  final String initialTab;
  const ListingsScreen({super.key, this.initialTab = 'Active'});

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  late String _activeTab = widget.initialTab;
  Timer? _snackBarTimer;

  @override
  void dispose() {
    _snackBarTimer?.cancel();
    super.dispose();
  }

  List<ItemModel> get _userItems {
    return sampleItems.where((item) {
      if (_activeTab == 'Active') {
        return item.status == 'Active';
      } else {
        return item.status != 'Active';
      }
    }).toList();
  }

  void _markAsReturned(ItemModel item) {
    final isCurrentlyReturned = item.status == 'Returned';
    final updatedStatus = isCurrentlyReturned ? 'Active' : 'Returned';

    FirestoreService.updateItem(item.copyWith(status: updatedStatus));
    setState(() {});

    _snackBarTimer?.cancel();
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: Text(
          isCurrentlyReturned
              ? 'Marked "${item.title}" as active!'
              : 'Marked "${item.title}" as returned!',
        ),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: AppColors.primaryLight,
          onPressed: () {
            _snackBarTimer?.cancel();
            messenger.hideCurrentSnackBar();
            FirestoreService.updateItem(item.copyWith(
              status: isCurrentlyReturned ? 'Returned' : 'Active',
            ));
            setState(() {});
          },
        ),
      ),
    );

    _snackBarTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        messenger.hideCurrentSnackBar();
      }
    });
  }

  void _editItem(ItemModel item) async {
    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ReportItemScreen(itemToEdit: item),
      ),
    );
    if (updated == true && mounted) {
      setState(() {});
    }
  }

  void _createNewListing() async {
    final created = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => const ReportItemScreen(),
      ),
    );
    if (created == true && mounted) {
      setState(() {});
    }
  }

  void _showItemActions(ItemModel item) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('Edit Listing'),
                onTap: () {
                  Navigator.pop(context);
                  _editItem(item);
                },
              ),
              ListTile(
                leading: Icon(
                  item.status == 'Returned' ? Icons.replay_rounded : Icons.check_circle_outline,
                  color: AppColors.green,
                ),
                title: Text(item.status == 'Returned' ? 'Mark as Active' : 'Mark as Returned'),
                onTap: () {
                  Navigator.pop(context);
                  _markAsReturned(item);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: AppColors.red),
                title: const Text('Remove Listing', style: TextStyle(color: AppColors.red)),
                onTap: () {
                  Navigator.pop(context);
                  FirestoreService.deleteItem(item.id);
                  setState(() {});
                  _snackBarTimer?.cancel();
                  final messenger = ScaffoldMessenger.of(context);
                  messenger.clearSnackBars();
                  messenger.showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 5),
                      content: Text('Removed "${item.title}"'),
                    ),
                  );
                  _snackBarTimer = Timer(const Duration(seconds: 5), () {
                    if (mounted) messenger.hideCurrentSnackBar();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSortSheet() {
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
                'Sort Listings',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.access_time_rounded),
                title: const Text('Most Recent First'),
                onTap: () {
                  setState(() => sampleItems.sort((a, b) => b.id.compareTo(a.id)));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.sort_by_alpha_rounded),
                title: const Text('Alphabetical (A-Z)'),
                onTap: () {
                  setState(() => sampleItems.sort((a, b) => a.title.compareTo(b.title)));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.history_rounded),
                title: const Text('Oldest First'),
                onTap: () {
                  setState(() => sampleItems.sort((a, b) => a.id.compareTo(b.id)));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
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
          ListingsHeader(
            totalCount: sampleItems.length,
            activeTab: _activeTab,
            activeCount: sampleItems.where((i) => i.status == 'Active').length,
            returnedCount: sampleItems.where((i) => i.status != 'Active').length,
            onTabChanged: (tab) => setState(() => _activeTab = tab),
            onSortTap: _showSortSheet,
            onFilterTap: _showSortSheet,
          ),
          const SizedBox(height: 14),
          if (items.isEmpty)
            EmptyState(
              title: _activeTab == 'Active' ? 'No active listings' : 'No returned listings',
              subtitle: _activeTab == 'Active'
                  ? 'All caught up! Found something lost or missing your own essentials on campus?'
                  : 'Items you mark as returned will appear here.',
              onButtonTap: _createNewListing,
            )
          else
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ItemCard(
                  item: item,
                  isListingView: true,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ItemDetailsScreen(item: item),
                      ),
                    );
                    setState(() {});
                  },
                  onEdit: () => _editItem(item),
                  onMarkReturned: () => _markAsReturned(item),
                  onMore: () => _showItemActions(item),
                ),
              ),
            ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          _snackBarTimer?.cancel();
          ScaffoldMessenger.of(context).clearSnackBars();
          if (index == 0) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) => const HomeScreen()), (r) => false);
          } else if (index == 2) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }
        },
      ),
    );
  }
}