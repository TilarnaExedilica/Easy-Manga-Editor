class AppConstants {
  // App info
  static const String appName = 'easy_manga_editor';
  static const String appVersion = '1.0.0';

  // API
  static const int apiTimeoutSeconds = 30;
  static const int maxRetries = 3;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache
  static const Duration cacheDuration = Duration(days: 7);

  // Animation
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
}
