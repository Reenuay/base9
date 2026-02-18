import 'package:flutter/material.dart';
import 'package:base9/widgets/app_version.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(alignment: Alignment.centerLeft, child: AppVersion());
  }
}
