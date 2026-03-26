abstract class PaywallRepository {
  Future<bool> getSubscriptionStatus();
  Future<void> saveSubscriptionStatus();
}

