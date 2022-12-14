import 'package:code/global.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final themes = ["xcode", "tomorrow", "tomorrowNight", "monokaiSublime"];

  @override
  Widget build(BuildContext context) {
    final global = context.watch<Global>();
    return Column(
      children: [
        Expander(
            header: const Text('全局主题'),
            initiallyExpanded: true,
            content: Row(
                children: List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RadioButton(
                    content: Text(ThemeMode.values[index].name),
                    checked: global.mode.index == index,
                    onChanged: (checked) {
                      if (checked) {
                        global.mode = ThemeMode.values[index];
                      }
                    }),
              );
            }))),
        Expander(
            header: const Text('代码主题'),
            initiallyExpanded: true,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(themes.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RadioButton(
                      content: Text(themes[index]),
                      checked: global.codeTheme == index,
                      onChanged: (checked) {
                        if (checked) {
                          global.codeTheme = index;
                        }
                      }),
                );
              }),
            )),
      ],
    );
  }
}
