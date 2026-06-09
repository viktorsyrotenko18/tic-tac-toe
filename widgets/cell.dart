import 'dart:ui';
import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final String value;
  final bool highlight;
  final VoidCallback onTap;

  const Cell({
    super.key,
    required this.value,
    required this.highlight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isX = value == 'X';

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: highlight
                  ? Colors.greenAccent.withOpacity(0.8)
                  : (isX ? Colors.cyanAccent : Colors.pinkAccent)
                      .withOpacity(value.isEmpty ? 0.0 : 0.6),
              blurRadius: 25,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              child: Center(
                child: AnimatedScale(
                  scale: value.isEmpty ? 0.5 : 1,
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.bold,
                      color: isX ? Colors.cyanAccent : Colors.pinkAccent,
                      shadows: [
                        Shadow(
                          blurRadius: 25,
                          color: isX ? Colors.cyanAccent : Colors.pinkAccent,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
