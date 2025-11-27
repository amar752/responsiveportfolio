class PortfolioProfile {
  final String name;
  final String title;
  final String tagline;
  final String bio;
  final String email;
  final String phone;
  final String location;
  final String profileImage;
  final Map<String, String> socialLinks;

  const PortfolioProfile({
    required this.name,
    required this.title,
    required this.tagline,
    required this.bio,
    required this.email,
    required this.phone,
    required this.location,
    required this.profileImage,
    required this.socialLinks,
  });
}

class Experience {
  final String company;
  final String position;
  final String duration;
  final String location;
  final String description;
  final List<String> achievements;
  final String? companyLogo;

  const Experience({
    required this.company,
    required this.position,
    required this.duration,
    required this.location,
    required this.description,
    required this.achievements,
    this.companyLogo,
  });
}

class Project {
  final String title;
  final String description;
  final List<String> technologies;
  final String? imageUrl;
  final String? githubUrl;
  final String? liveUrl;
  final bool isFeatured;

  const Project({
    required this.title,
    required this.description,
    required this.technologies,
    this.imageUrl,
    this.githubUrl,
    this.liveUrl,
    this.isFeatured = false,
  });
}

class Skill {
  final String name;
  final String category;
  final double proficiency; // 0.0 to 1.0
  final String? iconPath;

  const Skill({
    required this.name,
    required this.category,
    required this.proficiency,
    this.iconPath,
  });
}

class Education {
  final String institution;
  final String degree;
  final String field;
  final String duration;
  final String? description;
  final String? grade;

  const Education({
    required this.institution,
    required this.degree,
    required this.field,
    required this.duration,
    this.description,
    this.grade,
  });
}

class Certification {
  final String name;
  final String issuer;
  final String date;
  final String? credentialUrl;

  const Certification({
    required this.name,
    required this.issuer,
    required this.date,
    this.credentialUrl,
  });
}
