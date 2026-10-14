import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/profile_setting_tile.dart';
import '../widgets/profile_stat_card.dart';
import 'home_screen.dart';
import 'listings_screen.dart';
import 'login_screen.dart';

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
          _buildStatsRow(),
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
          final target = index == 0 ? const HomeScreen() : const ListingsScreen();
          if (index == 0 || index == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => target));
          }
        },
      ),
    );
  }

  Widget _buildUserProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 36,
                backgroundImage: AssetImage("assets/images/avtar.jpg")
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Avi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.verified, size: 16, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: 2),
          const Text(
            'avi@campus.edu',
            style: TextStyle(fontSize: 12, color: AppColors.muted),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Senior • Class of 2025',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.muted,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.greenLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '✓ Verified Campus Member',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroLevelBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.amberLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          Icon(Icons.emoji_events_rounded, color: AppColors.amber, size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              "Campus Hero Level 2: You've reunited items for 5 fellow students this semester!",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFF92400E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return const Row(
      children: [
        ProfileStatCard(
          value: '8',
          label: 'Total Reports',
          icon: Icons.assignment_outlined,
          iconColor: AppColors.primary,
        ),
        SizedBox(width: 8),
        ProfileStatCard(
          value: '3',
          label: 'Lost Items',
          icon: Icons.search_rounded,
          iconColor: AppColors.red,
        ),
        SizedBox(width: 8),
        ProfileStatCard(
          value: '5',
          label: 'Reunited',
          icon: Icons.card_giftcard_rounded,
          iconColor: AppColors.green,
          extraBadge: '62% resolved',
        ),
      ],
    );
  }

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

  Widget _buildSettingsList(BuildContext context) {
    return Column(
      children: [
        ProfileSettingTile(
          icon: Icons.badge_outlined,
          title: 'Campus Affiliation & Student ID',
          subtitle: 'ID: •••• 8842 (Engineering Quad)',
          iconColor: AppColors.blue,
          onTap: () {},
        ),
        ProfileSettingTile(
          icon: Icons.notifications_none_rounded,
          title: 'Notification Preferences',
          subtitle: 'In-app alerts, daily email digest',
          iconColor: AppColors.primary,
          onTap: () {},
        ),
        ProfileSettingTile(
          icon: Icons.shield_outlined,
          title: 'Campus Safety & Contact Privacy',
          subtitle: 'Masked campus chat, anonymous claims',
          iconColor: AppColors.blue,
          onTap: () {},
        ),
        ProfileSettingTile(
          icon: Icons.home_work_outlined,
          title: 'Lost & Found Drop-off Centers',
          subtitle: 'Campus Police, Main Library, Union Desk',
          iconColor: AppColors.amber,
          onTap: () {},
        ),
        ProfileSettingTile(
          icon: Icons.help_outline_rounded,
          title: 'Help & Campus Guidelines',
          subtitle: 'Ownership verification FAQs & honor code',
          iconColor: AppColors.primary,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.redLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: const Icon(Icons.logout_rounded, color: AppColors.red, size: 20),
        title: const Text(
          'Log Out',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.red,
          ),
        ),
        onTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        },
      ),
    );
  }

  Widget _buildFooterText() {
    return const Column(
      children: [
        Text(
          'FindIt v1.4.0 • Built for Campus Community',
          style: TextStyle(fontSize: 10, color: AppColors.muted),
        ),
        SizedBox(height: 2),
        Text(
          'Safe Recovery • Peer Honor Code Enabled',
          style: TextStyle(fontSize: 10, color: AppColors.muted),
        ),
      ],
    );
  }
}