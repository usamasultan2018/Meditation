import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
class LanguageProvider with ChangeNotifier {
  String _selectedLanguage = 'en'; // Default language is English

  String get selectedLanguage => _selectedLanguage;

  void changeLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }
}
