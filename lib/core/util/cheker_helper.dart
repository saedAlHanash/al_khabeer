
import 'package:al_khabeer/core/util/shared_preferences.dart';

bool checkEmail(String? email) {
  final bool emailValid =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email ?? '');
  return emailValid;
}

bool get isAr => AppSharedPreference.isAr;