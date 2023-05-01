validateField(String value, String field) {
  if (value.trim().isEmpty) {
    return "$field is required";
  } else {
    return null;
  }
}

validateEmail(String email) {
  RegExp regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (email.isEmpty) {
    return "Email is required";
  } else if (!regex.hasMatch(email)) {
    return "Please Make Sure Your Email Address is Correct";
  } else {
    return null;
  }
}

validatePassword(String value) {
  if (value.isEmpty) {
    return "Password is required";
  } else {
    return null;
  }
}
