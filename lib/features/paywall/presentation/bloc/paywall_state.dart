part of 'paywall_bloc.dart';

abstract class PaywallState {}

class PaywallInitial extends PaywallState {}

class PaywallPurchaseInProgress extends PaywallState {}

class PaywallPurchaseSuccess extends PaywallState {}

class PaywallPurchaseFailure extends PaywallState {
  final String message;
  PaywallPurchaseFailure(this.message);
}