abstract class OnboardingEvent {}

class LoadOnboarding extends OnboardingEvent {}

class NextPage extends OnboardingEvent {}

class PreviousPage extends OnboardingEvent {}

class CompleteOnboarding extends OnboardingEvent {}

class SilentPageUpdate extends OnboardingEvent {
  final int index;
  SilentPageUpdate(this.index);
}
