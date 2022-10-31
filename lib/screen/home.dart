import 'package:code/global.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final path = context.select<Global, String?>((value) => value.filePath);
    final getFilePathFunction =
        context.select<Global, Function?>((value) => value.getFilePathFunction);
    return path == null
        ? Center(
            child: Button(
            onPressed: () => getFilePathFunction?.call(),
            child: const Text("打开文件夹"),
          ))
        : const FileTree(key: GlobalObjectKey(1));
  }
}

class FileTree extends StatefulWidget {
  const FileTree({super.key});

  @override
  State<FileTree> createState() => _FileTreeState();
}

class _FileTreeState extends State<FileTree> {
  final lazyItems = [
    TreeViewItem(
      content: const Text('Item with lazy loading'),
      value: 'lazy_load',
      // This means the item will be expandable, although there are no
      // children yet.
      lazy: true,
      // Ensure the list is modifiable.
      children: [],
      onExpandToggle: (item, getsExpanded) async {
        // If it's already populated, return.
        if (item.children.isNotEmpty) return;

        // Do your fetching...
        await Future.delayed(const Duration(seconds: 2));

        // ...and add the fetched nodes.
        item.children.addAll([
          TreeViewItem(
            content: const Text('Lazy item 1'),
            value: 'lazy_1',
          ),
          TreeViewItem(
            content: const Text('Lazy item 2'),
            value: 'lazy_2',
          ),
          TreeViewItem(
            content: const Text('Lazy item 3'),
            value: 'lazy_3',
          ),
          TreeViewItem(
            content: const Text(
              'Lazy item 4 (this text should not overflow)',
              overflow: TextOverflow.ellipsis,
            ),
            value: 'lazy_4',
          ),
        ]);
      },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return TreeView(
      shrinkWrap: true,
      items: lazyItems,
      onItemInvoked: (item, _) async => debugPrint('onItemInvoked: $item'),
      onSelectionChanged: (selectedItems) async => debugPrint(
          'onSelectionChanged: ${selectedItems.map((i) => i.value)}'),
      onSecondaryTap: (item, details) async {
        debugPrint('onSecondaryTap $item at ${details.globalPosition}');
      },
    );
  }
}
