import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BASE',
          style: context.theme.typography.xl7.copyWith(
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
        Text(
          '9',
          style: context.theme.typography.xl4.copyWith(
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
      ],
    );
  }
}
