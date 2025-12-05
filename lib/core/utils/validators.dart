class Validators {
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }

    // Accepts only 10 digits (0–9)
    final regex = RegExp(r'^[6-9][0-9]{9}$');

    if (!regex.hasMatch(value)) {
      return "Enter a valid 10-digit phone number starting with 6-9";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }
}
