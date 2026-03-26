import 'package:birthmark/features/onboarding/presentation/bloc/onboardig_event.dart';
import 'package:birthmark/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:birthmark/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_indicators.dart';

class OnboardingControls extends StatelessWidget {
  final OnboardingBloc bloc;

  const OnboardingControls({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is! OnboardingLoaded) return const SizedBox.shrink();
        final isLast = state.currentIndex == state.items.length - 1;

        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OnboardingIndicators(count: state.items.length, currentIndex: state.currentIndex),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isLast)
                    SizedBox(
                      height: 65,
                      width: 300,
                      child: CupertinoButton.filled(
                        onPressed: () {
                          bloc.add(NextPage());
                        },
                        child: MediaQuery(
                          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                          child: Text(
                            "Далее",
                            style: TextStyle(color: CupertinoColors.extraLightBackgroundGray),
                          ),
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      height: 65,
                      width: 300,
                      child: CupertinoButton.filled(
                        onPressed: () async {
                          bloc.add(CompleteOnboarding());
                        },
                        child: MediaQuery(
                          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                          child: Text("Начать", style: TextStyle(color: CupertinoColors.extraLightBackgroundGray)),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
