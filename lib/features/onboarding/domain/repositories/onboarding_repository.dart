import 'package:birthmark/features/onboarding/domain/entities/onboarding_item.dart';

abstract class OnboardingRepository {
  Future<List<OnboardingItem>> getOnboardingItems();
  Future<bool> isCompleted();
  Future<void> markCompleted();
}
