import 'package:birthmark/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MarkOnboardingCompleted {
  final OnboardingRepository repository;
  MarkOnboardingCompleted(this.repository);
  Future<void> call() => repository.markCompleted();
}
