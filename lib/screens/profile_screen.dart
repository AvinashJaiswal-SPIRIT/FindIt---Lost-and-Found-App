import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../data/sample_items.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/profile_setting_tile.dart';
import '../widgets/profile_stat_card.dart';
import 'home_screen.dart';
import 'listings_screen.dart';
import 'login_screen.dart';
import '../services/pref_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        subtitle: 'Profile',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.text),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          _buildUserProfileCard(),
          const SizedBox(height: 12),
          _buildHeroLevelBanner(),
          const SizedBox(height: 14),
          _buildStatsRow(context),
          const SizedBox(height: 20),
          _buildSettingsHeader(),
          const SizedBox(height: 10),
          _buildSettingsList(context),
          const SizedBox(height: 16),
          _buildLogoutButton(context),
          const SizedBox(height: 16),
          _buildFooterText(),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) => const HomeScreen()), (r) => false);
          } else if (index == 1) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const ListingsScreen()));
          }
        },
      ),
    );
  }

  int get _totalReports => sampleItems.length;
  int get _lostCount =>
      sampleItems.where((i) => i.type.toLowerCase() == 'lost').length;
  int get _reunitedCount => sampleItems
      .where((i) =>
          i.status.toLowerCase() == 'returned' ||
          i.status.toLowerCase() == 'resolved')
      .length;

  // Build user profile card with avatar and member status
  Widget _buildUserProfileCard() {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = (user?.displayName != null && user!.displayName!.trim().isNotEmpty)
        ? user.displayName!.trim()
        : (user?.email != null && user!.email!.contains('@')
            ? user.email!.split('@')[0]
            : 'Campus Member');
    final email = user?.email ?? 'student@campus.edu';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: 72,
              height: 72,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage("assets/images/avtar.jpg"),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(displayName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.text)),
              const SizedBox(width: 4),
              const Icon(Icons.verified, size: 16, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: 2),
          Text(email, style: const TextStyle(fontSize: 12, color: AppColors.muted)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBadge('Senior • Class of 2025', AppColors.borderLight, AppColors.muted),
              const SizedBox(width: 6),
              _buildBadge('✓ Verified Campus Member', AppColors.greenLight, AppColors.green),
            ],
          ),
        ],
      ),
    );
  }

  // Build campus hero announcement banner
  Widget _buildHeroLevelBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.amberLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.emoji_events_rounded, color: AppColors.amber, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Campus Hero: You've reunited $_reunitedCount items for fellow students this semester!",
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF92400E)),
            ),
          ),
        ],
      ),
    );
  }

  // Build statistical summary cards row for reported and reunited items
  Widget _buildStatsRow(BuildContext context) {
    final resolvePercent =
        _totalReports > 0 ? ((_reunitedCount / _totalReports) * 100).round() : 0;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileStatCard(
            value: '$_totalReports',
            label: 'Total Reports',
            icon: Icons.assignment_outlined,
            iconColor: AppColors.primary,
            onTap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen(initialTypeFilter: 'All')),
              (r) => false,
            ),
          ),
          const SizedBox(width: 8),
          ProfileStatCard(
            value: '$_lostCount',
            label: 'Lost Items',
            icon: Icons.search_rounded,
            iconColor: AppColors.red,
            onTap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen(initialTypeFilter: 'Lost')),
              (r) => false,
            ),
          ),
          const SizedBox(width: 8),
          ProfileStatCard(
            value: '$_reunitedCount',
            label: 'Reunited',
            icon: Icons.card_giftcard_rounded,
            iconColor: AppColors.green,
            extraBadge: '$resolvePercent% resolved',
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const ListingsScreen(initialTab: 'Returned & Resolved'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build settings section header title
  Widget _buildSettingsHeader() {
    return const Text(
      'CAMPUS & ACCOUNT SETTINGS',
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.8,
        color: AppColors.muted,
      ),
    );
  }

  // Build list of campus and account configuration tiles
  Widget _buildSettingsList(BuildContext context) {
    final settings = [
      {'icon': Icons.badge_outlined, 'title': 'Campus Affiliation & Student ID', 'sub': 'ID: •••• 8842 (Engineering Quad)', 'color': AppColors.blue},
      {'icon': Icons.notifications_none_rounded, 'title': 'Notification Preferences', 'sub': 'In-app alerts, daily email digest', 'color': AppColors.primary},
      {'icon': Icons.shield_outlined, 'title': 'Campus Safety & Contact Privacy', 'sub': 'Masked campus chat, anonymous claims', 'color': AppColors.blue},
      {'icon': Icons.home_work_outlined, 'title': 'Lost & Found Drop-off Centers', 'sub': 'Campus Police, Main Library, Union Desk', 'color': AppColors.amber},
      {'icon': Icons.help_outline_rounded, 'title': 'Help & Campus Guidelines', 'sub': 'Ownership verification FAQs & honor code', 'color': AppColors.primary},
    ];

    return Column(
      children: settings.map((s) => ProfileSettingTile(
        icon: s['icon'] as IconData,
        title: s['title'] as String,
        subtitle: s['sub'] as String,
        iconColor: s['color'] as Color,
        onTap: () {},
      )).toList(),
    );
  }

  // Build small status badge container
  Widget _buildBadge(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(text, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: textCol)),
    );
  }

  // Build logout button with session clearing and navigation
  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.redLight, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: const Icon(Icons.logout_rounded, color: AppColors.red, size: 20),
        title: const Text('Log Out', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.red)),
        onTap: () async {
          await PrefService.clearAuth();
          await FirebaseAuth.instance.signOut();
          if (!context.mounted) return;
          Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => const LoginScreen()), (r) => false);
        },
      ),
    );
  }

  // Build app version and campus honor code footer
  Widget _buildFooterText() {
    return const Column(
      children: [
        Text('FindIt v1.4.0 • Built for Campus Community', style: TextStyle(fontSize: 10, color: AppColors.muted)),
        SizedBox(height: 2),
        Text('Safe Recovery • Peer Honor Code Enabled', style: TextStyle(fontSize: 10, color: AppColors.muted)),
      ],
    );
  }
}