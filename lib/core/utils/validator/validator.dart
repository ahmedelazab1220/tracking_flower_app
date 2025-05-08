import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../l10n/locale_keys.g.dart';

@lazySingleton
class Validator {
  String? validateEmail(String input) {
    if (input.isEmpty) {
      return LocaleKeys.EmailCannotBeEmpty.tr();
    } else if (!RegExp(
      r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(input)) {
      return LocaleKeys.ThisEmailIsNotValid.tr();
    }
    return null;
  }

  String? validatePassword(String input) {
    if (input.isEmpty) {
      return LocaleKeys.PasswordCannotBeEmpty.tr();
    } else if (!RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$',
    ).hasMatch(input)) {
      return LocaleKeys.InvalidPassword.tr();
    }
    return null;
  }
}
