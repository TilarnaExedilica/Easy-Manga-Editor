class Endpoints {
  static const String baseUrl = 'https://api.mangadex.org';

  // Auth endpoints
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refresh = '/auth/refresh';

  // Manga endpoints
  static const String manga = '/manga';
  static const String mangaFeed = '/manga/{id}/feed';
  static const String mangaAggregate = '/manga/{id}/aggregate';

  // Chapter endpoints
  static const String chapter = '/chapter';
  static const String chapterPages = '/at-home/server/{id}';

  // User endpoints
  static const String user = '/user';
  static const String userFollows = '/user/follows/manga';
}
