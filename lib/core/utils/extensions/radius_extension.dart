extension RadiusExtension on double {
  double get r {
    if (this <= 40) return 4.0;
    if (this <= 100) return 8.0;
    if (this <= 200) return 12.0;
    if (this <= 400) return 16.0;
    return 20.0;
  }

  double radiusWithRatio([double ratio = 0.1]) {
    final safeRatio = ratio.clamp(0.0, 0.5);
    return this * safeRatio;
  }
}
