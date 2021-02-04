import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO falta pasar los metodos a repositorio y conectarlos desde aca
final retrieveThemeFromPreferences =
    FutureProvider.autoDispose<bool>((ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('THEMESTATUS') ?? false;
});

class ThemesProvider with ChangeNotifier {
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    notifyListeners();
  }

  Future<void> getThemeFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isDark = prefs.getBool('THEMESTATUS') ?? false;
    setDarkTheme(isDark);
  }

  Future<void> setThemeToPreferences(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('SETVALUE: $val');
    prefs.setBool('THEMESTATUS', val);
  }

  void setDarkTheme(bool value) {
    setThemeToPreferences(value);
    darkTheme = value;
  }
}
