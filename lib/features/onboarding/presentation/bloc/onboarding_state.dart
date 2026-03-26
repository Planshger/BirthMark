import 'package:birthmark/features/onboarding/domain/entities/onboarding_item.dart';

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingCompleted extends OnboardingState {}

class OnboardingError extends OnboardingState {
  final String message;
  OnboardingError(this.message);
}

class OnboardingLoaded extends OnboardingState {
  final List<OnboardingItem> items;
  final int currentIndex;
  OnboardingLoaded(this.items, this.currentIndex);
}
