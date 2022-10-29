import 'package:code/global.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_highlight/themes/tomorrow-night.dart';
import 'package:flutter_highlight/themes/tomorrow.dart';
import 'package:flutter_highlight/themes/xcode.dart';

// Import the language & theme
import 'package:highlight/languages/dart.dart';
import 'package:provider/provider.dart';

class CodeEditor extends StatefulWidget {
  const CodeEditor({super.key});

  @override
  State<CodeEditor> createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  CodeController? _codeController;
  final source = "void main() {\n    print(\"Hello, world!\");\n}";
  final themes = [
    xcodeTheme,
    tomorrowTheme,
    tomorrowNightTheme,
    monokaiSublimeTheme
  ];

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final codeTheme = context.select<Global, int>((value) => value.codeTheme);
    _codeController?.dispose();
    _codeController = CodeController(
      text: source,
      language: dart,
      theme: themes[codeTheme],
    );

    return Material(
      child: CodeField(
        controller: _codeController!,
        textStyle: const TextStyle(fontFamily: 'SourceCode'),
      ),
    );
  }
}
