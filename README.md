# easy_manga_editor

Under development...

## Project structure

```bash
lib/
├── app/                    # App configuration
│   ├── di/                # Dependency injection
│   ├── l10n/              # Localization
│   ├── routes/            # Routing
│   └── theme/             # Theme configuration
│
├── core/                  # Core functionality
│   ├── api/              # API related code
│   ├── bloc/             # Base bloc classes
│   ├── error/            # Error handling
│   ├── storage/          # Local storage
│   └── utils/            # Utilities
│
├── features/             # Business features
│   ├── demo/            # Demo feature
│   │   ├── bloc/        # Demo state management
│   │   ├── models/      # Demo models
│   │   ├── repositories/ # Demo repositories
│   │   └── services/    # Demo services
│   │
│   └── settings/        # Settings feature
│       ├── bloc/        # Settings state management
│       ├── models/      # Settings models
│       └── services/    # Settings services
│
├── screens/             # UI screens
│   ├── home/           # Home screen
│   │   ├── widgets/    # Screen-specific widgets
│   │   └── home_screen.dart
│   │
│   ├── manga_detail/   # Manga detail screen
│   │   ├── widgets/    # Screen-specific widgets  
│   │   └── manga_detail_screen.dart
│   │
│   └── editor/         # Editor screen
│       ├── widgets/    # Screen-specific widgets
│       └── editor_screen.dart
│
└── shared/            # Shared components
    ├── widgets/       # Reusable widgets
    ├── models/       # Shared models
    └── constants/    # Shared constants
```

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
