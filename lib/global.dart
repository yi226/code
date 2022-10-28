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

  final Map<String, Tab> _tabMap = {};
  Map<String, Tab> get tabMap => _tabMap;
  addTab(Map<String, Tab> tab){
    _tabMap.addAll(tab);
    notifyListeners();
  }
  removeTab(String label) {
    _tabMap.remove(label);
    notifyListeners();
  }
}
