import 'package:birthmark/features/paywall/domain/repositories/paywall_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveSubscriptionStatus {
  final PaywallRepository repository;

  SaveSubscriptionStatus(this.repository);

  Future<void> call() async => repository.saveSubscriptionStatus();
}