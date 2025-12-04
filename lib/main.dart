import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'theme/app_theme.dart';
import 'widgets/responsive_navbar.dart';
import 'utils/responsive_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amarchand NP - Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Column(
          children: [
            ResponsiveNavbar(onNavigate: _scrollToSection),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    _buildHeroSection(),
                    _buildAboutSection(),
                    _buildSkillsSection(),
                    _buildExperienceSection(),
                    _buildProjectsSection(),
                    _buildContactSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      key: _sectionKeys['home'],
      height: MediaQuery.of(context).size.height * 0.9,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.responsiveValue(
          context,
          mobile: 24,
          desktop: 64,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppTheme.primaryGradient.createShader(bounds),
              child: Text(
                'Hi, I\'m Amarchand NP',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontSize: ResponsiveHelper.responsiveFontSize(
                        context,
                        mobile: 48,
                        desktop: 72,
                      ),
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Flutter Developer',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Building beautiful cross-platform mobile applications',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(
                  FontAwesomeIcons.github,
                  'https://github.com/amar752',
                ),
                const SizedBox(width: 24),
                _buildSocialIcon(
                  FontAwesomeIcons.linkedin,
                  'https://www.linkedin.com/in/amarchand-np-3335ab301',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppTheme.primaryColor, width: 2),
        ),
        child: FaIcon(
          icon,
          color: AppTheme.primaryColor,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      key: _sectionKeys['about'],
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.responsiveValue(
          context,
          mobile: 24,
          desktop: 120,
        ),
        vertical: 80,
      ),
      child: Column(
        children: [
          _buildSectionTitle('About Me'),
          const SizedBox(height: 48),
          Text(
            'I\'m a passionate Flutter developer with experience in building cross-platform mobile applications. '
            'Currently interning at Luminar, I\'ve developed multiple projects including a Telegram clone and an Expense Tracker app. '
            'I love creating intuitive user interfaces and solving complex problems through clean, efficient code.',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.textSecondary,
                  height: 1.6,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    return Container(
      key: _sectionKeys['skills'],
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.responsiveValue(
          context,
          mobile: 24,
          desktop: 120,
        ),
        vertical: 80,
      ),
      child: Column(
        children: [
          _buildSectionTitle('Skills'),
          const SizedBox(height: 48),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _buildSkillChip('Flutter'),
              _buildSkillChip('Dart'),
              _buildSkillChip('Firebase'),
              _buildSkillChip('Git'),
              _buildSkillChip('REST APIs'),
              _buildSkillChip('State Management'),
              _buildSkillChip('UI/UX Design'),
              _buildSkillChip('Responsive Design'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        skill,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildExperienceSection() {
    return Container(
      key: _sectionKeys['experience'],
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.responsiveValue(
          context,
          mobile: 24,
          desktop: 120,
        ),
        vertical: 80,
      ),
      child: Column(
        children: [
          _buildSectionTitle('Experience'),
          const SizedBox(height: 48),
          _buildExperienceCard(
            'Flutter Development Intern',
            'Luminar',
            'Present',
            'Working on mobile app development using Flutter framework. '
            'Developed multiple real-world applications and collaborated with the team on various projects.',
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(
    String title,
    String company,
    String period,
    String description,
  ) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      company,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppTheme.primaryColor,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  period,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection() {
    return Container(
      key: _sectionKeys['projects'],
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.responsiveValue(
          context,
          mobile: 24,
          desktop: 120,
        ),
        vertical: 80,
      ),
      child: Column(
        children: [
          _buildSectionTitle('Projects'),
          const SizedBox(height: 48),
          ResponsiveHelper.isMobile(context)
              ? Column(
                  children: [
                    _buildProjectCard(
                      'Telegram Clone (Frontend)',
                      'A pixel-perfect UI clone of Telegram messaging app built with Flutter, featuring '
                      'beautiful Material Design interface, chat screens, and local data persistence using SharedPreferences.',
                      ['Flutter', 'SharedPreferences', 'UI/UX'],
                      githubUrl: 'https://github.com/amar752/telegram_clone',
                    ),
                    const SizedBox(height: 24),
                    _buildProjectCard(
                      'Expense Tracker',
                      'Comprehensive personal finance management app with SQLite database that helps users track income and expenses, '
                      'categorize transactions, visualize spending patterns with charts, and manage budgets effectively.',
                      ['Flutter', 'SQLite', 'Charts', 'Data Persistence'],
                      githubUrl: 'https://github.com/amar752/expensetracker2',
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildProjectCard(
                        'Telegram Clone (Frontend)',
                        'A pixel-perfect UI clone of Telegram messaging app built with Flutter, featuring '
                        'beautiful Material Design interface, chat screens, and local data persistence using SharedPreferences.',
                        ['Flutter', 'SharedPreferences', 'UI/UX'],
                        githubUrl: 'https://github.com/amar752/telegram_clone',
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildProjectCard(
                        'Expense Tracker',
                        'Comprehensive personal finance management app with SQLite database that helps users track income and expenses, '
                        'categorize transactions, visualize spending patterns with charts, and manage budgets effectively.',
                        ['Flutter', 'SQLite', 'Charts', 'Data Persistence'],
                        githubUrl: 'https://github.com/amar752/expensetracker2',
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
    String title,
    String description,
    List<String> technologies, {
    String? githubUrl,
  }) {
    final cardContent = Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              if (githubUrl != null)
                FaIcon(
                  FontAwesomeIcons.github,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                  height: 1.6,
                ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: technologies
                .map((tech) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tech,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.primaryColor,
                            ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );

    if (githubUrl != null) {
      return InkWell(
        onTap: () => launchUrl(
          Uri.parse(githubUrl),
          mode: LaunchMode.externalApplication,
        ),
        borderRadius: BorderRadius.circular(16),
        child: cardContent,
      );
    }

    return cardContent;
  }

  Widget _buildContactSection() {
    return Container(
      key: _sectionKeys['contact'],
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.responsiveValue(
          context,
          mobile: 24,
          desktop: 120,
        ),
        vertical: 80,
      ),
      child: Column(
        children: [
          _buildSectionTitle('Get In Touch'),
          const SizedBox(height: 48),
          Text(
            'I\'m always open to discussing new projects, creative ideas, or opportunities to be part of your visions.',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.textSecondary,
                  height: 1.6,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: ResponsiveHelper.isMobile(context) ? 16 : 32,
            runSpacing: 24,
            children: [
              _buildContactLink(
                FontAwesomeIcons.envelope,
                'Email',
                'mailto:amarchandnp2002@gmail.com',
              ),
              _buildContactLink(
                FontAwesomeIcons.phone,
                'Phone',
                'tel:+919061491509',
              ),
              _buildContactLink(
                FontAwesomeIcons.github,
                'GitHub',
                'https://github.com/amar752',
              ),
              _buildContactLink(
                FontAwesomeIcons.linkedin,
                'LinkedIn',
                'https://www.linkedin.com/in/amarchand-np-3335ab301',
              ),
            ],
          ),
          const SizedBox(height: 64),
          Text(
            '© 2024 Amarchand NP. All rights reserved.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactLink(IconData icon, String label, String url) {
    return InkWell(
      onTap: () => launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppTheme.primaryGradient,
            ),
            child: FaIcon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          AppTheme.primaryGradient.createShader(bounds),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
