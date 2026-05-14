import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const ActionButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () => onPressed(),
      child: GlassContainer(        
        height: 56,
        width: 56,
        isFrostedGlass: true,
        frostedOpacity: 0.05,
        blur: 20,
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.25),
            Colors.white.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderGradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.60),
            Colors.white.withValues(alpha: 0.0),
            Colors.white.withValues(alpha: 0.0),
            Colors.white.withValues(alpha: 0.60),
          ],
          stops: [0.0, 0.45, 0.55, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 20.0,
          ),
        ],
        borderRadius: BorderRadius.circular(28),
        child: Icon(CupertinoIcons.add, color: CupertinoColors.activeGreen, size: 28)));         
  }
}