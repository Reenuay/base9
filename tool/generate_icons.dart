import 'dart:io';

void main() async {
  final result = await Process.run('flutter', [
    'test',
    'tool/generate_icons_test.dart',
    '--reporter',
    'expanded',
  ], runInShell: true);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
  exit(result.exitCode);
}
