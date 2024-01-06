import 'package:flutter/material.dart';

class CircleRippleButton extends StatelessWidget {
  final Widget destination, icon;
  final ShapeDecoration? customDecoration;

  const CircleRippleButton(
      {super.key,
      required this.destination,
      required this.icon,
      this.customDecoration});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => destination,
          ),
        );
      },
      child: Ink(
        decoration: customDecoration ??
            ShapeDecoration(
              color: Colors.grey.shade200,
              shape: const CircleBorder(),
            ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: icon,
        ),
      ),
    );
  }
}
