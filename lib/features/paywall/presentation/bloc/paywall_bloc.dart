import 'package:birthmark/features/paywall/domain/usecases/save_subscription_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'paywall_event.dart';
part 'paywall_state.dart';

@injectable
class PaywallBloc extends Bloc<PaywallEvent, PaywallState> {
  final SaveSubscriptionStatus _saveSubscriptionStatus;

  PaywallBloc(this._saveSubscriptionStatus) : super(PaywallInitial()) {
    on<SubscriptionPurchased>(_onSubscriptionPurchased);
  }

  Future<void> _onSubscriptionPurchased(
    SubscriptionPurchased event,
    Emitter<PaywallState> emit,
  ) async {
    emit(PaywallPurchaseInProgress());
    await _saveSubscriptionStatus();
    emit(PaywallPurchaseSuccess());
  }
}