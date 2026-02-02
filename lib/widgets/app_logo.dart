import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showShadow;

  const AppLogo({
    Key? key,
    this.size = 120,
    this.showShadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size * 0.25),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ]
            : null,
      ),
      child: Stack(
        children: [
          // Background gradient circle
          Center(
            child: Container(
              width: size * 0.85,
              height: size * 0.85,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.teal.shade400,
                    Colors.teal.shade700,
                  ],
                ),
              ),
            ),
          ),
          // Fork and spoon
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Fork (left)
                Transform.translate(
                  offset: Offset(-size * 0.12, 0),
                  child: Transform.rotate(
                    angle: -0.3,
                    child: Icon(
                      Icons.restaurant,
                      size: size * 0.45,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Spoon (right)
                Transform.translate(
                  offset: Offset(size * 0.12, 0),
                  child: Transform.rotate(
                    angle: 0.3,
                    child: Icon(
                      Icons.restaurant_menu,
                      size: size * 0.45,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Small plate circle in center
          Center(
            child: Container(
              width: size * 0.25,
              height: size * 0.25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.9),
                border: Border.all(
                  color: Colors.teal.shade300,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  'ML',
                  style: TextStyle(
                    fontSize: size * 0.12,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
