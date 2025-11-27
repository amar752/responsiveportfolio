import 'package:flutter/material.dart';
import 'package:responsiveportfolio/models/portfolio_models.dart';
import '../config/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive_helper.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skillsByCategory = <String, List<Skill>>{};
    for (final skill in PortfolioData.skills) {
      skillsByCategory.putIfAbsent(skill.category, () => []).add(skill);
    }

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
              _buildSectionTitle(context, 'Skills'),
              const SizedBox(height: 40),
              ...skillsByCategory.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: _SkillCategory(
                    category: entry.key,
                    skills: entry.value,
                  ),
                );
              }),
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
}

class _SkillCategory extends StatelessWidget {
  final String category;
  final List<Skill> skills;

  const _SkillCategory({required this.category, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ...skills.map(
          (skill) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _SkillBar(skill: skill),
          ),
        ),
      ],
    );
  }
}

class _SkillBar extends StatelessWidget {
  final Skill skill;

  const _SkillBar({required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Text(
        skill.name,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(color: AppTheme.textPrimary),
      ),
    );
  }
}
