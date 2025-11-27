import '../models/portfolio_models.dart';

class PortfolioData {
  static const profile = PortfolioProfile(
    name: 'Amarchand NP',
    title: 'Junior Flutter Developer',
    tagline: 'Building innovative solutions with modern technologies',
    bio: '''
I'm a passionate developer with expertise in creating responsive, 
user-friendly applications. I love turning complex problems into 
simple, beautiful, and intuitive solutions. When I'm not coding, 
you'll find me exploring new technologies and contributing to 
open-source projects.
    ''',
    email: 'amarchandnp2002@gmail.com',
    phone: '+91 9061491509',
    location: 'India',
    profileImage: 'assets/images/profile.jpg',
    socialLinks: {
      'linkedin': 'https://www.linkedin.com/in/amarchand-np-3335ab301',
      'github': 'https://github.com/amar752',
    },
  );

  static const experiences = [
    Experience(
      company: 'Luminar',
      position: 'Junior Flutter Developer',
      duration: 'June 2025 - Present',
      location: 'Kochi, India',
      description: 'Developing mobile applications with Flutter',
      achievements: [
        'Developed and launched mobile applications',
        'Improved app performance and user experience',
        'Collaborated with team on various projects',
        'Implemented best practices in Flutter development',
      ],
    ),
  ];

  static const projects = [
    Project(
      title: 'Expense Tracker',
      description:
          'A comprehensive expense tracking application with income/expense management, category-based organization, and visual analytics for better financial insights.',
      technologies: ['Flutter', 'Dart', 'Riverpod', 'Hive'],
      githubUrl: 'https://github.com/amar752/expensetracker',
      isFeatured: true,
    ),
    Project(
      title: 'Portfolio Website',
      description:
          'Responsive portfolio website showcasing projects and skills. Built with Flutter Web and custom animations.',
      technologies: ['Flutter Web', 'Dart', 'Responsive Design'],
      githubUrl: 'https://github.com/amar752', // Linking to profile as placeholder or repo if exists
      isFeatured: true,
    ),
  ];

  static const skills = [
    // Mobile Development
    Skill(name: 'Flutter', category: 'Mobile', proficiency: 0.9),
    Skill(name: 'Dart', category: 'Mobile', proficiency: 0.9),

    // Backend
    Skill(name: 'Firebase', category: 'Backend', proficiency: 0.85),

    // Tools & Others
    Skill(name: 'Git', category: 'Tools', proficiency: 0.9),
    Skill(name: 'Figma', category: 'Design', proficiency: 0.75),
  ];

  static const education = [
    Education(
      institution: 'University of Technology',
      degree: 'Bachelor of Science',
      field: 'Computer Science',
      duration: '2015 - 2019',
      grade: '3.8 GPA',
      description: 'Focused on software engineering and mobile development',
    ),
  ];

  static const certifications = [
    Certification(
      name: 'Google Associate Android Developer',
      issuer: 'Google',
      date: '2021',
    ),
  ];
}
