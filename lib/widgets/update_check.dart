import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version/version.dart';
import 'package:yaml/yaml.dart';
import 'package:base9/overlays/update_dialog.dart';

const _pubspecUrl =
    'https://raw.githubusercontent.com/Reenuay/base9/main/pubspec.yaml';

class UpdateCheck extends StatefulWidget {
  const UpdateCheck({
    super.key,
    required this.navigatorKey,
    required this.child,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

  @override
  State<UpdateCheck> createState() => _UpdateCheckState();
}

class _UpdateCheckState extends State<UpdateCheck> {
  String? _pendingInstall;
  String? _pendingAvailable;

  @override
  void initState() {
    super.initState();
    _check();
  }

  Future<void> _check() async {
    final info = await PackageInfo.fromPlatform();
    final Version installed;
    try {
      installed = Version.parse(info.version);
    } on FormatException {
      return;
    }

    final http.Response response;
    try {
      response = await http.get(Uri.parse(_pubspecUrl));
    } catch (_) {
      return;
    }
    if (response.statusCode != 200) return;

    final yaml = loadYaml(response.body) as YamlMap?;
    final versionStr = yaml?['version']?.toString();
    if (versionStr == null) return;

    final Version available;
    try {
      available = Version.parse(versionStr);
    } on FormatException {
      return;
    }
    if (available <= installed) return;

    if (!mounted) return;
    setState(() {
      _pendingInstall = info.version;
      _pendingAvailable = versionStr;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_pendingInstall != null && _pendingAvailable != null) {
      final ctx = widget.navigatorKey.currentContext;
      if (ctx != null && ctx.mounted) {
        final installed = _pendingInstall!;
        final available = _pendingAvailable!;
        setState(() {
          _pendingInstall = null;
          _pendingAvailable = null;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final c = widget.navigatorKey.currentContext;
          if (c != null && c.mounted) {
            c.showUpdateDialog(installed: installed, available: available);
          }
        });
      }
    }
    return widget.child;
  }
}
