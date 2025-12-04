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
  bool _showScrollToTop = false;
  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'projects': GlobalKey(),
    'skills': GlobalKey(),
    'contact': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 300 && !_showScrollToTop) {
      setState(() => _showScrollToTop = true);
    } else if (_scrollController.offset <= 300 && _showScrollToTop) {
      setState(() => _showScrollToTop = false);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
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

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
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
      floatingActionButton: AnimatedOpacity(
        opacity: _showScrollToTop ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          offset: _showScrollToTop ? Offset.zero : const Offset(0, 2),
          child: FloatingActionButton(
            onPressed: _scrollToTop,
            backgroundColor: AppTheme.primaryColor,
            child: const Icon(Icons.keyboard_arrow_up, size: 32),
          ),
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
            const SizedBox(height: 40),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _buildActionButton(
                  'View Projects',
                  Icons.work_outline,
                  () => _scrollToSection('projects'),
                  isPrimary: true,
                ),
                _buildActionButton(
                  'Contact Me',
                  Icons.email_outlined,
                  () => _scrollToSection('contact'),
                  isPrimary: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    VoidCallback onPressed, {
    bool isPrimary = true,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            gradient: isPrimary ? AppTheme.primaryGradient : null,
            borderRadius: BorderRadius.circular(30),
            border: isPrimary
                ? null
                : Border.all(color: AppTheme.primaryColor, width: 2),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isPrimary ? Colors.white : AppTheme.primaryColor,
                size: 22,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: isPrimary ? Colors.white : AppTheme.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () => launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        ),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppTheme.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.4),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: FaIcon(
            icon,
            color: Colors.white,
            size: 26,
          ),
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: AppTheme.normalAnimation,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          skill,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
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
      constraints: const BoxConstraints(maxWidth: 900),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.surfaceColor.withOpacity(0.7),
            AppTheme.cardColor.withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppTheme.largeRadius,
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          AppTheme.cardShadow,
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 12),
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppTheme.primaryGradient.createShader(bounds),
                      child: Text(
                        company,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: AppTheme.accentGradient,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.accentColor.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  period,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                  height: 1.8,
                  fontSize: 16,
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
      padding: const EdgeInsets.all(36),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.surfaceColor.withOpacity(0.8),
            AppTheme.cardColor.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppTheme.largeRadius,
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            blurRadius: 30,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      AppTheme.primaryGradient.createShader(bounds),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              if (githubUrl != null)
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryColor.withOpacity(0.2),
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.github,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                  height: 1.7,
                ),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: technologies
                .map((tech) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.primaryColor.withOpacity(0.3),
                            AppTheme.secondaryColor.withOpacity(0.2),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppTheme.primaryColor.withOpacity(0.4),
                        ),
                      ),
                      child: Text(
                        tech,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.secondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );

    if (githubUrl != null) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: () => launchUrl(
            Uri.parse(githubUrl),
            mode: LaunchMode.externalApplication,
          ),
          borderRadius: AppTheme.largeRadius,
          child: cardContent,
        ),
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
            '© 2025 Amarchand NP. All rights reserved.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactLink(IconData icon, String label, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () => launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        ),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.primaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: FaIcon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return ShaderMask(
      shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
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
