import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key, 
    required this.child, 
    this.color = Colors.white,
    required this.height,
    required this.onTap,
    required this.width
  });

  final Widget child;
  final double height;
  final double width;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        child: Center(child: child),
        onTap: onTap,
        // onTap: () => onTap(),
      ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color:Colors.black.withOpacity(.1),
            blurRadius: 2.0,
            spreadRadius: .05,
          )
        ]
      ),
    );
  }
}