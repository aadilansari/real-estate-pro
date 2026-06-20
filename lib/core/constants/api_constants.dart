class ApiConstants {
  ApiConstants._();

  /// Base URL — replace with your real backend URL when ready.
  static const String baseUrl = 'https://api.realaura.in/v1';

  // ── Endpoints ──────────────────────────────────────────────────────────────
  static const String properties = '/properties';
  static const String locations = '/locations';

  // ── Request timeouts ───────────────────────────────────────────────────────
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
