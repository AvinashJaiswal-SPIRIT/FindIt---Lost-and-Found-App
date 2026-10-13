class AuthService {
  static bool isLoggedIn = false;
  static String currentUserEmail = 'alex.rivers@campus.edu';
  static String currentUserName = 'Alex Rivers';

  static Future<bool> login(String email, String password) async {
    isLoggedIn = true;
    currentUserEmail = email;
    return true;
  }

  static Future<bool> signup(String name, String email, String password) async {
    isLoggedIn = true;
    currentUserName = name;
    currentUserEmail = email;
    return true;
  }

  static void logout() {
    isLoggedIn = false;
  }
}
