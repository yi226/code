import 'package:fluent_ui/fluent_ui.dart';

// change when to call onChange
class MyPane extends NavigationPane {
  MyPane({
    super.key,
    super.selected,
    super.onChanged,
    super.size,
    super.header,
    super.items = const [],
    super.footerItems = const [],
    super.autoSuggestBox,
    super.autoSuggestBoxReplacement,
    super.displayMode = PaneDisplayMode.auto,
    super.customPane,
    super.menuButton,
    super.scrollController,
    super.leading,
    super.indicator = const StickyNavigationIndicator(),
  });
  @override
  void changeTo(NavigationPaneItem item) {
    final index = effectiveIndexOf(item);
    if (!index.isNegative) onChanged?.call(index);
  }
}
