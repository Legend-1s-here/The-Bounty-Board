import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home_widget/home_widget.dart';

import '../themes/app_themes.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'selectedThemeId';
  static const String _fontSizeKey = 'selectedFontSizeSp';
  static const String _widgetName = 'TodoWidget';

  String _selectedThemeId = 'midnight';
  int _fontSizeSp = 13;

  String get selectedThemeId => _selectedThemeId;
  int get fontSizeSp => _fontSizeSp;

  AppTheme get currentTheme => appThemes.firstWhere(
        (t) => t.id == _selectedThemeId,
        orElse: () => appThemes.first,
      );

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() {
    final box = Hive.box('settings');
    _selectedThemeId = box.get(_themeKey, defaultValue: 'midnight') as String;
    _fontSizeSp = box.get(_fontSizeKey, defaultValue: 13) as int;
    _updateWidgetTheme();
    notifyListeners();
  }

  Future<void> setTheme(String themeId) async {
    if (_selectedThemeId == themeId) return;
    _selectedThemeId = themeId;
    final box = Hive.box('settings');
    await box.put(_themeKey, themeId);
    await _updateWidgetTheme();
    notifyListeners();
  }

  Future<void> setFontSize(int sizeSp) async {
    if (_fontSizeSp == sizeSp) return;
    _fontSizeSp = sizeSp;
    final box = Hive.box('settings');
    await box.put(_fontSizeKey, sizeSp);
    await _updateWidgetTheme();
    notifyListeners();
  }

  Future<void> _updateWidgetTheme() async {
    try {
      await HomeWidget.saveWidgetData<String>('theme_id', _selectedThemeId);
      await HomeWidget.saveWidgetData<int>('font_size_sp', _fontSizeSp);
      await HomeWidget.updateWidget(
        name: _widgetName,
        androidName: _widgetName,
        iOSName: _widgetName,
        qualifiedAndroidName: 'com.example.todo_app.$_widgetName',
      );
    } catch (e) {
      debugPrint('Theme widget update skipped: $e');
    }
  }
}
