# Responsive Portfolio

A modern, responsive portfolio website built with Flutter.

## Features

- ✨ Fully responsive design (mobile, tablet, desktop)
- 🎨 Modern dark theme with gradient accents
- 🧭 Smooth scrolling navigation
- 📱 Mobile-friendly hamburger menu
- ⚡ Built with Flutter for web

## Getting Started

### Prerequisites

- Flutter SDK (3.5.0 or higher)
- Dart SDK
- A web browser (Chrome recommended for development)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/amar752/responsiveportfolio.git
cd responsiveportfolio
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run -d chrome
```

### Building for Production

To build the web version:
```bash
flutter build web
```

The output will be in the `build/web` directory.

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── theme/
│   └── app_theme.dart          # Theme configuration
├── utils/
│   └── responsive_helper.dart  # Responsive utilities
└── widgets/
    └── responsive_navbar.dart  # Navigation bar component
```

## Deployment

This project uses GitHub Actions for automatic deployment to GitHub Pages.

## License

This project is open source and available under the MIT License.

## Contact

For any questions or feedback, please reach out through the contact section of the portfolio.
