/// Konfigurasi URL dasar endpoint Django REST Framework backend.
///
/// Secara default mengarah ke http://10.0.2.2:8000 (akses localhost mesin dari Android emulator).
/// Nilai ini dapat ditimpa saat run/build menggunakan flag --dart-define=API_BASE_URL=...
const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:8000',
);
