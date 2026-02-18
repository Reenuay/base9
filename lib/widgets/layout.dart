import 'package:base9/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:base9/theme/spacing.dart';
import 'package:base9/widgets/copy_button.dart';

class Layout extends StatelessWidget {
  const Layout({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.paddingOf(context),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [const Header(), body],
              ),
            ),
          ),
          Positioned(
            bottom: Spacing.lg,
            left: 0,
            right: 0,
            child: const Center(child: CopyButton()),
          ),
        ],
      ),
    );
  }
}
