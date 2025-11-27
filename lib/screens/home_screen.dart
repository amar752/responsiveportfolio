import 'package:flutter/material.dart';
import '../widgets/responsive_navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/contact_section.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'projects': GlobalKey(),
    'skills': GlobalKey(),
    'contact': GlobalKey(),
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: Stack(
          children: [
            // Main content
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 80), // Space for navbar
                  // Hero Section
                  Container(
                    key: _sectionKeys['home'],
                    child: const HeroSection(),
                  ),

                  const SizedBox(height: 80),

                  // About Section
                  Container(
                    key: _sectionKeys['about'],
                    child: const AboutSection(),
                  ),

                  const SizedBox(height: 80),

                  // Experience Section
                  Container(
                    key: _sectionKeys['experience'],
                    child: const ExperienceSection(),
                  ),

                  const SizedBox(height: 80),

                  // Projects Section
                  Container(
                    key: _sectionKeys['projects'],
                    child: const ProjectsSection(),
                  ),

                  const SizedBox(height: 80),

                  // Skills Section
                  Container(
                    key: _sectionKeys['skills'],
                    child: const SkillsSection(),
                  ),

                  const SizedBox(height: 80),

                  // Contact Section
                  Container(
                    key: _sectionKeys['contact'],
                    child: const ContactSection(),
                  ),

                  const SizedBox(height: 40),

                  // Footer
                  _buildFooter(),
                ],
              ),
            ),

            // Fixed navbar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ResponsiveNavbar(onNavigate: _scrollToSection),
            ),
          ],
        ),
      ),

      // Floating action button to scroll to top
      floatingActionButton: AnimatedOpacity(
        opacity: _scrollController.hasClients && _scrollController.offset > 500
            ? 1.0
            : 0.0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
          onPressed: () {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
            );
          },
          backgroundColor: AppTheme.primaryColor,
          child: const Icon(Icons.arrow_upward),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withOpacity(0.5),
        border: Border(
          top: BorderSide(
            color: AppTheme.primaryColor.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
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
          const SizedBox(height: 16),
          Text(
            '© ${DateTime.now().year} All rights reserved.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            'Built with Flutter ❤️',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppTheme.textLight),
          ),
        ],
      ),
    );
  }
}
