class AppEnv {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://advia-server.onrender.com',
  );
}