import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:version/version.dart';
import 'package:base9/navigator_scope.dart';
import 'package:base9/overlays/upgrade_dialog.dart';

const _appcastURL =
    'https://raw.githubusercontent.com/Reenuay/base9/main/appcast.xml';

class UpgradeCheck extends StatefulWidget {
  const UpgradeCheck({super.key, required this.child});

  final Widget child;

  static final _upgrader = Upgrader(
    storeController: UpgraderStoreController(
      onAndroid: () => UpgraderAppcastStore(
        appcastURL: _appcastURL,
        osVersion: Version(1, 0, 0),
      ),
    ),
    durationUntilAlertAgain: Duration.zero,
    debugLogging: true,
  );

  @override
  State<UpgradeCheck> createState() => _UpgradeCheckState();
}

class _UpgradeCheckState extends State<UpgradeCheck> {
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    UpgradeCheck._upgrader.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UpgraderState>(
      initialData: UpgradeCheck._upgrader.state,
      stream: UpgradeCheck._upgrader.stateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state != null &&
            state.versionInfo != null &&
            !_dialogShown &&
            UpgradeCheck._upgrader.shouldDisplayUpgrade()) {
          final navKey = NavigatorKeyScope.of(context);
          final navContext = navKey?.currentContext;
          if (navContext != null && navContext.mounted) {
            _dialogShown = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final ctx = navKey?.currentContext;
              if (ctx != null && ctx.mounted) {
                UpgradeCheck._upgrader.showUpgradeDialog(
                  ctx,
                  installed: state.packageInfo?.version,
                  available: state.versionInfo?.appStoreVersion?.toString(),
                );
              }
            });
          }
        }
        return widget.child;
      },
    );
  }
}
