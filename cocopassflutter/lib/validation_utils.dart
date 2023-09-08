class ValidationUtils {
  static bool isValidFirstName(String value) {
    return value.isNotEmpty;
  }

  static bool isValidLastName(String value) {
    return value.isNotEmpty;
  }

  static bool isValidEmail(String value) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(value);
  }

  static bool isValidPassword(String value) {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{16,}$')
        .hasMatch(value);
  }

  static bool doPasswordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }
}
