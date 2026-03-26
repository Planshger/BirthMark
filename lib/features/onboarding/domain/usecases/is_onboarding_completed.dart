import 'package:birthmark/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class IsOnboardingCompleted {
  final OnboardingRepository repository;
  IsOnboardingCompleted(this.repository);
  Future<bool> call() => repository.isCompleted();
}
