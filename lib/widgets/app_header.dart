import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../screens/profile_screen.dart';
import 'app_logo.dart';

// AppBar

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showLogo;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final bool showNotificationsAndAvatar;
  final VoidCallback? onProfileTap;

  const AppHeader({
    super.key,
    this.title = 'FindIt',
    this.subtitle,
    this.showLogo = true,
    this.showBack = false,
    this.onBack,
    this.actions,
    this.showNotificationsAndAvatar = false,
    this.onProfileTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: showBack ? 8 : 16,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.text),
              onPressed: onBack ?? () => Navigator.maybePop(context),
            )
          : null,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLogo) ...[
            const AppLogo(size: 32),
            const SizedBox(width: 10),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.2,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ],
      ),
      actions: actions ??
          (showNotificationsAndAvatar
              ? [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_none_rounded,
                          color: AppColors.text,
                          size: 22,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 12,
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: AppColors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: onProfileTap ??
                        () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProfileScreen(),
                              ),
                            ),
                    child: const Padding(
                      padding: EdgeInsets.only(right: 16, left: 4),
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: AppColors.primaryLight,
                        backgroundImage: AssetImage(
                          'assets/images/avtar.jpg',
                        ),
                      ),
                    ),
                  ),
                ]
              : null),
    );
  }
}
