import 'package:birthmark/core/di/injector.dart';
import 'package:birthmark/features/onboarding/presentation/bloc/onboardig_event.dart';
import 'package:birthmark/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:birthmark/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:birthmark/features/onboarding/presentation/widgets/onboarding_controls.dart';
import 'package:birthmark/features/onboarding/presentation/widgets/onboarding_slide.dart';
import 'package:birthmark/features/paywall/presentation/pages/paywall_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged(BuildContext context, int index) {
    final bloc = context.read<OnboardingBloc>();
    final state = bloc.state;
    if (state is OnboardingLoaded && state.currentIndex != index) {
      bloc.add(SilentPageUpdate(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => OnboardingBloc(
            getOnboardingItems: injector(),
            isCompleted: injector(),
            markCompleted: injector(),
          )..add(LoadOnboarding()),
      child: CupertinoPageScaffold(
        child: SafeArea(
          child: BlocListener<OnboardingBloc, OnboardingState>(
            listener: (context, state) {
              if (state is OnboardingCompleted) {
                Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (_) => const PaywallPage()));
              } else if (state is OnboardingLoaded) {
                if (_controller.hasClients && _controller.page?.round() != state.currentIndex) {
                  _controller.animateToPage(
                    state.currentIndex,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              }
            },
            child: BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                if (state is OnboardingLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (state is OnboardingError) {
                  return Center(child: Text(state.message));
                } else if (state is OnboardingLoaded) {
                  return Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: _controller,
                          onPageChanged: (index) => _onPageChanged(context, index),
                          itemCount: state.items.length,
                          itemBuilder: (context, index) => OnboardingSlide(item: state.items[index]),
                        ),
                      ),
                      OnboardingControls(bloc: context.read<OnboardingBloc>()),
                      const SizedBox(height: 24),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
