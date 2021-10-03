import 'package:form_field_validator/form_field_validator.dart';

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'password is required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'passwords must have at least one special character')
]);

basicvalidator(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}
