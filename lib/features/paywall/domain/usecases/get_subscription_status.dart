import 'package:birthmark/features/paywall/domain/repositories/paywall_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSubscriptionStatus {
  final PaywallRepository repository;

  GetSubscriptionStatus(this.repository);

  Future<bool> call() async => repository.getSubscriptionStatus();
}