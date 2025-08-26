

class TValidator{
  /// Empty Text Validator
  static String? validateEmptyText(String? fieldName, String? value){
    if(value == null || value.isEmpty){
      return '$fieldName is required';
    }

    return null;
  }

  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return 'Email is required.';
    }
    // regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if(!emailRegExp.hasMatch(value)){
      return 'Invalid email address.';
    }
    return null;
  }

  static String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return 'Password is required.';
    }

    //Check for Minimum password length
    if(value.length < 6){
      return 'Password must be at least 6 Characters long.';
    }
    // Check for number
    if(!value.contains(RegExp(r'[0-9]'))){
      return 'Password must contain at least one number.';
    }
    // Check for number
    if(!value.contains(RegExp(r'[$&+,:;=?@#|"<>.^*()%!-]'))){
      return 'Password must contain at least one special character.';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value){
    if(value == null || value.isEmpty){
      return 'Phone number is required.';
    }
    // regular expression for phone number validation (assuming its 10 digit)
    final phoneRegExp = RegExp(r'^\d{8}$');

    if(!phoneRegExp.hasMatch(value)){
      return 'Invalid phone number format (8 digits required)';
    }
    return null;
  }
}