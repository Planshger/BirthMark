import 'package:birthmark/core/di/injector.dart';
import 'package:birthmark/features/birthdate/presentation/pages/birthdate_page.dart';
import 'package:birthmark/features/onboarding/domain/usecases/is_onboarding_completed.dart';
import 'package:birthmark/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  final isOnboarded = await injector<IsOnboardingCompleted>()();

  runApp(MainApp(isOnboarded: isOnboarded));
}

class MainApp extends StatelessWidget {
  final bool isOnboarded;
  const MainApp({super.key, required this.isOnboarded});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: isOnboarded ? const BirthDatePage() : const OnboardingPage(),
    );
  }
}
