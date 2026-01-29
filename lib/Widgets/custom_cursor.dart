import 'package:flutter/material.dart';
import '../resource/appClass.dart';
import '../resource/colors.dart';

class CustomCursor extends StatefulWidget {
  final Widget child;
  const CustomCursor({super.key, required this.child});

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> {
  Offset pointerOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onHover: (event) {
        setState(() {
          pointerOffset = event.position;
        });
      },
      child: Stack(
        children: [
          widget.child,
          if(AppClass().getScreenType(context) == ScreenType.web)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            left: pointerOffset.dx - 15,
            top: pointerOffset.dy - 15,
            child: IgnorePointer(
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ],
                ),
              ),
            ),
          ),
          if(AppClass().getScreenType(context) == ScreenType.web)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 50),
            left: pointerOffset.dx - 4,
            top: pointerOffset.dy - 4,
            child: IgnorePointer(
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors().primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors().primaryColor.withValues(alpha: 0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
