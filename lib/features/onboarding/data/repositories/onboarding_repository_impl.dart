import 'package:birthmark/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:birthmark/features/onboarding/domain/entities/onboarding_item.dart';
import 'package:birthmark/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl(this.localDataSource);

  @override
  Future<List<OnboardingItem>> getOnboardingItems() async {
    final models = await localDataSource.loadItems();
    return models
        .map(
          (model) => OnboardingItem(
            titleKey: model.titleKey,
            descriptionKey: model.descriptionKey,
          ),
        )
        .toList();
  }

  @override
  Future<bool> isCompleted() => localDataSource.isCompleted();

  @override
  Future<void> markCompleted() => localDataSource.markCompleted();
}
