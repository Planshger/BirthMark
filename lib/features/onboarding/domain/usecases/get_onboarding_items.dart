import 'package:birthmark/features/onboarding/domain/entities/onboarding_item.dart';
import 'package:birthmark/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetOnboardingItems {
  final OnboardingRepository repository;
  GetOnboardingItems(this.repository);
  Future<List<OnboardingItem>> call() => repository.getOnboardingItems();
}
