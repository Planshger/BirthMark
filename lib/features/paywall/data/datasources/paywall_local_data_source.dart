import 'package:birthmark/core/constants/preferences_keys.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PaywallLocalDataSource {
  Future<bool> getSubscriptionStatus();
  Future<void> saveSubscriptionStatus();
}

@LazySingleton(as: PaywallLocalDataSource)
class PaywallLocalDataSourceImpl implements PaywallLocalDataSource {
  final SharedPreferences prefs;

  PaywallLocalDataSourceImpl(this.prefs);

  @override
  Future<bool> getSubscriptionStatus() async => prefs.getBool(PreferencesKeys.isSubscribed) ?? false;

  @override
  Future<void> saveSubscriptionStatus() async => await prefs.setBool(PreferencesKeys.isSubscribed, true);
}


