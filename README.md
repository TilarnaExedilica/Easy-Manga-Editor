# easy_manga_editor

Under development...

## Getting started

### Scripts

- Generate translation keys

```bash
dart tools/generate_tr_keys.dart
```

- Generate code

```bash
# Watch changes
flutter pub run build_runner watch --delete-conflicting-outputs

# Build once
flutter pub run build_runner build --delete-conflicting-outputs
```

### Project structure

```bash
lib/
├── app/
│   ├── di/                  # Dependency injection
│   │   ├── injection.dart
│   │   └── modules/
│   ├── l10n/               # Localization resources
│   ├── routes/             # Routing configuration
│   │   ├── guards/
│   │   └── app_router.dart
│   └── theme/              # Theme configuration
│       ├── bloc/           # Theme state management
│       ├── data/           # Theme data layer
│       ├── models/         # Theme models
│       └── styles/         # Theme styles
│           ├── colors.dart
│           ├── decorations.dart
│           ├── dimensions.dart
│           └── text_styles.dart
│
├── core/                   # Core functionality
│   ├── api/               # API related code
│   │   ├── interceptors/
│   │   └── endpoints.dart
│   ├── bloc/              # Base bloc classes
│   ├── error/             # Error handling
│   ├── storage/           # Local storage
│   └── utils/             # Utilities
│       ├── extensions/
│       ├── helpers/
│       └── constants/
│
├── features/              # Feature modules
│   ├── home/
│   │   ├── bloc/
│   │   ├── models/
│   │   ├── repositories/
│   │   ├── screens/
│   │   └── widgets/
│   ├── manga/
│   ├── reader/
│   ├── search/
│   └── settings/
│
└── shared/               # Shared components
    ├── widgets/          # Reusable widgets
    ├── models/          # Shared models
    └── enums/           # Shared enums
```
