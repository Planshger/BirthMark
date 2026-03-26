import 'package:flutter/cupertino.dart';

class OnboardingIndicators extends StatelessWidget {
  final int count;
  final int currentIndex;

  const OnboardingIndicators({super.key, required this.count, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: index == currentIndex ? 12 : 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                index == currentIndex
                    ? CupertinoTheme.of(context).primaryColor
                    : CupertinoTheme.of(context).primaryColor.withAlpha(85),
          ),
        );
      }),
    );
  }
}
