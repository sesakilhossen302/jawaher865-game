class ApiUrl {
  static const String baseUrl = 'https://api.jawaher.com/v1';
  static const String socketUrl = 'https://api.jawaher.com';

  // Auth Endpoints
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';

  // User Endpoints
  static const String profile = '$baseUrl/user/profile';
}
