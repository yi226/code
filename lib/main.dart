import 'package:code/screen/editor.dart';
import 'package:code/screen/home.dart';
import 'package:code/screen/setting.dart';
import 'package:code/global.dart';
import 'package:code/utils/mypane.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Global(),
      builder: (context, child) {
        final mode = context.select<Global, ThemeMode>((value) => value.mode);
        return FluentApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          themeMode: mode,
          title: 'Code',
          initialRoute: '/',
          routes: {'/': ((context) => const MainPage())},
        );
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double sideWidth =
        context.select<Global, double>((value) => value.sideWidth);
    return NavigationView(
      appBar: const NavigationAppBar(leading: Icon(FluentIcons.a_a_d_logo)),
      content: Row(
        children: [
          SizedBox(width: sideWidth, child: const SideWidget()),
          const Expanded(child: EditorTab()),
        ],
      ),
    );
  }
}

class SideWidget extends StatefulWidget {
  const SideWidget({super.key});

  @override
  State<SideWidget> createState() => _SideWidgetState();
}

class _SideWidgetState extends State<SideWidget> {
  int? topIndex;
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: MyPane(
        selected: topIndex,
        displayMode: PaneDisplayMode.compact,
        indicator: const StickyNavigationIndicator(
          duration: Duration(milliseconds: 200),
        ),
        onChanged: (index) => setState(() {
          if (index == topIndex) {
            topIndex = null;
            context.read<Global>().sideWidth = 50;
          } else {
            topIndex = index;
            context.read<Global>().sideWidth = 350;
          }
        }),
        menuButton: Container(),
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('Home'),
            body: const Home(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.issue_tracking),
            title: const Text('Track an order'),
            // infoBadge: const InfoBadge(source: Text('8')),
            body: const Home(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.account_management),
            title: const Text('Account'),
            // infoBadge: const InfoBadge(source: Text('8')),
            body: const Home(),
          ),
        ],
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: const Setting(),
          ),
          _LinkPaneItemAction(
            icon: const Icon(FluentIcons.open_source),
            title: const Text('Source code'),
            link: 'https://github.com/yi226',
            body: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _LinkPaneItemAction extends PaneItem {
  _LinkPaneItemAction({
    required super.icon,
    required this.link,
    required super.body,
    super.title,
  });

  final String link;

  @override
  Widget build(
    BuildContext context,
    bool selected,
    VoidCallback? onPressed, {
    PaneDisplayMode? displayMode,
    bool showTextOnTop = true,
    bool? autofocus,
    int? itemIndex,
  }) {
    return Link(
      uri: Uri.parse(link),
      builder: (context, followLink) => super.build(
        context,
        selected,
        followLink,
        displayMode: displayMode,
        showTextOnTop: showTextOnTop,
        itemIndex: itemIndex,
        autofocus: autofocus,
      ),
    );
  }
}
