import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsiveportfolio/models/portfolio_models.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive_helper.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ResponsiveHelper.responsivePadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.maxContentWidth(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(context, 'Projects'),
              const SizedBox(height: 40),
              _buildProjectsGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            title,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor,
                  AppTheme.primaryColor.withOpacity(0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsGrid(BuildContext context) {
    final columnCount = ResponsiveHelper.gridColumnCount(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 0.85,
      ),
      itemCount: PortfolioData.projects.length,
      itemBuilder: (context, index) {
        return _ProjectCard(
          project: PortfolioData.projects[index],
          onGithubTap: () {
            if (PortfolioData.projects[index].githubUrl != null) {
              _launchUrl(PortfolioData.projects[index].githubUrl!);
            }
          },
          onLiveTap: () {
            if (PortfolioData.projects[index].liveUrl != null) {
              _launchUrl(PortfolioData.projects[index].liveUrl!);
            }
          },
        );
      },
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final VoidCallback? onGithubTap;
  final VoidCallback? onLiveTap;

  const _ProjectCard({required this.project, this.onGithubTap, this.onLiveTap});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        child: Card(
          elevation: _isHovered ? 12 : 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: _isHovered
                  ? Border.all(color: AppTheme.primaryColor, width: 2)
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project image placeholder
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.code,
                      size: 64,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.project.title,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (widget.project.isFeatured)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  gradient: AppTheme.accentGradient,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Featured',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.project.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        const SizedBox(height: 12),

                        // Technologies
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.project.technologies
                              .take(3)
                              .map(
                                (tech) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.surfaceColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    tech,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: AppTheme.primaryColor,
                                        ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 16),

                        // Action buttons
                        Row(
                          children: [
                            if (widget.project.githubUrl != null)
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: widget.onGithubTap,
                                  icon: const FaIcon(
                                    FontAwesomeIcons.github,
                                    size: 16,
                                  ),
                                  label: const Text('Code'),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                              ),
                            if (widget.project.githubUrl != null &&
                                widget.project.liveUrl != null)
                              const SizedBox(width: 8),
                            if (widget.project.liveUrl != null)
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: widget.onLiveTap,
                                  icon: const Icon(Icons.open_in_new, size: 16),
                                  label: const Text('Live'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
