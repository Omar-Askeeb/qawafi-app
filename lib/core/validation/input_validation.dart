import 'package:form_validator/form_validator.dart';

class InputValidation {
  static StringValidationCallback requiredValidation() {
    return ValidationBuilder(localeName: 'ar').required().build();
  }

  static StringValidationCallback requiredPasswordValidation() {
    return ValidationBuilder(localeName: 'ar')
        .minLength(6, 'يجب ان تتكون كلمة المرور من 6 أرقام على الأقل')
        .required()
        .build();
  }

  static StringValidationCallback emailValidation() {
    return ValidationBuilder(localeName: 'ar').email().build();
  }

  static StringValidationCallback notEmptyValidation() {
    return ValidationBuilder(localeName: 'ar')
        .required('يجب ان تتكون كلمة المرور من 8 أرقام على الأقل')
        .build();
  }

  static StringValidationCallback phoneNumberValidation() {
    return ValidationBuilder(localeName: 'ar')
        .required('يجب ان لا يكون رقم الهاتف فارغ')
        .regExp(
            RegExp(r'^0?9\d{8}$'), 'الرجاء إدخال رقم الهاتف بالصيغة الصحيحة')
        .build();
  }

  static StringValidationCallback qawafiCardValidation() {
    return ValidationBuilder(localeName: 'ar')
        .minLength(13, "الرجاء إدخال بطاقة تعبئة صحيحة تتكون من 13 خانة")
        .regExp(RegExp(r'^\d+$'), 'الرجاء إدخال بطاقة التعبئة بشكل صحيح')
        .required('يجب ان لا يكون رقم الهاتف فارغ')
        .build();
  }

  static StringValidationCallback textLenthAndRequried() {
    return ValidationBuilder(localeName: 'ar')
        .required('يجب ان لا يكون فارغ')
        .minLength(5, 'يجب ان يكون النص المدخل لا يقل عن 5 أحرف')
        .build();
  }
}
