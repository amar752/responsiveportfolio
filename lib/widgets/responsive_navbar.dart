import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/responsive_helper.dart';

class ResponsiveNavbar extends StatefulWidget {
  final Function(String) onNavigate;

  const ResponsiveNavbar({super.key, required this.onNavigate});

  @override
  State<ResponsiveNavbar> createState() => _ResponsiveNavbarState();
}

class _ResponsiveNavbarState extends State<ResponsiveNavbar> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.responsiveValue(
          context,
          mobile: 16,
          desktop: 64,
        ),
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: _isScrolled
            ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.98)
            : Colors.transparent,
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          ShaderMask(
            shaderCallback: (bounds) =>
                AppTheme.primaryGradient.createShader(bounds),
            child: Text(
              'Portfolio',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Navigation items
          if (!isMobile)
            Row(
              children: [
                _NavItem(label: 'Home', onTap: () => widget.onNavigate('home')),
                _NavItem(
                  label: 'About',
                  onTap: () => widget.onNavigate('about'),
                ),
                _NavItem(
                  label: 'Experience',
                  onTap: () => widget.onNavigate('experience'),
                ),
                _NavItem(
                  label: 'Projects',
                  onTap: () => widget.onNavigate('projects'),
                ),
                _NavItem(
                  label: 'Skills',
                  onTap: () => widget.onNavigate('skills'),
                ),
                _NavItem(
                  label: 'Contact',
                  onTap: () => widget.onNavigate('contact'),
                ),
              ],
            )
          else
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => _showMobileMenu(context),
            ),
        ],
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MobileNavItem(
              label: 'Home',
              icon: Icons.home_outlined,
              onTap: () {
                Navigator.pop(context);
                widget.onNavigate('home');
              },
            ),
            _MobileNavItem(
              label: 'About',
              icon: Icons.person_outline,
              onTap: () {
                Navigator.pop(context);
                widget.onNavigate('about');
              },
            ),
            _MobileNavItem(
              label: 'Experience',
              icon: Icons.work_outline,
              onTap: () {
                Navigator.pop(context);
                widget.onNavigate('experience');
              },
            ),
            _MobileNavItem(
              label: 'Projects',
              icon: Icons.folder_outlined,
              onTap: () {
                Navigator.pop(context);
                widget.onNavigate('projects');
              },
            ),
            _MobileNavItem(
              label: 'Skills',
              icon: Icons.code_outlined,
              onTap: () {
                Navigator.pop(context);
                widget.onNavigate('skills');
              },
            ),
            _MobileNavItem(
              label: 'Contact',
              icon: Icons.email_outlined,
              onTap: () {
                Navigator.pop(context);
                widget.onNavigate('contact');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavItem({required this.label, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: _isHovered
                      ? AppTheme.primaryColor
                      : AppTheme.textPrimary,
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _isHovered ? 30 : 0,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _MobileNavItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(label, style: Theme.of(context).textTheme.titleMedium),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }
}
