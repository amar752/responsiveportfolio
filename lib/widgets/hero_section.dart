import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive_helper.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 100,
      ),
      padding: ResponsiveHelper.responsivePadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.maxContentWidth(context),
          ),
          child: isMobile || isTablet
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 3, child: _buildContent(context)),
        const SizedBox(width: 80),
        Expanded(flex: 2, child: _buildProfileImage(context)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProfileImage(context),
        const SizedBox(height: 40),
        _buildContent(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Greeting
        Text(
          'Hi, I\'m',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(color: AppTheme.textSecondary),
        ),
        const SizedBox(height: 8),

        // Name with gradient
        ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            PortfolioData.profile.name,
            style: ResponsiveHelper.responsiveValue(
              context,
              mobile: Theme.of(context).textTheme.displaySmall,
              desktop: Theme.of(context).textTheme.displayLarge,
            )?.copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),

        // Animated title
        Row(
          mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
          children: [
            Text(
              'I\'m a ',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: AppTheme.textPrimary),
            ),
            AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TypewriterAnimatedText(
                  PortfolioData.profile.title,
                  textStyle: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                  speed: const Duration(milliseconds: 100),
                ),
                TypewriterAnimatedText(
                  'Problem Solver',
                  textStyle: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                  speed: const Duration(milliseconds: 100),
                ),
                TypewriterAnimatedText(
                  'Tech Enthusiast',
                  textStyle: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(
                        color: AppTheme.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Tagline
        Text(
          PortfolioData.profile.tagline,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: AppTheme.textSecondary),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 40),

        // Action buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _GradientButton(
              label: 'View LinkedIn',
              icon: FontAwesomeIcons.linkedin,
              onPressed: () => _launchUrl(
                PortfolioData.profile.socialLinks['linkedin'] ?? '',
              ),
            ),
            _OutlineButton(
              label: 'Download CV',
              icon: Icons.download_outlined,
              onPressed: () {
                // TODO: Implement CV download
              },
            ),
          ],
        ),
        const SizedBox(height: 40),

        // Social links
        _buildSocialLinks(context),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    final size = ResponsiveHelper.responsiveValue(
      context,
      mobile: 250.0,
      tablet: 300.0,
      desktop: 400.0,
    );

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppTheme.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.3),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.surfaceColor,
          image: const DecorationImage(
            image: AssetImage('assets/images/profile.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    final socialIcons = {
      'linkedin': FontAwesomeIcons.linkedin,
      'github': FontAwesomeIcons.github,
      'twitter': FontAwesomeIcons.twitter,
    };

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: PortfolioData.profile.socialLinks.entries
          .where((entry) => socialIcons.containsKey(entry.key))
          .map((entry) {
            return _SocialIconButton(
              icon: socialIcons[entry.key]!,
              onPressed: () => _launchUrl(entry.value),
            );
          })
          .toList(),
    );
  }
}

class _GradientButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _GradientButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: ElevatedButton.icon(
            onPressed: widget.onPressed,
            icon: FaIcon(widget.icon, size: 18),
            label: Text(widget.label),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _OutlineButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: OutlinedButton.icon(
          onPressed: widget.onPressed,
          icon: Icon(widget.icon, size: 18),
          label: Text(widget.label),
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: _isHovered
                  ? AppTheme.primaryColor
                  : AppTheme.textSecondary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _SocialIconButton({required this.icon, required this.onPressed});

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: _isHovered ? AppTheme.primaryGradient : null,
          color: _isHovered ? null : AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: IconButton(
          onPressed: widget.onPressed,
          icon: FaIcon(widget.icon),
          iconSize: 24,
          color: Colors.white,
          padding: const EdgeInsets.all(12),
        ),
      ),
    );
  }
}
