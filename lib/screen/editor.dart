import 'package:code/global.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
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
      currentIndex: currentIndex,
      onChanged: (value) => setState(() => currentIndex = value),
      onNewPressed: () => global.addTab({
        '/new': Tab(
            text: const Text('new*'),
            body: const FlutterLogo(),
            onClosed: () => global.removeTab('/new'))
      }),
      tabs: global.tabMap.values.toList(),
    );
  }
}
