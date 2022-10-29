import 'package:code/global.dart';
import 'package:code/widget/codeeditor.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class EditorTab extends StatefulWidget {
  const EditorTab({super.key});

  @override
  State<EditorTab> createState() => _EditorTabState();
}

class _EditorTabState extends State<EditorTab> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final global = context.watch<Global>();
    return TabView(
      currentIndex: global.currentIndex,
      onChanged: (value) => global.currentIndex = value,
      onNewPressed: () => global.addTab({
        '/new': Tab(
            text: const Text('new*'),
            body: const CodeEditor(),
            onClosed: () => global.removeTab('/new'))
      }),
      tabs: global.tabMap.values.toList(),
    );
  }
}
