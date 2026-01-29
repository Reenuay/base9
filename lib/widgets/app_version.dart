import 'package:base9/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.all(Spacing.sm),
          child: Text(
            'v${snapshot.data!.version}',
            style: context.theme.typography.sm.copyWith(
              color: context.theme.colors.mutedForeground,
            ),
          ),
        );
      },
    );
  }
}
