class AppConfig {
  static const bool isLocal = false; //! true when running on LocalHost
  static const String _localBaseUrl = "http://localhost:3000/api";
  static const String _liveBaseUrl = "https://fyp.pelarinfruit.com/api";
  static const String mapApi = "AIzaSyDaaNW6khrCkxJesgZCZ9lEqGqfPS6373Q";
  static String get baseUrl => isLocal ? _localBaseUrl : _liveBaseUrl;
}
