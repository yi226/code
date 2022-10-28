import 'package:fluent_ui/fluent_ui.dart';

class Global extends ChangeNotifier {
  Global() {
    _tabMap.addAll({
      '/': Tab(
          text: const Text('hello'),
          body: const FlutterLogo(),
          onClosed: () => removeTab('/'))
    });
  }

  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;
  set mode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  double _sideWidth = 50;
  double get sideWidth => _sideWidth;
  set sideWidth(double width) {
    _sideWidth = width;
    notifyListeners();
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  final Map<String, Tab> _tabMap = {};
  Map<String, Tab> get tabMap => _tabMap;
  addTab(Map<String, Tab> tab) {
    _tabMap.addAll(tab);
    notifyListeners();
  }

  removeTab(String label) {
    if (_tabMap.keys.toList().indexOf(label) == _currentIndex) {
      _currentIndex = 0;
    }
    _tabMap.remove(label);
    notifyListeners();
  }
}
