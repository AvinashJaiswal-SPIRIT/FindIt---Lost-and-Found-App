import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/item_model.dart';
import '../widgets/app_header.dart';
import '../widgets/hero_image_carousel.dart';
import '../widgets/listing_controls_card.dart';
import '../widgets/pickup_coordinates_card.dart';
import '../widgets/primary_button.dart';
import '../widgets/recovery_location_card.dart';
import '../widgets/reporter_profile_card.dart';
import '../widgets/status_badge.dart';

class ItemDetailsScreen extends StatelessWidget {
  final ItemModel item;

  const ItemDetailsScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppHeader(
          title: 'Item Detail',
          showBack: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.bookmark_border_rounded, color: AppColors.text),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.share_outlined, color: AppColors.text),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            _buildItemHeaderRow(),
            const SizedBox(height: 10),
            HeroImageCarousel(
              imageUrl: item.imageUrl.isNotEmpty
                  ? item.imageUrl
                  : 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=500',
            ),
            const SizedBox(height: 14),
            _buildSubheaderSection(),
            const SizedBox(height: 16),
            _buildDescriptionSection(),
            const SizedBox(height: 16),
            RecoveryLocationCard(location: item.recoveryLocation),
            const SizedBox(height: 16),
            _buildReportedByHeader(),
            const SizedBox(height: 8),
            ReporterProfileCard(
              name: item.reportedBy,
              role: item.reportedByRole,
            ),
            const SizedBox(height: 16),
            const PickupCoordinatesCard(),
            const SizedBox(height: 16),
            ListingControlsCard(
              onEdit: () {},
              onResolved: () {},
              onRemove: () {},
            ),
            const SizedBox(height: 80),
          ],
        ),
        bottomSheet: _buildBottomActionBar(context),
      ),
    );
  }

  Widget _buildItemHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '• ID #${item.id}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        StatusBadge(label: '${item.type.toUpperCase()} ITEM'),
      ],
    );
  }

  Widget _buildSubheaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.access_time_rounded, size: 12, color: AppColors.muted),
            const SizedBox(width: 4),
            Text(
              'Found ${item.timeAgo}',
              style: const TextStyle(fontSize: 11, color: AppColors.muted),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.location_on_outlined, size: 12, color: AppColors.muted),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                item.location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11, color: AppColors.muted),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          item.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.text),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Active Listing',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Waiting to be claimed by rightful owner',
                      style: TextStyle(fontSize: 10, color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              const Text(
                'Stage 1 of 2',
                style: TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description & Identifiers',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.text),
        ),
        const SizedBox(height: 6),
        Text(
          item.description,
          style: const TextStyle(fontSize: 11, color: AppColors.muted, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildReportedByHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Reported By',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.text),
        ),
        Text(
          '🌿 Biology Dept',
          style: TextStyle(fontSize: 10, color: AppColors.green, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.explore_outlined, size: 16),
                label: const Text('Directions', style: TextStyle(fontSize: 12)),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 44),
                  side: const BorderSide(color: AppColors.border),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: PrimaryButton(
                text: 'Contact ${item.reportedBy}',
                icon: Icons.chat_bubble_outline_rounded,
                height: 44,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Contacting ${item.contactEmail}...')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}