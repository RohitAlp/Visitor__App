class AppValidators {
  AppValidators._();

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }

    final trimmed = value.trim();

    if (trimmed.length < 3 || trimmed.length > 50) {
      return 'Name must be 3–50 characters';
    }

    final nameRegex = RegExp(r'^[a-zA-Z ]+$');

    if (!nameRegex.hasMatch(trimmed)) {
      return 'Name can contain only letters';
    }

    return null;
  }

  static String? validateGuardId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Guard ID is required';
    }

    final trimmed = value.trim();

    if (trimmed.contains(' ')) {
      return 'Guard ID cannot contain spaces';
    }

    if (trimmed.length < 4 || trimmed.length > 20) {
      return 'Guard ID must be 4–20 characters';
    }

    final idRegex = RegExp(r'^[a-zA-Z0-9]+$');

    if (!idRegex.hasMatch(trimmed)) {
      return 'Only letters and numbers allowed';
    }

    return null;
  }

  static String? validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number is required';
    }

    final trimmed = value.trim();

    final mobileRegex = RegExp(r'^[6-9]\d{9}$');

    if (!mobileRegex.hasMatch(trimmed)) {
      return 'Enter valid 10-digit mobile number';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final trimmed = value.trim();

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
      r"[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z]{2,}$",
    );

    if (!emailRegex.hasMatch(trimmed)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Address is required';
    }

    final trimmed = value.trim();

    if (trimmed.length < 5 || trimmed.length > 200) {
      return 'Address must be 5–200 characters';
    }

    final addressRegex = RegExp(r'^[a-zA-Z0-9\s,.\-#/]+$');

    if (!addressRegex.hasMatch(trimmed)) {
      return 'Address contains invalid characters';
    }

    return null;
  }
}