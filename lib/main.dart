import 'package:birthmark/core/di/injector.dart';
import 'package:birthmark/features/birthdate/presentation/pages/birthdate_page.dart';
import 'package:birthmark/features/onboarding/domain/usecases/is_onboarding_completed.dart';
import 'package:birthmark/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:birthmark/features/paywall/domain/usecases/get_subscription_status.dart';
import 'package:birthmark/features/paywall/presentation/pages/paywall_page.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

typedef AppStatus = ({bool isOnboarded, bool isSubscribed});

class _MainAppState extends State<MainApp> {
  late final Future<AppStatus> _appStatusFuture;

  @override
  void initState() {
    super.initState();
    _appStatusFuture = _checkAppStatus();
  }

  Future<AppStatus> _checkAppStatus() async {
    final results = await Future.wait([
      injector<IsOnboardingCompleted>()(),
      injector<GetSubscriptionStatus>()(),
    ]);
    return (isOnboarded: results[0], isSubscribed: results[1]);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: FutureBuilder<AppStatus>(
        future: _appStatusFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoPageScaffold(child: Center(child: CupertinoActivityIndicator()));
          }

          final status = snapshot.data;
          if (status == null || !status.isOnboarded) {
            return const OnboardingPage();
          }

          if (!status.isSubscribed) {
            return const PaywallPage();
          }

          return const BirthDatePage();
        },
      ),
    );
  }
}
