import 'package:birthmark/features/paywall/data/datasources/paywall_local_data_source.dart';
import 'package:birthmark/features/paywall/domain/repositories/paywall_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PaywallRepository)
class PaywallRepositoryImpl implements PaywallRepository {
  final PaywallLocalDataSource localDataSource;

  PaywallRepositoryImpl(this.localDataSource);

  @override
  Future<bool> getSubscriptionStatus() => localDataSource.getSubscriptionStatus();

  @override
  Future<void> saveSubscriptionStatus() => localDataSource.saveSubscriptionStatus();
}